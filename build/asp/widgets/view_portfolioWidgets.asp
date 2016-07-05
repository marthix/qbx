<%
	sqlGetPortfolio = "SELECT portfolio_ID, cash_Value, share_Value, cash_Value + share_Value AS net_Worth FROM samelevel.qbx_portfolios WHERE samelevel.qbx_portfolios.user_ID =  " & Session.Contents("QBX_View_User_ID") & " AND is_Current = 1 ORDER BY date_Calculated DESC LIMIT 1"
	Set rsPortfolio = sqlSameLevel.Execute(sqlGetPortfolio)
	
	share_Value = FormatCurrency(rsPortfolio("share_Value"), 2)
	cash_Value = FormatCurrency(rsPortfolio("cash_Value"), 2)
	net_Worth = FormatCurrency(rsPortfolio("net_Worth"), 2)
	portfolio_ID = rsPortfolio("portfolio_ID")
	Session.Contents("QBX_View_Portfolio_ID") = portfolio_ID
	
	share_Value_Percentage = FormatNumber(((share_Value * 100) / net_Worth), 2)
	cash_Value_Percentage = FormatNumber(((cash_Value * 100) / net_Worth), 2)
	
	sqlGetBetterTeamCount = "SELECT COUNT(portfolio_ID) AS BetterCount FROM samelevel.qbx_portfolios WHERE portfolio_ID <> " & portfolio_ID & " AND samelevel.qbx_portfolios.is_Current = 1 AND (cash_Value + share_Value) > " & rsPortfolio("net_Worth")
	Set rsBetterTeamCount = sqlSameLevel.Execute(sqlGetBetterTeamCount)
	
	CurrentStanding = CInt(rsBetterTeamCount("BetterCount")) + 1
	
	If Right(CurrentStanding, 1) = 1 Then CurrentStandingDisplay = CurrentStanding & "st Place"
	If Right(CurrentStanding, 1) = 2 Then CurrentStandingDisplay = CurrentStanding & "nd Place"
	If Right(CurrentStanding, 1) > 2 Then CurrentStandingDisplay = CurrentStanding & "th Place"
	If Right(CurrentStanding, 1) = 3 Then CurrentStandingDisplay = CurrentStanding & "rd Place"
	If Right(CurrentStanding, 1) = 0 Then CurrentStandingDisplay = CurrentStanding & "th Place"
	If CurrentStanding = 11 Then CurrentStandingDisplay = CurrentStanding & "th Place"
	If CurrentStanding = 12 Then CurrentStandingDisplay = CurrentStanding & "th Place"
	If CurrentStanding = 13 Then CurrentStandingDisplay = CurrentStanding & "th Place"
	
	rsPortfolio.Close
	Set rsPortfolio = Nothing
	
	rsBetterTeamCount.Close
	Set rsBetterTeamCount = Nothing
	
	sqlGetPreviousNetWorth = "SELECT ROUND(cash_Value + share_Value, 2) AS NetWorth FROM samelevel.qbx_portfolios WHERE user_ID = " & Session.Contents("QBX_View_User_ID") & " AND is_Current = 0 ORDER BY date_Calculated desc LIMIT 1"
	Set rsPreviousNetWorth = sqlSameLevel.Execute(sqlGetPreviousNetWorth)
	
	If Not rsPreviousNetWorth.Eof Then
	
		previous_NetWorth = rsPreviousNetWorth("NetWorth")
		rsPreviousNetWorth.Close
		Set rsPreviousNetWorth = Nothing
		
		change_NetWorth = Round((net_Worth * 100) / previous_NetWorth, 0) - 100
		
	End If
%>
	<div class="row">
	
		<div class="col-md-3 col-sm-12 col-xs-12">
		
			<div class="info-box bg-blue">
			
				<span class="info-box-icon"><img src="/build/img/users/<%= Session.Contents("QBX_View_User_Avatar") %>" align="center" width="75%" class="img-circle" style="margin-top: -10px; padding-top: 0; border: 1px solid #fff;" /></span>
				<div class="info-box-content">
					<span class="info-box-text"><%= Session.Contents("QBX_View_User_Name") %></span>
					<span class="info-box-number"><%= CurrentStandingDisplay %></span>
					<div class="btn-group" style="margin-top: 7px;">
						<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" style="padding: 2px; padding-top: 0px; padding-bottom: 1px; padding-left: 5px; padding-right: 5px;">
							<div style="padding-right: 5px; padding-top: 2px; float: left; font-size: 12px;">SELECT A TEAM</div>
							<span class="caret"></span>
							<span class="sr-only">Toggle Dropdown</span>
						</button>
						<ul class="dropdown-menu" role="menu">
<%
							sqlGetAllUsers = "SELECT * FROM qbx_users ORDER BY qbx_Name ASC"
							Set rsAllUsers = sqlSameLevel.Execute(sqlGetAllUsers)
							
							Do While Not rsAllUsers.Eof
							
								Response.Write("<li><a href=""/portfolio/" & QBLink(rsAllUsers("qbx_Name")) & "/"">" & rsAllUsers("qbx_Name") & "</a></li>")
								
								rsAllUsers.MoveNext
							
							Loop
							
							rsAllUsers.Close
							Set rsAllUsers = Nothing
%>
						</ul>
					</div>
				</div>
				
			</div>
		
		</div>
		
		<div class="col-md-3 col-sm-12 col-xs-12">
		
			<div class="info-box bg-red">
			
				<span class="info-box-icon"><i class="fa fa-group"></i></span>
				<div class="info-box-content">
					<span class="info-box-text">SHARE VALUE</span>
					<span class="info-box-number"><%= share_Value %></span>
					<div class="progress">
						<div class="progress-bar" style="width: <%= share_Value_Percentage %>%"></div>
					</div>
					<span class="progress-description"><%= share_Value_Percentage %>% of Net Worth</span>
				</div>
				
			</div>
		
		</div>
		
		<div class="col-md-3 col-sm-12 col-xs-12">
		
			<div class="info-box bg-yellow">
			
				<span class="info-box-icon"><i class="fa fa-money"></i></span>
				<div class="info-box-content">
					<span class="info-box-text">AVAILABLE CASH</span>
					<span class="info-box-number"><%= cash_Value %></span>
					<div class="progress">
						<div class="progress-bar" style="width: <%= cash_Value_Percentage %>%"></div>
					</div>
					<span class="progress-description"><%= cash_Value_Percentage %>% of Net Worth</span>
				</div>
				
			</div>
		
		</div>
		
		<div class="col-md-3 col-sm-12 col-xs-12">
		
			<div class="info-box bg-purple">
			
				<span class="info-box-icon"><i class="fa fa-bank"></i></span>
				<div class="info-box-content">
					<span class="info-box-text">NET WORTH</span>
					<span class="info-box-number"><%= net_Worth %></span>
					<div class="progress">
						<div class="progress-bar" style="width: <%= change_NetWorth %>%"></div>
					</div>
					<span class="progress-description"><%= change_NetWorth %>% Weekly <% If change_NetWorth < 0 Then %>Decrease<% Else %>Increase<% End If %></span>
				</div>
				
			</div>
		
		</div>
		
	</div>