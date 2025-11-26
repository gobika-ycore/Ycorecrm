<div class="page-title clearfix">
    <h1>Holidays</h1>
</div>
<div class="card">
    <div class="table-responsive">
        <table class="table" id="holidays-table">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Name</th>
                    <th>Type</th>
                </tr>
            </thead>
        </table>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#holidays-table").appTable({
            source: '<?php echo get_uri("holidays/list_data"); ?>',
            columns: [
                {title: 'Date'},
                {title: 'Name'},
                {title: 'Type'}
            ]
        });
    });
</script>
