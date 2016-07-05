<!DOCTYPE html>
<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/headers.asp"-->
<%
	If Request.Form("action") = "submit" Then
	
		login_email = Request.Form("login_email")
		login_password = Request.Form("login_password")
		login_remember = Request.Form("login_remember")
		encodedPassword = GetEncodedPassword(login_password)
		
		sqlCheckLogin = "SELECT * FROM qbx_users WHERE qbx_email = '" & login_email & "' and qbx_password = '" & encodedPassword & "'"
		Set rsLogin   = sqlSameLevel.Execute(sqlCheckLogin)
		
		If Not rsLogin.Eof Then
		
			'SET SESSION
			Session.Contents("QBX_Status") = "logged_in"
			Session.Contents("QBX_ID") = rsLogin("qbx_ID")
			Session.Contents("QBX_Name") = rsLogin("qbx_Name")
			Session.Contents("QBX_Email") = rsLogin("qbx_Email")
			Session.Contents("QBX_Avatar") = rsLogin("qbx_Avatar")
			Session.Contents("QBX_Password") = encodedPassword
			
			sqlGetCurrent = "SELECT * FROM qbx_Current"
			Set rsCurrent = sqlSameLevel.Execute(sqlGetCurrent)
			
			If Not rsCurrent.Eof Then
			
				Session.Contents("QBX_Current_Week") = rsCurrent("qbx_Current_Week")
				Session.Contents("QBX_Current_Year") = rsCurrent("qbx_Current_Week")
				rsCurrent.Close
				Set rsCurrent = Nothing
			
			End If
			
			If login_remember = "on" Then
				Response.Cookies("QBX_ID") = rsLogin("qbx_ID")
				Response.Cookies("QBX_Name") = rsLogin("qbx_Name")
				Response.Cookies("QBX_Email") = rsLogin("qbx_Email")
				Response.Cookies("QBX_Password") = encodedPassword
				
				Response.Cookies("QBX_ID").Expires = Date() + 365
				Response.Cookies("QBX_Name").Expires = Date() + 365
				Response.Cookies("QBX_Email").Expires = Date() + 365
				Response.Cookies("QBX_Password").Expires = Date() + 365
			End If
			
			Response.Redirect("/")
			
		Else
		
			'BAD LOGIN
			
		End If
	
	End If
%>
<html>

	<head>
		
		<title>The Quarterback Exchange - Same Level Fantasy Sports</title>
		
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
			
				<form action="/login/" method="post">
				
					<input type="hidden" name="action" value="submit" />
					
					<div class="form-group has-feedback">
						<input id="login_email" name="login_email" type="email" class="form-control" placeholder="E-Mail" required />
						<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
					</div>
					
					<div class="form-group has-feedback">
						<input id="login_password" name="login_password" type="password" class="form-control" placeholder="Password" required />
						<span class="glyphicon glyphicon-lock form-control-feedback"></span>
					</div>
					
					<div class="row">
						
						<div class="col-xs-12">
							<button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
						</div>
						
					</div>
					
					<div class="row">
					
						<div class="col-xs-6" style="padding-top: 10px;">
							<a href="/register/" class="text-center">Register Account</a>
						</div>
						<div class="col-xs-6">
							<div class="checkbox icheck">
								<label><input type="checkbox" name="login_remember" id="login_remember"> Remember Me</label>
							</div>
						</div>
						
					</div>
					
				</form>
				
			</div>
			
			<div style="text-align: center; margin-top: 40px; color: #000; font-weight: bold; opacity: 0.5;">&copy; 2015 SAME LEVEL FANTASY SPORTS</div>
			
		</div>
		
		<script src="/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
		<script src="/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
		
		<script>
		
			$(function () {
				$('input').iCheck({ checkboxClass: 'icheckbox_square-blue', radioClass: 'iradio_square-blue', increaseArea: '20%' });
			});
		
		</script>
		
		<!--#include virtual="/build/asp/framework/google.asp"-->	

	</body>
	
</html>