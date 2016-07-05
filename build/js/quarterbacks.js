
$(function () {
	
	$("#listQuarterbacks").dataTable(
		{
			"order": [[ 2, "desc" ]],
			"lengthMenu": [[10, 25, 50], [10, 25, 50]]
		}
	);
	
});