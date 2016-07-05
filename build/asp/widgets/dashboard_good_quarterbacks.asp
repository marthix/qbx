<div class="box box-warning">
	<div class="box-header with-border">
		<h3 class="box-title"><b>Good Quarterbacks</b></h3>
	</div>
	<div class="box-body">
		<table class="table">
<%
			QuarterbackCount = 1
			sqlGetGoodQuarterbacks = "SELECT qb_Name, qb_StockPrice FROM samelevel.qbx_quarterbacks WHERE qb_Active = 1 ORDER BY qb_StockPrice DESC LIMIT 3;"
			Set rsGoodQuarterbacks = sqlSameLevel.Execute(sqlGetGoodQuarterbacks)
			
			Do While Not rsGoodQuarterbacks.Eof
			
				If QuarterbackCount = 1 Then
%>
					<tr>
						<td style="border: 0; padding-top: 0; width: 40px;"><b>1.</b></td>
						<td nowrap style="border: 0; padding-top: 0; overflow: hidden"><a href="/quarterbacks/<%= QBLink(rsGoodQuarterbacks("qb_Name")) %>/"><%= rsGoodQuarterbacks("qb_Name") %></a></td>
						<td style="border: 0; padding-top: 0;" align="right" nowrap><span class="badge bg-green"><%= FormatCurrency(rsGoodQuarterbacks("qb_StockPrice"), 2) %></span></td>
					</tr>
<%
				Else
%>
					<tr>
						<td><%= QuarterbackCount %>.</td>
						<td nowrap><a href="/quarterbacks/<%= QBLink(rsGoodQuarterbacks("qb_Name")) %>/"><%= rsGoodQuarterbacks("qb_Name") %></a></td>
						<td align="right" nowrap><span class="badge bg-green"><%= FormatCurrency(rsGoodQuarterbacks("qb_StockPrice"), 2) %></span></td>
					</tr>
<%
				End If
				
				rsGoodQuarterbacks.MoveNext
				QuarterbackCount = QuarterbackCount + 1
				
			Loop
			
			rsGoodQuarterbacks.Close
			Set rsGoodQuarterbacks = Nothing
%>
		</table>
	</div>
</div>