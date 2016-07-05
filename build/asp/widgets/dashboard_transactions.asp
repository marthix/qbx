<div class="box box-warning">
	<div class="box-header with-border">
		<h3 class="box-title"><b>Recent Transactions</b></h3>
	</div>
	<div class="box-body">
		<table id="recentTransactions" class="table table-bordered table-striped display responsive nowrap" width="100%" cellpadding="0">
			<thead>
				<tr>
					<th class="all">Team</th>
					<th class="min-tablet">Quarterback</th>
					<th class="min-tablet">Type</th>
					<th class="min-tablet">Shares</th>
					<th class="min-tablet">Value</th>
				</tr>
			</thead>
			<tbody>
<%
				sqlGetTransactions = "SELECT samelevel.qbx_users.qbx_Name, samelevel.qbx_quarterbacks.qb_Name, samelevel.qbx_transactions.transaction_Date, samelevel.qbx_transaction_types.type_Title, samelevel.qbx_transactions.share_Total, samelevel.qbx_transactions.cash_Value FROM samelevel.qbx_transactions INNER JOIN samelevel.qbx_quarterbacks ON samelevel.qbx_quarterbacks.qb_ID = samelevel.qbx_transactions.qb_ID INNER JOIN samelevel.qbx_users ON samelevel.qbx_users.qbx_ID = samelevel.qbx_transactions.user_ID INNER JOIN samelevel.qbx_transaction_types ON samelevel.qbx_transaction_types.transaction_type_ID = samelevel.qbx_transactions.transaction_Type ORDER BY samelevel.qbx_transactions.transaction_Date DESC LIMIT 40"
				Set rsTransactions = sqlSameLevel.Execute(sqlGetTransactions)
				
				Do While Not rsTransactions.Eof
				
					type_Title = rsTransactions("type_Title")
					If type_Title = "Buy" Then
						type_Style = "text-green"
					ElseIf type_Title = "Sell" Then
						type_Style = "text-red"
					End If
				
					Response.Write("<tr>")
						Response.Write("<td><a href=""/portfolio/" & QBLink(rsTransactions("qbx_Name")) & "/"">" & rsTransactions("qbx_Name") & "</a></td>")
						Response.Write("<td><a href=""/quarterbacks/" & QBLink(rsTransactions("qb_Name")) & "/"">" & rsTransactions("qb_Name") & "</a></td>")
						Response.Write("<td class=""" & type_Style & """>" & rsTransactions("type_Title") & "</td>")
						Response.Write("<td>" & rsTransactions("share_Total") & "</td>")
						Response.Write("<td align=""right"">" & FormatCurrency(rsTransactions("cash_Value"), 2) & "</td>")
					Response.Write("</tr>")
					
					rsTransactions.MoveNext
					
				Loop
				
				rsTransactions.Close
				Set rsTransactions = Nothing
%>
			</tbody>
			
		</table>
	</div>
</div>