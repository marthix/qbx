<div class="box box-warning">

	<div class="box-header with-border">
		<i class="fa fa-thumbs-up"></i>
		<h3 class="box-title">Trending Up</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		</div>
	</div>

	<div class="box-body">
			
		<table id="listQuarterbacks" class="table table-bordered table-striped display responsive nowrap" width="100%" cellpadding="0">
			<thead>
				<tr>
					<th class="all">Name</th>
					<th class="min-tablet">Current Price</th>
					<th class="all">Change</th>
				</tr>
			</thead>
			<tbody>
<%
				sqlGetQuarterbacks = "SELECT qbx_prices.qb_ID, qbx_prices.price_Value, qbx_prices.price_Change, qbx_quarterbacks.qb_Name FROM samelevel.qbx_prices INNER JOIN qbx_quarterbacks ON qbx_quarterbacks.qb_ID = qbx_prices.qb_ID WHERE qbx_prices.game_Year = " & Session.Contents("QBX_Current_Year") & " AND qbx_prices.game_Week = " & Session.Contents("QBX_Current_Week") & " AND qbx_quarterbacks.qb_Active = 1 ORDER BY price_Change DESC LIMIT 4"
				'Response.Write(sqlGetQuarterbacks)
				Set rsQuarterbacks = sqlSameLevel.Execute(sqlGetQuarterbacks)
				
				Do While Not rsQuarterbacks.Eof 
				
					Response.Write("<tr>")
						Response.Write("<td><a href=""/quarterbacks/" & QBLink(rsQuarterbacks("qb_Name")) & "/"">" & rsQuarterbacks("qb_Name") & "</a></td>")
						Response.Write("<td>" & FormatCurrency(rsQuarterbacks("price_Value"), 2) & "</td>")
						Response.Write("<td><span class=""text-green"">+" & FormatNumber(rsQuarterbacks("price_Change"), 0) & "%</span></td>")
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