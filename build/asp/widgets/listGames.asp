<div class="box box-warning">

	<div class="box-header with-border">
		<i class="fa fa-database"></i>
		<h3 class="box-title">NFL Game Database</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>

	<div class="box-body">
			
		<table id="listGames" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>Year</th>
					<th>Week</th>
					<th>Away Team</th>
					<th>Home Team</th>
					<th align="right"></th>
				</tr>
			</thead>
			<tbody>
<%
				sqlGetGames = "SELECT * FROM qbx_games ORDER BY game_Year DESC, game_Week DESC"
				Set rsGames = sqlSameLevel.Execute(sqlGetGames)
				
				Do While Not rsGames.Eof 
				
					sqlGetHomeTeam = "SELECT team_City, team_Color_Primary, team_Color_Secondary FROM qbx_teams WHERE team_ID = " & rsGames("game_HomeTeam_ID")
					Set rsHomeTeam = sqlSameLevel.Execute(sqlGetHomeTeam)
					
					HomeTeam = rsHomeTeam("team_City")
					HomeTeam_Color_Primary = rsHomeTeam("team_Color_Primary")
					HomeTeam_Color_Secondary = rsHomeTeam("team_Color_Secondary")
					
					rsHomeTeam.Close
					Set rsHomeTeam = Nothing
					
					sqlGetAwayTeam = "SELECT team_City, team_Color_Primary, team_Color_Secondary FROM qbx_teams WHERE team_ID = " & rsGames("game_AwayTeam_ID")
					Set rsAwayTeam = sqlSameLevel.Execute(sqlGetAwayTeam)
					
					AwayTeam = rsAwayTeam("team_City")
					AwayTeam_Color_Primary = rsAwayTeam("team_Color_Primary")
					AwayTeam_Color_Secondary = rsAwayTeam("team_Color_Secondary")
					
					rsAwayTeam.Close
					Set rsAwayTeam = Nothing
					
					sqlGetQuarterbacks = "SELECT COUNT(qb_ID) AS StarterCount FROM qbx_tracker WHERE tracker_Starter = 1 AND tracker_PassingAttempts IS NOT NULL AND game_ID = " & rsGames("game_ID")
					Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
					
					If Not rsQuarterbacks.Eof Then
					
						StarterCount = rsQuarterbacks("StarterCount")
						
						If CInt(StarterCount) = 2 Then
							StatusImage = "<div style=""float: right;"" id=""status" & rsGames("game_ID") & """><span style=""color: green;""><i class=""fa fa-check-circle""></i></span></div>"
						Else
							StatusImage = "<div style=""float: right;"" id=""status" & rsGames("game_ID") & """><span style=""color: #dd4b39;""><i class=""fa fa-times-circle""></i></span></div>"
						End If
					
					End If
					
					Response.Write("<tr>")
						Response.Write("<td>" & rsGames("game_Year") & "</td>")
						Response.Write("<td>" & rsGames("game_Week") & "</td>")
						Response.Write("<td>" & UCase(AwayTeam) & "</td>")
						Response.Write("<td>" & UCase(HomeTeam) & "</td>")
						Response.Write("<td align=""right""><a style=""cursor: pointer; font-weight: bold;"" onclick=""loadGameData(" & rsGames("game_ID") & ");"">EDIT</a> &nbsp;&nbsp;&nbsp;" & StatusImage & "</td>")
					Response.Write("</tr>")
					
					rsGames.MoveNext
					
				Loop
				
				rsGames.Close
				Set rsGames = Nothing
%>
			</tbody>
			
		</table>

		
	</div>
	
</div>