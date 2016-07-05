<!DOCTYPE html>
<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<!--#include virtual="/build/asp/framework/headers.asp"-->
<%
	thisPage = "Quarterbacks"
%>
<html>
	
	<head>
		
		<title><%= Session.Contents("QBX_Current_QB_Name") %> - The Quarterback Exchange</title>
		
		<meta charset="UTF-8">
		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
		
		<link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		<link href="/build/css/main.css" rel="stylesheet" type="text/css" />
		<link href="/plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
		<link href="/plugins/datatables/extensions/Responsive/css/dataTables.responsive.css" rel="stylesheet" type="text/css" />
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
		<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
		<link href="/plugins/bootstrap-slider/slider.css" rel="stylesheet" type="text/css" />
		
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
					<h1><%= Session.Contents("QBX_Current_QB_Name") %></h1>
					<ol class="breadcrumb">
						<li><a href="/"><i class="fa fa-dashboard"></i> Dashboard</a></li>
						<li class="active"><a href="/quarterbacks/"><i class="fa fa-users"></i> Quarterbacks</a></li>
					</ol>
				</section>
				
				<section class="content">
				
					<div class="row">
					
						<div class="col-lg-6">
							<!--#include virtual="/build/asp/widgets/qb_overview.asp"-->
						</div>
						
						<div class="col-lg-2">
							<!--#include virtual="/build/asp/widgets/qb_buy.asp"-->
						</div>
						
						<div class="col-lg-2">
							<!--#include virtual="/build/asp/widgets/qb_sell.asp"-->
						</div>
						
						<div class="col-lg-2">
							<!--#include virtual="/build/asp/widgets/qb_holdings.asp"-->
						</div>
						
					</div>
					
					<div class="row">
					
						<div class="col-lg-4">
							<!--#include virtual="/build/asp/widgets/qb_values_2015.asp"-->
						</div>
						
						<div class="col-lg-4">
							<!--#include virtual="/build/asp/widgets/qb_stats_2015.asp"-->
						</div>
						
						<div class="col-lg-4">
							<!--#include virtual="/build/asp/widgets/qb_values_against_average_2015.asp"-->
						</div>
						
					</div>

<%
					sqlCheck2014 = "SELECT COUNT(samelevel.qbx_tracker.tracker_ID) AS TotalGames FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " AND samelevel.qbx_games.game_Year = 2014"
					Set rsCheck  = sqlSameLevel.Execute(sqlCheck2014)
					
					If CInt(rsCheck("TotalGames")) > 0 Then
						
						played2014 = 1
						rsCheck.Close
						Set rsCheck = Nothing
%>
						<div class="row">
						
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_2014.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_stats_2014.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_against_average_2014.asp"-->
							</div>
							
						</div>
<%
					End If
					
					sqlCheck2013 = "SELECT COUNT(samelevel.qbx_tracker.tracker_ID) AS TotalGames FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " AND samelevel.qbx_games.game_Year = 2013"
					Set rsCheck  = sqlSameLevel.Execute(sqlCheck2013)
					
					If CInt(rsCheck("TotalGames")) > 0 Then
					
						played2013 = 1
						rsCheck.Close
						Set rsCheck = Nothing
%>
						<div class="row">
						
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_2013.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_stats_2013.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_against_average_2013.asp"-->
							</div>
							
						</div>
<%
					End If
					
					sqlCheck2012 = "SELECT COUNT(samelevel.qbx_tracker.tracker_ID) AS TotalGames FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " AND samelevel.qbx_games.game_Year = 2012"
					Set rsCheck  = sqlSameLevel.Execute(sqlCheck2012)
					
					If CInt(rsCheck("TotalGames")) > 0 Then
					
						played2012 = 1
						rsCheck.Close
						Set rsCheck = Nothing
%>
						<div class="row">
						
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_2012.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_stats_2012.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_against_average_2012.asp"-->
							</div>
							
						</div>
<%
					End If
					
					sqlCheck2011 = "SELECT COUNT(samelevel.qbx_tracker.tracker_ID) AS TotalGames FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " AND samelevel.qbx_games.game_Year = 2011"
					Set rsCheck  = sqlSameLevel.Execute(sqlCheck2011)
					
					If CInt(rsCheck("TotalGames")) > 0 Then
					
						played2011 = 1
						rsCheck.Close
						Set rsCheck = Nothing
%>
						<div class="row">
						
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_2011.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_stats_2011.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_against_average_2011.asp"-->
							</div>
							
						</div>
<%
					End If
					
					sqlCheck2010 = "SELECT COUNT(samelevel.qbx_tracker.tracker_ID) AS TotalGames FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND samelevel.qbx_games.game_Year = 2010"
					Set rsCheck  = sqlSameLevel.Execute(sqlCheck2010)
					
					If CInt(rsCheck("TotalGames")) > 0 Then
					
						played2010 = 1
						rsCheck.Close
						Set rsCheck = Nothing
%>
						<div class="row">
						
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_2010.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_stats_2010.asp"-->
							</div>
							
							<div class="col-lg-4">
								<!--#include virtual="/build/asp/widgets/qb_values_against_average_2010.asp"-->
							</div>
							
						</div>
<%
					End If
%>
					
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
		
		<script src="/plugins/bootstrap-slider/bootstrap-slider.js" type="text/javascript"></script>
		<script src="/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
		<script src="/plugins/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>
		<script src="/plugins/datatables/extensions/Responsive/js/dataTables.responsive.min.js" type="text/javascript"></script>
		<script src="/plugins/chartjs/Chart.min.js" type="text/javascript"></script>
		
		<!--#include virtual="/build/js/profile.asp"-->	
		
		<!--#include virtual="/build/asp/framework/google.asp"-->	

</body>
	
</html>