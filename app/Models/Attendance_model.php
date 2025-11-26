<?php

namespace App\Models;

class Attendance_model extends Crud_model {

    protected $table = null;

    function __construct() {
        $this->table = 'attendance';
        parent::__construct($this->table);
    }

    function current_clock_in_record($user_id) {
        $user_id = $this->_get_clean_value($user_id);
        
        $attendnace_table = $this->db->prefixTable('attendance');
        $sql = "SELECT $attendnace_table.*
        FROM $attendnace_table
        WHERE $attendnace_table.deleted=0 AND $attendnace_table.user_id=$user_id AND $attendnace_table.status='incomplete'";
        $result = $this->db->query($sql);
        if ($result->resultID->num_rows) {
            return $result->getRow();
        } else {
            return false;
        }
    }

    function log_time($user_id, $note = "", $latitude = null, $longitude = null) {

        $user_id = $this->_get_clean_value(array("user_id" => $user_id), "user_id");

        $current_clock_record = $this->current_clock_in_record($user_id);

        $now = get_current_utc_time();

        if ($current_clock_record && $current_clock_record->id) {
            $data = array(
                "out_time" => $now,
                "status" => "pending",
                "note" => $note
            );
            $attendance_id = $this->ci_save($data, $current_clock_record->id);
            
            // Save checkout location if provided
            if ($attendance_id && $latitude !== null && $longitude !== null) {
                $this->save_geo_location($attendance_id, null, null, $latitude, $longitude);
            }
            
            return $attendance_id;
        } else {
            $data = array(
                "in_time" => $now,
                "status" => "incomplete",
                "user_id" => $user_id
            );
            $attendance_id = $this->ci_save($data);
            
            // Save checkin location if provided
            if ($attendance_id && $latitude !== null && $longitude !== null) {
                $this->save_geo_location($attendance_id, $latitude, $longitude, null, null);
            }
            
            return $attendance_id;
        }
    }

    function save_geo_location($attendance_id, $check_in_lat = null, $check_in_lng = null, $check_out_lat = null, $check_out_lng = null) {
        $db_prefix = $this->db->getPrefix();
        $geo_table = $db_prefix . 'attendance_geo';
        
        // Check if a record already exists for this attendance_id
        $existing = $this->db->query("SELECT id FROM $geo_table WHERE attendance_id = ?", [$attendance_id])->getRow();
        
        if ($existing) {
            // Update existing record
            $update_data = [];
            if ($check_in_lat !== null && $check_in_lng !== null) {
                $update_data['check_in_lat'] = $check_in_lat;
                $update_data['check_in_lng'] = $check_in_lng;
            }
            if ($check_out_lat !== null && $check_out_lng !== null) {
                $update_data['check_out_lat'] = $check_out_lat;
                $update_data['check_out_lng'] = $check_out_lng;
            }
            
            if (!empty($update_data)) {
                $builder = $this->db->table($geo_table);
                $builder->where('attendance_id', $attendance_id);
                $builder->update($update_data);
            }
        } else {
            // Insert new record
            $insert_data = [
                'attendance_id' => $attendance_id,
                'check_in_lat' => $check_in_lat,
                'check_in_lng' => $check_in_lng,
                'check_out_lat' => $check_out_lat,
                'check_out_lng' => $check_out_lng
            ];
            
            $builder = $this->db->table($geo_table);
            $builder->insert($insert_data);
        }
        
        // Also mirror into legacy columns on rise_attendance if those columns exist
        try {
            $attendance_table = $this->db->prefixTable('attendance');
            // detect columns once per request
            static $columnsChecked = null;
            if ($columnsChecked === null) {
                $columnsChecked = [
                    'in_lat' => false,
                    'in_lng' => false,
                    'out_lat' => false,
                    'out_lng' => false,
                ];
                $cols = $this->db->query("SHOW COLUMNS FROM $attendance_table")->getResult();
                foreach ($cols as $col) {
                    if ($col->Field === 'check_in_latitude') { $columnsChecked['in_lat'] = true; }
                    if ($col->Field === 'check_in_longitude') { $columnsChecked['in_lng'] = true; }
                    if ($col->Field === 'check_out_latitude') { $columnsChecked['out_lat'] = true; }
                    if ($col->Field === 'check_out_longitude') { $columnsChecked['out_lng'] = true; }
                }
            }

            $updateLegacy = [];
            if ($columnsChecked['in_lat'] && $columnsChecked['in_lng'] && $check_in_lat !== null && $check_in_lng !== null) {
                $updateLegacy['check_in_latitude'] = $check_in_lat;
                $updateLegacy['check_in_longitude'] = $check_in_lng;
            }
            if ($columnsChecked['out_lat'] && $columnsChecked['out_lng'] && $check_out_lat !== null && $check_out_lng !== null) {
                $updateLegacy['check_out_latitude'] = $check_out_lat;
                $updateLegacy['check_out_longitude'] = $check_out_lng;
            }
            if (!empty($updateLegacy)) {
                $this->db->table($attendance_table)->where('id', $attendance_id)->update($updateLegacy);
            }
        } catch (\Throwable $e) {
            // ignore mirroring failures to avoid breaking primary save
        }
        
        return true;
    }

    function get_details($options = array()) {
        $attendnace_table = $this->db->prefixTable('attendance');
        $users_table = $this->db->prefixTable('users');

        $where = "";
        $id = $this->_get_clean_value($options, "id");
        if ($id) {
            $where .= " AND $attendnace_table.id=$id";
        }
        $offset = convert_seconds_to_time_format(get_timezone_offset());

        $start_date = $this->_get_clean_value($options, "start_date");
        if ($start_date) {
            $where .= " AND DATE(ADDTIME($attendnace_table.in_time,'$offset'))>='$start_date'";
        }
        $end_date = $this->_get_clean_value($options, "end_date");
        if ($end_date) {
            $where .= " AND DATE(ADDTIME($attendnace_table.in_time,'$offset'))<='$end_date'";
        }

        $user_id = $this->_get_clean_value($options, "user_id");
        if ($user_id) {
            $where .= " AND $attendnace_table.user_id=$user_id";
        }

        $access_type = $this->_get_clean_value($options, "access_type");

        if (!$id && $access_type !== "all") {

            $allowed_members = $this->_get_clean_value($options, "allowed_members");
            if (is_array($allowed_members) && count($allowed_members)) {
                $allowed_members = join(",", $allowed_members);
            } else {
                $allowed_members = '0';
            }
            $login_user_id = $this->_get_clean_value($options, "login_user_id");
            if ($login_user_id) {
                $allowed_members .= "," . $login_user_id;
            }
            $where .= " AND $attendnace_table.user_id IN($allowed_members)";
        }

        $only_clocked_in_members = $this->_get_clean_value($options, "only_clocked_in_members");
        if ($only_clocked_in_members) {
            $where .= " AND $attendnace_table.status = 'incomplete'";
        }

        $sql = "SELECT $attendnace_table.*,  CONCAT($users_table.first_name, ' ',$users_table.last_name) AS created_by_user, $users_table.image as created_by_avatar, $users_table.id as user_id, $users_table.job_title as user_job_title
        FROM $attendnace_table
        LEFT JOIN $users_table ON $users_table.id = $attendnace_table.user_id
        WHERE $attendnace_table.deleted=0 $where
        ORDER BY $attendnace_table.in_time DESC";
        return $this->db->query($sql);
    }

    function get_summary_details($options = array()) {
        $attendnace_table = $this->db->prefixTable('attendance');
        $users_table = $this->db->prefixTable('users');

        $where = "";
        $offset = convert_seconds_to_time_format(get_timezone_offset());

        $start_date = $this->_get_clean_value($options, "start_date");
        if ($start_date) {
            $where .= " AND DATE(ADDTIME($attendnace_table.in_time,'$offset'))>='$start_date'";
        }
        $end_date = $this->_get_clean_value($options, "end_date");
        if ($end_date) {
            $where .= " AND DATE(ADDTIME($attendnace_table.in_time,'$offset'))<='$end_date'";
        }

        $user_id = $this->_get_clean_value($options, "user_id");
        if ($user_id) {
            $where .= " AND $attendnace_table.user_id=$user_id";
        }

        $access_type = $this->_get_clean_value($options, "access_type");

        if ($access_type !== "all") {

            $allowed_members = $this->_get_clean_value($options, "allowed_members");
            if (is_array($allowed_members) && count($allowed_members)) {
                $allowed_members = join(",", $allowed_members);
            } else {
                $allowed_members = '0';
            }
            $login_user_id = $this->_get_clean_value($options, "login_user_id");
            if ($login_user_id) {
                $allowed_members .= "," . $login_user_id;
            }
            $where .= " AND $attendnace_table.user_id IN($allowed_members)";
        }



        //we'll show the details deport in summary_detials view         
        $extra_inner_select = "";
        $extra_group_by = "";
        $extra_select = "";
        $sort_by = "";
        if ($this->_get_clean_value($options, "summary_details")) {
            $extra_select = ", start_date ";
            $extra_inner_select = ", MAX(DATE(ADDTIME($attendnace_table.in_time,'$offset'))) AS start_date ";
            $extra_group_by = ", DATE(ADDTIME($attendnace_table.in_time,'$offset')) ";
            $sort_by = "ORDER BY user_id, start_date ASC"; //order by must be with user_id 
        }


        $sql = "SELECT user_id, total_duration, CONCAT($users_table.first_name, ' ',$users_table.last_name) AS created_by_user, $users_table.image as created_by_avatar $extra_select
                 FROM (SELECT $attendnace_table.user_id, SUM(TIMESTAMPDIFF(SECOND, $attendnace_table.in_time, $attendnace_table.out_time)) AS total_duration $extra_inner_select
                    FROM $attendnace_table
                    WHERE $attendnace_table.deleted=0 $where 
                    GROUP BY $attendnace_table.user_id $extra_group_by) AS new_summary_table 
                LEFT JOIN $users_table ON $users_table.id = new_summary_table.user_id
                $sort_by    
               ";

        return $this->db->query($sql);
    }

    function count_clock_status($options = array()) {
        $attendnace_table = $this->db->prefixTable('attendance');
        $users_table = $this->db->prefixTable('users');

        $total_members_where = "";
        $clocked_in_members_where = "";
        $access_type = $this->_get_clean_value($options, "access_type");
        if ($access_type !== "all") {

            $allowed_members = $this->_get_clean_value($options, "allowed_members");
            if (is_array($allowed_members) && count($allowed_members)) {
                $allowed_members = join(",", $allowed_members);
            } else {
                $allowed_members = '0';
            }
            $login_user_id = $this->_get_clean_value($options, "login_user_id");
            if ($login_user_id) {
                $allowed_members .= "," . $login_user_id;
            }
            $total_members_where .= " AND $users_table.id IN ($allowed_members)";
            $clocked_in_members_where .= " AND $attendnace_table.user_id IN ($allowed_members)";
        }

        $clocked_in = "SELECT $attendnace_table.user_id
        FROM $attendnace_table
        WHERE $attendnace_table.deleted=0 AND $attendnace_table.status='incomplete' $clocked_in_members_where
        GROUP BY $attendnace_table.user_id";
        $clocked_in_result = $this->db->query($clocked_in);

        $total_members = "SELECT COUNT(id) AS total_members
        FROM $users_table
        WHERE $users_table.deleted=0 AND $users_table.user_type='staff' AND $users_table.status='active' $total_members_where";
        $total_members_result = $this->db->query($total_members)->getRow()->total_members;

        $info = new \stdClass();
        $info->members_clocked_in = $clocked_in_result->resultID->num_rows;
        $info->total_members = $total_members_result ? $total_members_result : 0;
        $info->members_clocked_out = $total_members_result - $info->members_clocked_in;

        return $info;
    }

    function get_timecard_statistics($options = array()) {
        $attendnace_table = $this->db->prefixTable('attendance');

        $where = "";
        $offset = convert_seconds_to_time_format(get_timezone_offset());

        $start_date = $this->_get_clean_value($options, "start_date");
        if ($start_date) {
            $where .= " AND DATE(ADDTIME($attendnace_table.in_time,'$offset'))>='$start_date'";
        }
        $end_date = $this->_get_clean_value($options, "end_date");
        if ($end_date) {
            $where .= " AND DATE(ADDTIME($attendnace_table.in_time,'$offset'))<='$end_date'";
        }

        $user_id = $this->_get_clean_value($options, "user_id");
        if ($user_id) {
            $where .= " AND $attendnace_table.user_id=$user_id";
        }

        $sql = "SELECT DATE_FORMAT($attendnace_table.in_time,'%d') AS day, SUM(TIME_TO_SEC(TIMEDIFF($attendnace_table.out_time,$attendnace_table.in_time))) total_sec
                FROM $attendnace_table 
                WHERE $attendnace_table.deleted=0 AND $attendnace_table.status!='incomplete' $where
                GROUP BY DATE($attendnace_table.in_time)";
        return $this->db->query($sql);
    }

    function get_clocked_out_members($options = array()) {
        $attendnace_table = $this->db->prefixTable('attendance');
        $users_table = $this->db->prefixTable('users');

        $where = "";
        $access_type = $this->_get_clean_value($options, "access_type");
        if ($access_type !== "all") {

            $allowed_members = $this->_get_clean_value($options, "allowed_members");
            if (is_array($allowed_members) && count($allowed_members)) {
                $allowed_members = join(",", $allowed_members);
            } else {
                $allowed_members = '0';
            }
            $login_user_id = $this->_get_clean_value($options, "login_user_id");
            if ($login_user_id) {
                $allowed_members .= "," . $login_user_id;
            }
            $where .= " AND $users_table.id IN ($allowed_members)";
        }

        $sql = "SELECT CONCAT($users_table.first_name, ' ',$users_table.last_name) AS member_name, $users_table.last_online, $users_table.image, $users_table.id, $users_table.job_title
        FROM $users_table
        WHERE $users_table.deleted=0 AND $users_table.status='active' AND $users_table.user_type='staff' AND $users_table.id NOT IN (SELECT user_id from $attendnace_table WHERE $attendnace_table.deleted=0 AND $attendnace_table.status='incomplete') $where
        ORDER BY $users_table.first_name DESC";
        return $this->db->query($sql);
    }

    function get_clock_in_out_details_of_all_users($options = array()) {
        $attendnace_table = $this->db->prefixTable('attendance');
        $users_table = $this->db->prefixTable('users');

        $where = "";

        $id = $this->_get_clean_value($options, "id");
        if ($id) {
            $where .= " AND $users_table.id=$id";
        }

        $where_in = $this->_get_clean_value($options, "where_in");
        if ($where_in) {
            $where_in_implode = implode(',', $where_in);
            $where .= " AND $users_table.id IN($where_in_implode)";
        }

        $sql = "SELECT CONCAT($users_table.first_name, ' ',$users_table.last_name) AS member_name, $users_table.image, $users_table.id, attendance_table.id AS attendance_id, attendance_table.in_time
        FROM $users_table
        LEFT JOIN (SELECT user_id, id, in_time FROM $attendnace_table WHERE $attendnace_table.deleted=0 AND $attendnace_table.status='incomplete') AS attendance_table ON attendance_table.user_id=$users_table.id
        WHERE $users_table.deleted=0 AND $users_table.status='active' AND $users_table.user_type='staff' $where";
        return $this->db->query($sql);
    }

    // Get today's latest attendance per user with geolocation
    function get_today_logins($date = null) {
        $date = $date ? $this->_get_clean_value($date) : date('Y-m-d');

        $attendnace_table = $this->db->prefixTable('attendance');
        $users_table = $this->db->prefixTable('users');
        $db_prefix = $this->db->getPrefix();
        $geo_table = $db_prefix . 'attendance_geo'; // rise_attendance_geo

        $date = $this->_get_clean_value(array('date' => $date), 'date');

        $sql = "SELECT a.*, CONCAT(u.first_name, ' ', u.last_name) AS user_name,
                       g.check_in_lat, g.check_in_lng, g.check_out_lat, g.check_out_lng
                FROM $attendnace_table a
                INNER JOIN $users_table u ON u.id = a.user_id AND u.deleted = 0
                LEFT JOIN $geo_table g ON g.attendance_id = a.id
                WHERE a.deleted = 0 AND DATE(a.in_time) = '$date'
                  AND a.id IN (
                      SELECT MAX(id) FROM $attendnace_table
                      WHERE deleted = 0 AND DATE(in_time) = '$date'
                      GROUP BY user_id
                  )
                ORDER BY a.in_time DESC";

        return $this->db->query($sql);
    }

}
