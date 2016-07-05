StartTime = Now()
thisRunDate = Now()

Set sqlSameLevel = CreateObject("ADODB.Connection")
sqlSameLevel.Open "Provider=MSDASQL; DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost; DATABASE=SameLevel; UID=root;PASSWORD=mysClaim5Page5; OPTION=3"

Sub DisableQBx ()

	sqlSetDisable = "UPDATE qbx_status SET qbx_Market_Open = 0 WHERE qbx_Status_ID = 1"
	Set rsDisable = sqlSameLevel.Execute(sqlSetDisable)

End Sub

Sub EnableQBx ()

	sqlSetEnable = "UPDATE qbx_status SET qbx_Market_Open = 1 WHERE qbx_Status_ID = 1"
	Set rsEnable = sqlSameLevel.Execute(sqlSetEnable)

End Sub

Sub UpdateCurrentWeek (current_Year, current_Week)

	sqlSetCurrentWeek = "UPDATE qbx_current SET qbx_Current_Year = " & current_Year & ", qbx_Current_Week = " & current_Week & " WHERE qbx_Current_ID = 1"
	Set rsCurrentWeek = sqlSameLevel.Execute(sqlSetCurrentWeek)

End Sub

Sub UpdateWeeklyPrice (game_Year, game_Week, qb_ID, this_Price, this_Change)

	sqlGetPriceEntry = "SELECT * FROM qbx_prices WHERE game_Year = " & game_Year & " AND game_Week = " & game_Week & " AND qb_ID = " & qb_ID
	Set rsPriceEntry = sqlSameLevel.Execute(sqlGetPriceEntry)
	
	'UPDATE OR INSERT NEW PRICE
	If rsPriceEntry.Eof Then
		sqlInsert = "INSERT INTO qbx_prices (qb_ID, game_Year, game_Week, price_Value, price_Change) VALUES "
		sqlInsert = sqlInsert & "(" & qb_ID & ", " & game_Year & ", " & game_Week & ", " & this_Price & ", " & this_Change & ")"
	Else
		sqlInsert = "UPDATE qbx_prices SET price_Value = " & this_Price & ", price_Change = " & this_Change & " WHERE qb_ID = " & qb_ID & " AND game_Year = " & game_Year & " AND game_Week = " & game_Week
	End If
	Set rsInsert = sqlSameLevel.Execute(sqlInsert)

End Sub

Sub UpdateCurrentPrice(this_Price, qb_ID)

	sqlUpdate = "UPDATE qbx_quarterbacks SET qb_StockPrice = " & this_Price & " WHERE qb_ID = " & qb_ID
	Set rsUpdate = sqlSameLevel.Execute(sqlUpdate)

End Sub

Function SetRookie (qb_ID)

	sqlGetFirstWeek = "SELECT samelevel.qbx_games.game_Year, samelevel.qbx_games.game_Week FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " ORDER BY samelevel.qbx_games.game_Year ASC, samelevel.qbx_games.game_Week ASC LIMIT 1"
	Set rsFirstWeek = sqlSameLevel.Execute(sqlGetFirstWeek)
	
	first_Year = rsFirstWeek("game_Year")
	first_Week = rsFirstWeek("game_Week")
	
	sqlGetAvgPrice = "SELECT AVG(price_Value) AS AVG_Price_Value FROM qbx_prices WHERE qbx_prices.price_Value > 1 AND qbx_prices.game_Year = " & first_Year & " AND qbx_prices.game_Week = 1 AND qbx_prices.qb_ID IN (SELECT distinct qb_ID FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_games.game_Year = " & first_Year & " AND samelevel.qbx_games.game_Week = 1)"
	Set rsAvgPrice = sqlSameLevel.Execute(sqlGetAvgPrice)
	
	If Not IsNull(rsAvgPrice("AVG_Price_Value")) Then
		this_Price = FormatNumber(rsAvgPrice("AVG_Price_Value") * 0.8, 2)
	Else
		this_Price = 1
	End If
	
	rsFirstWeek.Close
	Set rsFirstWeek = Nothing
	
	rsAvgPrice.Close
	Set rsAvgPrice = Nothing
	
	game_Week = 1
	game_Played = 0
	
	Do While game_Played = 0 And game_Week < 22
	
		sqlGetTracker = "SELECT samelevel.qbx_tracker.tracker_ID FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " AND samelevel.qbx_games.game_Year = " & first_Year & " AND samelevel.qbx_games.game_Week = " & game_Week
		Set rsTracker = sqlSameLevel.Execute(sqlGetTracker)
		
		If rsTracker.Eof Then
		
			game_Played = 0
			
		Else
		
			game_Played = 1
			rsTracker.Close
			Set rsTracker = Nothing
			
		End If
		
		sqlGetPriceEntry = "SELECT * FROM qbx_prices WHERE game_Year = " & first_Year & " AND game_Week = " & game_Week & " AND qb_ID = " & qb_ID
		Set rsPriceEntry = sqlSameLevel.Execute(sqlGetPriceEntry)
		
		If rsPriceEntry.Eof Then
			
			sqlInsert = "INSERT INTO qbx_prices (qb_ID, game_Year, game_Week, price_Value) VALUES "
			sqlInsert = sqlInsert & "(" & qb_ID & ", " & first_Year & ", " & game_Week & ", " & this_Price & ")"
			
			Set rsInsert = sqlSameLevel.Execute(sqlInsert)
			
		Else
		
			sqlUpdate = "UPDATE qbx_prices SET price_Value = " & this_Price & " WHERE qb_ID = " & qb_ID & " AND game_Year = " & first_Year & " AND game_Week = " & game_Week
			Set rsUpdate = sqlSameLevel.Execute(sqlUpdate)
			
		End If
		
		game_Week = game_Week + 1
		
	Loop
	
	SetRookie = this_Price
	
End Function

Function SetSeason (qb_ID, game_Year)

	sqlGetAvgPrice = "SELECT AVG(price_Value) AS AVG_Price_Value FROM qbx_prices WHERE qbx_prices.qb_ID = " & qb_ID & " AND qbx_prices.game_Year >= " & game_Year - 3 & " AND qbx_prices.game_Year < " & game_Year & " AND qbx_prices.game_Week < 18 AND qbx_prices.game_Week > 1 AND qbx_prices.game_Year IN (SELECT DISTINCT samelevel.qbx_games.game_Year FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & ")"
	Set rsAvgPrice = sqlSameLevel.Execute(sqlGetAvgPrice)
	
	If Not IsNull(rsAvgPrice("AVG_Price_Value")) Then
		this_Price = FormatNumber(rsAvgPrice("AVG_Price_Value") * 0.8, 2)
	Else
		this_Price = 1
	End If
	
	rsAvgPrice.Close
	Set rsAvgPrice = Nothing
	
	SetSeason = this_Price
	
End Function


Function SetWeekly (qb_ID, game_Year, game_Week)

	game_Count = 1
	total_QBR = 0
	total_PaAtt = 0
	total_PaComp = 0
	total_PaYDS = 0
	total_PaTD = 0
	total_RuYDS = 0
	total_RuTD = 0
	total_Victories = 0
	total_Losses = 0
	qbr_Score = 0
	Pa_YDS_Score = 0
	PaTD_Score = 0
	total_INT = 0
	total_Fum = 0
	Final_Price = 1
	
	sqlGetTracker = "SELECT samelevel.qbx_tracker.tracker_ID FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " AND samelevel.qbx_games.game_Year = " & game_Year & " AND samelevel.qbx_games.game_Week = " & game_Week - 1
	Set rsTracker = sqlSameLevel.Execute(sqlGetTracker)
	
	If rsTracker.Eof Then
		
		'DID NOT PLAY. CHECK IF ANY GAMES THIS SEASON.
		sqlGetLastPrice = "SELECT price_Value FROM qbx_prices WHERE qbx_prices.qb_ID = " & qb_ID & " AND qbx_prices.game_Year = " & game_Year & " AND qbx_prices.game_Week = " & game_Week - 1
		Set rsLastPrice = sqlSameLevel.Execute(sqlGetLastPrice)
		
		LastPrice = rsLastPrice("price_Value")
		
		sqlGetAllSeason = "SELECT samelevel.qbx_tracker.tracker_ID FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " AND samelevel.qbx_games.game_Year = " & game_Year & " AND samelevel.qbx_games.game_Week < " & game_Week
		Set rsAllSeason = sqlSameLevel.Execute(sqlGetAllSeason)
		
		If Not rsAllSeason.Eof Then
		
			sqlGetTeamID = "SELECT qb_Team FROM qbx_quarterbacks WHERE qb_ID = " & qb_ID
			Set rsTeamID = sqlSameLevel.Execute(sqlGetTeamID)
			
			qb_TeamID = rsTeamID("qb_Team")
			
			rsTeamID.Close
			Set rsTeamID = Nothing
			
			'BYE WEEK TEAMS ARE NOT DECREASED
			'If qb_TeamID = 1 Or qb_TeamID = 5 Or qb_TeamID = 10 Or qb_TeamID = 19 Then
			'	Final_Price = LastPrice
			'Else
				Final_Price = FormatNumber(CDbl(LastPrice) * 0.95, 2)
			'End If
			
		Else
		
			Final_Price = LastPrice
		
		End If
	
	Else
	
		sqlGetYTD = "SELECT samelevel.qbx_tracker.*, samelevel.qbx_games.* FROM samelevel.qbx_tracker INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " AND samelevel.qbx_games.game_Year = " & game_Year & " AND samelevel.qbx_games.game_Week < " & game_Week & " ORDER BY samelevel.qbx_games.game_Year DESC, samelevel.qbx_games.game_Week DESC"
		Set rsYTD = sqlSameLevel.Execute(sqlGetYTD)
		
		Do While Not rsYTD.Eof
		
			If game_Count < 21 Then game_Weight = "0.4"
			If game_Count < 19 Then game_Weight = "0.8"
			If game_Count < 17 Then game_Weight = "1.2"
			If game_Count < 15 Then game_Weight = "1.6"
			If game_Count < 13 Then game_Weight = "2.0"
			If game_Count < 11 Then game_Weight = "2.4"
			If game_Count < 9  Then game_Weight = "2.8"
			If game_Count < 7  Then game_Weight = "3.2"
			If game_Count < 5  Then game_Weight = "3.6"
			If game_Count < 3  Then game_Weight = "4.0"
			
			this_QBR     = rsYTD("tracker_QBR")
			this_Starter = rsYTD("tracker_Starter")
			this_Victory = rsYTD("tracker_Victory")
			this_PaAtt   = rsYTD("tracker_PassingAttempts")
			this_PaComp  = rsYTD("tracker_PassingCompletions")
			this_PaYDS   = rsYTD("tracker_PassingYards")
			this_PaTD    = rsYTD("tracker_PassingTouchdowns")
			this_RuYDS   = rsYTD("tracker_RushingYards")
			this_RuTD    = rsYTD("tracker_RushingTouchdowns")
			this_INT     = rsYTD("tracker_PassingInterceptions")
			this_Fum     = rsYTD("tracker_FumblesLost")
			this_Team    = rsYTD("team_ID")
			this_game_HomeTeam = rsYTD("game_HomeTeam_ID")
			this_game_AwayTeam = rsYTD("game_AwayTeam_ID")
			this_game_Week = rsYTD("game_Week")
			
			If this_game_Week > 17 Then game_Weight = game_Weight * 2
			If this_game_Week = 21 Then game_Weight = game_Weight * 2
			
			this_Home = 0
			this_Away = 0
			If CInt(this_Team) = CInt(this_game_HomeTeam) Then
				this_Home = 1
			Else
				this_Away = 1
			End If
			
			If IsNull(this_QBR) Then this_QBR = 0.0
			If IsNull(this_PaAtt) Then this_PaAtt = 0.0
			If IsNull(this_PaComp) Then this_PaComp = 0.0
			If IsNull(this_PaYDS) Then this_PaYDS = 0.0
			If IsNull(this_PaTD) Then this_PaTD = 0.0
			If IsNull(this_RuYDS) Then this_RuYDS = 0.0
			If IsNull(this_RuTD) Then this_RuTD = 0.0
			If IsNull(this_INT) Then this_INT = 0.0
			If IsNull(this_Fum) Then this_Fum = 0.0
			
			If this_Starter Then total_Starts = total_Starts + 1
			
			If this_Starter And this_Victory Then
				If this_Home Then total_Victories = total_Victories + game_Weight
				If this_Away Then total_Victories = total_Victories + (game_Weight * 1.1)
			End If
			
			If this_Starter And Not this_Victory Then
				If this_Home Then total_Losses = total_Losses + (game_Weight * 1.1)
				If this_Away Then total_Losses = total_Losses + game_Weight
			End If
			
			total_QBR = total_QBR + (this_QBR)
			total_PaAtt = total_PaAtt + (this_PaAtt * game_Weight)
			total_PaComp = total_PaComp + (this_PaComp * game_Weight)
			total_PaYDS = total_PaYDS + (this_PaYDS * game_Weight)
			total_PaTD = total_PaTD + (this_PaTD * game_Weight)
			total_RuYDS = total_RuYDS + (this_RuYDS * game_Weight)
			total_RuTD = total_RuTD + (this_RuTD * game_Weight)
			total_INT = total_INT + (this_INT * game_Weight)
			total_Fum = total_Fum + (this_Fum * game_Weight)
			
			game_Count = game_Count + 1
			rsYTD.MoveNext
			
		Loop
		
		rsYTD.Close
		Set rsYTD = Nothing
		
		qbr_Score = 0
		PaComp_Score = 0
		Pa_YDS_Score = 0
		PaTD_Score = 0
		Ru_YDS_Score = 0
		RuTD_Score = 0
		WL_Score = 0
		INT_Score = 0
		Fum_Score = 0
		
		If total_PaAtt > 0 Then PaComp_Score = FormatNumber(((total_PaComp / total_PaAtt) * 15), 2)
		qbr_Score = FormatNumber((CDbl(total_QBR) / game_Count) / 6, 2)
		Pa_YDS_Score = FormatNumber((CDbl(total_PaYDS) / game_Count) / 50, 2)
		PaTD_Score = FormatNumber((CDbl(total_PaTD) / game_Count) * 3, 2)
		Ru_YDS_Score = FormatNumber((CDbl(total_RuYDS) / game_Count) / 25, 2)
		RuTD_Score = FormatNumber((CDbl(total_RuTD) / game_Count) * 4, 2)
		WL_Score = FormatNumber(((total_Victories - total_Losses) / 2), 2)
		INT_Score = FormatNumber((CDbl(total_INT) / game_Count) * 6, 2)
		Fum_Score = FormatNumber((CDbl(total_Fum) / game_Count) * 6, 2)
		
		WScript.Echo(vbcrlf & game_Year & " " & game_Week & " " & qb_Name & " " & qbr_Score & " + " & PaComp_Score & " + " & Pa_YDS_Score & " + " & PaTD_Score)
		
		rsTracker.Close
		Set rsTracker = Nothing
		
		Final_Price = CDbl(qbr_Score) + CDbl(PaComp_Score) + CDbl(Pa_YDS_Score) + CDbl(PaTD_Score) + CDbl(Ru_YDS_Score) + CDbl(RuTD_Score) + CDbl(WL_Score) - CDbl(INT_Score) - CDbl(Fum_Score)
		
	End If
	
	If Final_Price < 5 Then Final_Price = 5
	SetWeekly = FormatNumber(Final_Price, 2)
	
End Function

Function SetChange (qb_ID, game_Year, game_Week, current_Price)

	If game_Week = 1 Then
		previous_Year = game_Year - 1
		previous_Week = 22
	Else
		previous_Year = game_Year
		previous_Week = game_Week - 1
	End If
	
	sqlGetPreviousPrice = "SELECT price_Value FROM qbx_prices WHERE qb_ID = " & qb_ID & " AND game_Year = " & previous_Year & " AND game_Week = " & previous_Week
	Set rsPreviousPrice = sqlSameLevel.Execute(sqlGetPreviousPrice)
	
	If Not rsPreviousPrice.Eof Then
		
		previous_Price = rsPreviousPrice("price_Value")
		rsPreviousPrice.Close
		Set rsPreviousPrice = Nothing
		
		SetChange = Round((((current_Price * 100) / previous_Price) - 100), 2)
		
	Else
		
		SetChange = 100
		
	End If

End Function