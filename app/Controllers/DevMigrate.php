<?php

namespace App\Controllers;

class DevMigrate extends \CodeIgniter\Controller
{
    public function run()
    {
        // Restrict to localhost only for safety
        $ip = $_SERVER['REMOTE_ADDR'] ?? '';
        if ($ip !== '127.0.0.1' && $ip !== '::1') {
            return $this->response->setStatusCode(403)->setBody('Forbidden: localhost only');
        }

        try {
            $migrations = \Config\Services::migrations();
            // Run latest migrations for App namespace
            $migrations->setNamespace('App');
            $migrations->latest();
            return $this->response->setStatusCode(200)->setBody('Migrations run successfully.');
        } catch (\Throwable $e) {
            return $this->response->setStatusCode(500)->setBody('Migration error: ' . $e->getMessage());
        }
    }
}
