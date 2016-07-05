<%
	qb_Stock_Price = FormatNumber(Session.Contents("QBX_Current_QB_StockPrice"), 2)
	
	sqlGetPortfolio = "SELECT portfolio_ID, cash_Value FROM qbx_portfolios WHERE portfolio_ID = " & Session.Contents("QBX_Current_Portfolio_ID") & " AND user_ID = " & Session.Contents("QBX_ID")
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
<div class="box box-warning <%= disabled %>">
	<div class="box-header with-border">
		<i class="fa fa-usd"></i>
		<h3 class="box-title">Buy Shares</h3>
	</div>
	<div class="box-body">
	
		<form onsubmit="submitBuy(); return false;" action="#" id="submitBuyForm" class="form-group" style="margin: 0; padding: 0;">
			<input type="hidden" name="portfolio_ID" value="<%= portfolio_ID %>" />
			<input type="hidden" name="user_ID" value="<%= Session.Contents("QBX_ID") %>" />
			<input type="hidden" name="qb_ID" value="<%= Session.Contents("QBX_Current_QB_ID") %>" />
	
			<div id="submitBuyBlock" <% If Session.Contents("QBX_Market_Open") = 0 Then %>style="opacity: 0.7;"<% End If %>>
			
				<div class="row">
					<div class="col-sm-12" align="center">
			
						<div style="padding-bottom: 5px; padding-top: 5px;">TOTAL SHARES: <span id="buy_slide_value" style="font-weight: bold;">1</span></div>
						<input width="80%" id="buy_slide" name="buy_slide" type="text" data-slider-min="1" data-slider-max="<%= transaction_Max_Buy %>" data-slider-step="1" data-slider-value="1" style="width: 80%;" />
						
						<div>TOTAL COST:</div>
						<h2 id="buy_total_cost" style="padding-top: 0px; margin-top: 0px; margin-bottom: 20px;"><%= FormatCurrency(qb_Stock_Price, 2) %></h2>
<%
						hasPlayed = 0
						
						sqlGetPlayed = "SELECT * FROM qbx_quarterbacks WHERE qb_team = 29 OR qb_Team = 30 OR qb_Team = 9 OR qb_Team = 22"
						Set rsPlayed = sqlSameLevel.Execute(sqlGetPlayed)
						
						Do While Not rsPlayed.Eof
						
							If Session.Contents("QBX_Current_QB_ID") = rsPlayed("qb_ID") Then hasPlayed = 1
							rsPlayed.MoveNext
							
						Loop
						
						rsPlayed.Close
						Set rsPlayed = Nothing
						
						hasPlayed = 0
						
						If (Session.Contents("QBX_Market_Open") = 0) Or hasPlayed = 1 Then
%>
							<button disabled type="submit" class="btn btn-block btn-success">EXCHANGE CLOSED</button>
<%
						Else
%>
							<button <% If transaction_Max_Buy = 0 Then %>disabled<% End If %> type="submit" class="btn btn-block btn-success">PLACE ORDER</button>
<%
						End If
%>
					</div>
				</div>
				
			</div>
			
		</form>
	
	</div>
	
	<div id="submitBuyLoading" style="display: none;">
		<i class="fa fa-refresh fa-spin"></i>
	</div>
	
</div>