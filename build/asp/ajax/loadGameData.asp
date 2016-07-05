<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<%
	game_ID = Request.Form("game_ID")
	
	sqlGetGameData = "SELECT * FROM qbx_games WHERE game_ID = " & game_ID
	Set rsGameData = sqlSameLevel.Execute(sqlGetGameData)
	
	If Not rsGameData.Eof Then
	
		game_Year = rsGameData("game_Year")
		game_Week = rsGameData("game_Week")
		game_HomeTeam_ID = rsGameData("game_HomeTeam_ID")
		game_HomeTeam_Score = rsGameData("game_HomeTeam_Score")
		game_AwayTeam_ID = rsGameData("game_AwayTeam_ID")
		game_AwayTeam_Score = rsGameData("game_AwayTeam_Score")
		rsGameData.Close
		Set rsGameData = Nothing
	
	End If
	
	sqlGetHomeData = "SELECT team_City, team_Mascot, team_Color_Primary, team_Color_Secondary FROM qbx_Teams WHERE team_ID = " & game_HomeTeam_ID
	sqlGetAwayData = "SELECT team_City, team_Mascot, team_Color_Primary, team_Color_Secondary FROM qbx_Teams WHERE team_ID = " & game_AwayTeam_ID
	
	Set rsHomeData = sqlSameLevel.Execute(sqlGetHomeData)
	Set rsAwayData = sqlSameLevel.Execute(sqlGetAwayData)
	
	game_HomeTeam_City = rsHomeData("team_City")
	game_HomeTeam_Mascot = rsHomeData("team_Mascot")
	game_HomeTeam_Color_Primary = rsHomeData("team_Color_Primary")
	game_HomeTeam_Color_Secondary = rsHomeData("team_Color_Secondary")
	game_AwayTeam_City = rsAwayData("team_City")
	game_AwayTeam_Mascot = rsAwayData("team_Mascot")
	game_AwayTeam_Color_Primary = rsAwayData("team_Color_Primary")
	game_AwayTeam_Color_Secondary = rsAwayData("team_Color_Secondary")
	
	rsHomeData.Close
	Set rsHomeData = Nothing
	
	rsAwayData.Close
	Set rsAwayData = Nothing	
	
	sqlGetQBData = "SELECT * FROM qbx_tracker WHERE game_ID = " & game_ID
	Set rsQBData = sqlSameLevel.Execute(sqlGetQBData)
	
	If Not rsQBData.Eof Then
	
		Do While Not rsQBData.Eof
		
			tracker_Starter = rsQBData("tracker_Starter")
			tracker_BackUp1 = rsQBData("tracker_BackUp1")
			tracker_BackUp2 = rsQBData("tracker_BackUp2")
			
			If tracker_Starter Then
				
				If rsQBData("team_ID") = game_HomeTeam_ID Then
					home_Starter_ID     = rsQBData("qb_ID")
					home_Starter_QBR    = rsQBData("tracker_QBR")
					home_Starter_PaTD   = rsQBData("tracker_PassingTouchdowns")
					home_Starter_PaInt  = rsQBData("tracker_PassingInterceptions")
					home_Starter_PaYds  = rsQBData("tracker_PassingYards")
					home_Starter_PaYPA  = rsQBData("tracker_PassingYardsPerAttempt")
					home_Starter_PaAtt  = rsQBData("tracker_PassingAttempts")
					home_Starter_PaComp = rsQBData("tracker_PassingCompletions")
					home_Starter_RuTD   = rsQBData("tracker_RushingTouchdowns")
					home_Starter_Fum    = rsQBData("tracker_FumblesLost")
					home_Starter_RuYds  = rsQBData("tracker_RushingYards")
					home_Starter_RuYPA  = rsQBData("tracker_RushingYardsPerAttempt")
					home_Starter_RuAtt  = rsQBData("tracker_RushingAttempts")
					home_Starter_Sacks  = rsQBData("tracker_Sacks")
					
				ElseIf rsQBData("team_ID") = game_AwayTeam_ID Then
					away_Starter_ID     = rsQBData("qb_ID")
					away_Starter_QBR    = rsQBData("tracker_QBR")
					away_Starter_PaTD   = rsQBData("tracker_PassingTouchdowns")
					away_Starter_PaInt  = rsQBData("tracker_PassingInterceptions")
					away_Starter_PaYds  = rsQBData("tracker_PassingYards")
					away_Starter_PaYPA  = rsQBData("tracker_PassingYardsPerAttempt")
					away_Starter_PaAtt  = rsQBData("tracker_PassingAttempts")
					away_Starter_PaComp = rsQBData("tracker_PassingCompletions")
					away_Starter_RuTD   = rsQBData("tracker_RushingTouchdowns")
					away_Starter_Fum    = rsQBData("tracker_FumblesLost")
					away_Starter_RuYds  = rsQBData("tracker_RushingYards")
					away_Starter_RuYPA  = rsQBData("tracker_RushingYardsPerAttempt")
					away_Starter_RuAtt  = rsQBData("tracker_RushingAttempts")
					away_Starter_Sacks  = rsQBData("tracker_Sacks")
				End If
			
			End If
			
			If tracker_BackUp1 Then
			
				If rsQBData("team_ID") = game_HomeTeam_ID Then
					home_BackUp1_ID     = rsQBData("qb_ID")
					home_BackUp1_QBR    = rsQBData("tracker_QBR")
					home_BackUp1_PaTD   = rsQBData("tracker_PassingTouchdowns")
					home_BackUp1_PaInt  = rsQBData("tracker_PassingInterceptions")
					home_BackUp1_PaYds  = rsQBData("tracker_PassingYards")
					home_BackUp1_PaYPA  = rsQBData("tracker_PassingYardsPerAttempt")
					home_BackUp1_PaAtt  = rsQBData("tracker_PassingAttempts")
					home_BackUp1_PaComp = rsQBData("tracker_PassingCompletions")
					home_BackUp1_RuTD   = rsQBData("tracker_RushingTouchdowns")
					home_BackUp1_Fum    = rsQBData("tracker_FumblesLost")
					home_BackUp1_RuYds  = rsQBData("tracker_RushingYards")
					home_BackUp1_RuYPA  = rsQBData("tracker_RushingYardsPerAttempt")
					home_BackUp1_RuAtt  = rsQBData("tracker_RushingAttempts")
					home_BackUp1_Sacks  = rsQBData("tracker_Sacks")
				ElseIf rsQBData("team_ID") = game_AwayTeam_ID Then
					away_BackUp1_ID     = rsQBData("qb_ID")
					away_BackUp1_QBR    = rsQBData("tracker_QBR")
					away_BackUp1_PaTD   = rsQBData("tracker_PassingTouchdowns")
					away_BackUp1_PaInt  = rsQBData("tracker_PassingInterceptions")
					away_BackUp1_PaYds  = rsQBData("tracker_PassingYards")
					away_BackUp1_PaYPA  = rsQBData("tracker_PassingYardsPerAttempt")
					away_BackUp1_PaAtt  = rsQBData("tracker_PassingAttempts")
					away_BackUp1_PaComp = rsQBData("tracker_PassingCompletions")
					away_BackUp1_RuTD   = rsQBData("tracker_RushingTouchdowns")
					away_BackUp1_Fum    = rsQBData("tracker_FumblesLost")
					away_BackUp1_RuYds  = rsQBData("tracker_RushingYards")
					away_BackUp1_RuYPA  = rsQBData("tracker_RushingYardsPerAttempt")
					away_BackUp1_RuAtt  = rsQBData("tracker_RushingAttempts")
					away_BackUp1_Sacks  = rsQBData("tracker_Sacks")
				End If
			
			End If
			
			If tracker_BackUp2 Then
				
				If rsQBData("team_ID") = game_HomeTeam_ID Then
					home_BackUp2_ID     = rsQBData("qb_ID")
					home_BackUp2_QBR    = rsQBData("tracker_QBR")
					home_BackUp2_PaTD   = rsQBData("tracker_PassingTouchdowns")
					home_BackUp2_PaInt  = rsQBData("tracker_PassingInterceptions")
					home_BackUp2_PaYds  = rsQBData("tracker_PassingYards")
					home_BackUp2_PaYPA  = rsQBData("tracker_PassingYardsPerAttempt")
					home_BackUp2_PaAtt  = rsQBData("tracker_PassingAttempts")
					home_BackUp2_PaComp = rsQBData("tracker_PassingCompletions")
					home_BackUp2_RuTD   = rsQBData("tracker_RushingTouchdowns")
					home_BackUp2_Fum    = rsQBData("tracker_FumblesLost")
					home_BackUp2_RuYds  = rsQBData("tracker_RushingYards")
					home_BackUp2_RuYPA  = rsQBData("tracker_RushingYardsPerAttempt")
					home_BackUp2_RuAtt  = rsQBData("tracker_RushingAttempts")
					home_BackUp2_Sacks  = rsQBData("tracker_Sacks")
				ElseIf rsQBData("team_ID") = game_AwayTeam_ID Then
					away_BackUp2_ID     = rsQBData("qb_ID")
					away_BackUp2_QBR    = rsQBData("tracker_QBR")
					away_BackUp2_PaTD   = rsQBData("tracker_PassingTouchdowns")
					away_BackUp2_PaInt  = rsQBData("tracker_PassingInterceptions")
					away_BackUp2_PaYds  = rsQBData("tracker_PassingYards")
					away_BackUp2_PaYPA  = rsQBData("tracker_PassingYardsPerAttempt")
					away_BackUp2_PaAtt  = rsQBData("tracker_PassingAttempts")
					away_BackUp2_PaComp = rsQBData("tracker_PassingCompletions")
					away_BackUp2_RuTD   = rsQBData("tracker_RushingTouchdowns")
					away_BackUp2_Fum    = rsQBData("tracker_FumblesLost")
					away_BackUp2_RuYds  = rsQBData("tracker_RushingYards")
					away_BackUp2_RuYPA  = rsQBData("tracker_RushingYardsPerAttempt")
					away_BackUp2_RuAtt  = rsQBData("tracker_RushingAttempts")
					away_BackUp2_Sacks  = rsQBData("tracker_Sacks")
				End If
				
			End If
			
			rsQBData.MoveNext
		
		Loop
		
		rsQBData.Close
		Set rsQBData = Nothing
		
	End If
%>
	<input type="hidden" name="game_ID" id="game_ID" value="<%= game_ID %>" />
	<input type="hidden" name="home_TeamID" id="home_TeamID" value="<%= game_HomeTeam_ID %>" />
	<input type="hidden" name="away_TeamID" id="away_TeamID" value="<%= game_AwayTeam_ID %>" />
	<input type="hidden" name="home_TeamScore" id="home_TeamScore" value="<%= game_HomeTeam_Score %>" />
	<input type="hidden" name="away_TeamScore" id="away_TeamScore" value="<%= game_AwayTeam_Score %>" />
	<%= game_ID %>
	<div class="row" style="margin-bottom: 0; padding-bottom: 0;">
	
		<div class="col-xs-6">
			
			<div class="input-group">
				
				<div class="alert" style="margin-bottom: 10px; background-color: #<%= game_AwayTeam_Color_Primary %>; color: #<%= game_AwayTeam_Color_Secondary %>;">
					<div class="pull-left"><b><%= game_AwayTeam_City %></b></div>
					<div class="pull-right"><b><%= game_AwayTeam_Score %></b></div>
					<div style="clear: both;"></div>
				</div>
				
				<div class="alert" style="padding-top: 0; margin-top: 0px;">
				
					<div class="row">
					
						<div class="col-xs-8">
							<label>Starting Quarterback</label>
							<select name="away_Starter_ID" id="away_Starter_ID" class="form-control" style="margin-bottom: 10px; padding-left: 7px;" required>
								<option value="" disabled selected>Starter</option>
<%
								sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team = " & game_AwayTeam_ID & " ORDER BY qb_Name ASC"
								Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
								
								Do While Not rsQuarterbacks.Eof
								
									selected = ""
									If away_Starter_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
									
									Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
									rsQuarterbacks.MoveNext
									
								Loop
								
								rsQuarterbacks.Close
								Set rsQuarterbacks = Nothing
%>
								<option value="">----------------</option>
<%
								sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team <> " & game_AwayTeam_ID & " ORDER BY qb_Name ASC"
								Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
								
								Do While Not rsQuarterbacks.Eof
									
									selected = ""
									If away_Starter_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
									
									Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
									rsQuarterbacks.MoveNext
									
								Loop
								
								rsQuarterbacks.Close
								Set rsQuarterbacks = Nothing
%>
							</select>
						</div>
						
						<div class="col-xs-4">
							<label>QBR</label>
							<input name="away_Starter_QBR" id="away_Starter_QBR" type="text" class="form-control col-xs-4" value="<%= away_Starter_QBR %>" required>
						</div>
						
					</div>
					
					<div class="row">
						<div class="col-xs-4"><label>PaAtt</label></div>
						<div class="col-xs-4"><label>PaComp</label></div>
						<div class="col-xs-4"><label>PaYds</label></div>
					</div>
					
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-xs-4"><input name="away_Starter_PaAtt" id="away_Starter_PaAtt" type="text" class="form-control col-xs-4" value="<%= away_Starter_PaAtt %>" required></div>
						<div class="col-xs-4"><input name="away_Starter_PaComp" id="away_Starter_PaComp" type="text" class="form-control col-xs-4" value="<%= away_Starter_PaComp %>" required></div>
						<div class="col-xs-4"><input name="away_Starter_PaYds" id="away_Starter_PaYds" type="text" class="form-control col-xs-4" value="<%= away_Starter_PaYds %>" required></div>
					</div>
					
					<div class="row">
						<div class="col-xs-4"><label>PaYPA</label></div>
						<div class="col-xs-4"><label>PaTD</label></div>
						<div class="col-xs-4"><label>PaInt</label></div>
					</div>
					
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-xs-4"><input name="away_Starter_PaYPA" id="away_Starter_PaYPA" type="text" class="form-control col-xs-4" value="<%= away_Starter_PaYPA %>" required></div>
						<div class="col-xs-4"><input name="away_Starter_PaTD" id="away_Starter_PaTD" type="text" class="form-control col-xs-4" value="<%= away_Starter_PaTD %>" required></div>
						<div class="col-xs-4"><input name="away_Starter_PaInt" id="away_Starter_PaInt" type="text" class="form-control col-xs-4" value="<%= away_Starter_PaInt %>" required></div>
						
					</div>
					
					<div class="row">
						<div class="col-xs-4"><label>RuAtt</label></div>
						<div class="col-xs-4"><label>RuYds</label></div>
						<div class="col-xs-4"><label>Fum</label></div>
					</div>
					
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-xs-4"><input name="away_Starter_RuAtt" id="away_Starter_RuAtt" type="text" class="form-control col-xs-4" value="<%= away_Starter_RuAtt %>" required></div>
						<div class="col-xs-4"><input name="away_Starter_RuYds" id="away_Starter_RuYds" type="text" class="form-control col-xs-4" value="<%= away_Starter_RuYds %>" required></div>
						<div class="col-xs-4"><input name="away_Starter_Fum" id="away_Starter_Fum" type="text" class="form-control col-xs-4" value="<%= away_Starter_Fum %>" required></div>
					</div>
					
					<div class="row">	
						<div class="col-xs-4"><label>RuYPA</label></div>
						<div class="col-xs-4"><label>RuTD</label></div>
						<div class="col-xs-4"><label>Sacks</label></div>
					</div>
					
					<div class="row">
						<div class="col-xs-4"><input name="away_Starter_RuYPA" id="away_Starter_RuYPA" type="text" class="form-control col-xs-4" value="<%= away_Starter_RuYPA %>" required></div>
						<div class="col-xs-4"><input name="away_Starter_RuTD" id="away_Starter_RuTD" type="text" class="form-control col-xs-4" value="<%= away_Starter_RuTD %>" required></div>
						<div class="col-xs-4"><input name="away_Starter_Sacks" id="away_Starter_Sacks" type="text" class="form-control col-xs-4" value="<%= away_Starter_Sacks %>" required></div>
					</div>
					
					
					<div id="away_BackUps" style="display: none;">
						
						<hr />
						<div class="row">
					
							<div class="col-xs-8">
								<label>Back-Up Quarterback #1</label>
								<select name="away_BackUp1_ID" id="away_BackUp1_ID" class="form-control" style="margin-bottom: 10px; padding-left: 7px;">
									<option value="">Back-Up #1</option>
<%
									sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team = " & game_AwayTeam_ID & " ORDER BY qb_Name ASC"
									Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
									
									Do While Not rsQuarterbacks.Eof
									
										selected = ""
										If away_BackUp1_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
										
										Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
										rsQuarterbacks.MoveNext
										
									Loop
									
									rsQuarterbacks.Close
									Set rsQuarterbacks = Nothing
%>
									<option value="">----------------</option>
<%
									sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team <> " & game_AwayTeam_ID & " ORDER BY qb_Name ASC"
									Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
									
									Do While Not rsQuarterbacks.Eof
										
										selected = ""
										If away_BackUp1_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
										
										Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
										rsQuarterbacks.MoveNext
										
									Loop
									
									rsQuarterbacks.Close
									Set rsQuarterbacks = Nothing
%>
								</select>
							</div>
							
							<div class="col-xs-4">
								<label>QBR</label>
								<input name="away_BackUp1_QBR" id="away_BackUp1_QBR" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_QBR %>">
							</div>
							
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>PaAtt</label></div>
							<div class="col-xs-4"><label>PaComp</label></div>
							<div class="col-xs-4"><label>PaYds</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="away_BackUp1_PaAtt" id="away_BackUp1_PaAtt" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_PaAtt %>"></div>
							<div class="col-xs-4"><input name="away_BackUp1_PaComp" id="away_BackUp1_PaComp" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_PaComp %>"></div>
							<div class="col-xs-4"><input name="away_BackUp1_PaYds" id="away_BackUp1_PaYds" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_PaYds %>"></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>PaYPA</label></div>
							<div class="col-xs-4"><label>PaTD</label></div>
							<div class="col-xs-4"><label>PaInt</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="away_BackUp1_PaYPA" id="away_BackUp1_PaYPA" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_PaYPA %>"></div>
							<div class="col-xs-4"><input name="away_BackUp1_PaTD" id="away_BackUp1_PaTD" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_PaTD %>"></div>
							<div class="col-xs-4"><input name="away_BackUp1_PaInt" id="away_BackUp1_PaInt" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_PaInt %>"></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>RuAtt</label></div>
							<div class="col-xs-4"><label>RuYds</label></div>
							<div class="col-xs-4"><label>Fum</label></div>
						</div>
						
						
						<div class="row" style="margin-bottom: 10px;">
							
							<div class="col-xs-4"><input name="away_BackUp1_RuAtt" id="away_BackUp1_RuAtt" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_RuAtt %>"></div>
							<div class="col-xs-4"><input name="away_BackUp1_RuYds" id="away_BackUp1_RuYds" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_RuYds %>"></div>
							<div class="col-xs-4"><input name="away_BackUp1_Fum" id="away_BackUp1_Fum" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_Fum %>"></div>
						</div>
						
						
						<div class="row">
							<div class="col-xs-4"><label>RuYPA</label></div>
							<div class="col-xs-4"><label>RuTD</label></div>
							<div class="col-xs-4"><label>Sacks</label></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><input name="away_BackUp1_RuYPA" id="away_BackUp1_RuYPA" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_RuYPA %>"></div>
							<div class="col-xs-4"><input name="away_BackUp1_RuTD" id="away_BackUp1_RuTD" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_RuTD %>"></div>
							<div class="col-xs-4"><input name="away_BackUp1_Sacks" id="away_BackUp1_Sacks" type="text" class="form-control col-xs-4" value="<%= away_BackUp1_Sacks %>"></div>
						</div>
						
						<hr />
						
						<div class="row">
					
							<div class="col-xs-8">
								<label>Back-Up Quarterback #2</label>
								<select name="away_BackUp2_ID" id="away_BackUp2_ID" class="form-control" style="margin-bottom: 10px; padding-left: 7px;">
									<option value="">Back-Up #2</option>
<%
									sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team = " & game_AwayTeam_ID & " ORDER BY qb_Name ASC"
									Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
									
									Do While Not rsQuarterbacks.Eof
									
										selected = ""
										If away_BackUp2_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
										
										Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
										rsQuarterbacks.MoveNext
										
									Loop
									
									rsQuarterbacks.Close
									Set rsQuarterbacks = Nothing
%>
									<option value="">----------------</option>
<%
									sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team <> " & game_AwayTeam_ID & " ORDER BY qb_Name ASC"
									Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
									
									Do While Not rsQuarterbacks.Eof
										
										selected = ""
										If away_BackUp2_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
										
										Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
										rsQuarterbacks.MoveNext
										
									Loop
									
									rsQuarterbacks.Close
									Set rsQuarterbacks = Nothing
%>
								</select>
							</div>
							
							<div class="col-xs-4">
								<label>QBR</label>
								<input name="away_BackUp2_QBR" id="away_BackUp2_QBR" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_QBR %>">
							</div>
							
						</div>
						
						
						<div class="row">
							<div class="col-xs-4"><label>PaAtt</label></div>
							<div class="col-xs-4"><label>PaComp</label></div>
							<div class="col-xs-4"><label>PaYds</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="away_BackUp2_PaAtt" id="away_BackUp2_PaAtt" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_PaAtt %>"></div>
							<div class="col-xs-4"><input name="away_BackUp2_PaComp" id="away_BackUp2_PaComp" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_PaComp %>"></div>
							<div class="col-xs-4"><input name="away_BackUp2_PaYds" id="away_BackUp2_PaYds" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_PaYds %>"></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>PaYPA</label></div>
							<div class="col-xs-4"><label>PaTD</label></div>
							<div class="col-xs-4"><label>PaInt</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="away_BackUp2_PaYPA" id="away_BackUp2_PaYPA" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_PaYPA %>"></div>
							<div class="col-xs-4"><input name="away_BackUp2_PaTD" id="away_BackUp2_PaTD" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_PaTD %>"></div>
							<div class="col-xs-4"><input name="away_BackUp2_PaInt" id="away_BackUp2_PaInt" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_PaInt %>"></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>RuAtt</label></div>
							<div class="col-xs-4"><label>RuYds</label></div>
							<div class="col-xs-4"><label>Fum</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="away_BackUp2_RuAtt" id="away_BackUp2_RuAtt" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_RuAtt %>"></div>
							<div class="col-xs-4"><input name="away_BackUp2_RuYds" id="away_BackUp2_RuYds" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_RuYds %>"></div>
							<div class="col-xs-4"><input name="away_BackUp2_Fum" id="away_BackUp2_Fum" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_Fum %>"></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>RuYPA</label></div>
							<div class="col-xs-4"><label>RuTD</label></div>
							<div class="col-xs-4"><label>Sacks</label></div>
						</div>
							
						<div class="row">
							<div class="col-xs-4"><input name="away_BackUp2_RuYPA" id="away_BackUp2_RuYPA" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_RuYPA %>"></div>
							<div class="col-xs-4"><input name="away_BackUp2_RuTD" id="away_BackUp2_RuTD" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_RuTD %>"></div>
							<div class="col-xs-4"><input name="away_BackUp2_Sacks" id="away_BackUp2_Sacks" type="text" class="form-control col-xs-4" value="<%= away_BackUp2_Sacks %>"></div>
						</div>
					
					</div>
					
				</div>
				
			</div>
			
		</div>
		
		<div class="col-xs-6">
			
			<div class="input-group">
				
				<div class="alert" style="margin-bottom: 10px; background-color: #<%= game_HomeTeam_Color_Primary %>; color: #<%= game_HomeTeam_Color_Secondary %>;">
					<div class="pull-left"><b><%= game_HomeTeam_City %></b></div>
					<div class="pull-right"><b><%= game_HomeTeam_Score %></b></div>
					<div style="clear: both;"></div>
				</div>
				
				<div class="alert" style="padding-top: 0; margin-top: 0px;">
				
					<div class="row">
					
						<div class="col-xs-8">
							<label>Starting Quarterback</label>
							<select name="home_Starter_ID" id="home_Starter_ID" class="form-control" style="margin-bottom: 10px; padding-left: 7px;" required>
								<option value="" disabled selected>Starter</option>
<%
								sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team = " & game_HomeTeam_ID & " ORDER BY qb_Name ASC"
								Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
								
								Do While Not rsQuarterbacks.Eof
								
									selected = ""
									If home_Starter_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
									
									Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
									rsQuarterbacks.MoveNext
									
								Loop
								
								rsQuarterbacks.Close
								Set rsQuarterbacks = Nothing
%>
								<option value="">----------------</option>
<%
								sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team <> " & game_HomeTeam_ID & " ORDER BY qb_Name ASC"
								Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
								
								Do While Not rsQuarterbacks.Eof
									
									selected = ""
									If home_Starter_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
									
									Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
									rsQuarterbacks.MoveNext
									
								Loop
								
								rsQuarterbacks.Close
								Set rsQuarterbacks = Nothing
%>
							</select>
						</div>
						
						<div class="col-xs-4">
							<label>QBR</label>
							<input name="home_Starter_QBR" id="home_Starter_QBR" type="text" class="form-control col-xs-4" value="<%= home_Starter_QBR %>" required>
						</div>
						
					</div>
					
					<div class="row">
						<div class="col-xs-4"><label>PaAtt</label></div>
						<div class="col-xs-4"><label>PaComp</label></div>
						<div class="col-xs-4"><label>PaYds</label></div>
					</div>
					
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-xs-4"><input name="home_Starter_PaAtt" id="home_Starter_PaAtt" type="text" class="form-control col-xs-4" value="<%= home_Starter_PaAtt %>" required></div>
						<div class="col-xs-4"><input name="home_Starter_PaComp" id="home_Starter_PaComp" type="text" class="form-control col-xs-4" value="<%= home_Starter_PaComp %>" required></div>
						<div class="col-xs-4"><input name="home_Starter_PaYds" id="home_Starter_PaYds" type="text" class="form-control col-xs-4" value="<%= home_Starter_PaYds %>" required></div>
					</div>
					
					<div class="row">
						<div class="col-xs-4"><label>PaYPA</label></div>
						<div class="col-xs-4"><label>PaTD</label></div>
						<div class="col-xs-4"><label>PaInt</label></div>
					</div>
					
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-xs-4"><input name="home_Starter_PaYPA" id="home_Starter_PaYPA" type="text" class="form-control col-xs-4" value="<%= home_Starter_PaYPA %>" required></div>
						<div class="col-xs-4"><input name="home_Starter_PaTD" id="home_Starter_PaTD" type="text" class="form-control col-xs-4" value="<%= home_Starter_PaTD %>" required></div>
						<div class="col-xs-4"><input name="home_Starter_PaInt" id="home_Starter_PaInt" type="text" class="form-control col-xs-4" value="<%= home_Starter_PaInt %>" required></div>
					</div>
					
					<div class="row">
						<div class="col-xs-4"><label>RuAtt</label></div>
						<div class="col-xs-4"><label>RuYds</label></div>
						<div class="col-xs-4"><label>Fum</label></div>
					</div>
					
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-xs-4"><input name="home_Starter_RuAtt" id="home_Starter_RuAtt" type="text" class="form-control col-xs-4" value="<%= home_Starter_RuAtt %>" required></div>
						<div class="col-xs-4"><input name="home_Starter_RuYds" id="home_Starter_RuYds" type="text" class="form-control col-xs-4" value="<%= home_Starter_RuYds %>" required></div>
						<div class="col-xs-4"><input name="home_Starter_Fum" id="home_Starter_Fum" type="text" class="form-control col-xs-4" value="<%= home_Starter_Fum %>" required></div>
					</div>
					
					<div class="row">
						<div class="col-xs-4"><label>RuYPA</label></div>
						<div class="col-xs-4"><label>RuTD</label></div>
						<div class="col-xs-4"><label>Sacks</label></div>
					</div>
					
					<div class="row">
						<div class="col-xs-4"><input name="home_Starter_RuYPA" id="home_Starter_RuYPA" type="text" class="form-control col-xs-4" value="<%= home_Starter_RuYPA %>" required></div>
						<div class="col-xs-4"><input name="home_Starter_RuTD" id="home_Starter_RuTD" type="text" class="form-control col-xs-4" value="<%= home_Starter_RuTD %>" required></div>
						<div class="col-xs-4"><input name="home_Starter_Sacks" id="home_Starter_Sacks" type="text" class="form-control col-xs-4" value="<%= home_Starter_Sacks %>" required></div>
					</div>
					
					<div id="home_BackUps" style="display: none;">
						
						<hr />
						<div class="row">
					
							<div class="col-xs-8">
								<label>Back-Up Quarterback #1</label>
								<select name="home_BackUp1_ID" id="home_BackUp1_ID" class="form-control" style="margin-bottom: 10px; padding-left: 7px;">
									<option value="">Back-Up #1</option>
<%
									sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team = " & game_HomeTeam_ID & " ORDER BY qb_Name ASC"
									Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
									
									Do While Not rsQuarterbacks.Eof
									
										selected = ""
										If home_BackUp1_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
										
										Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
										rsQuarterbacks.MoveNext
										
									Loop
									
									rsQuarterbacks.Close
									Set rsQuarterbacks = Nothing
%>
									<option value="">----------------</option>
<%
									sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team <> " & game_HomeTeam_ID & " ORDER BY qb_Name ASC"
									Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
									
									Do While Not rsQuarterbacks.Eof
										
										selected = ""
										If home_BackUp1_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
										
										Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
										rsQuarterbacks.MoveNext
										
									Loop
									
									rsQuarterbacks.Close
									Set rsQuarterbacks = Nothing
%>
								</select>
							</div>
							
							<div class="col-xs-4">
								<label>QBR</label>
								<input name="home_BackUp1_QBR" id="home_BackUp1_QBR" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_QBR %>">
							</div>
							
						</div>
						
						
						<div class="row">
							<div class="col-xs-4"><label>PaAtt</label></div>
							<div class="col-xs-4"><label>PaComp</label></div>
							<div class="col-xs-4"><label>PaYds</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="home_BackUp1_PaAtt" id="home_BackUp1_PaAtt" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_PaAtt %>"></div>
							<div class="col-xs-4"><input name="home_BackUp1_PaComp" id="home_BackUp1_PaComp" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_PaComp %>"></div>
							<div class="col-xs-4"><input name="home_BackUp1_PaYds" id="home_BackUp1_PaYds" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_PaYds %>"></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>PaYPA</label></div>
							<div class="col-xs-4"><label>PaTD</label></div>
							<div class="col-xs-4"><label>PaInt</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="home_BackUp1_PaYPA" id="home_BackUp1_PaYPA" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_PaYPA %>"></div>
							<div class="col-xs-4"><input name="home_BackUp1_PaTD" id="home_BackUp1_PaTD" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_PaTD %>"></div>
							<div class="col-xs-4"><input name="home_BackUp1_PaInt" id="home_BackUp1_PaInt" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_PaInt %>"></div>
						</div>
						
						
						<div class="row">
							<div class="col-xs-4"><label>RuAtt</label></div>
							<div class="col-xs-4"><label>RuYds</label></div>
							<div class="col-xs-4"><label>Fum</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="home_BackUp1_RuAtt" id="home_BackUp1_RuAtt" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_RuAtt %>"></div>
							<div class="col-xs-4"><input name="home_BackUp1_RuYds" id="home_BackUp1_RuYds" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_RuYds %>"></div>
							<div class="col-xs-4"><input name="home_BackUp1_Fum" id="home_BackUp1_Fum" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_Fum %>"></div>
						</div>
						
						
						<div class="row">
							<div class="col-xs-4"><label>RuYPA</label></div>
							<div class="col-xs-4"><label>RuTD</label></div>
							<div class="col-xs-4"><label>Sacks</label></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><input name="home_BackUp1_RuYPA" id="home_BackUp1_RuYPA" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_RuYPA %>"></div>
							<div class="col-xs-4"><input name="home_BackUp1_RuTD" id="home_BackUp1_RuTD" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_RuTD %>"></div>
							<div class="col-xs-4"><input name="home_BackUp1_Sacks" id="home_BackUp1_Sacks" type="text" class="form-control col-xs-4" value="<%= home_BackUp1_Sacks %>"></div>
						</div>
						
						<hr />
						
						<div class="row">
					
							<div class="col-xs-8">
								<label>Back-Up Quarterback #2</label>
								<select name="home_BackUp2_ID" id="home_BackUp2_ID" class="form-control" style="margin-bottom: 10px; padding-left: 7px;">
									<option value="">Back-Up #2</option>
<%
									sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team = " & game_HomeTeam_ID & " ORDER BY qb_Name ASC"
									Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
									
									Do While Not rsQuarterbacks.Eof
									
										selected = ""
										If home_BackUp2_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
										
										Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
										rsQuarterbacks.MoveNext
										
									Loop
									
									rsQuarterbacks.Close
									Set rsQuarterbacks = Nothing
%>
									<option value="">----------------</option>
<%
									sqlGetQuarterbacks = "SELECT * FROM qbx_quarterbacks WHERE qb_Team <> " & game_HomeTeam_ID & " ORDER BY qb_Name ASC"
									Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
									
									Do While Not rsQuarterbacks.Eof
										
										selected = ""
										If home_BackUp2_ID = rsQuarterbacks("qb_ID") Then selected="selected=""selected"""
										
										Response.Write("<option value=""" & rsQuarterbacks("qb_ID") & """ " & selected & ">" & rsQuarterbacks("qb_Name") & "</option>")
										rsQuarterbacks.MoveNext
										
									Loop
									
									rsQuarterbacks.Close
									Set rsQuarterbacks = Nothing
%>
								</select>
							</div>
							
							<div class="col-xs-4">
								<label>QBR</label>
								<input name="home_BackUp2_QBR" id="home_BackUp2_QBR" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_QBR %>">
							</div>
							
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>PaAtt</label></div>
							<div class="col-xs-4"><label>PaComp</label></div>
							<div class="col-xs-4"><label>PaYds</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="home_BackUp2_PaAtt" id="home_BackUp2_PaAtt" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_PaAtt %>"></div>
							<div class="col-xs-4"><input name="home_BackUp2_PaComp" id="home_BackUp2_PaComp" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_PaComp %>"></div>
							<div class="col-xs-4"><input name="home_BackUp2_PaYds" id="home_BackUp2_PaYds" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_PaYds %>"></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>PaYPA</label></div>
							<div class="col-xs-4"><label>PaTD</label></div>
							<div class="col-xs-4"><label>PaInt</label></div>
						</div>
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="home_BackUp2_PaYPA" id="home_BackUp2_PaYPA" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_PaYPA %>"></div>
							<div class="col-xs-4"><input name="home_BackUp2_PaTD" id="home_BackUp2_PaTD" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_PaTD %>"></div>
							<div class="col-xs-4"><input name="home_BackUp2_PaInt" id="home_BackUp2_PaInt" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_PaInt %>"></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><label>RuAtt</label></div>
							<div class="col-xs-4"><label>RuYds</label></div>
							<div class="col-xs-4"><label>Fum</label></div>
						</div>
						
						
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-xs-4"><input name="home_BackUp2_RuAtt" id="home_BackUp2_RuAtt" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_RuAtt %>"></div>
							<div class="col-xs-4"><input name="home_BackUp2_RuYds" id="home_BackUp2_RuYds" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_RuYds %>"></div>
							<div class="col-xs-4"><input name="home_BackUp2_Fum" id="home_BackUp2_Fum" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_Fum %>"></div>
						</div>	
						
						<div class="row">
							<div class="col-xs-4"><label>RuYPA</label></div>
							<div class="col-xs-4"><label>RuTD</label></div>
							<div class="col-xs-4"><label>Sacks</label></div>
						</div>
						
						<div class="row">
							<div class="col-xs-4"><input name="home_BackUp2_RuYPA" id="home_BackUp2_RuYPA" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_RuYPA %>"></div>
							<div class="col-xs-4"><input name="home_BackUp2_RuTD" id="home_BackUp2_RuTD" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_RuTD %>"></div>
							<div class="col-xs-4"><input name="home_BackUp2_Sacks" id="home_BackUp2_Sacks" type="text" class="form-control col-xs-4" value="<%= home_BackUp2_Sacks %>"></div>
						</div>
					
					</div>
					
				</div>
				
			</div>
			
		</div>
		
	</div>
	
	<div id="toggle_BackUps" style="text-align: center; margin-bottom: 20px; margin-top: 0;"><button type="button" class="btn btn-primary btn-xs" onclick="document.getElementById('home_BackUps').style.display = 'block';document.getElementById('away_BackUps').style.display = 'block';document.getElementById('toggle_BackUps').style.display = 'none';">SHOW BACK-UP QUARTERBACKS</button></div>
	
	
	<button type="submit" class="btn btn-success" style="width: 100%;">UPDATE GAME DATA</button>