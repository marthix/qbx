<div class="box box-warning">
	<div class="box-header with-border">
		<h3 class="box-title"><b>Bad Teams</b></h3>
	</div>
	<div class="box-body">
		<table class="table">
<%
			sqlGetTeamCount = "SELECT COUNT(samelevel.qbx_users.qbx_ID) AS TotalUsers FROM samelevel.qbx_users"
			Set rsTeamCount = sqlSameLevel.Execute(sqlGetTeamCount)
			
			TeamCount = CInt(rsTeamCount("TotalUsers"))
			TeamCount = TeamCount - 2
			If TeamCount < 1 Then TeamCount = 1
			
			ListCount = 1
			
			rsTeamCount.Close
			Set rsTeamCount = Nothing
			
			sqlGetBadTeams = "SELECT samelevel.qbx_users.qbx_ID, ROUND((samelevel.qbx_portfolios.cash_Value + samelevel.qbx_portfolios.share_Value), 0) AS qbx_NetWorth FROM samelevel.qbx_users INNER JOIN samelevel.qbx_portfolios ON samelevel.qbx_users.qbx_ID = samelevel.qbx_portfolios.user_ID WHERE samelevel.qbx_portfolios.is_Current = 1 ORDER BY qbx_NetWorth ASC LIMIT 3"
			Set rsBadTeams = sqlSameLevel.Execute(sqlGetBadTeams)
			
			Do While Not rsBadTeams.Eof
			
				badTeamID = badTeamID & rsBadTeams("qbx_ID") & ","
				
				rsBadTeams.MoveNext
			
			Loop
			
			If Right(badTeamID, 1) = "," Then badTeamID = Left(badTeamID, Len(badTeamID) - 1)
			
			rsBadTeams.Close
			Set rsBadTeams = Nothing
			
			sqlGetBadTeams = "SELECT samelevel.qbx_users.qbx_Name, ROUND((samelevel.qbx_portfolios.cash_Value + samelevel.qbx_portfolios.share_Value), 0) AS qbx_NetWorth FROM samelevel.qbx_users INNER JOIN samelevel.qbx_portfolios ON samelevel.qbx_users.qbx_ID = samelevel.qbx_portfolios.user_ID WHERE samelevel.qbx_portfolios.is_Current = 1 AND samelevel.qbx_users.qbx_ID IN (" & badTeamID & ") ORDER BY qbx_NetWorth DESC"
			Set rsBadTeams = sqlSameLevel.Execute(sqlGetBadTeams)
			
			Do While Not rsBadTeams.Eof
			
				If ListCount = 1 Then
%>
					<tr>
						<td style="border: 0; padding-top: 0; width: 40px;"><%= TeamCount %>.</td>
						<td nowrap style="border: 0; padding-top: 0; overflow: hidden"><a href="/portfolio/<%= QBLink(rsBadTeams("qbx_Name")) %>/"><%= rsBadTeams("qbx_Name") %></a></td>
						<td style="border: 0; padding-top: 0;" align="right" nowrap><span class="badge bg-red"><%= FormatCurrency(rsBadTeams("qbx_NetWorth"), 0) %></span></td>
					</tr>
<%
				ElseIf ListCount = 3 Then
%>
					<tr>
						<td><b><%= TeamCount %>.</b></td>
						<td nowrap><a href="/portfolio/<%= QBLink(rsBadTeams("qbx_Name")) %>/"><%= rsBadTeams("qbx_Name") %></a></td>
						<td align="right" nowrap><span class="badge bg-red"><%= FormatCurrency(rsBadTeams("qbx_NetWorth"), 0) %></span></td>
					</tr>
<%
				Else
%>
					<tr>
						<td><%= TeamCount %>.</td>
						<td nowrap><a href="/portfolio/<%= QBLink(rsBadTeams("qbx_Name")) %>/"><%= rsBadTeams("qbx_Name") %></a></td>
						<td align="right" nowrap><span class="badge bg-red"><%= FormatCurrency(rsBadTeams("qbx_NetWorth"), 0) %></span></td>
					</tr>
<%
				End If
				
				rsBadTeams.MoveNext
				TeamCount = TeamCount + 1
				ListCount = ListCount + 1
				
			Loop
			
			rsBadTeams.Close
			Set rsBadTeams = Nothing
%>
		</table>
	</div>
</div>