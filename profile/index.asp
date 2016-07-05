<!DOCTYPE html>
<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/framework/user.asp"-->
<!--#include virtual="/build/asp/framework/headers.asp"-->
<%
	thisPage = "Profile"
	If Request.Form("action") = "contact" Then
	
		throwError = 0
		TeamName = Request.Form("TeamName")
		Email = Request.Form("Email")
		
		If InStr(TeamName, "'") Then TeamName = Replace(TeamName, "'", "")
		
		sqlCheckExisting = "SELECT * FROM qbx_users WHERE qbx_ID <> " & Session.Contents("QBX_ID") & " AND qbx_Email = '" & Email & "'"
		Set rsExisting   = sqlSameLevel.Execute(sqlCheckExisting)
		
		If Not rsExisting.Eof Then
		
			throwError = 1
			errorEmail = "E-Mail address already in use."
			
			rsExisting.Close
			Set rsExisting = Nothing
			
			Response.Redirect("/profile/?error=email")
		
		End If
		
		sqlCheckExisting = "SELECT * FROM qbx_users WHERE qbx_ID <> " & Session.Contents("QBX_ID") & " AND qbx_Name = '" & TeamName & "'"
		Set rsExisting   = sqlSameLevel.Execute(sqlCheckExisting)
		
		If Not rsExisting.Eof Then
		
			throwError = 1
			errorTeam = "Team name already in use."
			
			rsExisting.Close
			Set rsExisting = Nothing
			
			Response.Redirect("/profile/?error=team")
		
		End If
		
		If throwError = 0 Then
		
			sqlUpdateUser = "UPDATE qbx_users SET qbx_Name = '" & TeamName & "', qbx_Email = '" & Email & "' WHERE qbx_ID = " & Session.Contents("QBX_ID")
			Set rsUpdate  = sqlSameLevel.Execute(sqlUpdateUser)
			
			'SET SESSION & COOKIES
			Session.Contents("QBX_Name") = TeamName
			Session.Contents("QBX_Email") = Email
			
			Response.Cookies("QBX_Name") = TeamName
			Response.Cookies("QBX_Email") = Email
			
			Response.Cookies("QBX_Name").Expires = Date() + 365
			Response.Cookies("QBX_Email").Expires = Date() + 365
			
			Response.Redirect("/profile/?updated=contact")
			
		End If
		
	End If
	
	If Request.Form("action") = "password" Then
	
		throwError = 0
		Password = CStr(Request.Form("Password"))
		Password2 = CStr(Request.Form("Password2"))
		
		If CStr(Password) <> CStr(Password2) Then
		
			throwError = 1
			errorPassword = "Passwords don't match."
			Response.Redirect("/profile/?error=password")
		
		End If
		
		If throwError = 0 Then
		
			sqlUpdateUser = "UPDATE qbx_users SET qbx_Password = '" & GetEncodedPassword(Password) & "' WHERE qbx_ID = " & Session.Contents("QBX_ID")
			Set rsUpdate  = sqlSameLevel.Execute(sqlUpdateUser)
			
			Session.Contents("QBX_Password") = GetEncodedPassword(Password)
			
			Response.Cookies("QBX_Password") = encodedPassword
			Response.Cookies("QBX_Password").Expires = Date() + 365
			
			Response.Redirect("/profile/?updated=password")
			
		End If
	
	End If

%>
<html>
	
	<head>
		
		<title>Profile - The Quarterback Exchange</title>
		
		<meta charset="UTF-8">
		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
		
		<link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		<link href="/build/css/main.css" rel="stylesheet" type="text/css" />
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
		<link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
		
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

	</head>
	
	<body class="sidebar-mini skin-green">
	
		<div class="wrapper">
		
			<!--#include virtual="/build/asp/framework/navbar.asp"-->
			
			<!--#include virtual="/build/asp/framework/sidebar.asp"-->
			
			<div class="content-wrapper">
			
				<section class="content-header">
					<h1>Profile Settings</h1>
					<ol class="breadcrumb">
						<li><a href="/"><i class="fa fa-dashboard"></i> Dashboard</a></li>
						<li class="active"><a href="/profile/"><i class="fa fa-cogs"></i> Profile</a></li>
					</ol>
				</section>
				
				<section class="content">
				
					<div class="row">
					
						<div class="col-lg-9">
							
							<div class="box box-warning">

								<div class="box-header with-border">
									<i class="fa fa-user"></i>
									<h3 class="box-title">Update Contact Information</h3>
								</div>
							
								<form action="/profile/" method="post">
								
									<input type="hidden" name="action" value="contact" />
								
									<div class="box-body">
										<div class="form-group">
											<label for="TeamName">Team Name</label>
											<input type="text" class="form-control" name="TeamName" value="<%= Session.Contents("QBX_Name") %>">
										</div>
										<div class="form-group">
											<label for="Email">E-Mail Address</label>
											<input type="email" class="form-control" name="Email" value="<%= Session.Contents("QBX_Email") %>">
										</div>
										<div>
<%
											If Request.QueryString("updated") = "contact" Then Response.Write("<span class=""text-green""><i class=""fa fa-check""></i> <b>Contact Information Updated</b></span>")
%>
										</div>
									</div>
																	
									<div class="box-footer">
										<button type="submit" class="btn btn-primary">Submit New Contact Information</button>
									</div>
								
								</form>

							
							</div>
							
							<div class="box box-warning">

								<div class="box-header with-border">
									<i class="fa fa-lock"></i>
									<h3 class="box-title">Modify Password</h3>
								</div>
							
								<form action="/profile/" method="post">
								
									<input type="hidden" name="action" value="password" />
								
									<div class="box-body">
										<div class="form-group">
											<label for="Password">New Password</label>
											<input type="password" class="form-control" name="Password">
										</div>
										<div class="form-group">
											<label for="Password2">Confirm New Password</label>
											<input type="password" class="form-control" name="Password2">
										</div>
										<div>
<%
											If Request.QueryString("updated") = "password" Then Response.Write("<span class=""text-green""><i class=""fa fa-check""></i> <b>Password Updated</b></span>")
											If Request.QueryString("error") = "password" Then Response.Write("<span class=""text-red""><i class=""fa fa-cancel""></i> <b>Passwords don't match</b></span>")
%>
										</div>
									</div>
																	
									<div class="box-footer">
										<button type="submit" class="btn btn-primary">Submit New Password</button>
									</div>
								
								</form>
							
							</div>
							
						</div>
					
						<div class="col-lg-3">
							
							<div class="box box-warning">

								<div class="box-header with-border">
									<i class="fa fa-file-image-o"></i>
									<h3 class="box-title">Update Avatar</h3>
								</div>
							
								<form action="/build/asp/upload-avatar.asp" method="post" enctype="multipart/form-data">
								
									<input type="hidden" name="action" value="avatar" />
								
									<div class="box-body">
										<div class="form-group">
											
											<div><img src="/build/img/users/<%= Session.Contents("QBX_Avatar") %>" width="160" style="padding-top: 5px;" /></div><br>
											
											<div>
												<label for="Avatar">Select New Image</label>
												<input type="file" name="Avatar">
												<div style="padding-top: 5px;"><i>160 x 160 pixels</i></div>
<%
												If Request.QueryString("updated") = "avatar" Then Response.Write("<span class=""text-green""><i class=""fa fa-check""></i> <b>Avatar Updated!</b></span>")
												If Request.QueryString("error") = "avatar-size" Then Response.Write("<span class=""text-red""><i class=""fa fa-cancel""></i> <b>Avatar must be 160x160</b></span>")
												If Request.QueryString("error") = "avatar-type" Then Response.Write("<span class=""text-red""><i class=""fa fa-cancel""></i> <b>Avatar must be JPG, GIF, or PNG</b></span>")
%>
											</div>
											
										</div>
									</div>
																	
									<div class="box-footer">
										<button type="submit" class="btn btn-primary">Submit New Avatar</button>
									</div>
								
								</form>
							
							</div>
							
						</div>
					
					</div>
					
				</section>
				
			</div>
			
			<!--#include virtual="/build/asp/framework/footer.asp"-->
			
			<!--#include virtual="/build/asp/framework/recent.asp"-->
			
		</div>
		
		<script src="/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
		<script src="/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="/build/js/app.min.js" type="text/javascript"></script>
		<script src="/plugins/fastclick/fastclick.min.js" type="text/javascript"></script>
		<script src="/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
		
		<!--#include virtual="/build/asp/framework/google.asp"-->	

</body>
	
</html>