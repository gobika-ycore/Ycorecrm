<?php

namespace App\Controllers;

class Qrattendance extends Security_Controller {

    function __construct() {
        parent::__construct();
        $this->access_only_team_members();
        $this->init_permission_checker("attendance");
        $this->Qr_attendance_logs_model = model('App\\Models\\Qr_attendance_logs_model');
    }

    function index() {
        return $this->template->rander("qrattendance/index");
    }

    function list_data() {
        $list = $this->Qr_attendance_logs_model->get_all_where([])->getResult();
        $result = [];
        foreach ($list as $row) {
            $result[] = [
                $row->scanned_at,
                $row->user_id,
                $row->qr_id,
                $row->attendance_status,
                $row->location_scanned
            ];
        }
        echo json_encode(["data" => $result]);
    }
}
