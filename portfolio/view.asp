<!DOCTYPE html>
<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<!--#include virtual="/build/asp/framework/headers.asp"-->
<%
	thisPage = "Portfolio"
%>
<html>
	
	<head>
		
		<title>Portfolio - <%= Session.Contents("QBX_View_User_Name") %> - The Quarterback Exchange</title>
		
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
						
					<h1>Portfolio Overview</h1>
					<ol class="breadcrumb">
						<li><a href="/"><i class="fa fa-dashboard"></i> Dashboard</a></li>
						<li class="active"><a href="/portfolio/"><i class="fa fa-bar-chart"></i> Portfolio</a></li>
					</ol>
				</section>
				
				<section class="content">
				
					<!--#include virtual="/build/asp/widgets/view_portfolioWidgets.asp"-->
					
					<div class="row">
					
						<div class="col-lg-12">
							<!--#include virtual="/build/asp/widgets/view_listHoldings.asp"-->
						</div>
					
					</div>
					
					<div class="row">
					
						<div class="col-lg-8">
							<!--#include virtual="/build/asp/widgets/view_listTransactions.asp"-->
						</div>
					
						<div class="col-lg-4">
							<!--#include virtual="/build/asp/widgets/view_portfolioHistory.asp"-->
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
		<script src="/plugins/chartjs/Chart.min.js" type="text/javascript"></script>
		<script src="/plugins/chartjs/Chart.HorizontalBar.js" type="text/javascript"></script>
		
		<!--#include virtual="/build/js/portfolio.asp"-->	
		
		<!--#include virtual="/build/asp/framework/google.asp"-->	

</body>
	
</html>