<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/sql.asp"-->
<%
	Function GetStats(y, w)
		
		thisURL = "http://sports.yahoo.com/nfl/stats/byposition?pos=QB&conference=NFL&year=postseason_2015"
		Set oXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP.3.0")
		oXMLHTTP.Open "GET", thisURL, False
		oXMLHTTP.Send
		
		If oXMLHTTP.Status = 200 Then RawSource = oXMLHTTP.responseText
		
		RawSource = Replace(RawSource, vbcrlf, "")
		RawSource = Replace(RawSource, vblf, "")
		RawSource = Replace(RawSource, vbtab, "")
		RawSource = Replace(RawSource, "ysptblclbg6", "yspscores")
		RawSource = Replace(RawSource, " align=""right""", "")
		RawSource = Replace(RawSource, " align=""left""", "")
		RawSource = Replace(RawSource, " align=""center""", "")
		RawSource = Replace(RawSource, "&nbsp;", "")
		RawSource = Replace(RawSource, "<span class=""yspscores"">", "")
		RawSource = Replace(RawSource, " class=""yspscores""", "")
		RawSource = Replace(RawSource, "</span>", "")
		RawSource = Replace(RawSource, "ysprow2", "ysprow1")
		
		arSource = Split(RawSource, "class=""ysptblhdrsts"">FumL</a>")
		arFinal  = Split(arSource(1), "</table>")
		arPlayers = Split(arFinal(0), "<tr class=""ysprow1"" height=""16"">")
		
		i = 0
		
		For Each Player In arPlayers
		
			If i > 0 Then
				Player = Replace(Player, "<td></td>", "")
				Player = Replace(Player, "<td>", "")
				Player = Replace(Player, "</td>", "||")
				Player = Replace(Player, "</a>", "")
				Player = Replace(Player, "</tr>", "")
				Player = Replace(Player, "N/A", "NULL")
				
				arfinalSplit1 = Split(Player, "<a href")
				
				arPlayerName = Split(arfinalSplit1(1), """>")
				arPlayerStat = Split(arfinalSplit1(2), """>")
				
				finalName = arPlayerName(1)
				finalStat = arPlayerStat(1)
				
				If Right(finalStat, 1) = "," Then finalStat = Left(finalStat, Len(finalStat)-1)
				
				finalSource = finalSource & finalName & finalStat & "###"
				
			End If
			i = i + 1
		
		Next
		
		thisWeek_Players = Split(finalSource, "###")
	
		Response.Write("<table>")
		
		For Each Player In thisWeek_Players
		
			thisPlayer_Stats = Split(Player, "||")
			
			
			Column = 0
			Response.Write("<tr>")
			For Each Stat In thisPlayer_Stats
			
				If Column = 0 Then stat_Name = Stat
				If Column = 1 Then stat_Team = Stat
				If Column = 2 Then stat_Game = Stat
				If Column = 3 Then stat_Rating = Stat
				If Column = 4 Then stat_PassingCompletions = Stat
				If Column = 5 Then stat_PassingAttempts = Stat
				If Column = 6 Then stat_PassingYards = Stat
				If Column = 7 Then stat_PassingYardsAverage = Stat
				If Column = 8 Then stat_PassingYardsLong = Stat
				If Column = 9 Then stat_Interceptions = Stat
				If Column = 10 Then stat_PassingTouchdowns = Stat
				If Column = 11 Then stat_RushingAttempts = Stat
				If Column = 12 Then stat_RushingYards = Stat
				If Column = 13 Then stat_RushingYardsAverage = Stat
				If Column = 14 Then stat_RushingLong = Stat
				If Column = 15 Then stat_RushingTouchdowns = Stat
				If Column = 16 Then stat_Sacks = Stat
				If Column = 17 Then stat_SackYards = Stat
				If Column = 18 Then stat_Fumbles = Stat
				If Column = 19 Then stat_FumblesLost = Stat
				
				Column = Column + 1
				
				Response.Write("<td >" & Stat & "</td>")
			
			Next
			Response.Write("</tr>")
			
			If InStr(stat_Name, ".") Then stat_Name = Replace(stat_Name, ".", "")
				
			sqlGetQBID = "SELECT qb_ID FROM qbx_quarterbacks WHERE qb_Name LIKE '" & Left(stat_Name, 14) & "%'"
			Set rsQBID = sqlSameLevel.Execute(sqlGetQBID)
			
			If Not rsQBID.Eof Then
			
				sqlGetUpdates = "UPDATE qbx_tracker SET " & _
								"tracker_PassingCompletions = " & stat_PassingCompletions & ", " & _
								"tracker_PassingAttempts = " & stat_PassingAttempts & ", " & _
								"tracker_PassingYards = " & stat_PassingYards & ", " & _
								"tracker_PassingYardsPerAttempt = " & stat_PassingYardsAverage & ", " & _
								"tracker_PassingLong = " & stat_PassingYardsLong & ", " & _
								"tracker_PassingInterceptions = " & stat_Interceptions & ", " & _
								"tracker_PassingTouchdowns = " & stat_PassingTouchdowns & ", " & _
								"tracker_RushingAttempts = " & stat_RushingAttempts & ", " & _
								"tracker_RushingYards = " & stat_RushingYards & ", " & _
								"tracker_RushingYardsPerAttempt = " & stat_RushingYardsAverage & ", " & _
								"tracker_RushingLong = " & stat_RushingLong & ", " & _
								"tracker_RushingTouchdowns = " & stat_RushingTouchdowns & ", " & _
								"tracker_Sacks = " & stat_Sacks & ", " & _
								"tracker_SackYards = " & stat_SackYards & ", " & _
								"tracker_Fumbles = " & stat_Fumbles & ", " & _
								"tracker_FumblesLost = " & stat_FumblesLost & " " & _
								"WHERE qb_ID = " & rsQBID("qb_ID") & " AND game_ID IN (SELECT game_ID FROM qbx_games WHERE game_Year = " & y & " AND game_Week = " & w & ")"
								
				'Response.Write(vbcrlf & vbcrlf & sqlGetUpdates & vbcrlf & vbcrlf)
				Set rsUpdate = sqlSameLevel.Execute(sqlGetUpdates)
				
				rsQBID.Close
				Set rsQBID = Nothing
			
			End If
			
		Next
		Response.Write("</table>")
		GetStats = True
	End Function
	
	this = GetStats(2015, 18)
	
	
%>