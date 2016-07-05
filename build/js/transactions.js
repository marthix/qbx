$(function () {
	
	$("#listAllTransactions").dataTable(
		{
			"order": [[ 0, "desc" ]],
			"lengthMenu": [[10, 25, 50], [10, 25, 50]]
		}
	);
	
});