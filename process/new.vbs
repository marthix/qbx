StartTime = Now()
thisRunDate = Now()

Set sqlSameLevel = CreateObject("ADODB.Connection")
sqlSameLevel.Open "Provider=MSDASQL; DRIVER={MySQL ODBC 5.1 Driver};SERVER=10.0.1.9; DATABASE=SameLevel; UID=samelevel;PASSWORD=levelsame; OPTION=3"

Set cnnAdd = CreateObject("ADODB.Connection")
cnnAdd.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='C:\Utilities\Processes\fantasy\data\2006_games.xls';Extended Properties='Excel 8.0;HDR=Yes;IMEX=1';"

Set rstExcel = CreateObject("ADODB.Recordset")
rstExcel.Open "SELECT * FROM A0:G268;", cnnAdd, adOpenStatic, adLockPessimistic

rstExcel.MoveFirst
i = 0
Do While Not rstExcel.Eof

	game_Year = rstExcel.Fields.Item(0).Value
	game_Week = rstExcel.Fields.Item(1).Value
	game_HomeTeam_Name = rstExcel.Fields.Item(3).Value
	game_HomeTeam_Score = rstExcel.Fields.Item(4).Value
	game_AwayTeam_Name = rstExcel.Fields.Item(6).Value
	game_AwayTeam_Score = rstExcel.Fields.Item(5).Value
	
	sqlGetHomeTeamID = "SELECT team_ID FROM qbx_teams WHERE team_Mascot = '" & game_HomeTeam_Name & "'"
	Set rsHomeTeadID = sqlSameLevel.Execute(sqlGetHomeTeamID)
	
	sqlGetAwayTeamID = "SELECT team_ID FROM qbx_teams WHERE team_Mascot = '" & game_AwayTeam_Name & "'"
	Set rsAwayTeadID = sqlSameLevel.Execute(sqlGetAwayTeamID)
	
	game_HomeTeam_ID = rsHomeTeadID("team_ID")
	game_AwayTeam_ID = rsAwayTeadID("team_ID")
	
	rsHomeTeadID.Close
	Set rsHomeTeadID = Nothing
	
	rsAwayTeadID.Close
	Set rsAwayTeadID = Nothing
	
	sqlInsert = "INSERT INTO qbx_games (game_Year, game_Week, game_HomeTeam_ID, game_AwayTeam_ID, game_HomeTeam_Score, game_AwayTeam_Score) VALUES "
	sqlInsert = sqlInsert & "(" & game_Year & ", " & game_Week & ", " & game_HomeTeam_ID & ", " & game_AwayTeam_ID & ", " & game_HomeTeam_Score & ", " & game_AwayTeam_Score & ")"
	
	Set rsInsert = sqlSameLevel.Execute(sqlInsert)
	
	WScript.Echo(vbcrlf & i & ".) **************** " & game_Year & " - " & game_Week)
	
	
	rstExcel.MoveNext
	i = i + 1
	
Loop

EndTime = Now()

rstExcel.Close
Set rstExcel = Nothing


WScript.Echo(vbcrlf & StartTime)
WScript.Echo(vbcrlf & EndTime)