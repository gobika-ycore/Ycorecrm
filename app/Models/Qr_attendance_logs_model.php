<?php

namespace App\Models;

class Qr_attendance_logs_model extends Crud_model {
    protected $table = null;

    function __construct() {
        $this->table = 'qr_attendance_logs';
        parent::__construct($this->table);
    }
}
