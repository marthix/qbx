StartTime = Now()
thisRunDate = Now()

game_Year = 2015
game_Week = 21

Set sqlSameLevel = CreateObject("ADODB.Connection")
sqlSameLevel.Open "Provider=MSDASQL; DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost; DATABASE=SameLevel; UID=root;PASSWORD=mysClaim5Page5; OPTION=3"
	
sqlGetQuarterbacks = "SELECT qb_ID, qb_Name FROM qbx_quarterbacks"
Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)

Set cnnAdd = CreateObject("ADODB.Connection")
cnnAdd.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='C:\Processes\fantasy\data\2015-Week" & game_Week & ".xls';Extended Properties='Excel 8.0;HDR=No;IMEX=1';"

Set rstExcel = CreateObject("ADODB.Recordset")
rstExcel.Open "SELECT * FROM A0:B2;", cnnAdd, adOpenStatic, adLockPessimistic

rstExcel.MoveFirst
i = 0
Do While Not rstExcel.Eof

	qb_Details = rstExcel.Fields.Item(0).Value
	qb_QBR = rstExcel.Fields.Item(1).Value
	
	ar_QB = Split(qb_Details, ", ")
	
	qb_Name = ar_QB(0)
	team_Abbr = ar_QB(1)
	
	sqlGetTeam = "SELECT team_ID FROM qbx_Teams WHERE team_Abbr = '" & team_Abbr & "'"
	Set rsTeam = sqlSameLevel.Execute(sqlGetTeam)
	
	team_ID = rsTeam("team_ID")
	
	rsTeam.Close
	Set rsTeam = Nothing
	
	sqlGetGame = "SELECT * FROM qbx_games WHERE (game_Year = " & CInt(game_Year) & ") AND (game_Week = " & CInt(game_Week) & ") AND (game_AwayTeam_ID = " & CInt(team_ID) & " OR game_HomeTeam_ID = " & CInt(team_ID) & ") ORDER BY game_ID"
	Set rsGame = sqlSameLevel.Execute(sqlGetGame)
	
	game_ID = rsGame("game_ID")
	game_AwayTeam_ID = rsGame("game_AwayTeam_ID")
	game_HomeTeam_ID = rsGame("game_HomeTeam_ID")
	game_AwayTeam_Score = rsGame("game_AwayTeam_Score")
	game_HomeTeam_Score = rsGame("game_HomeTeam_Score")
	
	isVictory = 0
	If team_ID = game_AwayTeam_ID Then
		isHome = 0
		If game_AwayTeam_Score > game_HomeTeam_Score Then isVictory = 1
	ElseIf team_ID = game_HomeTeam_ID Then
		isHome = 1
		If game_AwayTeam_Score < game_HomeTeam_Score Then isVictory = 1
	End If
	
	rsGame.Close
	Set rsGame = Nothing
	
	sqlGetQB = "SELECT qb_ID FROM qbx_quarterbacks WHERE qb_Name = '" & qb_Name & "'"
	Set rsQB = sqlSameLevel.Execute(sqlGetQB)
	
	If Not rsQB.Eof Then
	
		qb_ID = rsQB("qb_ID")
		rsQB.Close
		Set rsQB = Nothing
	
	Else
	
		sqlInsert = "INSERT INTO qbx_quarterbacks (qb_Name, qb_Team) VALUES "
		sqlInsert = sqlInsert & "('" & qb_Name & "', " & team_ID & ")"
		Set rsInsert = sqlSameLevel.Execute(sqlInsert)
		
		sqlGetQB = "SELECT qb_ID FROM qbx_quarterbacks WHERE qb_Name = '" & qb_Name & "'"
		Set rsQB = sqlSameLevel.Execute(sqlGetQB)
		qb_ID = rsQB("qb_ID")
		rsQB.Close
		Set rsQB = Nothing
		
		WScript.Echo(vbcrlf & "NEW QB **************** " & qb_Name)
	
	End If
	
	sqlGetQBCount = "SELECT COUNT(qb_ID) AS QBCount FROM qbx_tracker WHERE game_ID = " & game_ID & " AND team_ID = " & team_ID
	Set rsQBCount = sqlSameLevel.Execute(sqlGetQBCount)
	
	QBCount = CInt(rsQBCount("QBCount"))
	rsQBCount.Close
	Set rsQBCount = Nothing
	
	isStarter = 0
	isBackUp1 = 0
	isBackUp2 = 0
	
	If QBCount = 0 Then
		isStarter = 1
	ElseIf QBCount = 1 Then
		isBackUp1 = 1
	ElseIf QBCount = 2 Then
		isBackUp2 = 1
	End If
	
	sqlInsert = "INSERT INTO qbx_tracker (game_ID, team_ID, qb_ID, tracker_Starter, tracker_BackUp1, tracker_BackUp2, tracker_Victory, tracker_QBR) VALUES "
	sqlInsert = sqlInsert & "(" & game_ID & ", " & team_ID & ", " & qb_ID & ", " & isStarter & ", " & isBackUp1 & ", " & isBackUp2 & ", " & isVictory & ", " & qb_QBR & ")"
	
	Set rsInsert = sqlSameLevel.Execute(sqlInsert)
	
	WScript.Echo(vbcrlf & i & ".) **************** " & qb_Name & " - " & qb_QBR & vbcrlf & vbcrlf)
	
	
	rstExcel.MoveNext
	i = i + 1
	
Loop

EndTime = Now()

rstExcel.Close
Set rstExcel = Nothing

WScript.Echo(vbcrlf & StartTime)
WScript.Echo(vbcrlf & EndTime)