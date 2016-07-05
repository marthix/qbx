<div class="box box-warning">
	
	<div class="box-header with-border">
		<i class="fa fa-database"></i>
		<h3 class="box-title">Edit Game Data</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	
	<div class="box-body">
	
		<form onsubmit="submitGameData(); return false;" action="#" id="submitGameDataForm" class="form-group" style="margin-bottom: 0; padding: 0;">
			
			<div id="submitGameData" style="min-height: 200px;">
			
				SELECT GAME TO EDIT
			
			</div>
			
		</form>
		
	</div>
	
	<div id="submitGameDataLoading" style="display: none;">
		<i class="fa fa-refresh fa-spin"></i>
	</div>
	
</div>