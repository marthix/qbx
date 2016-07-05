$(function () {
	
	$("#currentStandings").dataTable(
		{
			"columnDefs": [ { "targets": "_all", "orderable": false } ],
			"order": [[ 4, "desc" ]],
			"bFilter" : false,
			"paging" : false,
			"info" : false,              
			"bLengthChange": false
		}
	);
	
});