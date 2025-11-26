<?php

namespace App\Models;

class Qr_codes_model extends Crud_model {
    protected $table = null;

    function __construct() {
        $this->table = 'qr_codes';
        parent::__construct($this->table);
    }
}
