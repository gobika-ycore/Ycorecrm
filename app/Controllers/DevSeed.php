<?php

namespace App\Controllers;

class DevSeed extends \CodeIgniter\Controller
{
    public function run()
    {
        $ip = $_SERVER['REMOTE_ADDR'] ?? '';
        if ($ip !== '127.0.0.1' && $ip !== '::1') {
            return $this->response->setStatusCode(403)->setBody('Forbidden: localhost only');
        }

        helper('date');

        try {
            $db = \Config\Database::connect();

            // Ensure there is at least one user
            $user = $db->table($db->getPrefix() . 'users')->select('id, first_name, last_name')->limit(1)->get()->getRow();
            if (!$user) {
                return $this->response->setStatusCode(409)->setBody('No users found in rise_users. Please create at least one user first.');
            }
            $userId = $user->id;

            // Seed holidays
            $holidays = [
                [
                    'holiday_date' => date('Y-m-d', strtotime('+10 days')),
                    'holiday_name' => 'Company Foundation Day',
                    'holiday_type' => 'Company',
                    'created_at' => date('Y-m-d H:i:s')
                ],
                [
                    'holiday_date' => date('Y-m-d', strtotime('+25 days')),
                    'holiday_name' => 'Regional Festival',
                    'holiday_type' => 'Regional',
                    'created_at' => date('Y-m-d H:i:s')
                ]
            ];
            foreach ($holidays as $row) {
                // avoid duplicates by unique holiday_date
                $exists = $db->table($db->getPrefix() . 'holidays')->where('holiday_date', $row['holiday_date'])->get()->getRow();
                if (!$exists) {
                    $db->table($db->getPrefix() . 'holidays')->insert($row);
                }
            }

            // Seed a QR code
            $qrId = 'QR-' . substr(md5(uniqid('', true)), 0, 8);
            $qrCode = [
                'qr_id' => $qrId,
                'qr_type' => 'entry',
                'location' => 'Main Gate',
                'valid_date' => null,
                'valid_time' => 'all_day',
                'qr_data' => json_encode(['purpose' => 'attendance', 'zone' => 'A']),
                'is_active' => 1,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s')
            ];
            // ensure unique qr_id
            $existsQr = $db->table($db->getPrefix() . 'qr_codes')->where('qr_id', $qrCode['qr_id'])->get()->getRow();
            if (!$existsQr) {
                $db->table($db->getPrefix() . 'qr_codes')->insert($qrCode);
            }

            // Seed QR attendance logs (2 entries)
            $logs = [
                [
                    'user_id' => $userId,
                    'qr_id' => $qrId,
                    'attendance_status' => 'Present',
                    'location_scanned' => 'Main Gate',
                    'ip_address' => '127.0.0.1',
                    'scanned_at' => date('Y-m-d H:i:s', strtotime('-1 day 09:00:00')),
                    'user_latitude' => null,
                    'user_longitude' => null
                ],
                [
                    'user_id' => $userId,
                    'qr_id' => $qrId,
                    'attendance_status' => 'Present',
                    'location_scanned' => 'Main Gate',
                    'ip_address' => '127.0.0.1',
                    'scanned_at' => date('Y-m-d H:i:s', strtotime('today 09:00:00')),
                    'user_latitude' => null,
                    'user_longitude' => null
                ]
            ];
            foreach ($logs as $row) {
                $db->table($db->getPrefix() . 'qr_attendance_logs')->insert($row);
            }

            // Seed work reports (2 rows unique on user_id + report_date)
            $reports = [
                [
                    'user_id' => $userId,
                    'report_date' => date('Y-m-d', strtotime('-1 day')),
                    'morning_time' => '09:00:00',
                    'evening_time' => '18:00:00',
                    'total_working_hours' => 9.0,
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s')
                ],
                [
                    'user_id' => $userId,
                    'report_date' => date('Y-m-d'),
                    'morning_time' => '09:15:00',
                    'evening_time' => '18:05:00',
                    'total_working_hours' => 8.83,
                    'created_at' => date('Y-m-d H:i:s'),
                    'updated_at' => date('Y-m-d H:i:s')
                ]
            ];
            foreach ($reports as $row) {
                $existsReport = $db->table($db->getPrefix() . 'reports')->where('user_id', $row['user_id'])->where('report_date', $row['report_date'])->get()->getRow();
                if (!$existsReport) {
                    $db->table($db->getPrefix() . 'reports')->insert($row);
                }
            }

            return $this->response->setStatusCode(200)->setBody('Seed data inserted for holidays, qr_codes, qr_attendance_logs, reports.');
        } catch (\Throwable $e) {
            return $this->response->setStatusCode(500)->setBody('Seeding error: ' . $e->getMessage());
        }
    }
}
