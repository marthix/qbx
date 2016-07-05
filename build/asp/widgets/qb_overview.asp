<div class="box box-warning">
	<div class="box-header with-border">
		<i class="fa fa-user"></i>
		<h3 class="box-title">Quarterback Overview</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		</div>
	</div>
	<div class="box-body" style="padding-bottom: 0;">
		
		<div class="row">
			
			<div class="col-lg-4" align="center"><img src="/build/img/profile/<%= QBLink(Session.Contents("QBX_Current_QB_Name")) %>.png" width="100%" style="max-width: 200px;" /></div>
<%
			sqlGetLastTwo     = "SELECT price_Value FROM samelevel.qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " ORDER BY game_Year DESC, game_Week DESC LIMIT 2"
			sqlGetLastFour    = "SELECT price_Value FROM samelevel.qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " ORDER BY game_Year DESC, game_Week DESC LIMIT 4"
			sqlGetLastEight   = "SELECT price_Value FROM samelevel.qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " ORDER BY game_Year DESC, game_Week DESC LIMIT 8"
			sqlGetLastSixteen = "SELECT price_Value FROM samelevel.qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " ORDER BY game_Year DESC, game_Week DESC LIMIT 16"
			sqlGetYTD         = "SELECT price_Value FROM samelevel.qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2015 ORDER BY game_Week DESC"
			
			Set rsLastTwo     = sqlSameLevel.Execute(sqlGetLastTwo)
			Set rsLastFour    = sqlSameLevel.Execute(sqlGetLastFour)
			Set rsLastEight   = sqlSameLevel.Execute(sqlGetLastEight)
			Set rsLastSixteen = sqlSameLevel.Execute(sqlGetLastSixteen)
			Set rsYTD         = sqlSameLevel.Execute(sqlGetYTD)
			
			arLastTwo = rsLastTwo.GetRows()
			arLastFour = rsLastFour.GetRows()
			arLastEight = rsLastEight.GetRows()
			arLastSixteen = rsLastSixteen.GetRows()
			arYTD = rsYTD.GetRows()
			
			LastTwo_End = arLastTwo(0,0)
			LastTwo_Start = arLastTwo(0,UBound(arLastTwo,2))
			
			LastTwo_Change = LastTwo_End - LastTwo_Start
			LastTwo_Percent = (LastTwo_Change / LastTwo_Start) * 100
			
			If LastTwo_Percent < 0 Then
				LastTwo_Change_Type = "text-red"
				LastTwo_Caret_Type = "fa-caret-down"
				LastTwo_Percent = LastTwo_Percent * -1
			ElseIf LastTwo_Percent > 0 Then
				LastTwo_Change_Type = "text-green"
				LastTwo_Caret_Type = "fa-caret-up"
			Else
				LastTwo_Change_Type = "text-yellow"
				LastTwo_Caret_Type = "fa-caret-right"
			End If
			
			LastFour_End = arLastFour(0,0)
			LastFour_Start = arLastFour(0,UBound(arLastFour,2))
			
			LastFour_Change = LastFour_End - LastFour_Start
			LastFour_Percent = (LastFour_Change / LastFour_Start) * 100
			
			If LastFour_Percent < 0 Then
				LastFour_Change_Type = "text-red"
				LastFour_Caret_Type = "fa-caret-down"
				LastFour_Percent = LastFour_Percent * -1
			ElseIf LastFour_Percent > 0 Then
				LastFour_Change_Type = "text-green"
				LastFour_Caret_Type = "fa-caret-up"
			Else
				LastFour_Change_Type = "text-yellow"
				LastFour_Caret_Type = "fa-caret-right"
			End If
			
			LastEight_End = arLastEight(0,0)
			LastEight_Start = arLastEight(0,UBound(arLastEight,2))
			
			LastEight_Change = LastEight_End - LastEight_Start
			LastEight_Percent = (LastEight_Change / LastEight_Start) * 100
			
			If LastEight_Percent < 0 Then
				LastEight_Change_Type = "text-red"
				LastEight_Caret_Type = "fa-caret-down"
				LastEight_Percent = LastEight_Percent * -1
			ElseIf LastEight_Percent > 0 Then
				LastEight_Change_Type = "text-green"
				LastEight_Caret_Type = "fa-caret-up"
			Else
				LastEight_Change_Type = "text-yellow"
				LastEight_Caret_Type = "fa-caret-right"
			End If
			
			LastSixteen_End = arLastSixteen(0,0)
			LastSixteen_Start = arLastSixteen(0,UBound(arLastSixteen,2))
			
			LastSixteen_Change = LastSixteen_End - LastSixteen_Start
			LastSixteen_Percent = (LastSixteen_Change / LastSixteen_Start) * 100
			
			If LastSixteen_Percent < 0 Then
				LastSixteen_Change_Type = "text-red"
				LastSixteen_Caret_Type = "fa-caret-down"
				LastSixteen_Percent = LastSixteen_Percent * -1
			ElseIf LastSixteen_Percent > 0 Then
				LastSixteen_Change_Type = "text-green"
				LastSixteen_Caret_Type = "fa-caret-up"
			Else
				LastSixteen_Change_Type = "text-yellow"
				LastSixteen_Caret_Type = "fa-caret-right"
			End If
			
			YTD_End = arYTD(0,0)
			YTD_Start = arYTD(0,UBound(arYTD,2))
			If YTD_Start = 0 Then YTD_Start = 0.1
			YTD_Change = YTD_End - YTD_Start
			YTD_Percent = (YTD_Change / YTD_Start) * 100
			
			If YTD_Percent < 0 Then
				YTD_Change_Type = "text-red"
				YTD_Caret_Type = "fa-caret-down"
				YTD_Percent = YTD_Percent * -1
			ElseIf YTD_Percent > 0 Then
				YTD_Change_Type = "text-green"
				YTD_Caret_Type = "fa-caret-up"
			Else
				YTD_Change_Type = "text-yellow"
				YTD_Caret_Type = "fa-caret-right"
			End If
%>
			<div class="col-lg-4" align="center">
				<div style="padding-top: 10px;">CURRENT STOCK VALUE</div>
				<div class="description-percentage <%= LastTwo_Change_Type %>"><i class="fa <%= LastTwo_Caret_Type %>"></i> <%= FormatNumber(LastTwo_Percent, 2) %>%</div>
				<h1 style="padding-top: 0; margin-top: 0;"><%= FormatCurrency(Session.Contents("QBX_Current_QB_StockPrice"), 2) %></h1>
			</div>
<%
			sqlGet2014WinCount = "SELECT COUNT(qbx_tracker.tracker_ID) AS WinCount_2014 FROM qbx_tracker INNER JOIN qbx_games ON qbx_games.game_ID = qbx_tracker.game_ID WHERE qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND qbx_tracker.tracker_Starter = 1 AND qbx_tracker.tracker_Victory = 1 AND qbx_games.game_Year = 2014"
			sqlGet2013WinCount = "SELECT COUNT(qbx_tracker.tracker_ID) AS WinCount_2013 FROM qbx_tracker INNER JOIN qbx_games ON qbx_games.game_ID = qbx_tracker.game_ID WHERE qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND qbx_tracker.tracker_Starter = 1 AND qbx_tracker.tracker_Victory = 1 AND qbx_games.game_Year = 2013"
			sqlGet2012WinCount = "SELECT COUNT(qbx_tracker.tracker_ID) AS WinCount_2012 FROM qbx_tracker INNER JOIN qbx_games ON qbx_games.game_ID = qbx_tracker.game_ID WHERE qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND qbx_tracker.tracker_Starter = 1 AND qbx_tracker.tracker_Victory = 1 AND qbx_games.game_Year = 2012"
			sqlGet2011WinCount = "SELECT COUNT(qbx_tracker.tracker_ID) AS WinCount_2011 FROM qbx_tracker INNER JOIN qbx_games ON qbx_games.game_ID = qbx_tracker.game_ID WHERE qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND qbx_tracker.tracker_Starter = 1 AND qbx_tracker.tracker_Victory = 1 AND qbx_games.game_Year = 2011"
			
			sqlGet2014LossCount = "SELECT COUNT(qbx_tracker.tracker_ID) AS LossCount_2014 FROM qbx_tracker INNER JOIN qbx_games ON qbx_games.game_ID = qbx_tracker.game_ID WHERE qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND qbx_tracker.tracker_Starter = 1 AND qbx_tracker.tracker_Victory = 0 AND qbx_games.game_Year = 2014"
			sqlGet2013LossCount = "SELECT COUNT(qbx_tracker.tracker_ID) AS LossCount_2013 FROM qbx_tracker INNER JOIN qbx_games ON qbx_games.game_ID = qbx_tracker.game_ID WHERE qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND qbx_tracker.tracker_Starter = 1 AND qbx_tracker.tracker_Victory = 0 AND qbx_games.game_Year = 2013"
			sqlGet2012LossCount = "SELECT COUNT(qbx_tracker.tracker_ID) AS LossCount_2012 FROM qbx_tracker INNER JOIN qbx_games ON qbx_games.game_ID = qbx_tracker.game_ID WHERE qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND qbx_tracker.tracker_Starter = 1 AND qbx_tracker.tracker_Victory = 0 AND qbx_games.game_Year = 2012"
			sqlGet2011LossCount = "SELECT COUNT(qbx_tracker.tracker_ID) AS LossCount_2011 FROM qbx_tracker INNER JOIN qbx_games ON qbx_games.game_ID = qbx_tracker.game_ID WHERE qbx_tracker.qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND qbx_tracker.tracker_Starter = 1 AND qbx_tracker.tracker_Victory = 0 AND qbx_games.game_Year = 2011"
			
			Set rs2014WinCount = sqlSameLevel.Execute(sqlGet2014WinCount)
			Set rs2013WinCount = sqlSameLevel.Execute(sqlGet2013WinCount)
			Set rs2012WinCount = sqlSameLevel.Execute(sqlGet2012WinCount)
			Set rs2011WinCount = sqlSameLevel.Execute(sqlGet2011WinCount)
			
			Set rs2014LossCount = sqlSameLevel.Execute(sqlGet2014LossCount)
			Set rs2013LossCount = sqlSameLevel.Execute(sqlGet2013LossCount)
			Set rs2012LossCount = sqlSameLevel.Execute(sqlGet2012LossCount)
			Set rs2011LossCount = sqlSameLevel.Execute(sqlGet2011LossCount)
			
			WinCount_2014 = rs2014WinCount("WinCount_2014")
			WinCount_2013 = rs2013WinCount("WinCount_2013")
			WinCount_2012 = rs2012WinCount("WinCount_2012")
			WinCount_2011 = rs2011WinCount("WinCount_2011")
			
			LossCount_2014 = rs2014LossCount("LossCount_2014")
			LossCount_2013 = rs2013LossCount("LossCount_2013")
			LossCount_2012 = rs2012LossCount("LossCount_2012")
			LossCount_2011 = rs2011LossCount("LossCount_2011")
			
			If CInt(WinCount_2014) > 11 Then
				Label_2014 = "success"
			ElseIf CInt(WinCount_2014) > 7 Then
				Label_2014 = "warning"
			Else
				Label_2014 = "danger"
			End If
			
			If CInt(WinCount_2013) > 11 Then
				Label_2013 = "success"
			ElseIf CInt(WinCount_2013) > 7 Then
				Label_2013 = "warning"
			Else
				Label_2013 = "danger"
			End If
			
			If CInt(WinCount_2012) > 11 Then
				Label_2012 = "success"
			ElseIf CInt(WinCount_2012) > 7 Then
				Label_2012 = "warning"
			Else
				Label_2012 = "danger"
			End If
			
			If CInt(WinCount_2011) > 11 Then
				Label_2011 = "success"
			ElseIf CInt(WinCount_2011) > 7 Then
				Label_2011 = "warning"
			Else
				Label_2011 = "danger"
			End If
			
			rs2014WinCount.Close
			rs2013WinCount.Close
			rs2012WinCount.Close
			rs2011WinCount.Close
%>
			
			<div class="col-lg-4" align="center">
			
				<div class="row" style="padding-top: 10px;">
					<div class="col-xs-12" align="right">
						<div class="row">
							<div class="col-xs-6" align="center">
								<div><span class="label label-<%= Label_2014 %>">2014 W-L</span></div>
								<div><b><%= WinCount_2014 %> - <%= LossCount_2014 %></b></div>
							</div>
							<div class="col-xs-6" align="center">
								<div><span class="label label-<%= Label_2013 %>">2013 W-L</span></div>
								<div><b><%= WinCount_2013 %> - <%= LossCount_2013 %></b></div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row" style="padding-top: 10px;padding-bottom: 10px;">
					<div class="col-xs-12" align="right">
						<div class="row">
							<div class="col-xs-6" align="center">
								<div><span class="label label-<%= Label_2012 %>">2012 W-L</span></div>
								<div><b><%= WinCount_2012 %> - <%= LossCount_2012 %></b></div>
							</div>
							<div class="col-xs-6" align="center">
								<div><span class="label label-<%= Label_2011 %>">2011 W-L</span></div>
								<div><b><%= WinCount_2011 %> - <%= LossCount_2011 %></b></div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<div class="box-footer">
		<div class="row">
			<div class="col-sm-3 col-xs-6">
				<div class="description-block border-right">
					<span class="description-percentage <%= YTD_Change_Type %>"><i class="fa <%= YTD_Caret_Type %>"></i> <%= FormatNumber(YTD_Percent, 2) %>%</span>
					<h5 class="description-header"><% If YTD_Change > 0 Then %>+<% End If %><%= FormatNumber(YTD_Change, 2) %></h5>
					<span class="description-text">YTD</span>
				</div>
			</div>
			<div class="col-sm-3 col-xs-6">
				<div class="description-block border-right">
					<span class="description-percentage <%= LastFour_Change_Type %>"><i class="fa <%= LastFour_Caret_Type %>"></i> <%= FormatNumber(LastFour_Percent, 2) %>%</span>
					<h5 class="description-header"><% If LastFour_Change > 0 Then %>+<% End If %><%= FormatNumber(LastFour_Change, 2) %></h5>
					<span class="description-text">LAST 4</span>
				</div>
			</div>
			<div class="col-sm-3 col-xs-6">
				<div class="description-block border-right">
					<span class="description-percentage <%= LastEight_Change_Type %>"><i class="fa <%= LastEight_Caret_Type %>"></i> <%= FormatNumber(LastEight_Percent, 2) %>%</span>
					<h5 class="description-header"><% If LastEight_Change > 0 Then %>+<% End If %><%= FormatNumber(LastEight_Change, 2) %></h5>
					<span class="description-text">LAST 8</span>
				</div>
			</div>
			<div class="col-sm-3 col-xs-6">
				<div class="description-block">
					<span class="description-percentage <%= LastSixteen_Change_Type %>"><i class="fa <%= LastSixteen_Caret_Type %>"></i> <%= FormatNumber(LastSixteen_Percent, 2) %>%</span>
					<h5 class="description-header"><% If LastSixteen_Change > 0 Then %>+<% End If %><%= FormatNumber(LastSixteen_Change, 2) %></h5>
					<span class="description-text">LAST 16</span>
				</div>
			</div>
		</div>
	</div>
</div>