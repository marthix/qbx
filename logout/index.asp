<%@ LANGUAGE="VBScript" %>
<!--#include virtual="/adovbs.inc"-->
<%
	'KILL SESSION
	Session.Abandon
	
	'KILL COOKIES
	For Each cookie in Response.Cookies
		Response.Cookies(cookie).Expires = DateAdd("d",-1,now())
	Next
	
	'SEND TO LOGIN SCREEN
	Response.Redirect("/login/")
%>