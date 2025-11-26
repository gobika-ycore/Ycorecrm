<?php

namespace App\Controllers;

class Holidays extends Security_Controller {

    function __construct() {
        parent::__construct();
        $this->access_only_team_members();
        $this->init_permission_checker("attendance");
        $this->Holidays_model = model('App\\Models\\Holidays_model');
    }

    function index() {
        return $this->template->rander("holidays/index");
    }

    function list_data() {
        $list = $this->Holidays_model->get_all_where([])->getResult();
        $result = [];
        foreach ($list as $row) {
            $result[] = [
                $row->holiday_date,
                $row->holiday_name,
                $row->holiday_type
            ];
        }
        echo json_encode(["data" => $result]);
    }
}
