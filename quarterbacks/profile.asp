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
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
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
					
					<div class="row">
<%
						sqlGetNewTeamID = "SELECT qb_Team FROM qbx_quarterbacks WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID")
						Set rsNewTeamID = sqlSameLevel.Execute(sqlGetNewTeamID)
						
						If Not rsNewTeamID.Eof Then
						
							this_QB_Team_ID = rsNewTeamID("qb_Team")
							rsNewTeamID.Close
							Set rsNewTeamID = Nothing
						
						End If
						
						sqlGetNextGame = "SELECT * FROM qbx_games WHERE game_Year = " & Session.Contents("QBX_Current_Year") & " AND game_Week = " & Session.Contents("QBX_Current_Week") & " AND (game_HomeTeam_ID = " & this_QB_Team_ID & " OR game_AwayTeam_ID = " & this_QB_Team_ID & ")"
						Set rsNextGame = sqlSameLevel.Execute(sqlGetNextGame)
						
						game_Count = 0
						
						If Not rsNextGame.Eof Then
						
							If rsNextGame("game_HomeTeam_ID") = this_QB_Team_ID Then
							
								sqlGetOpponent = "SELECT * FROM qbx_teams WHERE team_ID = " & rsNextGame("game_AwayTeam_ID")
								Set rsOpponent = sqlSameLevel.Execute(sqlGetOpponent)
								
								If Not rsOpponent.Eof Then
								
									OpponentID = rsOpponent("team_ID")
									OpponentColor = rsOpponent("team_Color_Primary")
									OpponentCity  = rsOpponent("team_City")
									OpponentMascot  = rsOpponent("team_Mascot")
									
									sqlGetHistory = "SELECT samelevel.qbx_games.game_Year, samelevel.qbx_games.game_Week, samelevel.qbx_tracker.* FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND samelevel.qbx_tracker.team_ID <> " & rsOpponent("team_ID") & " AND samelevel.qbx_tracker.game_id IN (SELECT game_id FROM samelevel.qbx_games WHERE game_awayteam_id = " & rsOpponent("team_ID") & " OR game_hometeam_id = " & rsOpponent("team_ID") & ") ORDER BY samelevel.qbx_games.game_Year DESC, samelevel.qbx_games.game_Week DESC"
									Set rsHistory = sqlSameLevel.Execute(sqlGetHistory)
									
									If Not rsHistory.Eof Then
									
										game_Count = 0
										total_QBR = 0
										total_PassingCompletions = 0
										total_PassingAttempts = 0
										total_PassingYards = 0
										total_PassingInterceptions = 0
										total_PassingTouchdowns = 0
										total_RushingAttempts = 0
										total_RushingYards = 0
										total_RushingTouchdowns = 0
										total_Sacks = 0
										total_Fumbles = 0
										
										Do While Not rsHistory.Eof
										
											game_Count = game_Count + 1
											total_QBR = total_QBR + rsHistory("tracker_QBR")
											total_PassingCompletions = total_PassingCompletions + rsHistory("tracker_PassingCompletions")
											total_PassingAttempts = total_PassingAttempts + rsHistory("tracker_PassingAttempts")
											total_PassingYards = total_PassingYards + rsHistory("tracker_PassingYards")
											total_PassingInterceptions = total_PassingInterceptions + rsHistory("tracker_PassingInterceptions")
											total_PassingTouchdowns = total_PassingTouchdowns + rsHistory("tracker_PassingTouchdowns")
											total_RushingAttempts = total_RushingAttempts + rsHistory("tracker_RushingAttempts")
											total_RushingYards = total_RushingYards + rsHistory("tracker_RushingYards")
											total_RushingTouchdowns = total_RushingTouchdowns + rsHistory("tracker_RushingTouchdowns")
											total_Sacks = total_Sacks + rsHistory("tracker_Sacks")
											total_Fumbles = total_Fumbles + rsHistory("tracker_FumblesLost")
											
											rsHistory.MoveNext
										
										Loop
										
										rsHistory.Close
										Set rsHistory = Nothing
										
										average_QBR = Round(total_QBR / game_Count, 2)
										average_PassingCompletions = Round(total_PassingCompletions / game_Count, 2)
										average_PassingAttempts = Round(total_PassingAttempts / game_Count, 2)
										average_PassingPercentage = FormatNumber(((average_PassingCompletions / average_PassingAttempts) * 100), 2)
										average_PassingYards = Round(total_PassingYards / game_Count, 2)
										average_PassingInterceptions = Round(total_PassingInterceptions / game_Count, 2)
										average_PassingTouchdowns = Round(total_PassingTouchdowns / game_Count, 2)
										average_RushingAttempts = Round(total_RushingAttempts / game_Count, 2)
										average_RushingYards = Round(total_RushingYards / game_Count, 2)
										average_RushingTouchdowns = Round(total_RushingTouchdowns / game_Count, 2)
										average_Sacks = Round(total_Sacks / game_Count, 2)
										average_Fumbles = Round(total_Fumbles / game_Count, 2)
										
										no_History = 0
										
										'Response.Write("<div class=""pull-left"" style=""padding-right: 10px; margin-right: 10px; border-right: 1px solid #e7e7e7;""><b>WEEK " & Session.Contents("QBX_Current_Week") & " vs. <span style=""color: #" & OpponentColor & ";"">" & UCase(rsOpponent("team_City")) & " " & UCase(rsOpponent("team_Mascot")) & "</span></b></div>")
										'Response.Write("<div class=""pull-left"">AVERAGE VS. OPPONENT: " & average_PassingCompletions & "/" & average_PassingAttempts & " " & average_PassingYards & " YDS, " & average_PassingTouchdowns & " TD</div>")
									
									Else
									
										no_History = 1
										
									End If
									
									
									rsOpponent.Close
									Set rsOpponent = Nothing
									
								End If
								
							ElseIf rsNextGame("game_AwayTeam_ID") = this_QB_Team_ID Then
							
								sqlGetOpponent = "SELECT * FROM qbx_teams WHERE team_ID = " & rsNextGame("game_HomeTeam_ID")
								Set rsOpponent = sqlSameLevel.Execute(sqlGetOpponent)
								
								If Not rsOpponent.Eof Then
								
									OpponentID = rsOpponent("team_ID")
									OpponentColor = rsOpponent("team_Color_Primary")
									OpponentCity  = rsOpponent("team_City")
									OpponentMascot  = rsOpponent("team_Mascot")
									
									sqlGetHistory = "SELECT samelevel.qbx_games.game_Year, samelevel.qbx_games.game_Week, samelevel.qbx_tracker.* FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND samelevel.qbx_tracker.team_ID <> " & rsOpponent("team_ID") & " AND samelevel.qbx_tracker.game_id IN (SELECT game_id FROM samelevel.qbx_games WHERE game_awayteam_id = " & rsOpponent("team_ID") & " OR game_hometeam_id = " & rsOpponent("team_ID") & ") ORDER BY samelevel.qbx_games.game_Year DESC, samelevel.qbx_games.game_Week DESC"
									Set rsHistory = sqlSameLevel.Execute(sqlGetHistory)
									
									If Not rsHistory.Eof Then
									
										game_Count = 0
										total_QBR = 0
										total_PassingCompletions = 0
										total_PassingAttempts = 0
										total_PassingYards = 0
										total_PassingInterceptions = 0
										total_PassingTouchdowns = 0
										total_RushingAttempts = 0
										total_RushingYards = 0
										total_RushingTouchdowns = 0
										total_Sacks = 0
										total_Fumbles = 0
										
										Do While Not rsHistory.Eof
										
											game_Count = game_Count + 1
											total_QBR = total_QBR + rsHistory("tracker_QBR")
											total_PassingCompletions = total_PassingCompletions + rsHistory("tracker_PassingCompletions")
											total_PassingAttempts = total_PassingAttempts + rsHistory("tracker_PassingAttempts")
											total_PassingYards = total_PassingYards + rsHistory("tracker_PassingYards")
											total_PassingInterceptions = total_PassingInterceptions + rsHistory("tracker_PassingInterceptions")
											total_PassingTouchdowns = total_PassingTouchdowns + rsHistory("tracker_PassingTouchdowns")
											total_RushingAttempts = total_RushingAttempts + rsHistory("tracker_RushingAttempts")
											total_RushingYards = total_RushingYards + rsHistory("tracker_RushingYards")
											total_RushingTouchdowns = total_RushingTouchdowns + rsHistory("tracker_RushingTouchdowns")
											total_Sacks = total_Sacks + rsHistory("tracker_Sacks")
											total_Fumbles = total_Fumbles + rsHistory("tracker_FumblesLost")
											
											rsHistory.MoveNext
										
										Loop
										
										rsHistory.Close
										Set rsHistory = Nothing
										
										average_QBR = Round(total_QBR / game_Count, 2)
										average_PassingCompletions = Round(total_PassingCompletions / game_Count, 2)
										average_PassingAttempts = Round(total_PassingAttempts / game_Count, 2)
										average_PassingPercentage = FormatNumber(((average_PassingCompletions / average_PassingAttempts) * 100), 2)
										average_PassingYards = Round(total_PassingYards / game_Count, 2)
										average_PassingInterceptions = Round(total_PassingInterceptions / game_Count, 2)
										average_PassingTouchdowns = Round(total_PassingTouchdowns / game_Count, 2)
										average_RushingAttempts = Round(total_RushingAttempts / game_Count, 2)
										average_RushingYards = Round(total_RushingYards / game_Count, 2)
										average_RushingTouchdowns = Round(total_RushingTouchdowns / game_Count, 2)
										average_Sacks = Round(total_Sacks / game_Count, 2)
										average_Fumbles = Round(total_Fumbles / game_Count, 2)
									
										'Response.Write("<div class=""pull-left"" style=""padding-right: 10px; margin-right: 10px; border-right: 1px solid #e7e7e7;""><b>WEEK " & Session.Contents("QBX_Current_Week") & " vs. <span style=""color: #" & OpponentColor & ";"">" & UCase(rsOpponent("team_City")) & " " & UCase(rsOpponent("team_Mascot")) & "</span></b></div>")
										'Response.Write("<div class=""pull-left"">LAST " & game_Count & " VS. OPPONENT: " & average_PassingCompletions & "/" & average_PassingAttempts & " " & average_PassingYards & " YDS, " & average_PassingTouchdowns & " TD</div>")
										no_History = 0
										
									Else
									
										'Response.Write("<div><b>NEXT GAME:</b> Week " & Session.Contents("QBX_Current_Week") & " vs. " & rsOpponent("team_ID") & "... No History.</div>")
										no_History = 1
										
									End If
									
									
									rsOpponent.Close
									Set rsOpponent = Nothing
									
								End If
							
							End If
							
							If average_QBR <= 33 Then
								average_QBR_Icon  = "<span class=""badge bg-red""><i class=""fa fa-thumbs-down""></i></span>"
							ElseIf average_QBR <= 66 Then
								average_QBR_Icon  = "<span class=""badge bg-yellow""><i class=""fa fa-hand-rock-o""></i></span>"
							Else
								average_QBR_Icon  = "<span class=""badge bg-green""><i class=""fa fa-thumbs-up""></i></span>"
							End If
							
							If average_PassingPercentage <= 40 Then
								average_PassingPercentage_Icon  = "<span class=""badge bg-red""><i class=""fa fa-thumbs-down""></i></span>"
							ElseIf average_PassingPercentage <= 55 Then
								average_PassingPercentage_Icon  = "<span class=""badge bg-yellow""><i class=""fa fa-hand-rock-o""></i></span>"
							Else
								average_PassingPercentage_Icon  = "<span class=""badge bg-green""><i class=""fa fa-thumbs-up""></i></span>"
							End If
							
							If average_PassingYards <= 200 Then
								average_PassingYards_Icon  = "<span class=""badge bg-red""><i class=""fa fa-thumbs-down""></i></span>"
							ElseIf average_PassingYards <= 260 Then
								average_PassingYards_Icon  = "<span class=""badge bg-yellow""><i class=""fa fa-hand-rock-o""></i></span>"
							Else
								average_PassingYards_Icon  = "<span class=""badge bg-green""><i class=""fa fa-thumbs-up""></i></span>"
							End If
							
							If average_PassingInterceptions >= 2 Then
								average_PassingInterceptions_Icon  = "<span class=""badge bg-red""><i class=""fa fa-thumbs-down""></i></span>"
							ElseIf average_PassingInterceptions >= 1 Then
								average_PassingInterceptions_Icon  = "<span class=""badge bg-yellow""><i class=""fa fa-hand-rock-o""></i></span>"
							Else
								average_PassingInterceptions_Icon  = "<span class=""badge bg-green""><i class=""fa fa-thumbs-up""></i></span>"
							End If
							
							If average_PassingTouchdowns <= 1 Then
								average_PassingTouchdowns_Icon  = "<span class=""badge bg-red""><i class=""fa fa-thumbs-down""></i></span>"
							ElseIf average_PassingTouchdowns <= 2 Then
								average_PassingTouchdowns_Icon  = "<span class=""badge bg-yellow""><i class=""fa fa-hand-rock-o""></i></span>"
							Else
								average_PassingTouchdowns_Icon  = "<span class=""badge bg-green""><i class=""fa fa-thumbs-up""></i></span>"
							End If
							
							If average_RushingYards <= 10 Then
								average_RushingYards_Icon  = "<span class=""badge bg-red""><i class=""fa fa-thumbs-down""></i></span>"
							ElseIf average_RushingYards <= 30 Then
								average_RushingYards_Icon  = "<span class=""badge bg-yellow""><i class=""fa fa-hand-rock-o""></i></span>"
							Else
								average_RushingYards_Icon  = "<span class=""badge bg-green""><i class=""fa fa-thumbs-up""></i></span>"
							End If
							
							If average_RushingTouchdowns <= 0.3 Then
								average_RushingTouchdowns_Icon  = "<span class=""badge bg-red""><i class=""fa fa-thumbs-down""></i></span>"
							ElseIf average_RushingYards <= 0.9 Then
								average_RushingTouchdowns_Icon  = "<span class=""badge bg-yellow""><i class=""fa fa-hand-rock-o""></i></span>"
							Else
								average_RushingTouchdowns_Icon  = "<span class=""badge bg-green""><i class=""fa fa-thumbs-up""></i></span>"
							End If
						
						Else
						
							is_Bye = 1
						
						End If
						
						If is_Bye = 0 Then
						
							sqlGetOpponentLastGames = "SELECT * FROM qbx_games WHERE (game_HomeTeam_ID = " & OpponentID & " OR game_AwayTeam_ID = " & OpponentID & ") AND (game_ID < " & rsNextGame("game_ID") & ") ORDER BY game_Year DESC, game_Week DESC LIMIT 7"
							Set rsOpponentLastGames = sqlSameLevel.Execute(sqlGetOpponentLastGames)
	%>
							<div class="col-lg-4">
							
								<div class="box box-danger">
									<div class="box-header with-border">
										<i class="fa fa-calendar"></i>
										<h3 class="box-title">Week <%= Session.Contents("QBX_Current_Week") %> vs. <%= OpponentCity %>&nbsp;<%= OpponentMascot %></h3>
										<div class="box-tools pull-right">
											<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
										</div>
									</div>
									<div class="box-body">
										<table class="table table-condensed" style="margin-bottom: 5px; border-top: 0;">
	<%
											i = 0
											Do While Not rsOpponentLastGames.Eof
											
												sqlGetTrackerData = "SELECT qbx_tracker.*, qbx_games.game_Week, qbx_quarterbacks.qb_Name, qbx_teams.team_City, qbx_teams.team_Color_Primary FROM qbx_tracker INNER JOIN qbx_games ON qbx_tracker.game_ID = qbx_games.game_ID INNER JOIN qbx_teams ON qbx_tracker.team_ID = qbx_teams.team_ID INNER JOIN qbx_quarterbacks ON qbx_tracker.qb_ID = qbx_quarterbacks.qb_ID WHERE qbx_tracker.game_ID = " & rsOpponentLastGames("game_ID") & " AND qbx_tracker.team_ID <> " & OpponentID & " AND tracker_Starter = 1 ORDER BY game_ID DESC"
												Set rsTrackerData = sqlSameLevel.Execute(sqlGetTrackerData)
												
												If Not rsTrackerData.Eof Then
												
													thisTeam = rsTrackerData("team_City")
													thisTeamColor = rsTrackerData("team_Color_Primary")
													thisQuarterback = rsTrackerData("qb_Name")
													
													thisPassingYards = rsTrackerData("tracker_PassingYards")
													thisRushingYards = rsTrackerData("tracker_RushingYards")
													thisPassingTouchdowns = rsTrackerData("tracker_PassingTouchdowns")
													thisRushingTouchdowns = rsTrackerData("tracker_RushingTouchdowns")
													thisPassingInterceptions = rsTrackerData("tracker_PassingInterceptions")
													thisFumblesLost = rsTrackerData("tracker_FumblesLost")
													
													thisFantasyScore = (thisPassingTouchdowns * 6) + (thisRushingTouchdowns * 6) + (thisPassingYards / 25) + (thisRushingYards / 10) - (thisPassingInterceptions * 2) - (thisFumblesLost * 2)
												
												End If
	%>
												<tr <% If i = 0 Then %>style="border-top: 0px;"<% End If %>>
													<td width="20%" <% If i = 0 Then %>style="border-top: 0px;"<% End If %>>Week <%= rsTrackerData("game_Week") %></td>
													<td width="70%" <% If i = 0 Then %>style="border-top: 0px;"<% End If %>>
													<b><span style="color: #<%= thisTeamColor %>;"><%= thisQuarterback %></span></b>
													</td>
													<td width="10%" <% If i = 0 Then %>style="border-top: 0px;"<% End If %> align="right"><%= thisFantasyScore %></td>
												</tr>
	<%
												rsOpponentLastGames.MoveNext
												i = i + 1
												
											Loop
	%>
										</table>
									</div>
								</div>
							
							</div>
							
							<div class="col-lg-4">
							
								<div class="box box-danger">
									<div class="box-header with-border">
										<i class="fa fa-calculator"></i>
										<h3 class="box-title"><%= game_Count %>-Game Average Versus Opponent</h3>
										<div class="box-tools pull-right">
											<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
										</div>
									</div>
									<div class="box-body">
	<%
										If no_History = 0 Then
	%>
										<table class="table table-condensed" style="margin-bottom: 5px; border-top: 0;">
											<tr style=" border-top: 0;">
												<td width="60%" style=" border-top: 0;">ESPN QBR</td>
												<td width="30%" style=" border-top: 0;">
													<%= FormatNumber(average_QBR, 2) %>
												</td>
												<td width="10%" align="right" style=" border-top: 0;"><%= average_QBR_Icon %></td>
											</tr>
											<tr>
												<td width="60%">Passing Completion</td>
												<td width="30%">
													<%= FormatNumber(((average_PassingCompletions / average_PassingAttempts) * 100), 2) %>%
												</td>
												<td width="10%" align="right"><%= average_PassingPercentage_Icon %></td>
											</tr>
											<tr>
												<td width="60%">Passing Yards</td>
												<td width="30%">
													<%= FormatNumber(average_PassingYards, 2) %>
												</td>
												<td width="10%" align="right"><%= average_PassingYards_Icon %></td>
											</tr>
											<tr>
												<td width="60%">Passing Touchdowns</td>
												<td width="30%">
													<%= FormatNumber(average_PassingTouchdowns, 2) %>
												</td>
												<td width="10%" align="right"><%= average_PassingTouchdowns_Icon %></td>
											</tr>
											<tr>
												<td width="60%">Passing Interceptions</td>
												<td width="30%">
													<%= FormatNumber(average_PassingInterceptions, 2) %>
												</td>
												<td width="10%" align="right"><%= average_PassingInterceptions_Icon %></td>
											</tr>
											<tr>
												<td width="60%">Rushing Yards</td>
												<td width="30%">
													<%= FormatNumber(average_RushingYards, 2) %>
												</td>
												<td width="10%" align="right"><%= average_RushingYards_Icon %></td>
											</tr>
											<tr>
												<td width="60%">Rushing Touchdowns</td>
												<td width="30%">
													<%= FormatNumber(average_RushingTouchdowns, 2) %>
												</td>
												<td width="10%" align="right"><%= average_RushingTouchdowns_Icon %></td>
											</tr>
										</table>
<%
										Else
%>
										<table class="table table-condensed" style="margin-bottom: 5px; border-top: 0;">
											<tr style=" border-top: 0;">
												<td colspan="3" style=" border-top: 0;">
													<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
												</td>
											</tr>
										</table>
<%
										End If
%>
									</div>
								</div>
							
							</div>
							
							<div class="col-lg-4">
							
								<div class="box box-danger">
									<div class="box-header with-border">
										<i class="fa fa-database"></i>
										<h3 class="box-title">Game Log Versus Opponent</h3>
										<div class="box-tools pull-right">
											<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
										</div>
									</div>
									<div class="box-body">
										<table class="table table-condensed" style="margin-bottom: 5px; border-top: 0;">
<%
											sqlGetHistory = "SELECT samelevel.qbx_games.game_Year, samelevel.qbx_games.game_Week, samelevel.qbx_tracker.* FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND samelevel.qbx_tracker.team_ID <> " & OpponentID & " AND samelevel.qbx_tracker.game_id IN (SELECT game_id FROM samelevel.qbx_games WHERE game_awayteam_id = " & OpponentID & " OR game_hometeam_id = " & OpponentID & ") ORDER BY samelevel.qbx_games.game_Year DESC, samelevel.qbx_games.game_Week DESC"
											Set rsHistory = sqlSameLevel.Execute(sqlGetHistory)
											
											'If Not rsHistory.Eof Then
											
												game_Count = 0
												
												Do While Not rsHistory.Eof
												
													If game_Count = 3 Then Exit Do
%>
														<tr style="border-top: 0; border-bottom: 1px solid #f4f4f4;">
															<td style="border-top: 0; border-bottom: 1px solid #f4f4f4;">
																<b>[<%= rsHistory("game_Year") %>] Week <%= rsHistory("game_Week") %></b>
															</td>
															<td align="right" style="border-top: 0; border-bottom: 1px solid #f4f4f4;">
<%
																If rsHistory("tracker_Victory") Then
																	Response.Write("<span style=""color: #00a65a;""><b>WIN</b></span>")
																Else
																	Response.Write("<span style=""color: #dd4b39;""><b>LOSS</b></span>")
																End If
%>
															</td>
														</tr>
														<tr style="border-top: 0; border-left: 1px;">
															<td style="border-top: 0; border-left: 1px; padding-bottom: 16px;" colspan="2">
																<%= rsHistory("tracker_PassingYards") %> PaYDS, &nbsp;<%= rsHistory("tracker_PassingTouchdowns") %> PaTD, &nbsp;<%= rsHistory("tracker_RushingYards") %> RuYDS, &nbsp;<%= rsHistory("tracker_RushingTouchdowns") %> RuTD, &nbsp;<%= rsHistory("tracker_PassingInterceptions") %> INT, &nbsp;<%= rsHistory("tracker_FumblesLost") %> FL
															</td>
														</tr>
<%
													
													rsHistory.MoveNext
													game_Count = game_Count + 1
												
												Loop
												
												If game_Count < 3 Then
												
													Do While game_Count < 3
													
%>
														<tr style="border-top: 0; border-bottom: 1px solid #fff;">
															<td style="border-top: 0; border-bottom: 1px solid #fff;">
																&nbsp;
															</td>
															<td align="right" style="border-top: 0; border-bottom: 1px solid #fff;">&nbsp;</td>
														</tr>
														<tr style="border-top: 0;">
															<td style="border-top: 0; padding-bottom: 16px;" colspan="2">
																&nbsp;
															</td>
														</tr>
<%
														game_Count = game_Count + 1
													
													Loop
												
												End If
												
												rsHistory.Close
												Set rsHistory = Nothing
												
											'End If
%>
										</table>
									</div>
								</div>
							
							</div>
						<% End If %>
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