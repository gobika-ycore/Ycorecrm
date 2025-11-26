<div class="page-title clearfix">
    <h1>QR Attendance Logs</h1>
</div>
<div class="card">
    <div class="table-responsive">
        <table class="table" id="qr-logs-table">
            <thead>
                <tr>
                    <th>Scanned At</th>
                    <th>User ID</th>
                    <th>QR ID</th>
                    <th>Status</th>
                    <th>Location</th>
                </tr>
            </thead>
        </table>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#qr-logs-table").appTable({
            source: '<?php echo get_uri("qrattendance/list_data"); ?>',
            columns: [
                {title: 'Scanned At'},
                {title: 'User ID'},
                {title: 'QR ID'},
                {title: 'Status'},
                {title: 'Location'}
            ]
        });
    });
</script>
