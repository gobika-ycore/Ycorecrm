<?php

namespace App\Models;

class Reports_model extends Crud_model {
    protected $table = null;

    function __construct() {
        $this->table = 'reports';
        parent::__construct($this->table);
    }
}
