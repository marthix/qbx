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
<div class="box box-warning">
	<div class="box-header with-border">
		<i class="fa fa-bank"></i>
		<h3 class="box-title">Ownership</h3>
	</div>
	<div class="box-body">
	
		<form onsubmit="submitSellEverything(); return false;" action="#" id="submitSellEverythingForm" class="form-group" style="margin: 0; padding: 0;">
			
			<div id="holdingsBlock">
			
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
							<button disabled type="submit" class="btn btn-block btn-primary" style="opacity: 0.5;">EXCHANGE CLOSED</button>
<%
						Else
%>
							<button <% If share_Total = 0 Then %>disabled<% End If %> type="submit" class="btn btn-block btn-primary">SELL EVERYTHING</button>
<%
						End If
%>
					</div>
					
				</div>
				
			</div>
		
		</form>
	
	</div>
	
	<div id="submitHoldingsLoading" style="display: none;">
		<i class="fa fa-refresh fa-spin"></i>
	</div>
	
</div>