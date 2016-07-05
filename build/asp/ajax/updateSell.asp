<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<%
	share_Total = 0
	
	sqlGetShareValue = "SELECT qb_StockPrice FROM qbx_quarterbacks WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID")
	Set rsShareValue = sqlSameLevel.Execute(sqlGetShareValue)
	
	share_Value = CDbl(FormatNumber(rsShareValue("qb_StockPrice"), 2))
	
	rsShareValue.close
	Set rsShareValue = Nothing
	
	sqlGetHoldings = "SELECT share_Total FROM qbx_Holdings WHERE portfolio_ID = " & Session.Contents("QBX_Current_Portfolio_ID") & " AND user_ID = " & Session.Contents("QBX_ID") & " AND qb_ID = " & Session.Contents("QBX_Current_QB_ID")
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
			<input width="80%" id="sell_slide" name="sell_slide" type="text" data-slider-min="1" data-slider-max="<%= share_Total %>" data-slider-step="1" data-slider-value="1" style="width: 90%; margin-bottom: 10px;" />
			
			<div>TOTAL VALUE:</div>
			<h2 id="sell_total_cost" style="padding-top: 0px; margin-top: 0px; margin-bottom: 20px;"><%= FormatCurrency(share_Value, 2) %></h2>
		
			<button <% If share_Total = 0 Then %>disabled<% End If %> type="submit" class="btn btn-block btn-danger">SELL STOCK</button>

		</div>
	</div>