<div class="box box-warning">
	<div class="box-header with-border">
		<h3 class="box-title"><b>Bad Quarterbacks</b></h3>
	</div>
	<div class="box-body">
		<table class="table">
<%
			sqlGetQBCount = "SELECT COUNT(qb_ID) AS TotalQuarterbacks FROM samelevel.qbx_quarterbacks WHERE qb_Active = 1"
			Set rsQBCount = sqlSameLevel.Execute(sqlGetQBCount)
			
			TotalQuarterbacks = CInt(rsQBCount("TotalQuarterbacks"))
			QuarterbackCount = TotalQuarterbacks - 2
			ListCount = 1
			
			rsQBCount.Close
			Set rsQBCount = Nothing
			
			sqlGetBadQuarterbackID = "SELECT qb_ID FROM samelevel.qbx_quarterbacks WHERE qb_Active = 1 ORDER BY qb_StockPrice ASC, qb_Name ASC LIMIT 3;"
			Set rsBadQuarterbackID = sqlSameLevel.Execute(sqlGetBadQuarterbackID)
			
			Do While Not rsBadQuarterbackID.Eof
			
				qb_IDs = qb_IDs & rsBadQuarterbackID("qb_ID") & ","
				rsBadQuarterbackID.MoveNext
				
			Loop
			
			rsBadQuarterbackID.Close
			Set rsBadQuarterbackID = Nothing
			
			If Right(qb_IDs, 1) = "," Then qb_IDs = Left(qb_IDs, Len(qb_IDs) - 1)
			
			sqlGetBadQuarterbacks = "SELECT qb_Name, qb_StockPrice FROM samelevel.qbx_quarterbacks WHERE qb_Active = 1 AND qb_ID IN (" & qb_IDs & ") ORDER BY qb_StockPrice ASC, qb_Name ASC"
			Set rsBadQuarterbacks = sqlSameLevel.Execute(sqlGetBadQuarterbacks)
			
			Do While Not rsBadQuarterbacks.Eof
			
				If ListCount = 1 Then
%>
					<tr>
						<td style="border: 0; padding-top: 0; width: 40px;"><%= QuarterbackCount %>.</td>
						<td nowrap style="border: 0; padding-top: 0; overflow: hidden"><a href="/quarterbacks/<%= QBLink(rsBadQuarterbacks("qb_Name")) %>/"><%= rsBadQuarterbacks("qb_Name") %></a></td>
						<td style="border: 0; padding-top: 0;" align="right" nowrap><span class="badge bg-red"><%= FormatCurrency(rsBadQuarterbacks("qb_StockPrice"), 2) %></span></td>
					</tr>
<%
				ElseIf ListCount = 3 Then
%>
					<tr>
						<td><b><%= QuarterbackCount %>.</b></td>
						<td nowrap><a href="/quarterbacks/<%= QBLink(rsBadQuarterbacks("qb_Name")) %>/"><%= rsBadQuarterbacks("qb_Name") %></a></td>
						<td align="right" nowrap><span class="badge bg-red"><%= FormatCurrency(rsBadQuarterbacks("qb_StockPrice"), 2) %></span></td>
					</tr>
<%
				Else
%>
					<tr>
						<td><%= QuarterbackCount %>.</td>
						<td nowrap><a href="/quarterbacks/<%= QBLink(rsBadQuarterbacks("qb_Name")) %>/"><%= rsBadQuarterbacks("qb_Name") %></a></td>
						<td align="right" nowrap><span class="badge bg-red"><%= FormatCurrency(rsBadQuarterbacks("qb_StockPrice"), 2) %></span></td>
					</tr>
<%
				End If
				
				rsBadQuarterbacks.MoveNext
				QuarterbackCount = QuarterbackCount + 1
				ListCount = ListCount + 1
				
			Loop
			
			rsBadQuarterbacks.Close
			Set rsBadQuarterbacks = Nothing
%>
		</table>
	</div>
</div>