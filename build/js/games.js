
$(function () {
	
	$("#listGames").dataTable(
		{
			"columnDefs": [ { "targets": 4, "orderable": false } ],
			"lengthMenu": [[10, 25, 50], [10, 25, 50]]
		}
	);
	
});

function submitGameData() {
	
	document.getElementById("submitGameDataLoading").style.display = "block";
	document.getElementById("submitGameDataLoading").className = "overlay";
	
	$.ajax({
		url: '/build/asp/ajax/submitGameData.asp',
		dataType: 'text',
		type: 'post',
		contentType: 'application/x-www-form-urlencoded',
		data: $("#submitGameDataForm").serialize(),
		success: function( data, textStatus, jQxhr ){
			
			var game_ID = document.getElementById("game_ID").value;
			document.getElementById("status" + game_ID).innerHTML = "<span style=\"color: green;\"><i class=\"fa fa-check-circle\"></i></span>";
			document.getElementById("submitGameDataLoading").style.display = "none";
			document.getElementById("submitGameDataLoading").className = "";
			
			$('#submitGameData').html( data );
			
			$('#successMessage').delay(5000).fadeOut();
			
			loadGameData(game_ID);
			
		},
		error: function( jqXhr, textStatus, errorThrown ){ console.log( errorThrown ); }
	});
	
}

function loadGameData(game_ID) {
	
	document.getElementById("submitGameDataLoading").style.display = "block";
	document.getElementById("submitGameDataLoading").className = "overlay";
	
	$.ajax({
		url: '/build/asp/ajax/loadGameData.asp',
		dataType: 'text',
		type: 'post',
		data: {'game_ID': game_ID},
		success: function( data, textStatus, jQxhr ){
			
			document.getElementById("submitGameDataLoading").style.display = "none";
			document.getElementById("submitGameDataLoading").className = "";
			
			$('#submitGameData').html( data );
			
		},
		error: function( jqXhr, textStatus, errorThrown ){ console.log( errorThrown ); }
	});
	
}