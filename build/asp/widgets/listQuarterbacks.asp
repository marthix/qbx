<div class="box box-warning">

	<div class="box-header with-border">
		<i class="fa fa-database"></i>
		<h3 class="box-title">NFL QB Database</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		</div>
	</div>

	<div class="box-body">
			
		<table id="listQuarterbacks" class="table table-bordered table-striped display responsive nowrap" width="100%" cellpadding="0">
			<thead>
				<tr>
					<th class="all">Name</th>
					<th class="min-tablet">Team</th>
					<th class="all">Price</th>
					<th class="min-tablet">Change</th>
				</tr>
			</thead>
			<tbody>
<%
				sqlGetQuarterbacks = "SELECT qbx_quarterbacks.*, qbx_teams.team_City, qbx_teams.team_Mascot, qbx_prices.price_Change FROM samelevel.qbx_quarterbacks INNER JOIN samelevel.qbx_teams ON samelevel.qbx_teams.team_ID = samelevel.qbx_quarterbacks.qb_Team INNER JOIN samelevel.qbx_prices ON samelevel.qbx_prices.qb_ID = samelevel.qbx_quarterbacks.qb_ID AND qbx_prices.game_Year = " & Session.Contents("QBX_Current_Year") & " AND qbx_prices.game_Week = " & Session.Contents("QBX_Current_Week") & " WHERE qb_Active = 1 AND samelevel.qbx_teams.team_ID IN (5, 10) ORDER BY qbx_quarterbacks.qb_Name ASC"
				Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
				
				Do While Not rsQuarterbacks.Eof 
					
					this_price_Change = CDbl(formatNumber(rsQuarterbacks("price_Change"), 2))
					If this_price_Change > 0 Then
						price_Change = "<span class=""text-green""><i class=""fa fa-caret-up""></i> " & abs(this_price_Change) & "%</span>"
					ElseIf this_price_Change = 0 Then
						price_Change = "<span class=""text-yellow""><i class=""fa fa-caret-right""></i> " & abs(this_price_Change) & "%</span>"
					Else
						price_Change = "<span class=""text-red""><i class=""fa fa-caret-down""></i> " & abs(this_price_Change) & "%</span>"
					End If
					
					Response.Write("<tr>")
						Response.Write("<td><a href=""/quarterbacks/" & QBLink(rsQuarterbacks("qb_Name")) & "/"">" & rsQuarterbacks("qb_Name") & "</a></td>")
						Response.Write("<td>" & rsQuarterbacks("team_City") & " " & rsQuarterbacks("team_Mascot") & "</td>")
						Response.Write("<td>" & FormatCurrency(rsQuarterbacks("qb_StockPrice"), 2) & "</td>")
						Response.Write("<td>" & price_Change & "</td>")
					Response.Write("</tr>")
					
					rsQuarterbacks.MoveNext
					
				Loop
				
				rsQuarterbacks.Close
				Set rsQuarterbacks = Nothing
%>
			</tbody>
			
		</table>

		
	</div>
	
</div>