<script>
$(function () {
	
	$("#recentTransactions").dataTable(
		{
			"lengthMenu": [[10, 10, 25], [10, 10, 25]],
			"bFilter" : false,               
			"bLengthChange": false
		}
	);
	
});
</script>