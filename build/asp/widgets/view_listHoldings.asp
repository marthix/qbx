<div class="box box-warning">

	<div class="box-header with-border">
		<i class="fa fa-database"></i>
		<h3 class="box-title">Current Holdings</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		</div>
	</div>

	<div class="box-body">
			
		<table id="listHoldings" class="table table-bordered table-striped display responsive nowrap" width="100%" cellpadding="0">
			<thead>
				<tr>
					<th class="all">Quarterback</th>
					<th class="min-tablet">Price</th>
					<th class="min-tablet">Shares</th>
					<th class="min-tablet">Value</th>
					<th class="min-tablet">Change</th>
				</tr>
			</thead>
			<tbody>
<%
				sqlGetPortfolio = "SELECT samelevel.qbx_holdings.holding_ID, samelevel.qbx_holdings.qb_ID, samelevel.qbx_quarterbacks.qb_Name, samelevel.qbx_quarterbacks.qb_StockPrice, samelevel.qbx_prices.price_Change, samelevel.qbx_holdings.share_Total AS qb_ShareCount, samelevel.qbx_holdings.share_Total * samelevel.qbx_quarterbacks.qb_StockPrice AS qb_CashValue FROM samelevel.qbx_portfolios INNER JOIN samelevel.qbx_holdings ON samelevel.qbx_holdings.portfolio_ID = samelevel.qbx_portfolios.portfolio_ID INNER JOIN samelevel.qbx_quarterbacks ON samelevel.qbx_quarterbacks.qb_ID = samelevel.qbx_holdings.qb_ID INNER JOIN samelevel.qbx_prices ON samelevel.qbx_prices.qb_ID = samelevel.qbx_holdings.qb_ID AND samelevel.qbx_prices.game_Year = " & Session.Contents("QBX_Current_Year") & " AND samelevel.qbx_prices.game_Week = " & Session.Contents("QBX_Current_Week") & " WHERE samelevel.qbx_portfolios.user_ID = " & Session.Contents("QBX_View_User_ID") & " AND samelevel.qbx_portfolios.portfolio_ID = " & Session.Contents("QBX_View_Portfolio_ID") & " AND samelevel.qbx_holdings.share_Total > 0 ORDER BY qb_CashValue DESC"
				Set rsPortfolio = sqlSameLevel.Execute(sqlGetPortfolio)
				
				Do While Not rsPortfolio.Eof 
				
					this_price_Change = CDbl(formatNumber(rsPortfolio("price_Change"), 2))
					If this_price_Change > 0 Then
						price_Change = "<span class=""text-green""><i class=""fa fa-caret-up""></i> " & abs(this_price_Change) & "%</span>"
					Else
						price_Change = "<span class=""text-red""><i class=""fa fa-caret-down""></i> " & abs(this_price_Change) & "%</span>"
					End If
					
					Response.Write("<tr>")
						Response.Write("<td style=""vertical-align: middle;""><a href=""/quarterbacks/" & QBLink(rsPortfolio("qb_Name")) & "/""><img src=""/build/img/profile/" & QBLink(rsPortfolio("qb_Name")) & ".png"" style=""max-width: 75px; float: left; margin-bottom:-8px; padding-right: 10px;"" /><div style=""font-size: 16px; font-weight: bold; padding-top: 8px;"">" & rsPortfolio("qb_Name") & "</div></a></td>")
						Response.Write("<td style=""vertical-align: middle;"">" & FormatCurrency(rsPortfolio("qb_StockPrice"), 2) & "</td>")
						Response.Write("<td style=""vertical-align: middle;"">" & rsPortfolio("qb_ShareCount") & "</td>")
						Response.Write("<td style=""vertical-align: middle;"">" & FormatCurrency(rsPortfolio("qb_CashValue"), 2) & "</td>")
						Response.Write("<td style=""vertical-align: middle;"">" & price_Change & "</td>")
					Response.Write("</tr>")
					
					rsPortfolio.MoveNext
					
				Loop
				
				rsPortfolio.Close
				Set rsPortfolio = Nothing
%>
			</tbody>
		</table>

		
	</div>
	
</div>