<div class="page-title clearfix">
    <h1>Today's Logins</h1>
    <div class="title-button-group">
        <span class="text-muted">Date: <?php echo format_to_date($date); ?></span>
    </div>
</div>

<div class="card">
    <div class="table-responsive">
        <table class="display dataTable" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>User</th>
                    <th>Check-in Time</th>
                    <th>Check-out Time</th>
                    <th>Status</th>
                    <th>Check-in Location</th>
                    <th>Check-out Location</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($today_logins)) { ?>
                    <?php foreach ($today_logins as $row) { ?>
                        <tr>
                            <td><?php echo get_team_member_profile_link($row->user_id, $row->user_name); ?></td>
                            <td><?php echo $row->in_time ? format_to_time($row->in_time) : "-"; ?></td>
                            <td><?php echo $row->out_time ? format_to_time($row->out_time) : "-"; ?></td>
                            <td><?php echo ucfirst($row->status); ?></td>
                            <td>
                                <?php if (!is_null($row->check_in_lat) && !is_null($row->check_in_lng)) { 
                                    $mapUrl = "https://maps.google.com/?q=" . $row->check_in_lat . "," . $row->check_in_lng;
                                ?>
                                    <a href="<?php echo $mapUrl; ?>" target="_blank">View on map</a>
                                <?php } else { echo "-"; } ?>
                            </td>
                            <td>
                                <?php if (!is_null($row->check_out_lat) && !is_null($row->check_out_lng)) { 
                                    $mapUrl2 = "https://maps.google.com/?q=" . $row->check_out_lat . "," . $row->check_out_lng;
                                ?>
                                    <a href="<?php echo $mapUrl2; ?>" target="_blank">View on map</a>
                                <?php } else { echo "-"; } ?>
                            </td>
                        </tr>
                    <?php } ?>
                <?php } else { ?>
                    <tr>
                        <td colspan="6" class="text-center text-muted">No logins found for this date.</td>
                    </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
</div>
