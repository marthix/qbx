<!DOCTYPE html>
<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/headers.asp"-->
<%
	If Request.Form("action") = "submit" Then
	
		throwError = 0
		login_name = Request.Form("login_name")
		login_email = Request.Form("login_email")
		login_password = Request.Form("login_password")
		login_password_repeat = Request.Form("login_password_repeat")
		
		sqlCheckExisting = "SELECT * FROM qbx_users WHERE qbx_Email = '" & login_email & "'"
		Set rsExisting   = sqlSameLevel.Execute(sqlCheckExisting)
		
		If Not rsExisting.Eof Then
		
			throwError = 1
			errorEmail = "E-Mail address already in use."
			
			rsExisting.Close
			Set rsExisting = Nothing
		
		End If
		
		If login_password <> login_password_repeat Then
		
			throwError = 1
			errorPassword = "Passwords don't match."
		
		End If
		
		If throwError = 0 Then
		
			encodedPassword = GetEncodedPassword(login_password)
			
			sqlInsertUser = "INSERT INTO qbx_users (qbx_Name, qbx_Email, qbx_Password) VALUES ('" & login_name & "', '" & login_email & "', '" & encodedPassword & "')"
			Set rsInsert  = sqlSameLevel.Execute(sqlInsertUser)
			
			sqlGetNewID = "SELECT qbx_ID FROM qbx_users WHERE qbx_Email = '" & login_email & "' AND qbx_Password = '" & encodedPassword & "'"
			Set rsNewID = sqlSameLevel.Execute(sqlGetNewID)
			
			qbx_ID = rsNewID("qbx_ID")
			
			rsNewID.Close
			Set rsNewID = Nothing
			
			sqlInsertPortfolio = "INSERT INTO qbx_portfolios (user_ID, cash_Value, share_Value) VALUES (" & qbx_ID & ", 10000, 0)"
			Set rsInsert  = sqlSameLevel.Execute(sqlInsertPortfolio)
			
			sqlInsertDashboard = "INSERT INTO qbx_dashboard (dashboard_Type_ID, dashboard_Header) VALUES (1, '<a href=""/portfolio/" & QBLink(login_name) & "/"">" & login_name & "</a>')"
			Set rsInsert  = sqlSameLevel.Execute(sqlInsertDashboard)
			
			'SET SESSION & COOKIES
			Session.Contents("QBX_Status") = "logged_in"
			Session.Contents("QBX_ID") = qbx_ID
			Session.Contents("QBX_Name") = login_name
			Session.Contents("QBX_Email") = login_email
			Session.Contents("QBX_Avatar") = "default.jpg"
			
			Response.Cookies("QBX_ID") = qbx_ID
			Response.Cookies("QBX_Name") = login_name
			Response.Cookies("QBX_Email") = login_email
			
			Response.Cookies("QBX_ID").Expires = Date() + 365
			Response.Cookies("QBX_Name").Expires = Date() + 365
			Response.Cookies("QBX_Email").Expires = Date() + 365
			
			Response.Redirect("/")
			
		End If
	
	End If
%>
<html>

	<head>
		
		<title>Register - The Quarterback Exchange - Same Level Fantasy Sports</title>
		
		<meta charset="UTF-8" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
		
		<link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
		<link href="/build/css/main.css" rel="stylesheet" type="text/css" />
		<link href="/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
	
	</head>
	
	<body class="login-page">
	
		<div class="login-box">
		
			<div class="login-logo">
				<a href="/"><img src="/build/img/main-title.png" width="100%" style="max-width: 360px; margin-bottom: 20px;" /></a>
			</div>
			
			<div class="login-box-body">
<%
				If throwError = 1 Then
				
					If Len(errorEmail) > 0 Then Response.Write("<div>" & errorEmail & "</div>")
					If Len(errorPassword) > 0 Then Response.Write("<div>" & errorPassword & "</div>")				
				
				End If
%>
			
				<form action="/register/" method="post">
				
					<input type="hidden" name="action" value="submit" />
					
					<div class="form-group has-feedback">
						<input id="login_name" name="login_name" type="text" class="form-control" placeholder="Team Name" required />
						<span class="glyphicon glyphicon-user form-control-feedback"></span>
					</div>
					
					<div class="form-group has-feedback">
						<input id="login_email" name="login_email" type="email" class="form-control" placeholder="E-Mail" required />
						<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
					</div>
					
					<div class="form-group has-feedback">
						<input id="login_password" name="login_password" type="password" class="form-control" placeholder="Password" required />
						<span class="glyphicon glyphicon-lock form-control-feedback"></span>
					</div>
					
					<div class="form-group has-feedback">
						<input id="login_password_repeat" name="login_password_repeat" type="password" class="form-control" placeholder="Repeat Password" required />
						<span class="glyphicon glyphicon-lock form-control-feedback"></span>
					</div>
					
					<div class="row">
						
						<div class="col-xs-12">
							<button type="submit" class="btn btn-primary btn-block btn-flat">Register QB<sup>X</sup> Account</button>
						</div>
						
					</div>
					
				</form>
				
			</div>
			
		</div>
		
		<script src="/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
		<script src="/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
		
		<!--#include virtual="/build/asp/framework/google.asp"-->	

</body>
	
</html>