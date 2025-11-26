<div class="page-title clearfix">
    <h1>Attendance Work Reports</h1>
</div>
<div class="card">
    <div class="table-responsive">
        <table class="table" id="attendance-reports-table">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>User</th>
                    <th>Morning</th>
                    <th>Evening</th>
                    <th>Total Hours</th>
                    <th>Location</th>
                </tr>
            </thead>
        </table>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#attendance-reports-table").appTable({
            source: '<?php echo get_uri("attendancereports/list_data"); ?>',
            dateRangeType: "daily",
            columns: [
                {title: 'Date'},
                {title: 'User'},
                {title: 'Morning'},
                {title: 'Evening'},
                {title: 'Total Hours'},
                {title: 'Location'}
            ]
        });
    });
</script>
