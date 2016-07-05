<div class="box box-warning">
	<div class="box-header with-border">
		<i class="fa fa-list-ol"></i>
		<h3 class="box-title">2015 Season Statistics</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		</div>
	</div>
	<div class="box-body">
<%
		qb_ID = CInt(Session.Contents("QBX_Current_QB_ID"))
		qb_Match = 0
		qb_Count = 1
		qb_PassingPercentage = 0
		qb_PassingPercentagePlace = 100
		sqlGetPassingPercentage = "SELECT qb_ID, (SUM(tracker_PassingCompletions) / SUM(tracker_PassingAttempts))* 100 AS PaComp FROM samelevel.qbx_tracker WHERE game_ID IN (SELECT game_ID FROM samelevel.qbx_games WHERE game_Year = 2015) GROUP BY qb_ID ORDER BY PaComp DESC"
		Set rsPassingPercentage = sqlSameLevel.Execute(sqlGetPassingPercentage)
		
		Do While Not rsPassingPercentage.Eof
		
			If rsPassingPercentage("qb_ID") = qb_ID Then
			
				qb_PassingPercentage = rsPassingPercentage("PaComp")
				qb_PassingPercentagePlace = qb_Count
			
			End If
			rsPassingPercentage.MoveNext
			qb_Count = qb_Count + 1
		
		Loop
		
		If CInt(qb_PassingPercentagePlace) = 100 Then qb_PassingPercentagePlace = Cint(qb_Count)
		qb_PassingPercentagePlaceTotal = qb_Count
		qb_PassingPercentage_Percentile = FormatNumber(100 - ((CInt(qb_PassingPercentagePlace) * 100) / qb_PassingPercentagePlaceTotal), 2)
		
		If qb_PassingPercentage_Percentile < 45 Then
			qb_PassingPercentage_Color = "bg-red"
		ElseIf qb_PassingPercentage_Percentile < 80 Then
			qb_PassingPercentage_Color = "bg-yellow"
		Else
			qb_PassingPercentage_Color = "bg-green"
		End If
		
		rsPassingPercentage.Close
		Set rsPassingPercentage = Nothing
		
		If Right(CStr(qb_PassingPercentagePlace), 1) = "1" Then
			If Right(CStr(qb_PassingPercentagePlace), 2) = "11" Then
				qb_PassingPercentagePlace = qb_PassingPercentagePlace & "th"
			Else
				qb_PassingPercentagePlace = qb_PassingPercentagePlace & "st"
			End If
		ElseIf Right(CStr(qb_PassingPercentagePlace), 1) = "2" Then
			qb_PassingPercentagePlace = qb_PassingPercentagePlace & "nd"
		ElseIf Right(CStr(qb_PassingPercentagePlace), 1) = "3" Then
			qb_PassingPercentagePlace = qb_PassingPercentagePlace & "rd"
		Else
			qb_PassingPercentagePlace = qb_PassingPercentagePlace & "th"
		End If
		
		
		qb_Match = 0
		qb_Count = 1
		qb_PassingYards = 0
		qb_PassingYardsPlace = 100
		sqlGetPassingYards = "SELECT qb_ID, SUM(tracker_PassingYards) AS PaYDS FROM samelevel.qbx_tracker WHERE game_ID IN (SELECT game_ID FROM samelevel.qbx_games WHERE game_Year = 2015) GROUP BY qb_ID ORDER BY PaYDS DESC"
		Set rsPassingYards = sqlSameLevel.Execute(sqlGetPassingYards)
		
		Do While Not rsPassingYards.Eof
		
			If rsPassingYards("qb_ID") = qb_ID Then
			
				qb_PassingYards = rsPassingYards("PaYDS")
				qb_PassingYardsPlace = qb_Count
			
			End If
			rsPassingYards.MoveNext
			qb_Count = qb_Count + 1
		
		Loop
		If qb_PassingYardsPlace = 100 Then qb_PassingYardsPlace = qb_Count
		qb_PassingYardsPlaceTotal = qb_Count
		qb_PassingYards_Percentile = FormatNumber(100 - ((qb_PassingYardsPlace * 100) / qb_PassingYardsPlaceTotal), 2)
		
		If qb_PassingYards_Percentile < 45 Then
			qb_PassingYards_Color = "bg-red"
		ElseIf qb_PassingYards_Percentile < 80 Then
			qb_PassingYards_Color = "bg-yellow"
		Else
			qb_PassingYards_Color = "bg-green"
		End If
		
		rsPassingYards.Close
		Set rsPassingYards = Nothing
		
		If Right(CStr(qb_PassingYardsPlace), 1) = "1" Then
			If Right(CStr(qb_PassingYardsPlace), 2) = "11" Then
				qb_PassingYardsPlace = qb_PassingYardsPlace & "th"
			Else
				qb_PassingYardsPlace = qb_PassingYardsPlace & "st"
			End If
		ElseIf Right(CStr(qb_PassingYardsPlace), 1) = "2" Then
			qb_PassingYardsPlace = qb_PassingYardsPlace & "nd"
		ElseIf Right(CStr(qb_PassingYardsPlace), 1) = "3" Then
			qb_PassingYardsPlace = qb_PassingYardsPlace & "rd"
		Else
			qb_PassingYardsPlace = qb_PassingYardsPlace & "th"
		End If
		
		
		qb_Match = 0
		qb_Count = 1
		qb_PassingTD = 0
		qb_PassingTDPlace = 100
		sqlGetPassingTD = "SELECT qb_ID, SUM(tracker_PassingTouchdowns) AS PaTD FROM samelevel.qbx_tracker WHERE game_ID IN (SELECT game_ID FROM samelevel.qbx_games WHERE game_Year = 2015) GROUP BY qb_ID ORDER BY PaTD DESC"
		Set rsPassingTD = sqlSameLevel.Execute(sqlGetPassingTD)
		
		Do While Not rsPassingTD.Eof
		
			If rsPassingTD("qb_ID") = qb_ID Then
			
				qb_PassingTD = rsPassingTD("PaTD")
				qb_PassingTDPlace = qb_Count
			
			End If
			rsPassingTD.MoveNext
			qb_Count = qb_Count + 1
		
		Loop
		If qb_PassingTDPlace = 100 Then qb_PassingTDPlace = qb_Count
		qb_PassingTDPlaceTotal = qb_Count
		qb_PassingTD_Percentile = FormatNumber(100 - ((qb_PassingTDPlace * 100) / qb_PassingTDPlaceTotal), 2)
		
		If qb_PassingTD_Percentile < 45 Then
			qb_PassingTD_Color = "bg-red"
		ElseIf qb_PassingTD_Percentile < 80 Then
			qb_PassingTD_Color = "bg-yellow"
		Else
			qb_PassingTD_Color = "bg-green"
		End If
		
		rsPassingTD.Close
		Set rsPassingTD = Nothing
		
		If Right(CStr(qb_PassingTDPlace), 1) = "1" Then
			If Right(CStr(qb_PassingTDPlace), 2) = "11" Then
				qb_PassingTDPlace = qb_PassingTDPlace & "th"
			Else
				qb_PassingTDPlace = qb_PassingTDPlace & "st"
			End If
		ElseIf Right(CStr(qb_PassingTDPlace), 1) = "2" Then
			qb_PassingTDPlace = qb_PassingTDPlace & "nd"
		ElseIf Right(CStr(qb_PassingTDPlace), 1) = "3" Then
			qb_PassingTDPlace = qb_PassingTDPlace & "rd"
		Else
			qb_PassingTDPlace = qb_PassingTDPlace & "th"
		End If
		
		
		qb_Match = 0
		qb_Count = 1
		qb_RushingTD = 0
		qb_RushingTDPlace = 100
		sqlGetRushingTD = "SELECT qb_ID, SUM(tracker_RushingTouchdowns) AS RuTD FROM samelevel.qbx_tracker WHERE game_ID IN (SELECT game_ID FROM samelevel.qbx_games WHERE game_Year = 2015) GROUP BY qb_ID ORDER BY RuTD DESC"
		Set rsRushingTD = sqlSameLevel.Execute(sqlGetRushingTD)
		
		Do While Not rsRushingTD.Eof
		
			If rsRushingTD("qb_ID") = qb_ID Then
			
				qb_RushingTD = rsRushingTD("RuTD")
				qb_RushingTDPlace = qb_Count
			
			End If
			rsRushingTD.MoveNext
			qb_Count = qb_Count + 1
		
		Loop
		If qb_RushingTDPlace = 100 Then qb_RushingTDPlace = qb_Count
		qb_RushingTDPlaceTotal = qb_Count
		qb_RushingTD_Percentile = FormatNumber(100 - ((qb_RushingTDPlace * 100) / qb_RushingTDPlaceTotal), 2)
		
		If qb_RushingTD_Percentile <= 45 Then
			qb_RushingTD_Color = "bg-red"
		ElseIf qb_RushingTD_Percentile <= 80 Then
			qb_RushingTD_Color = "bg-yellow"
		Else
			qb_RushingTD_Color = "bg-green"
		End If
		
		rsRushingTD.Close
		Set rsRushingTD = Nothing
		
		If Right(CStr(qb_RushingTDPlace), 1) = "1" Then
			If Right(CStr(qb_RushingTDPlace), 2) = "11" Then
				qb_RushingTDPlace = qb_RushingTDPlace & "th"
			Else
				qb_RushingTDPlace = qb_RushingTDPlace & "st"
			End If
		ElseIf Right(CStr(qb_RushingTDPlace), 1) = "2" Then
			qb_RushingTDPlace = qb_RushingTDPlace & "nd"
		ElseIf Right(CStr(qb_RushingTDPlace), 1) = "3" Then
			qb_RushingTDPlace = qb_RushingTDPlace & "rd"
		Else
			qb_RushingTDPlace = qb_RushingTDPlace & "th"
		End If
		
		
		qb_Match = 0
		qb_Count = 1
		qb_RushingYDS = 0
		qb_RushingYDSPlace = 100
		sqlGetRushingYDS = "SELECT qb_ID, SUM(tracker_RushingYards) AS RuYDS FROM samelevel.qbx_tracker WHERE game_ID IN (SELECT game_ID FROM samelevel.qbx_games WHERE game_Year = 2015) GROUP BY qb_ID ORDER BY RuYDS DESC"
		Set rsRushingYDS = sqlSameLevel.Execute(sqlGetRushingYDS)
		
		Do While Not rsRushingYDS.Eof
		
			If rsRushingYDS("qb_ID") = qb_ID Then
			
				qb_RushingYDS = rsRushingYDS("RuYDS")
				qb_RushingYDSPlace = qb_Count
			
			End If
			rsRushingYDS.MoveNext
			qb_Count = qb_Count + 1
		
		Loop
		If qb_RushingYDSPlace = 100 Then qb_RushingYDSPlace = qb_Count
		qb_RushingYDSPlaceTotal = qb_Count
		qb_RushingYDS_Percentile = FormatNumber(100 - ((qb_RushingYDSPlace * 100) / qb_RushingYDSPlaceTotal), 2)
		
		If qb_RushingYDS_Percentile <= 45 Then
			qb_RushingYDS_Color = "bg-red"
		ElseIf qb_RushingYDS_Percentile <= 80 Then
			qb_RushingYDS_Color = "bg-yellow"
		Else
			qb_RushingYDS_Color = "bg-green"
		End If
		
		rsRushingYDS.Close
		Set rsRushingYDS = Nothing
		
		If Right(CStr(qb_RushingYDSPlace), 1) = "1" Then
			If Right(CStr(qb_RushingYDSPlace), 2) = "11" Then
				qb_RushingYDSPlace = qb_RushingYDSPlace & "th"
			Else
				qb_RushingYDSPlace = qb_RushingYDSPlace & "st"
			End If
		ElseIf Right(CStr(qb_RushingYDSPlace), 1) = "2" Then
			qb_RushingYDSPlace = qb_RushingYDSPlace & "nd"
		ElseIf Right(CStr(qb_RushingYDSPlace), 1) = "3" Then
			qb_RushingYDSPlace = qb_RushingYDSPlace & "rd"
		Else
			qb_RushingYDSPlace = qb_RushingYDSPlace & "th"
		End If
%>
	
		<table class="table table-condensed" style="margin-bottom: 5px; border-top: 0;">
			<tr style=" border-top: 0;">
				<td width="60%" style=" border-top: 0;">Passing Completion</td>
				<td width="30%" style=" border-top: 0;">
					<%= FormatNumber(qb_PassingPercentage, 2) %>%
				</td>
				<td width="10%" align="right" style=" border-top: 0;"><span class="badge <%= qb_PassingPercentage_Color %>"><%= qb_PassingPercentagePlace %></span></td>
			</tr>
			<tr>
				<td width="60%">Passing Yards</td>
				<td width="30%">
					<%= FormatNumber(qb_PassingYards, 0) %>
				</td>
				<td width="10%" align="right"><span class="badge <%= qb_PassingYards_Color %>"><%= qb_PassingYardsPlace %></span></td>
			</tr>
			<tr>
				<td width="60%">Passing Touchdowns</td>
				<td width="30%">
					<%= FormatNumber(qb_PassingTD, 0) %>
				</td>
				<td width="10%" align="right"><span class="badge <%= qb_PassingTD_Color %>"><%= qb_PassingTDPlace %></span></td>
			</tr>
			<tr>
				<td width="60%">Rushing Yards</td>
				<td width="30%">
					<%= FormatNumber(qb_RushingYDS, 0) %>
				</td>
				<td width="10%" align="right"><span class="badge <%= qb_RushingYDS_Color %>"><%= qb_RushingYDSPlace %></span></td>
			</tr>
			<tr>
				<td width="60%">Rushing Touchdowns</td>
				<td width="30%">
					<%= FormatNumber(qb_RushingTD, 0) %>
				</td>
				<td width="10%" align="right"><span class="badge <%= qb_RushingTD_Color %>"><%= qb_RushingTDPlace %></span></td>
			</tr>
			
		</table>
		
	</div>
</div>