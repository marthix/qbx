<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<%
	qb_Stock_Price = FormatNumber(Session.Contents("QBX_Current_QB_StockPrice"), 2)
	share_Total = 0
	
	sqlGetHoldings = "SELECT share_Total FROM qbx_Holdings WHERE portfolio_ID = " & Session.Contents("QBX_Current_Portfolio_ID") & " AND user_ID = " & Session.Contents("QBX_ID") & " AND qb_ID = " & Session.Contents("QBX_Current_QB_ID")
	Set rsHoldings = sqlSameLevel.Execute(sqlGetHoldings)
	
	If Not rsHoldings.Eof Then
	
		share_Total = rsHoldings("share_Total")
		rsHoldings.Close
		Set rsHoldings = Nothing
	
	End If
%>
	<input type="hidden" name="portfolio_ID" value="<%= Session.Contents("QBX_Current_Portfolio_ID") %>" />
	<input type="hidden" name="user_ID" value="<%= Session.Contents("QBX_ID") %>" />
	<input type="hidden" name="qb_ID" value="<%= Session.Contents("QBX_Current_QB_ID") %>" />
	<input type="hidden" name="sell_slide" id="sell_slide" value="<%= share_Total %>" />
	
	<div class="row">
				
		<div class="col-md-12" align="center">

			<div style="padding-bottom: 5px; padding-top: 5px;">TOTAL SHARES:</div>
			<h3 style="padding-top: 0px; margin-top: 0px; margin-bottom: 14px;"><%= share_Total %></h3>
			
			<div>TOTAL VALUE:</div>
			<h2 style="padding-top: 0px; margin-top: 0px; margin-bottom: 20px;"><%= FormatCurrency(qb_Stock_Price * share_Total, 2) %></h2>
		
			<button <% If share_Total = 0 Then %>disabled<% End If %> type="submit" class="btn btn-block btn-primary">SELL EVERYTHING</button>
			
		</div>
		
	</div>