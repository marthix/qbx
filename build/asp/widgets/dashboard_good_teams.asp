<div class="box box-warning">
	<div class="box-header with-border">
		<h3 class="box-title"><b>Good Teams</b></h3>
	</div>
	<div class="box-body">
		<table class="table">
<%
			TeamCount = 1
			sqlGetGoodTeams = "SELECT samelevel.qbx_users.qbx_Name, ROUND((samelevel.qbx_portfolios.cash_Value + samelevel.qbx_portfolios.share_Value), 0) AS qbx_NetWorth FROM samelevel.qbx_users INNER JOIN samelevel.qbx_portfolios ON samelevel.qbx_users.qbx_ID = samelevel.qbx_portfolios.user_ID WHERE samelevel.qbx_portfolios.is_Current = 1 ORDER BY qbx_NetWorth DESC LIMIT 3"
			Set rsGoodTeams = sqlSameLevel.Execute(sqlGetGoodTeams)
			
			Do While Not rsGoodTeams.Eof
			
				If TeamCount = 1 Then
%>
					<tr>
						<td style="border: 0; padding-top: 0; width: 40px;"><b>1.</b></td>
						<td nowrap style="border: 0; padding-top: 0; overflow: hidden"><a href="/portfolio/<%= QBLink(rsGoodTeams("qbx_Name")) %>/"><%= rsGoodTeams("qbx_Name") %></a></td>
						<td style="border: 0; padding-top: 0;" align="right" nowrap><span class="badge bg-green"><%= FormatCurrency(rsGoodTeams("qbx_NetWorth"), 0) %></span></td>
					</tr>
<%
				Else
%>
					<tr>
						<td><%= TeamCount %>.</td>
						<td nowrap><a href="/portfolio/<%= QBLink(rsGoodTeams("qbx_Name")) %>/"><%= rsGoodTeams("qbx_Name") %></a></td>
						<td align="right" nowrap><span class="badge bg-green"><%= FormatCurrency(rsGoodTeams("qbx_NetWorth"), 0) %></span></td>
					</tr>
<%
				End If
				
				rsGoodTeams.MoveNext
				TeamCount = TeamCount + 1
				
			Loop
			
			rsGoodTeams.Close
			Set rsGoodTeams = Nothing
%>
		</table>
	</div>
</div>