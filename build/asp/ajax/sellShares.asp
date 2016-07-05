<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<%
	throwError = 0	
	
	portfolio_ID = Request.Form("portfolio_ID")
	user_ID = Request.Form("user_ID")
	qb_ID = Request.Form("qb_ID")
	share_Total = Request.Form("sell_slide")
	
	sqlGetShareValue = "SELECT qb_StockPrice FROM qbx_quarterbacks WHERE qb_ID = " & qb_ID
	Set rsShareValue = sqlSameLevel.Execute(sqlGetShareValue)
	
	share_Value = CDbl(FormatNumber(rsShareValue("qb_StockPrice"), 2))
	total_Cost = CDbl(FormatNumber(share_Value * share_Total, 2))
	
	sqlGetExistingHoldings = "SELECT share_Total FROM qbx_holdings WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & user_ID & " AND qb_ID = " & qb_ID
	Set rsExistingHoldings = sqlSameLevel.Execute(sqlGetExistingHoldings)
	
	If Not rsExistingHoldings.Eof Then
	
		current_Share_Total = rsExistingHoldings("share_Total")
		If CInt(current_Share_Total) < 1 Then throwError = 1
		rsExistingHoldings.Close
		Set rsExistingHoldings = Nothing
		
	End If
	
	If throwError = 0 Then
	
		
		'INSERT TRANSACTION
		Set rsInsert = Server.CreateObject("ADODB.RecordSet")
		rsInsert.CursorType = adOpenKeySet
		rsInsert.LockType = adLockOptimistic
		rsInsert.Open "qbx_transactions", sqlSameLevel, , , adCmdTable
		rsInsert.AddNew
		rsInsert("transaction_Type") = 2
		rsInsert("user_ID") = user_ID
		rsInsert("portfolio_ID") = portfolio_ID
		rsInsert("qb_ID") = qb_ID
		rsInsert("share_Total") = share_Total
		rsInsert("cash_Value") = total_Cost
		rsInsert.Update
		Set rsInsert = Nothing
		
		'UPDATE HOLDINGS
		sqlGetExistingHoldings = "SELECT share_Total FROM qbx_holdings WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & user_ID & " AND qb_ID = " & qb_ID
		Set rsExistingHoldings = sqlSameLevel.Execute(sqlGetExistingHoldings)
		
		If Not rsExistingHoldings.Eof Then
		
			current_Share_Total = rsExistingHoldings("share_Total")
			share_Total = current_Share_Total - share_Total
			total_Value = CStr(FormatNumber(share_Value * share_Total, 2))
			If InStr(total_Value, ",") Then total_Value = Replace(total_Value, ",", "")
			rsExistingHoldings.Close
			Set rsExistingHoldings = Nothing
			sqlUpdateHoldings = "UPDATE qbx_holdings SET share_Total = " & share_Total & ", cash_Value = " & total_Value & " WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & user_ID & " AND qb_ID = " & qb_ID
			Set rsUpdate      = sqlSameLevel.Execute(sqlUpdateHoldings)
			
		Else
		
			Set rsInsert = Server.CreateObject("ADODB.RecordSet")
			rsInsert.CursorType = adOpenKeySet
			rsInsert.LockType = adLockOptimistic
			rsInsert.Open "qbx_holdings", sqlSameLevel, , , adCmdTable
			rsInsert.AddNew
			rsInsert("portfolio_ID") = portfolio_ID
			rsInsert("user_ID") = user_ID
			rsInsert("qb_ID") = qb_ID
			rsInsert("share_Total") = share_Total
			rsInsert("cash_Value") = total_Cost
			rsInsert.Update
			Set rsInsert = Nothing
		
		End If
		
		'UPDATE PORTFOLIO
		sqlMakePayment = "UPDATE qbx_portfolios SET cash_Value = cash_Value + " & total_Cost & " WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & user_ID
		Set rsPayment  = sqlSameLevel.Execute(sqlMakePayment)
		
		sqlGetHoldings = "SELECT SUM(cash_Value) AS new_Portfolio_Share_Value FROM qbx_Holdings WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & user_ID
		Set rsHoldings = sqlSameLevel.Execute(sqlGetHoldings)
		
		new_Portfolio_Share_Value = CStr(FormatNumber(rsHoldings("new_Portfolio_Share_Value"), 2))
		If InStr(new_Portfolio_Share_Value, ",") Then new_Portfolio_Share_Value = Replace(new_Portfolio_Share_Value, ",", "")
		
		rsHoldings.Close
		Set rsHoldings = Nothing
		
		sqlUpdatePortfolioShareValue = "UPDATE qbx_portfolios SET share_Value = " & new_Portfolio_Share_Value & " WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & user_ID
		Set rsUpdatePortfolioShare   = sqlSameLevel.Execute(sqlUpdatePortfolioShareValue)
		
	End If
	
	share_Total = 0
	
	sqlGetHoldings = "SELECT share_Total FROM qbx_Holdings WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & Session.Contents("QBX_ID") & " AND qb_ID = " & Session.Contents("QBX_Current_QB_ID")
	Set rsHoldings = sqlSameLevel.Execute(sqlGetHoldings)
	
	If Not rsHoldings.Eof Then
	
		share_Total = rsHoldings("share_Total")
		rsHoldings.Close
		Set rsHoldings = Nothing
	
	End If
%>
	<div class="row">
		<div class="col-md-12" align="center">
	
			<div style="padding-bottom: 5px; padding-top: 5px;">TOTAL SHARES: <span id="sell_slide_value" style="font-weight: bold;">1</span></div>
			<input width="80%" id="sell_slide" name="sell_slide" type="text" data-slider-min="1" data-slider-max="<%= share_Total %>" data-slider-step="1" data-slider-value="1" style="width: 80%;" />
			
			<div>TOTAL VALUE:</div>
			<h2 id="sell_total_cost" style="padding-top: 0px; margin-top: 0px; margin-bottom: 20px;"><%= FormatCurrency(share_Value, 2) %></h2>
		
			<button <% If share_Total = 0 Then %>disabled<% End If %> type="submit" class="btn btn-block btn-danger">SELL STOCK</button>
<%
			If throwError = 1 Then
				Response.Write("<div id=""sellMessage"" style=""padding-top: 8px; color: #bf0007;""><b>Go home. You broke.</b></div>")
			Else
				Response.Write("<div id=""sellMessage"" style=""padding-top: 8px;""><b>Sale Successful!</b></div>")
			End If
%>
		</div>
	</div>