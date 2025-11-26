<?php
$wrapper_start = '<div id="js-clock-in-out" class="card dashboard-icon-widget clock-in-out-card" >';
$wrapper_end = '</div>';

if (isset($remove_wrapper) && $remove_wrapper == 1) {
    $wrapper_start = "";
    $wrapper_end = "";
} ?>
<?php echo  $wrapper_start; ?>

<div class="card-body">
    <div class="widget-icon  <?php echo (isset($clock_status->id)) ? 'bg-info' : 'bg-coral'; ?> ">
        <i data-feather="clock" class="icon"></i>
    </div>
    <div class="widget-details">
        <?php
        if (isset($clock_status->id)) {
            echo modal_anchor(get_uri("attendance/note_modal_form"), "<i data-feather='log-out' class='icon-16'></i> " . app_lang('clock_out'), array("class" => "btn btn-default text-primary", "title" => app_lang('clock_out'), "id" => "timecard-clock-out", "data-post-id" => $clock_status->id, "data-post-clock_out" => 1));

            $in_time = format_to_time($clock_status->in_time);
            $in_datetime = format_to_datetime($clock_status->in_time);
            echo "<div class='mt5 bg-transparent-white' title='$in_datetime'>" . app_lang('clock_started_at') . " : $in_time</div>";
        } else {
            echo ajax_anchor(get_uri("attendance/log_time"), "<i data-feather='log-out' class='icon-16'></i> " . app_lang('clock_in'), array("class" => "btn btn-default text-danger spinning-btn clock-in-btn", "title" => app_lang('clock_in'), "data-inline-loader" => "1", "data-closest-target" => "#js-clock-in-out"));
            echo "<div class='mt5 bg-transparent-white'>" . app_lang('you_are_currently_clocked_out') . "</div>";
        }
        ?>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    // Capture geolocation for clock in
    $(document).on('click', '.clock-in-btn', function(e) {
        e.preventDefault();
        var $btn = $(this);
        
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function(position) {
                    // Success - send request with location
                    sendClockRequest($btn, position.coords.latitude, position.coords.longitude);
                },
                function(error) {
                    // Error or user denied - send request without location
                    console.log('Geolocation error:', error.message);
                    sendClockRequest($btn, null, null);
                }
            );
        } else {
            // Geolocation not supported - send request without location
            sendClockRequest($btn, null, null);
        }
    });
    
    function sendClockRequest($btn, latitude, longitude) {
        var url = $btn.attr('href');
        var target = $btn.data('closest-target');
        
        $.ajax({
            url: url,
            type: 'POST',
            dataType: 'json',
            data: {
                latitude: latitude,
                longitude: longitude
            },
            beforeSend: function() {
                $btn.find('.icon-16').replaceWith('<i class="fa fa-spinner fa-spin icon-16"></i>');
            },
            success: function(response) {
                if (response.success) {
                    if (target) {
                        $(target).html(response);
                    }
                    location.reload();
                }
            },
            error: function() {
                appAlert.error('<?php echo app_lang("error_occurred"); ?>');
                location.reload();
            }
        });
    }
});
</script>
<?php echo  $wrapper_end; ?>