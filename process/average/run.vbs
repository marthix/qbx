
Set sqlSameLevel = CreateObject("ADODB.Connection")
sqlSameLevel.Open "Provider=MSDASQL; DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost; DATABASE=SameLevel; UID=root;PASSWORD=mysClaim5Page5; OPTION=3"


game_Year = 2015
game_Week = 19
	
	sqlGetAverage = "SELECT AVG(price_Value) AS AVG_Price_Value FROM samelevel.qbx_prices WHERE game_Year = " & game_Year & " AND game_Week = " & game_Week & " AND qb_ID IN (SELECT qb_ID FROM samelevel.qbx_tracker WHERE game_ID IN (SELECT game_ID FROM samelevel.qbx_games WHERE game_Year = " & game_Year & " AND game_Week = " & game_Week & "))"
	Set rsAverage = sqlSameLevel.Execute(sqlGetAverage)
		
	If Not rsAverage.Eof Then
		
		this_Average = rsAverage("AVG_Price_Value")
		If (Len(this_Average) < 1) Or IsNull(this_Average) Then this_Average = 0
		sqlInsert = "INSERT INTO qbx_averages (game_Year, game_Week, average_Price) VALUES "
		sqlInsert = sqlInsert & "(" & game_Year & ", " & game_Week & ", " & this_Average & ")"
		Set rsInsert = sqlSameLevel.Execute(sqlInsert)
		
		rsAverage.Close
		Set rsAverage = Nothing
		
	End If
	
	WScript.Echo(vbcrlf & game_Year & " " & game_Week & " = $" & this_Average)