<div id="page-content" class="page-wrapper clearfix grid-button">

    <div class="card">
        <ul id="attendance-tabs" data-bs-toggle="ajax-tab" class="nav nav-tabs bg-white title scrollable-tabs" role="tablist">
            <li class="title-tab"><h4 class="pl15 pt10 pr15"><?php echo app_lang("attendance"); ?></h4></li>

            <li><a role="presentation" data-bs-toggle="tab"  href="javascript:;" data-bs-target="#daily-attendance"><?php echo app_lang("daily"); ?></a></li>
            <li><a role="presentation" data-bs-toggle="tab" href="<?php echo_uri("attendance/custom/"); ?>" data-bs-target="#custom-attendance"><?php echo app_lang('custom'); ?></a></li>
            <li><a role="presentation" data-bs-toggle="tab" href="<?php echo_uri("attendance/summary/"); ?>" data-bs-target="#summary-attendance"><?php echo app_lang('summary'); ?></a></li>
            <li><a role="presentation" data-bs-toggle="tab" href="<?php echo_uri("attendance/summary_details/"); ?>" data-bs-target="#summary-attendance-details"><?php echo app_lang('summary_details'); ?></a></li>
            <li><a role="presentation" data-bs-toggle="tab" href="<?php echo_uri("attendance/members_clocked_in/"); ?>" data-bs-target="#members-clocked-in"><?php echo app_lang('members_clocked_in'); ?></a></li>
            <li><a role="presentation" data-bs-toggle="tab" href="<?php echo_uri("attendance/clock_in_out"); ?>" data-bs-target="#clock-in-out"><?php echo app_lang('clock_in_out'); ?></a></li>

            <div class="tab-title clearfix no-border time-card-page-title">
                <div class="title-button-group">
                    <?php echo modal_anchor(get_uri("attendance/modal_form"), "<i data-feather='plus-circle' class='icon-16'></i> " . app_lang('add_attendance'), array("class" => "btn btn-default", "title" => app_lang('add_attendance'))); ?>
                </div>
            </div>
        </ul>

        <div class="tab-content">
            <div role="tabpanel" class="tab-pane fade" id="daily-attendance">
                <div class="table-responsive">
                    <table id="attendance-table" class="display" cellspacing="0" width="100%">
                    </table>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane fade" id="custom-attendance"></div>
            <div role="tabpanel" class="tab-pane fade" id="summary-attendance"></div>
            <div role="tabpanel" class="tab-pane fade" id="summary-attendance-details"></div>
            <div role="tabpanel" class="tab-pane fade" id="members-clocked-in"></div>
            <div role="tabpanel" class="tab-pane fade" id="clock-in-out"></div>
        </div>
    </div>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        $("#attendance-table").appTable({
            source: '<?php echo_uri("attendance/today_list_data/"); ?>',
            order: [[1, "desc"]],
            // date picker shows a single selected date (daily)
            dateRangeType: "daily",
            columns: [
                {title: "<?php echo app_lang("team_member"); ?>", "class": "w20p"},
                {title: "<?php echo app_lang("in_time"); ?>", "class": "w15p"},
                {title: "<?php echo app_lang("out_time"); ?>", "class": "w15p"},
                {title: "<?php echo app_lang("status"); ?>", "class": "w10p"},
                {title: "<?php echo app_lang("check_in"); ?>", "class": "w10p"},
                {title: "<?php echo app_lang("check_out"); ?>", "class": "w10p"}
            ],
            printColumns: [0, 1, 2, 3],
            xlsColumns: [0, 1, 2, 3]
        });

        setTimeout(function () {
            var tab = "<?php echo $tab; ?>";
            if (tab === "members_clocked_in") {
                $("[data-bs-target='#members-clocked-in']").trigger("click");
            } else if (tab === "clock_in_out") {
                $("[data-bs-target='#clock-in-out']").trigger("click");
            }
        }, 210);
        
        // Global handler for clock in/out buttons with geolocation
        $(document).on('click', '[data-action-url*="attendance/log_time"]', function(e) {
            var $btn = $(this);
            var actionUrl = $btn.data('action-url');
            
            // Check if this is a clock in/out action
            if (actionUrl && actionUrl.indexOf('attendance/log_time') !== -1) {
                e.preventDefault();
                e.stopPropagation();
                
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(
                        function(position) {
                            // Add location data to the request
                            performClockAction($btn, actionUrl, position.coords.latitude, position.coords.longitude);
                        },
                        function(error) {
                            console.log('Geolocation error:', error.message);
                            // Continue without location
                            performClockAction($btn, actionUrl, null, null);
                        }
                    );
                } else {
                    // Geolocation not supported
                    performClockAction($btn, actionUrl, null, null);
                }
            }
        });
        
        function performClockAction($btn, url, latitude, longitude) {
            $.ajax({
                url: url,
                type: 'POST',
                dataType: 'json',
                data: {
                    latitude: latitude,
                    longitude: longitude
                },
                beforeSend: function() {
                    $btn.prop('disabled', true);
                    appLoader.show();
                },
                success: function(response) {
                    if (response.success) {
                        appAlert.success(response.message);
                        if (response.data) {
                            $(".dataTable:visible").appTable({newData: response.data, dataId: response.id});
                        } else {
                            $(".dataTable:visible").appTable({reload: true});
                        }
                    }
                    appLoader.hide();
                },
                error: function() {
                    appAlert.error('<?php echo app_lang("error_occurred"); ?>');
                    appLoader.hide();
                }
            });
        }

    });
</script>    
