<%
	share_Total = 0
	
	sqlGetHoldings = "SELECT share_Total FROM qbx_Holdings WHERE portfolio_ID = " & portfolio_ID & " AND user_ID = " & Session.Contents("QBX_ID") & " AND qb_ID = " & Session.Contents("QBX_Current_QB_ID")
	Set rsHoldings = sqlSameLevel.Execute(sqlGetHoldings)
	
	If Not rsHoldings.Eof Then
	
		share_Total = rsHoldings("share_Total")
		rsHoldings.Close
		Set rsHoldings = Nothing
	
	End If
%>
<div class="box box-warning">
	<div class="box-header with-border">
		<i class="fa fa-usd"></i>
		<h3 class="box-title">Sell Shares</h3>
	</div>
	<div class="box-body">
	
		<form onsubmit="submitSell(); return false;" action="#" id="submitSellForm" class="form-group" style="margin: 0; padding: 0;">
			<input type="hidden" name="portfolio_ID" value="<%= portfolio_ID %>" />
			<input type="hidden" name="user_ID" value="<%= Session.Contents("QBX_ID") %>" />
			<input type="hidden" name="qb_ID" value="<%= Session.Contents("QBX_Current_QB_ID") %>" />
	
			<div id="submitSellBlock" <% If Session.Contents("QBX_Market_Open") = 0 Then %>style="opacity: 0.7;"<% End If %>>
			
				<div class="row">
				
					<div class="col-md-12" align="center">
			
						<div style="padding-bottom: 5px; padding-top: 5px;">TOTAL SHARES: <span id="sell_slide_value" style="font-weight: bold;">1</span></div>
						<input width="80%" id="sell_slide" name="sell_slide" type="text" data-slider-min="1" data-slider-max="<%= share_Total %>" data-slider-step="1" data-slider-value="1" style="width: 80%;" />
						
						<div>TOTAL VALUE:</div>
						<h2 id="sell_total_cost" style="padding-top: 0px; margin-top: 0px; margin-bottom: 20px;"><%= FormatCurrency(qb_Stock_Price, 2) %></h2>
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
							<button disabled type="submit" class="btn btn-block btn-danger">EXCHANGE CLOSED</button>
<%
						Else
%>
							<button <% If share_Total = 0 Then %>disabled<% End If %> type="submit" class="btn btn-block btn-danger">SELL STOCK</button>
<%
						End If
%>
						
					</div>
					
				</div>
				
			</div>
			
		</form>
	
	</div>
	
	<div id="submitSellLoading" style="display: none;">
		<i class="fa fa-refresh fa-spin"></i>
	</div>
	
</div>