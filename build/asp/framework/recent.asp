<aside class="control-sidebar control-sidebar-dark">

	<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
	
		<li class="active"><a href="#control-sidebar-transactions-tab" data-toggle="tab"><i class="fa fa-retweet"></i></a></li>
		<li><a href="#control-sidebar-standings-tab" data-toggle="tab"><i class="fa fa-trophy"></i></a></li>
		<li><a href="#control-sidebar-portfolio-tab" data-toggle="tab"><i class="fa fa-bar-chart"></i></a></li>
	
	</ul>
	
	<div class="tab-content">
	
		<div class="tab-pane active" id="control-sidebar-transactions-tab">
			
			<h3 class="control-sidebar-heading" style="padding-top: 0; margin-top: 10px; margin-bottom: 5px;">Recent Transactions</h3>
			<ul class="control-sidebar-menu">
<%
				sqlGetRecentTransactions = "SELECT samelevel.qbx_transactions.transaction_Date, samelevel.qbx_transactions.transaction_Type, samelevel.qbx_transactions.share_Total, samelevel.qbx_transactions.cash_Value, samelevel.qbx_quarterbacks.qb_Name, samelevel.qbx_users.qbx_Name FROM samelevel.qbx_transactions INNER JOIN samelevel.qbx_quarterbacks ON samelevel.qbx_transactions.qb_ID = samelevel.qbx_quarterbacks.qb_ID INNER JOIN samelevel.qbx_users ON samelevel.qbx_transactions.user_ID = samelevel.qbx_users.qbx_ID ORDER BY samelevel.qbx_transactions.transaction_Date DESC LIMIT 10"
				Set rsRecentTransactions = sqlSameLevel.Execute(sqlGetRecentTransactions)
				
				i = 0
				
				Do While Not rsRecentTransactions.Eof
				
					transaction_Type = rsRecentTransactions("transaction_Type")
					transaction_Date = rsRecentTransactions("transaction_Date")
					share_Total = rsRecentTransactions("share_Total")
					cash_Value = rsRecentTransactions("cash_Value")
					qb_Name = rsRecentTransactions("qb_Name")
					qbx_Name = rsRecentTransactions("qbx_Name")
					
					If CInt(transaction_Type) = 1 Then
%>
						<li>
							<a href="/transactions/">
								<i class="menu-icon fa fa-money bg-green"></i>
								<div class="menu-info">
									<h4 class="control-sidebar-subheading"><%= qb_Name %></h4>
									<p style="overflow: hidden; height: 15px; color: #fff;"><%= share_Total %> shares (<%= FormatCurrency(cash_Value) %>)</p>
									<p style="overflow: hidden; height: 15px;"><%= qbx_Name %></p>
									<p style="overflow: hidden; height: 15px;"><i><%= transaction_Date %></i></p>
								</div>
							</a>
						</li>
<%
					ElseIf CInt(transaction_Type) = 2 Then
%>
						<li>
							<a href="/transactions/">
								<i class="menu-icon fa fa-money bg-red"></i>
								<div class="menu-info">
									<h4 class="control-sidebar-subheading"><%= qb_Name %></h4>
									<p style="overflow: hidden; height: 15px; color: #fff;"><%= share_Total %> shares (<%= FormatCurrency(cash_Value) %>)</p>
									<p style="overflow: hidden; height: 15px;"><%= qbx_Name %></p>
									<p style="overflow: hidden; height: 15px;"><i><%= transaction_Date %></i></p>
								</div>
							</a>
						</li>
<%
					End If
					
					rsRecentTransactions.MoveNext
					
					i = i + 1
					
				Loop
				
				rsRecentTransactions.Close
				Set rsRecentTransactions = Nothing
%>
			</ul>
			
		</div>
		
		<div class="tab-pane" id="control-sidebar-standings-tab">
			
			<h3 class="control-sidebar-heading" style="padding-top: 0; margin-top: 10px; margin-bottom: 5px;">Current Standings</h3>
			<ul class="control-sidebar-menu">
<%
				sqlGetStandings = "SELECT samelevel.qbx_users.qbx_Name, samelevel.qbx_users.qbx_Avatar, ROUND(samelevel.qbx_portfolios.share_Value, 2) AS share_Value, ROUND(samelevel.qbx_portfolios.cash_Value, 2) AS cash_Value, ROUND(ROUND(samelevel.qbx_portfolios.share_Value, 2) + ROUND(samelevel.qbx_portfolios.cash_Value, 2), 2) AS net_Worth FROM samelevel.qbx_portfolios INNER JOIN samelevel.qbx_users ON samelevel.qbx_portfolios.user_ID = samelevel.qbx_users.qbx_ID WHERE samelevel.qbx_portfolios.is_Current = 1 ORDER BY net_Worth DESC"
				Set rsStandings = sqlSameLevel.Execute(sqlGetStandings)
				i = 1
				
				Do While Not rsStandings.Eof
				
					qbx_Name = rsStandings("qbx_Name")
					qbx_Avatar = rsStandings("qbx_Avatar")
					cash_Value = rsStandings("cash_Value")
					share_Value = rsStandings("share_Value")
					net_Worth = rsStandings("net_Worth")
%>
						<li>
							<a href="/portfolio/<%= QBLink(qbx_Name) %>/">
								<img src="/build/img/users/<%= qbx_Avatar %>" class="img-circle" width="35" style="border: solid 1px #fff; float: left;" />
								<div class="menu-info">
									<h4 class="control-sidebar-subheading"><b><%= qbx_Name %></b></h4>
									<p style="overflow: hidden; font-size: 12px; color: #fff;"><%= FormatCurrency(net_Worth) %></p>
								</div>
							</a>
						</li>
<%
					
					rsStandings.MoveNext
					
					i = i + 1
					
				Loop
				
				rsStandings.Close
				Set rsStandings = Nothing
%>
			</ul>
			
		</div>
		
		<div class="tab-pane" id="control-sidebar-portfolio-tab">
			
			<h3 class="control-sidebar-heading" style="padding-top: 0; margin-top: 10px; margin-bottom: 5px;">Your Portfolio</h3>
			<ul class="control-sidebar-menu">
<%
				sqlGetPortfolio = "SELECT samelevel.qbx_holdings.holding_ID, samelevel.qbx_holdings.qb_ID, samelevel.qbx_quarterbacks.qb_Name, samelevel.qbx_quarterbacks.qb_StockPrice, samelevel.qbx_holdings.share_Total AS qb_ShareCount, samelevel.qbx_holdings.share_Total * samelevel.qbx_quarterbacks.qb_StockPrice AS qb_CashValue FROM samelevel.qbx_portfolios INNER JOIN samelevel.qbx_holdings ON samelevel.qbx_holdings.portfolio_ID = samelevel.qbx_portfolios.portfolio_ID INNER JOIN samelevel.qbx_quarterbacks ON samelevel.qbx_quarterbacks.qb_ID = samelevel.qbx_holdings.qb_ID WHERE samelevel.qbx_portfolios.user_ID = " & Session.Contents("QBX_ID") & " AND samelevel.qbx_portfolios.portfolio_ID = " & Session.Contents("QBX_Current_Portfolio_ID") & " AND samelevel.qbx_holdings.share_Total > 0 ORDER BY qb_CashValue DESC"
				Set rsPortfolio = sqlSameLevel.Execute(sqlGetPortfolio)
				
				Do While Not rsPortfolio.Eof
%>
						<li>
							<a href="/quarterbacks/<%= QBLink(rsPortfolio("qb_Name")) %>/">
								<div style="padding-bottom: 3px; border-bottom: 1px solid #111619;">
								<img src="/build/img/profile/<%= QBLink(rsPortfolio("qb_Name")) %>.png" height="40" style="float: left; margin-top: 0px; padding-right: 5px;" />
								<div class="menu-info" style="padding-top: 5px;">
									<h4 class="control-sidebar-subheading"><b><%= rsPortfolio("qb_Name") %></b></h4>
									<p style="overflow: hidden; font-size: 12px; color: #fff;"><%= FormatCurrency(rsPortfolio("qb_CashValue")) %></p>
								</div>
								</div>
							</a>
						</li>
<%
					
					rsPortfolio.MoveNext
					
					i = i + 1
					
				Loop
				
				rsPortfolio.Close
				Set rsPortfolio = Nothing
%>
			</ul>
			
		</div>
		
	</div>
	
</aside>

<div class="control-sidebar-bg"></div>