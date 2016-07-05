'*************************************************************
' DISABLE SYSTEM / UPDATE CURRENT WEEK
'*************************************************************

Call DisableQBx()

current_Week = 22
current_Year = 2015

Call UpdateCurrentWeek(current_Year, current_Week)

'*************************************************************
' SET QUARTERBACK PRICES
'*************************************************************
sqlGetQuarterbacks = "SELECT qb_ID, qb_Name FROM qbx_quarterbacks WHERE qb_Active = 1 order by qb_Name ASC"
Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)

Do While Not rsQuarterbacks.Eof

	game_Year = 2015
	game_Week = 22
	
	qb_ID = rsQuarterbacks("qb_ID")
	qb_Name = rsQuarterbacks("qb_Name")
	
	If game_Week = 1 Then this_Price = SetSeason(qb_ID, game_Year)
	If game_Week > 1 Then this_Price = SetWeekly(qb_ID, game_Year, game_Week)
			
	'SET WEEKLY CHANGE
	this_Change = SetChange(qb_ID, game_Year, game_Week, this_Price)
	
	'CHECK FOR EXISTING PRICE
	Call UpdateWeeklyPrice(game_Year, game_Week, qb_ID, this_Price, this_Change)
	
	'UPDATE CURRENT PRICE IN QB TABLE
	Call UpdateCurrentPrice(this_Price, qb_ID)
			
	rsQuarterbacks.MoveNext
	
Loop

rsQuarterbacks.Close
Set rsQuarterbacks = Nothing

'*************************************************************
' SET NEW PORTFOLIO / HOLDING VALUES
'*************************************************************

sqlGetUsers = "SELECT qbx_ID, qbx_Name FROM qbx_users ORDER BY qbx_Name ASC"
Set rsUsers = sqlSameLevel.Execute(sqlGetUsers)

Do While Not rsUsers.Eof

	qbx_ID = rsUsers("qbx_ID")
	qbx_Name = rsUsers("qbx_Name")

	'GET ID AND DISABLE PREVIOUS PORTFOLIO
	sqlGetPreviousPortfolio = "SELECT * FROM qbx_portfolios WHERE user_ID = " & qbx_ID & " AND is_Current = 1"
	Set rsPreviousPortfolio = sqlSameLevel.Execute(sqlGetPreviousPortfolio)
	
	qbx_Previous_Portfolio_ID = rsPreviousPortfolio("portfolio_ID")
	qbx_Previous_Portfolio_Cash_Value = rsPreviousPortfolio("cash_Value")
	qbx_Previous_Portfolio_Share_Value = rsPreviousPortfolio("share_Value")
	
	rsPreviousPortfolio.Close
	Set rsPreviousPortfolio = Nothing
	
	sqlDisablePreviousPortfolio = "UPDATE qbx_portfolios SET is_Current = 0 WHERE portfolio_ID = " & qbx_Previous_Portfolio_ID
	Set rsPreviousPortfolio     = sqlSameLevel.Execute(sqlDisablePreviousPortfolio)
	
	'ADD NEW BLANK PORTFOLIO AND GET NEW ID
	sqlInsert = "INSERT INTO qbx_portfolios (user_ID, cash_Value, share_Value) VALUES "
	sqlInsert = sqlInsert & "(" & qbx_ID & ", " & qbx_Previous_Portfolio_Cash_Value & ", " & qbx_Previous_Portfolio_Share_Value & ")"
	Set rsInsert = sqlSameLevel.Execute(sqlInsert)
	
	sqlGetNewPortfolio = "SELECT portfolio_ID FROM qbx_portfolios WHERE user_ID = " & qbx_ID & " AND is_Current = 1"
	Set rsNewPortfolio = sqlSameLevel.Execute(sqlGetNewPortfolio)
	
	qbx_New_Portfolio_ID = rsNewPortfolio("portfolio_ID")
	
	rsNewPortfolio.Close
	Set rsNewPortfolio = Nothing
	
	qbx_New_Portfolio_Share_Value = 0
	
	'ADD NEW HOLDINGS RECORDS WITH NEW PORTFOLIO_ID
	sqlGetPreviousHoldings = "SELECT * FROM qbx_holdings WHERE portfolio_ID = " & qbx_Previous_Portfolio_ID & " AND share_Total > 0"
	WScript.Echo(vbcrlf & sqlGetPreviousHoldings)
	Set rsPreviousHoldings = sqlSameLevel.Execute(sqlGetPreviousHoldings)
	
	Do While Not rsPreviousHoldings.Eof
	
		qb_ID = rsPreviousHoldings("qb_ID")
		share_Total = rsPreviousHoldings("share_Total")
		sqlGetNewPrice = "SELECT qb_StockPrice FROM qbx_quarterbacks WHERE qb_ID = " & qb_ID
		Set rsNewPrice = sqlSameLevel.Execute(sqlGetNewPrice)
		
		qb_StockPrice = rsNewPrice("qb_StockPrice")
		
		rsNewPrice.Close
		Set rsNewPrice = Nothing
		
		new_Cash_Value = FormatNumber(FormatNumber(qb_StockPrice, 2) * share_Total, 2)
		If InStr(new_Cash_Value, ",") Then new_Cash_Value = Replace(new_Cash_Value, ",", "")
		
		qbx_New_Portfolio_Share_Value = qbx_New_Portfolio_Share_Value + CDbl(new_Cash_Value)
		sqlInsert = "INSERT INTO qbx_holdings (portfolio_ID, user_ID, qb_ID, share_Total, cash_Value) VALUES "
		sqlInsert = sqlInsert & "(" & qbx_New_Portfolio_ID & ", " & qbx_ID & ", " & qb_ID & ", " & share_Total & ", " & new_Cash_Value & ")"
		Set rsInsert = sqlSameLevel.Execute(sqlInsert)
		
		rsPreviousHoldings.MoveNext
	
	Loop
	
	rsPreviousHoldings.Close
	Set rsPreviousHoldings = Nothing
	
	'UPDATE NEW PORTFOLIO VALUES
	
	qbx_New_Portfolio_Cash_Value = FormatNumber((qbx_Previous_Portfolio_Cash_Value * 1.05), 2)
	'qbx_New_Portfolio_Cash_Value = FormatNumber(qbx_Previous_Portfolio_Cash_Value, 2)
	If InStr(qbx_New_Portfolio_Cash_Value, ",") Then qbx_New_Portfolio_Cash_Value = Replace(qbx_New_Portfolio_Cash_Value, ",", "")
	
	sqlUpdateNewPortfolio = "UPDATE qbx_portfolios SET cash_Value = " & qbx_New_Portfolio_Cash_Value & ", share_Value = " & qbx_New_Portfolio_Share_Value & " WHERE portfolio_ID = " & qbx_New_Portfolio_ID
	
	Set rsUpdatePortfolio = sqlSameLevel.Execute(sqlUpdateNewPortfolio)
	
	WScript.Echo(vbcrlf & qbx_Name & " - " & qbx_New_Portfolio_Cash_Value & " (CASH) + " & qbx_New_Portfolio_Share_Value & " (SHARES)")
	
	rsUsers.MoveNext

Loop

rsUsers.Close
Set rsUsers = Nothing

Call EnableQBx()