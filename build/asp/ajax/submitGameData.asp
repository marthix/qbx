<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<%
	game_ID = Request.Form("game_ID")
	game_Year = Request.Form("game_Year")
	game_Week = Request.Form("game_Week")
	
	home_TeamID = Request.Form("home_TeamID")
	away_TeamID = Request.Form("away_TeamID")
	
	home_TeamScore = Request.Form("home_TeamScore")
	away_TeamScore = Request.Form("away_TeamScore")
	
	home_Starter_ID = Request.Form("home_Starter_ID")
	away_Starter_ID = Request.Form("away_Starter_ID")
	
	home_Starter_QBR = Request.Form("home_Starter_QBR")
	away_Starter_QBR = Request.Form("away_Starter_QBR")
	
	home_BackUp1_ID = Request.Form("home_BackUp1_ID")
	home_BackUp2_ID = Request.Form("home_BackUp2_ID")
	
	away_BackUp1_ID = Request.Form("away_BackUp1_ID")
	away_BackUp2_ID = Request.Form("away_BackUp2_ID")
	
	home_BackUp1_QBR = Request.Form("home_BackUp1_QBR")
	home_BackUp2_QBR = Request.Form("home_BackUp2_QBR")
	
	away_BackUp1_QBR = Request.Form("away_BackUp1_QBR")
	away_BackUp2_QBR = Request.Form("away_BackUp2_QBR")
	
	home_Starter_PaComp = Request.Form("home_Starter_PaComp")
	home_Starter_PaAtt = Request.Form("home_Starter_PaAtt")
	home_Starter_PaYds = Request.Form("home_Starter_PaYds")
	home_Starter_PaYPA = Request.Form("home_Starter_PaYPA")
	home_Starter_PaInt = Request.Form("home_Starter_PaInt")
	home_Starter_PaTD = Request.Form("home_Starter_PaTD")
	home_Starter_RuAtt = Request.Form("home_Starter_RuAtt")
	home_Starter_RuYds = Request.Form("home_Starter_RuYds")
	home_Starter_RuYPA = Request.Form("home_Starter_RuYPA")
	home_Starter_RuTD = Request.Form("home_Starter_RuTD")
	home_Starter_Sacks = Request.Form("home_Starter_Sacks")
	home_Starter_Fum = Request.Form("home_Starter_Fum")
	
	home_BackUp1_PaComp = Request.Form("home_BackUp1_PaComp")
	home_BackUp1_PaAtt = Request.Form("home_BackUp1_PaAtt")
	home_BackUp1_PaYds = Request.Form("home_BackUp1_PaYds")
	home_BackUp1_PaYPA = Request.Form("home_BackUp1_PaYPA")
	home_BackUp1_PaInt = Request.Form("home_BackUp1_PaInt")
	home_BackUp1_PaTD = Request.Form("home_BackUp1_PaTD")
	home_BackUp1_RuAtt = Request.Form("home_BackUp1_RuAtt")
	home_BackUp1_RuYds = Request.Form("home_BackUp1_RuYds")
	home_BackUp1_RuYPA = Request.Form("home_BackUp1_RuYPA")
	home_BackUp1_RuTD = Request.Form("home_BackUp1_RuTD")
	home_BackUp1_Sacks = Request.Form("home_BackUp1_Sacks")
	home_BackUp1_Fum = Request.Form("home_BackUp1_Fum")
	
	home_BackUp2_PaComp = Request.Form("home_BackUp2_PaComp")
	home_BackUp2_PaAtt = Request.Form("home_BackUp2_PaAtt")
	home_BackUp2_PaYds = Request.Form("home_BackUp2_PaYds")
	home_BackUp2_PaYPA = Request.Form("home_BackUp2_PaYPA")
	home_BackUp2_PaInt = Request.Form("home_BackUp2_PaInt")
	home_BackUp2_PaTD = Request.Form("home_BackUp2_PaTD")
	home_BackUp2_RuAtt = Request.Form("home_BackUp2_RuAtt")
	home_BackUp2_RuYds = Request.Form("home_BackUp2_RuYds")
	home_BackUp2_RuYPA = Request.Form("home_BackUp2_RuYPA")
	home_BackUp2_RuTD = Request.Form("home_BackUp2_RuTD")
	home_BackUp2_Sacks = Request.Form("home_BackUp2_Sacks")
	home_BackUp2_Fum = Request.Form("home_BackUp2_Fum")
	
	away_Starter_PaComp = Request.Form("away_Starter_PaComp")
	away_Starter_PaAtt = Request.Form("away_Starter_PaAtt")
	away_Starter_PaYds = Request.Form("away_Starter_PaYds")
	away_Starter_PaYPA = Request.Form("away_Starter_PaYPA")
	away_Starter_PaInt = Request.Form("away_Starter_PaInt")
	away_Starter_PaTD = Request.Form("away_Starter_PaTD")
	away_Starter_RuAtt = Request.Form("away_Starter_RuAtt")
	away_Starter_RuYds = Request.Form("away_Starter_RuYds")
	away_Starter_RuYPA = Request.Form("away_Starter_RuYPA")
	away_Starter_RuTD = Request.Form("away_Starter_RuTD")
	away_Starter_Sacks = Request.Form("away_Starter_Sacks")
	away_Starter_Fum = Request.Form("away_Starter_Fum")
	
	away_BackUp1_PaComp = Request.Form("away_BackUp1_PaComp")
	away_BackUp1_PaAtt = Request.Form("away_BackUp1_PaAtt")
	away_BackUp1_PaYds = Request.Form("away_BackUp1_PaYds")
	away_BackUp1_PaYPA = Request.Form("away_BackUp1_PaYPA")
	away_BackUp1_PaInt = Request.Form("away_BackUp1_PaInt")
	away_BackUp1_PaTD = Request.Form("away_BackUp1_PaTD")
	away_BackUp1_RuAtt = Request.Form("away_BackUp1_RuAtt")
	away_BackUp1_RuYds = Request.Form("away_BackUp1_RuYds")
	away_BackUp1_RuYPA = Request.Form("away_BackUp1_RuYPA")
	away_BackUp1_RuTD = Request.Form("away_BackUp1_RuTD")
	away_BackUp1_Sacks = Request.Form("away_BackUp1_Sacks")
	away_BackUp1_Fum = Request.Form("away_BackUp1_Fum")
	
	away_BackUp2_PaComp = Request.Form("away_BackUp2_PaComp")
	away_BackUp2_PaAtt = Request.Form("away_BackUp2_PaAtt")
	away_BackUp2_PaYds = Request.Form("away_BackUp2_PaYds")
	away_BackUp2_PaYPA = Request.Form("away_BackUp2_PaYPA")
	away_BackUp2_PaInt = Request.Form("away_BackUp2_PaInt")
	away_BackUp2_PaTD = Request.Form("away_BackUp2_PaTD")
	away_BackUp2_RuAtt = Request.Form("away_BackUp2_RuAtt")
	away_BackUp2_RuYds = Request.Form("away_BackUp2_RuYds")
	away_BackUp2_RuYPA = Request.Form("away_BackUp2_RuYPA")
	away_BackUp2_RuTD = Request.Form("away_BackUp2_RuTD")
	away_BackUp2_Sacks = Request.Form("away_BackUp2_Sacks")
	away_BackUp2_Fum = Request.Form("away_BackUp2_Fum")
	
	sqlDelTracks = "DELETE FROM qbx_tracker WHERE game_ID = " & game_ID
	Set rsDelete    = sqlSameLevel.Execute(sqlDelTracks)
	
	sqlInsert_Home_Starter = "INSERT INTO qbx_tracker (game_ID, team_ID, qb_ID, tracker_Starter, tracker_BackUp1, tracker_BackUp2, tracker_QBR, tracker_Victory, tracker_PassingCompletions, tracker_PassingAttempts, tracker_PassingYards, tracker_PassingYardsPerAttempt, tracker_PassingInterceptions, tracker_PassingTouchdowns, tracker_RushingAttempts, tracker_RushingYards, tracker_RushingYardsPerAttempt, tracker_RushingTouchdowns, tracker_Sacks, tracker_FumblesLost) VALUES ("
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & game_ID & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_TeamID & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_ID & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & "1, "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & "0, "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & "0, "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_QBR & ", "
	If home_TeamScore > away_TeamScore Then
		sqlInsert_Home_Starter = sqlInsert_Home_Starter & "1, "
	Else
		sqlInsert_Home_Starter = sqlInsert_Home_Starter & "0, "
	End If
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_PaComp & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_PaAtt & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_PaYds & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_PaYPA & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_PaInt & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_PaTD & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_RuAtt & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_RuYds & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_RuYPA & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_RuTD & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_Sacks & ", "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & home_Starter_Fum & " "
	sqlInsert_Home_Starter = sqlInsert_Home_Starter & ")"
	
	sqlInsert_Away_Starter = "INSERT INTO qbx_tracker (game_ID, team_ID, qb_ID, tracker_Starter, tracker_BackUp1, tracker_BackUp2, tracker_QBR, tracker_Victory, tracker_PassingCompletions, tracker_PassingAttempts, tracker_PassingYards, tracker_PassingYardsPerAttempt, tracker_PassingInterceptions, tracker_PassingTouchdowns, tracker_RushingAttempts, tracker_RushingYards, tracker_RushingYardsPerAttempt, tracker_RushingTouchdowns, tracker_Sacks, tracker_FumblesLost) VALUES ("
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & game_ID & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_TeamID & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_ID & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & "1, "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & "0, "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & "0, "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_QBR & ", "
	If home_TeamScore < away_TeamScore Then
		sqlInsert_Away_Starter = sqlInsert_Away_Starter & "1, "
	Else
		sqlInsert_Away_Starter = sqlInsert_Away_Starter & "0, "
	End If
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_PaComp & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_PaAtt & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_PaYds & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_PaYPA & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_PaInt & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_PaTD & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_RuAtt & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_RuYds & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_RuYPA & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_RuTD & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_Sacks & ", "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & away_Starter_Fum & " "
	sqlInsert_Away_Starter = sqlInsert_Away_Starter & ")"
	
	Set rsInsert_Home_Starter = sqlSameLevel.Execute(sqlInsert_Home_Starter)
	Set rsInsert_Away_Starter = sqlSameLevel.Execute(sqlInsert_Away_Starter)
	
	If Len(home_BackUp1_ID) > 0 Then
	
		sqlInsert_Home_BackUp1 = "INSERT INTO qbx_tracker (game_ID, team_ID, qb_ID, tracker_Starter, tracker_BackUp1, tracker_BackUp2, tracker_QBR, tracker_Victory, tracker_PassingCompletions, tracker_PassingAttempts, tracker_PassingYards, tracker_PassingYardsPerAttempt, tracker_PassingInterceptions, tracker_PassingTouchdowns, tracker_RushingAttempts, tracker_RushingYards, tracker_RushingYardsPerAttempt, tracker_RushingTouchdowns, tracker_Sacks, tracker_FumblesLost) VALUES ("
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & game_ID & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_TeamID & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_ID & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & "0, "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & "1, "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & "0, "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_QBR & ", "
		If home_TeamScore > away_TeamScore Then
			sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & "1, "
		Else
			sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & "0, "
		End If
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_PaComp & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_PaAtt & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_PaYds & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_PaYPA & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_PaInt & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_PaTD & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_RuAtt & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_RuYds & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_RuYPA & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_RuTD & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_Sacks & ", "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & home_BackUp1_Fum & " "
		sqlInsert_Home_BackUp1 = sqlInsert_Home_BackUp1 & ")"
		
		
		
		Set rsInsert_Home_BackUp1 = sqlSameLevel.Execute(sqlInsert_Home_BackUp1)
		
	End If
	
	If Len(home_BackUp2_ID) > 0 Then
	
		sqlInsert_Home_BackUp2 = "INSERT INTO qbx_tracker (game_ID, team_ID, qb_ID, tracker_Starter, tracker_BackUp1, tracker_BackUp2, tracker_QBR, tracker_Victory, tracker_PassingCompletions, tracker_PassingAttempts, tracker_PassingYards, tracker_PassingYardsPerAttempt, tracker_PassingInterceptions, tracker_PassingTouchdowns, tracker_RushingAttempts, tracker_RushingYards, tracker_RushingYardsPerAttempt, tracker_RushingTouchdowns, tracker_Sacks, tracker_FumblesLost) VALUES ("
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & game_ID & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_TeamID & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_ID & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & "0, "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & "0, "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & "1, "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_QBR & ", "
		If home_TeamScore > away_TeamScore Then
			sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & "1, "
		Else
			sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & "0, "
		End If
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_PaComp & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_PaAtt & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_PaYds & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_PaYPA & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_PaInt & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_PaTD & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_RuAtt & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_RuYds & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_RuYPA & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_RuTD & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_Sacks & ", "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & home_BackUp2_Fum & " "
		sqlInsert_Home_BackUp2 = sqlInsert_Home_BackUp2 & ")"
		Response.Write(sqlInsert_Home_BackUp2)
		Set sqlInsert_Home_BackUp2 = sqlSameLevel.Execute(sqlInsert_Home_BackUp2)
		
	End If
	
	If Len(away_BackUp1_ID) > 0 Then
	
		sqlInsert_Away_BackUp1 = "INSERT INTO qbx_tracker (game_ID, team_ID, qb_ID, tracker_Starter, tracker_BackUp1, tracker_BackUp2, tracker_QBR, tracker_Victory, tracker_PassingCompletions, tracker_PassingAttempts, tracker_PassingYards, tracker_PassingYardsPerAttempt, tracker_PassingInterceptions, tracker_PassingTouchdowns, tracker_RushingAttempts, tracker_RushingYards, tracker_RushingYardsPerAttempt, tracker_RushingTouchdowns, tracker_Sacks, tracker_FumblesLost) VALUES ("
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & game_ID & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_TeamID & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_ID & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & "0, "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & "1, "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & "0, "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_QBR & ", "
		If home_TeamScore < away_TeamScore Then
			sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & "1, "
		Else
			sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & "0, "
		End If
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_PaComp & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_PaAtt & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_PaYds & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_PaYPA & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_PaInt & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_PaTD & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_RuAtt & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_RuYds & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_RuYPA & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_RuTD & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_Sacks & ", "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & away_BackUp1_Fum & " "
		sqlInsert_Away_BackUp1 = sqlInsert_Away_BackUp1 & ")"
		
		Set rsInsert_Away_BackUp1 = sqlSameLevel.Execute(sqlInsert_Away_BackUp1)
		
	End If
	
	If Len(away_BackUp2_ID) > 0 Then
	
		sqlInsert_Away_BackUp2 = "INSERT INTO qbx_tracker (game_ID, team_ID, qb_ID, tracker_Starter, tracker_BackUp1, tracker_BackUp2, tracker_QBR, tracker_Victory, tracker_PassingCompletions, tracker_PassingAttempts, tracker_PassingYards, tracker_PassingYardsPerAttempt, tracker_PassingInterceptions, tracker_PassingTouchdowns, tracker_RushingAttempts, tracker_RushingYards, tracker_RushingYardsPerAttempt, tracker_RushingTouchdowns, tracker_Sacks, tracker_FumblesLost) VALUES ("
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & game_ID & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_TeamID & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_ID & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & "0, "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & "0, "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & "1, "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_QBR & ", "
		If home_TeamScore < away_TeamScore Then
			sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & "1,"
		Else
			sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & "0,"
		End If
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_PaComp & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_PaAtt & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_PaYds & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_PaYPA & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_PaInt & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_PaTD & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_RuAtt & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_RuYds & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_RuYPA & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_RuTD & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_Sacks & ", "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & away_BackUp2_Fum & " "
		sqlInsert_Away_BackUp2 = sqlInsert_Away_BackUp2 & ")"
		Response.Write(sqlInsert_Away_BackUp2)
		Set rsInsert_Away_BackUp2 = sqlSameLevel.Execute(sqlInsert_Away_BackUp2)
		
	End If
	
%>
	<div id="successMessage" class="alert alert-success alert-dismissable">
		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		<i class="icon fa fa-check"></i> <b>Game Updated Successfully!</b>
	</div>