<!DOCTYPE html>
<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<!--#include virtual="/build/asp/framework/headers.asp"-->
<%
	thisPage = "Dashboard"
%>
<html>
	
	<head>
		
		<title>The Quarterback Exchange</title>
		
		<meta charset="UTF-8">
		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
		
		<link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		<link href="/build/css/main.css" rel="stylesheet" type="text/css" />
		<link href="/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
		<link href="/plugins/datatables/extensions/Responsive/css/dataTables.responsive.css" rel="stylesheet" type="text/css" />
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
		<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
		
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

	</head>
	
	<body class="sidebar-mini skin-green">
	
		<div class="wrapper">
		
			<!--#include virtual="/build/asp/framework/navbar.asp"-->
			
			<!--#include virtual="/build/asp/framework/sidebar.asp"-->
			
			<div class="content-wrapper">
			
				<section class="content-header">
				
				</section>
				
				<section class="content">
				
					<div class="row">
					
						<div class="col-lg-6">
						
							<div class="row">
							
								<div class="col-lg-12">
								
									<!--#include virtual="/build/asp/widgets/dashboard_welcome.asp"-->
								
								</div>
								
							</div>
							
							<div class="row">
							
								<div class="col-lg-6">
								
									<!--#include virtual="/build/asp/widgets/dashboard_good_teams.asp"-->
								
								</div>
								
								<div class="col-lg-6">
									
									<!--#include virtual="/build/asp/widgets/dashboard_good_quarterbacks.asp"-->
									
								</div>
							
							</div>
							
							<div class="row">
							
								<div class="col-lg-6">
								
									<!--#include virtual="/build/asp/widgets/dashboard_bad_teams.asp"-->
								
								</div>
								
								<div class="col-lg-6">
									
									<!--#include virtual="/build/asp/widgets/dashboard_bad_quarterbacks.asp"-->
									
								</div>
							
							</div>
							
							<div class="row">
							
								<div class="col-lg-12">
								
									<!--#include virtual="/build/asp/widgets/dashboard_transactions.asp"-->
									
								</div>
								
							</div>
						
						</div>
						
						<div class="col-lg-6">
							
							<!--#include virtual="/build/asp/widgets/timeline.asp"-->
							
						</div>
						
					</div>
					
				</section>
				
			</div>
			
			<!--#include virtual="/build/asp/framework/footer.asp"-->
			
			<!--#include virtual="/build/asp/framework/recent.asp"-->
			
		</div>
		
		<script src="/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
		<script src="/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/build/js/app.min.js" type="text/javascript"></script>
		<script src="/plugins/fastclick/fastclick.min.js" type="text/javascript"></script>
		<script src="/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
		
		<script src="/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
		<script src="/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
		<script src="/plugins/datatables/extensions/Responsive/js/dataTables.responsive.min.js" type="text/javascript"></script>
		
		<!--#include virtual="/build/js/dashboard.asp"-->	
		
		<!--#include virtual="/build/asp/framework/google.asp"-->	

	</body>
	
</html>