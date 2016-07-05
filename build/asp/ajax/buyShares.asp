<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<%
	throwError = 0	
	
	portfolio_ID = Request.Form("portfolio_ID")
	user_ID = Request.Form("user_ID")
	qb_ID = Request.Form("qb_ID")
	share_Total = Request.Form("buy_slide")
	
	sqlGetShareValue = "SELECT qb_StockPrice FROM qbx_quarterbacks WHERE qb_ID = " & qb_ID
	Set rsShareValue = sqlSameLevel.Execute(sqlGetShareValue)
	
	share_Value = CDbl(FormatNumber(rsShareValue("qb_StockPrice"), 2))
	total_Cost = CDbl(FormatNumber(share_Value * share_Total, 2))
	
	'DOUBLE-CHECK PORTFOLIO CASH AMOUNT VERSUS TOTAL COST
	sqlGetCash = "SELECT cash_Value FROM qbx_portfolios WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & user_ID
	Set rsCash = sqlSameLevel.Execute(sqlGetCash)
	
	current_Cash_Value = CDbl(FormatNumber(rsCash("cash_Value"), 2))
	
	rsCash.Close
	Set rsCash = Nothing
	
	If total_Cost > current_Cash_Value Then throwError = 1
	If share_Total = 0 Then throwError = 1
	
	If throwError = 0 Then
	
		
		'INSERT TRANSACTION
		Set rsInsert = Server.CreateObject("ADODB.RecordSet")
		rsInsert.CursorType = adOpenKeySet
		rsInsert.LockType = adLockOptimistic
		rsInsert.Open "qbx_transactions", sqlSameLevel, , , adCmdTable
		rsInsert.AddNew
		rsInsert("transaction_Type") = 1
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
			share_Total = share_Total + current_Share_Total
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
		sqlMakePayment = "UPDATE qbx_portfolios SET cash_Value = cash_Value - " & total_Cost & " WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & user_ID
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
	
	qb_Stock_Price = FormatNumber(Session.Contents("QBX_Current_QB_StockPrice"), 2)
	
	sqlGetPortfolio = "SELECT portfolio_ID, cash_Value FROM qbx_portfolios WHERE is_Current = 1 AND user_ID = " & Session.Contents("QBX_ID")
	Set rsPortfolio = sqlSameLevel.Execute(sqlGetPortfolio)
	
	If Not rsPortfolio.Eof Then
	
		portfolio_ID = rsPortfolio("portfolio_ID")
		portfolio_Cash_Value = CDbl(rsPortfolio("cash_Value"))
		rsPortfolio.Close
		Set rsPortfolio = Nothing
	
	End If
	
	transaction_Max_Buy = CStr(FormatNumber((FormatNumber(portfolio_Cash_Value, 2) / qb_Stock_Price), 1))
	If Right(transaction_Max_Buy, 1) <> "0" Then transaction_Max_Buy = Left(transaction_Max_Buy, Len(transaction_Max_Buy)-1) & "0"
	transaction_Max_Buy = CInt(transaction_Max_Buy)
%>
		<div class="row">
			<div class="col-md-12" align="center">
				
				<div style="padding-bottom: 5px; padding-top: 5px;">TOTAL SHARES: <span id="buy_slide_value" style="font-weight: bold;">1</span></div>
				<input width="80%" id="buy_slide" name="buy_slide" type="text" data-slider-min="1" data-slider-max="<%= transaction_Max_Buy %>" data-slider-step="1" data-slider-value="1" style="width: 80%;" />
				
				<div>TOTAL COST:</div>
				<h2 id="buy_total_cost" style="padding-top: 0px; margin-top: 0px; margin-bottom: 20px;"><%= FormatCurrency(share_Value, 2) %></h2>
			
				<button <% If transaction_Max_Buy = 0 Then %>disabled<% End If %> type="submit" class="btn btn-block btn-success">PLACE ORDER</button>
<%
				If throwError = 1 Then
					Response.Write("<div id=""successMessage"" style=""padding-top: 8px; color: #bf0007;""><b>Go home. You broke.</b></div>")
				Else
					Response.Write("<div id=""successMessage"" style=""padding-top: 8px;""><b>Order Successful!</b></div>")
				End If
%>
			</div>
		</div>