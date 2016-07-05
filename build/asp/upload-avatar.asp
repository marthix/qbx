<!--#include virtual="/adovbs.inc"-->
<!--#include virtual="/build/asp/functions.asp"-->
<!--#include virtual="/build/asp/sql.asp"-->
<!--#include virtual="/build/asp/shadow-upload.asp"-->
<%

	throwError = 0
		
	Set objUpload = New ShadowUpload
	
	If objUpload.GetError <> "" Then
	
		Response.Redirect("/profile/?error=avatar-type")
	
	Else  
	
		newAvatar = objUpload.File(0).FileName
		Set FileObject = Server.CreateObject("Scripting.FileSystemObject")
		FileCheck = 1
		
		Do While FileObject.FileExists(Server.MapPath("/build/img/users") & "\" & newAvatar)
		
			arAvatar = Split(newAvatar, ".")
			
			newFilename = arAvatar(0)
			newFileExt  = arAvatar(1)
			
			newAvatar = newFilename & FileCheck & "." & newFileExt
			
			FileCheck = FileCheck + 1
			
		Loop
		
		Set FileObject = Nothing
		
		If (objUpload.File(0).ImageWidth < 0) Then Response.Redirect("/profile/?error=avatar-type")
		If (objUpload.File(0).ImageWidth <> 160) Or (objUpload.File(0).ImageHeight <> 160) Then Response.Redirect("/profile/?error=avatar-size")
		
		Call objUpload.File(0).SaveToDisk(Server.MapPath("/build/img/users"), newAvatar)
		
		sqlUpdateUser = "UPDATE qbx_users SET qbx_Avatar = '" & newAvatar & "' WHERE qbx_ID = " & Session.Contents("QBX_ID")
		Set rsUpdate  = sqlSameLevel.Execute(sqlUpdateUser)
		
		Session.Contents("QBX_Avatar") = newAvatar
		
		Response.Redirect("/profile/?updated=avatar")
		
	End If
		
%>