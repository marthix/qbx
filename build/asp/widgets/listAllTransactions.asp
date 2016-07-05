<div class="box box-warning">

	<div class="box-header with-border">
		<i class="fa fa-list-alt"></i>
		<h3 class="box-title">Transaction Archive</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
		</div>
	</div>

	<div class="box-body">
			
		<table id="listAllTransactions" class="table table-bordered table-striped display responsive nowrap" width="100%" cellpadding="0">
			<thead>
				<tr>
					<th>Date</th>
					<th>Team</th>
					<th>Quarterback</th>
					<th>Type</th>
					<th>Shares</th>
					<th>Cash Value</th>
				</tr>
			</thead>
			<tbody>
<%
				sqlGetTransactions = "SELECT samelevel.qbx_users.qbx_Name, samelevel.qbx_quarterbacks.qb_Name, samelevel.qbx_transactions.transaction_Date, samelevel.qbx_transaction_types.type_Title, samelevel.qbx_transactions.share_Total, samelevel.qbx_transactions.cash_Value FROM samelevel.qbx_transactions INNER JOIN samelevel.qbx_users ON samelevel.qbx_transactions.user_ID = samelevel.qbx_users.qbx_ID INNER JOIN samelevel.qbx_quarterbacks ON samelevel.qbx_quarterbacks.qb_ID = samelevel.qbx_transactions.qb_ID INNER JOIN samelevel.qbx_transaction_types ON samelevel.qbx_transaction_types.transaction_type_ID = samelevel.qbx_transactions.transaction_Type ORDER BY samelevel.qbx_transactions.transaction_Date DESC"
				Set rsTransactions = sqlSameLevel.Execute(sqlGetTransactions)
				
				Do While Not rsTransactions.Eof 
				
					Response.Write("<tr>")
						Response.Write("<td>" & FormatDateTime(rsTransactions("transaction_Date"), 2) & " @ " & FormatDateTime(rsTransactions("transaction_Date"), 3) & "</td>")
						Response.Write("<td><a href=""/portfolio/" & QBLink(rsTransactions("qbx_Name")) & "/"">" & rsTransactions("qbx_Name") & "</a></td>")
						Response.Write("<td><a href=""/quarterbacks/" & QBLink(rsTransactions("qb_Name")) & "/"">" & rsTransactions("qb_Name") & "</a></td>")
						Response.Write("<td>" & rsTransactions("type_Title") & "</td>")
						Response.Write("<td>" & rsTransactions("share_Total") & "</td>")
						Response.Write("<td>" & FormatCurrency(rsTransactions("cash_Value"), 2) & "</td>")
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