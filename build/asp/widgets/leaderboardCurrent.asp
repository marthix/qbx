<div class="box box-warning">

	<div class="box-header with-border">
		<i class="fa fa-list-ol"></i>
		<h3 class="box-title">Current Standings</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		</div>
	</div>

	<div class="box-body">
			
		<table id="currentStandings" class="table table-bordered table-striped display responsive nowrap" width="100%" cellpadding="0">
			<thead>
				<tr>
					<th class="all">#</th>
					<th class="all">Team Name</th>
					<th class="min-tablet">Share Value</th>
					<th class="min-tablet">Cash</th>
					<th class="min-tablet">Net Worth</th>
					<th class="min-tablet">Change</th>
				</tr>
			</thead>
			<tbody>
<%
				sqlGetStandings = "SELECT samelevel.qbx_users.qbx_ID, samelevel.qbx_users.qbx_Name, ROUND(samelevel.qbx_portfolios.share_Value, 2) AS share_Value, ROUND(samelevel.qbx_portfolios.cash_Value, 2) AS cash_Value, ROUND(ROUND(samelevel.qbx_portfolios.share_Value, 2) + ROUND(samelevel.qbx_portfolios.cash_Value, 2), 2) AS net_Worth FROM samelevel.qbx_portfolios INNER JOIN samelevel.qbx_users ON samelevel.qbx_portfolios.user_ID = samelevel.qbx_users.qbx_ID WHERE samelevel.qbx_portfolios.is_Current = 1 ORDER BY net_Worth DESC"
				Set rsStandings = sqlSameLevel.Execute(sqlGetStandings)
				i = 1
				
				Do While Not rsStandings.Eof
				
					change_NetWorth = 0
					
					sqlGetPreviousNetWorth = "SELECT ROUND(cash_Value + share_Value, 2) AS NetWorth FROM samelevel.qbx_portfolios WHERE user_ID = " & rsStandings("qbx_ID") & " AND is_Current = 0 ORDER BY date_Calculated desc LIMIT 1"
					Set rsPreviousNetWorth = sqlSameLevel.Execute(sqlGetPreviousNetWorth)
					
					If Not rsPreviousNetWorth.Eof Then
					
						previous_NetWorth = rsPreviousNetWorth("NetWorth")
						rsPreviousNetWorth.Close
						Set rsPreviousNetWorth = Nothing
						
						change_NetWorth = CDbl(((rsStandings("net_Worth") * 100) / previous_NetWorth) - 100)
						
					End If
					
					If change_NetWorth > 0.001 Then
						price_Change = "<span class=""text-green""><i class=""fa fa-caret-up""></i> " & abs(Round(change_NetWorth, 2)) & "%</span>"
					ElseIf (change_NetWorth = 0) Or (change_NetWorth > 0 And change_NetWorth <= 0.001) Then
						price_Change = "<span class=""text-yellow""><i class=""fa fa-caret-right""></i> 0%</span>"
					Else
						price_Change = "<span class=""text-red""><i class=""fa fa-caret-down""></i> " & abs(Round(change_NetWorth, 2)) & "%</span>"
					End If
				
					Response.Write("<tr>")
						Response.Write("<td>" & i & ".</td>")
						Response.Write("<td><a href=""/portfolio/" & QBLink(rsStandings("qbx_Name")) & "/"">" & rsStandings("qbx_Name") & "</a></td>")
						Response.Write("<td>" & FormatCurrency(rsStandings("share_Value"), 2) & "</td>")
						Response.Write("<td>" & FormatCurrency(rsStandings("cash_Value"), 2) & "</td>")
						Response.Write("<td>" & FormatCurrency(rsStandings("net_Worth"), 2) & "</td>")
						Response.Write("<td>" & price_Change & "</td>")
					Response.Write("</tr>")
					
					rsStandings.MoveNext
					i = i + 1
					
				Loop
				
				rsStandings.Close
				Set rsStandings = Nothing
%>
			</tbody>
		</table>

		
	</div>
	
</div>