<aside class="main-sidebar">

	<section class="sidebar">
	
		<a href="/profile/" style="color: #fff;" >
		
			<div class="user-panel">
				<div class="pull-left image">
					<img src="/build/img/users/<%= Session.Contents("QBX_Avatar") %>" class="img-circle" style="border: solid 1px #fff;" />
				</div>
				<div class="pull-left info">
					<p><%= Session.Contents("QBX_Name") %></p>
					<p style="color: #f39c12; opacity: 0.7;"><%= Session.Contents("QBX_Email") %></p>
				</div>
			</div>
			
		</a>

		<ul class="sidebar-menu">
			
			<li class="header">NAVIGATION</li>
			<li <% If thisPage = "Dashboard" Then %>class="active"<% End If %>><a href="/"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>
			<li <% If thisPage = "Portfolio" Then %>class="active"<% End If %>><a href="/portfolio/"><i class="fa fa-bar-chart"></i> <span>Portfolio</span></a></li>
			<li <% If thisPage = "Quarterbacks" Then %>class="active"<% End If %>><a href="/quarterbacks/"><i class="fa fa-users"></i> <span>Quarterbacks</span></a></li>
			<li <% If thisPage = "Transactions" Then %>class="active"<% End If %>><a href="/transactions/"><i class="fa fa-retweet"></i> <span>Transactions</span></a></li>
			<li <% If thisPage = "Leaderboard" Then %>class="active"<% End If %>><a href="/leaderboard/"><i class="fa fa-trophy"></i> <span>Leaderboard</span></a></li>
			<!--<li <% If thisPage = "Games" Then %>class="active"<% End If %>><a href="/games/"><i class="fa fa-database"></i> <span>Game Data</span></a></li>-->
			
			<li class="header">NOTIFICATIONS</li>
			<li><a href="#"><i class="fa fa-circle-o text-red"></i> <span><b>Last Price Update:</b><br />Monday, January 18th</span></a></li>
			<li><a href="#"><i class="fa fa-circle-o text-yellow"></i> <span><b>Next Price Update:</b><br />Monday, January 25th</span></a></li>
			<li><a href="#"><i class="fa fa-circle-o text-aqua"></i> <span><b>Current Price Week:</b><br />Week 20 [2015 Season]</span></a></li>
			
			<li class="header">CONTROL PANEL</li>
			<li><a href="/profile/"><i class="fa fa-cogs"></i> <span>Account Settings</span></a></li>
			<li><a href="/logout/"><i class="fa fa-sign-out"></i> <span>Logout</span></a></li><br />
			
		</ul>
		
	</section>
	
</aside>