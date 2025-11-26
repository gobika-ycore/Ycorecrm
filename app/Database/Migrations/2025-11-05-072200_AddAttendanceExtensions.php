<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class AddAttendanceExtensions extends Migration
{
    public function up()
    {
        // rise_holidays
        $this->forge->addField([
            'id' => [ 'type' => 'INT', 'constraint' => 11, 'unsigned' => false, 'auto_increment' => true ],
            'holiday_date' => [ 'type' => 'DATE', 'null' => false ],
            'holiday_name' => [ 'type' => 'VARCHAR', 'constraint' => 255, 'null' => false ],
            'holiday_type' => [ 'type' => 'ENUM', 'constraint' => ['National','Regional','Festival','Company'], 'default' => 'National' ],
            'created_at' => [ 'type' => 'DATETIME', 'null' => true ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->addUniqueKey('holiday_date');
        $this->forge->addKey('holiday_type');
        $this->forge->createTable('holidays', true);

        // rise_qr_codes
        $this->forge->addField([
            'id' => [ 'type' => 'INT', 'constraint' => 11, 'auto_increment' => true ],
            'qr_id' => [ 'type' => 'VARCHAR', 'constraint' => 255, 'null' => false ],
            'qr_type' => [ 'type' => 'VARCHAR', 'constraint' => 50, 'null' => false ],
            'location' => [ 'type' => 'VARCHAR', 'constraint' => 255, 'null' => false ],
            'valid_date' => [ 'type' => 'DATE', 'null' => true ],
            'valid_time' => [ 'type' => 'VARCHAR', 'constraint' => 20, 'default' => 'all_day' ],
            'qr_data' => [ 'type' => 'TEXT', 'null' => false ],
            'is_active' => [ 'type' => 'TINYINT', 'constraint' => 1, 'default' => 1 ],
            'created_at' => [ 'type' => 'DATETIME', 'null' => true ],
            'updated_at' => [ 'type' => 'DATETIME', 'null' => true ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->addUniqueKey('qr_id');
        $this->forge->addKey('location');
        $this->forge->addKey('valid_date');
        $this->forge->addKey('is_active');
        $this->forge->createTable('qr_codes', true);

        // rise_qr_attendance_logs
        $this->forge->addField([
            'id' => [ 'type' => 'INT', 'constraint' => 11, 'auto_increment' => true ],
            'user_id' => [ 'type' => 'INT', 'constraint' => 11, 'null' => false ],
            'qr_id' => [ 'type' => 'VARCHAR', 'constraint' => 255, 'null' => false ],
            'attendance_status' => [ 'type' => 'VARCHAR', 'constraint' => 50, 'default' => 'Present' ],
            'location_scanned' => [ 'type' => 'VARCHAR', 'constraint' => 255, 'null' => false ],
            'ip_address' => [ 'type' => 'VARCHAR', 'constraint' => 45, 'null' => true ],
            'scanned_at' => [ 'type' => 'DATETIME', 'null' => true ],
            'user_latitude' => [ 'type' => 'DECIMAL', 'constraint' => '10,8', 'null' => true ],
            'user_longitude' => [ 'type' => 'DECIMAL', 'constraint' => '11,8', 'null' => true ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->addKey('user_id');
        $this->forge->addKey('qr_id');
        $this->forge->addKey('scanned_at');
        $this->forge->createTable('qr_attendance_logs', true);

        // Add FK to rise_users
        $prefix = $this->db->getPrefix();
        $qrLogsTable = $prefix . 'qr_attendance_logs';
        $usersTable = $prefix . 'users';
        $this->db->query("ALTER TABLE `{$qrLogsTable}` ADD CONSTRAINT `fk_qr_logs_user` FOREIGN KEY (`user_id`) REFERENCES `{$usersTable}`(`id`) ON DELETE CASCADE");

        // rise_reports
        $this->forge->addField([
            'id' => [ 'type' => 'INT', 'constraint' => 11, 'auto_increment' => true ],
            'user_id' => [ 'type' => 'INT', 'constraint' => 11, 'null' => false ],
            'report_date' => [ 'type' => 'DATE', 'null' => false ],
            'morning_time' => [ 'type' => 'TIME', 'null' => true ],
            'evening_time' => [ 'type' => 'TIME', 'null' => true ],
            'total_working_hours' => [ 'type' => 'DECIMAL', 'constraint' => '4,2', 'null' => true ],
            'created_at' => [ 'type' => 'DATETIME', 'null' => true ],
            'updated_at' => [ 'type' => 'DATETIME', 'null' => true ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->addKey(['user_id','report_date']);
        $this->forge->addKey('report_date');
        $this->forge->createTable('reports', true);

        // FKs & unique keys for reports
        $reportsTable = $prefix . 'reports';
        $usersTable = $prefix . 'users';
        $this->db->query("ALTER TABLE `{$reportsTable}` ADD CONSTRAINT `fk_reports_user` FOREIGN KEY (`user_id`) REFERENCES `{$usersTable}`(`id`) ON DELETE CASCADE");
        $this->db->query("ALTER TABLE `{$reportsTable}` ADD UNIQUE KEY `uniq_user_report_date` (`user_id`,`report_date`)");
    }

    public function down()
    {
        $prefix = $this->db->getPrefix();
        $qrLogsTable = $prefix . 'qr_attendance_logs';
        $reportsTable = $prefix . 'reports';
        // Drop FKs first
        $this->db->query("ALTER TABLE `{$qrLogsTable}` DROP FOREIGN KEY `fk_qr_logs_user`");
        $this->db->query("ALTER TABLE `{$reportsTable}` DROP FOREIGN KEY `fk_reports_user`");
        // Drop tables
        $this->forge->dropTable('reports', true);
        $this->forge->dropTable('qr_attendance_logs', true);
        $this->forge->dropTable('qr_codes', true);
        $this->forge->dropTable('holidays', true);
    }
}
