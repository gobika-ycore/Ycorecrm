<?php

namespace App\Models;

class Holidays_model extends Crud_model {
    protected $table = null;

    function __construct() {
        $this->table = 'holidays';
        parent::__construct($this->table);
    }
}
