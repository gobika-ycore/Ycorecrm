<?php

namespace App\Controllers;

class Attendancereports extends Security_Controller {

    function __construct() {
        parent::__construct();
        $this->access_only_team_members();
        $this->init_permission_checker("attendance");
        $this->Reports_model = model('App\\Models\\Reports_model');
        $this->Users_model = model('App\\Models\\Users_model');
        $this->Qr_attendance_logs_model = model('App\\Models\\Qr_attendance_logs_model');
    }

    function index() {
        return $this->template->rander("attendancereports/index");
    }

    function list_data() {
        $db = \Config\Database::connect();
        $attTable = $db->prefixTable('attendance');
        $usersTable = $db->prefixTable('users');
        $geoTable = $db->getPrefix() . 'attendance_geo'; // rise_attendance_geo
        $qrLogsTable = $db->prefixTable('qr_attendance_logs');

        // Filters
        $start_date = $this->request->getPost('start_date');
        $end_date = $this->request->getPost('end_date');
        $user_id = $this->request->getPost('user_id');
        $where = "WHERE deleted = 0";
        
        // Handle daily date picker (only start_date provided)
        if ($start_date && !$end_date) {
            $where .= " AND DATE(in_time) = " . $db->escape($start_date);
        } elseif ($start_date && $end_date) {
            $where .= " AND DATE(in_time) BETWEEN " . $db->escape($start_date) . " AND " . $db->escape($end_date);
        }
        // Show all attendance records (no default date filter)
        if ($user_id) {
            $where .= " AND user_id = " . $db->escape($user_id);
        }

        // Ensure geo table exists to prevent SQL error on LEFT JOIN
        try {
            $db->query("CREATE TABLE IF NOT EXISTS `$geoTable` (
                `id` INT AUTO_INCREMENT PRIMARY KEY,
                `attendance_id` INT NOT NULL,
                `check_in_lat` DECIMAL(10,7) DEFAULT NULL,
                `check_in_lng` DECIMAL(10,7) DEFAULT NULL,
                `check_out_lat` DECIMAL(10,7) DEFAULT NULL,
                `check_out_lng` DECIMAL(10,7) DEFAULT NULL,
                `check_in_address` TEXT DEFAULT NULL,
                `check_out_address` TEXT DEFAULT NULL,
                `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                INDEX `idx_attendance_id` (`attendance_id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
        } catch (\Throwable $e) {
            // Ignore; proceed without geo
        }

        // Aggregate per user per date: morning(in_time), evening(out_time), total_sec, first attendance id for geo
        $sql = "SELECT t.report_date, t.user_id, CONCAT(u.first_name, ' ', u.last_name) AS user_name,
                       t.morning_time, t.evening_time, t.total_sec, g.check_in_lat, g.check_in_lng, q.location_scanned
                FROM (
                    SELECT DATE(in_time) AS report_date,
                           user_id,
                           MIN(TIME(in_time)) AS morning_time,
                           MAX(TIME(out_time)) AS evening_time,
                           SUM(CASE WHEN out_time IS NOT NULL THEN TIMESTAMPDIFF(SECOND, in_time, out_time) ELSE 0 END) AS total_sec,
                           MIN(id) AS first_attendance_id
                    FROM $attTable
                    $where
                    GROUP BY user_id, DATE(in_time)
                ) t
                INNER JOIN $usersTable u ON u.id = t.user_id AND u.deleted = 0
                LEFT JOIN $geoTable g ON g.attendance_id = t.first_attendance_id
                LEFT JOIN (
                    SELECT user_id, DATE(scanned_at) AS scan_date, MIN(scanned_at) AS first_scan_time,
                           SUBSTRING_INDEX(GROUP_CONCAT(location_scanned ORDER BY scanned_at ASC SEPARATOR '\n'), '\n', 1) AS location_scanned
                    FROM $qrLogsTable
                    GROUP BY user_id, DATE(scanned_at)
                ) q ON q.user_id = t.user_id AND q.scan_date = t.report_date
                ORDER BY t.report_date DESC";

        try {
            $query = $db->query($sql);
            $rows = $query->getResult();
        } catch (\Throwable $e) {
            echo json_encode(["data" => []]);
            return;
        }

        $result = [];
        foreach ($rows as $r) {
            $totalHours = $r->total_sec ? round(((int)$r->total_sec) / 3600, 2) : null;
            // Prefer QR scan location text; fallback to map link from geo
            $location = '-';
            if (!empty($r->location_scanned)) {
                $location = $r->location_scanned;
            } else if ($r->check_in_lat !== null && $r->check_in_lng !== null) {
                $mapUrl = "https://maps.google.com/?q=" . $r->check_in_lat . "," . $r->check_in_lng;
                $location = "<a href='" . $mapUrl . "' target='_blank'>View on map</a>";
            }
            $result[] = [
                $r->report_date,
                $r->user_name,
                $r->morning_time ? $r->morning_time : '-',
                $r->evening_time ? $r->evening_time : '-',
                $totalHours !== null ? $totalHours : '-',
                $location
            ];
        }

        echo json_encode(["data" => $result]);
    }
}
