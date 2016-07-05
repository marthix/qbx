<%

FUNCTION GetEncodedPassword (PasswordInput)

	Set this_asc = Server.CreateObject("System.Text.UTF8Encoding")
	Set enc = Server.CreateObject("System.Security.Cryptography.SHA1CryptoServiceProvider")

	bytes = this_asc.GetBytes_4(PasswordInput)
	bytes = enc.ComputeHash_2((bytes))

	encodedPassword = ""

	For pos = 1 To Lenb(bytes)
		encodedPassword = encodedPassword & LCase(Right("0" & Hex(Ascb(Midb(bytes, pos, 1))), 2))
	Next
	
	GetEncodedPassword = encodedPassword

END FUNCTION

FUNCTION MakeTotalTime(First, Second)
'-------- Divides the two time format numbers into parts: Hours, Minutes And Seconds ------
   	Firsth = Mid(First, 1, INSTR(First,":")-1)
   	Firstm = Mid(First, INSTR(First,":")+1, 2)
   	Firsts = Right(First, 2)
    Secondh = Left(Second, 2)
    Secondm = Mid(Second, 4, 2)
    Seconds = Right(Second, 2)

	'--------- Adds the numbers and makes sure that it will always be with two characters -------
    uth = CINT(Firsth) + CINT(Secondh)
    If Len(uth) = 1 Then 
    	uth = "0" & uth
	END IF
	utm = CINT(Firstm) + CINT(Secondm)
    If Len(utm) = 1 Then 
    	utm = "0" & utm
	END IF
	uts = CINT(Firsts) + CINT(Seconds)
    If Len(uts) = 1 Then 
    	uts = "0" & uts
    END IF

	'----------- If the Seconds are higher than 60 then add 1 to the Minutes and subtract 60 from the seconds -----
    If uts > 59 Then
        Do
            uts = CINT(uts) - 60
            If Len(uts) = 1 Then 
            	uts = "0" & uts
            END IF
            utm = CINT(utm) + 1
            If Len(utm) = 1 Then 
            	utm = "0" & utm
            END IF
        Loop Until uts <= 59
    End If

	'------------ If the Minutes are higher than 60 then add 1 to the Hours and subtract 60 from the Minutes -----
    If utm > 59 Then
        Do
            utm = CINT(utm) - 60
            If Len(utm) = 1 Then 
            	utm = "0" & utm
            END IF
            uth = CINT(uth) + 1
            If Len(uth) = 1 Then 
            	uth = "0" & uth
            END IF
       Loop Until utm <= 59
    End If

	'-------- Returns the Total Time ------------
    newTotal = uth & ":" & utm & ":" & uts
    MakeTotalTime = newTotal
END FUNCTION


FUNCTION CALChm()
	DHours=0
	DMins=0
	DMins=INT(RecordTxt(3)/60)
	
	Do WHILE DMins => 60 
		DMins=DMins - 60
		DHours=DHours + 1
	LOOP
	
	'-----Add a leading Zero if needed
	IF LEN(DHours)=1 THEN			
		DHours="0" & DHours
	END IF
		
	IF LEN(DMins)=1 THEN			
		DMins="0" & DMins
	END IF
	Session("Duration")=DHours&":"&DMins&":"
END FUNCTION

FUNCTION CALCs()
		'-----Get the Average Secs
		DSecs=INT(SDuration/60)
			
		'-----Get the minutes and seconds in sync
		DSecs=INT(SDuration/60)
		
		Do WHILE DSecs => 60 
			DSecs=DSecs - 60
		LOOP
			
		IF LEN(DSecs)=1 THEN
			DSecs="0" & DSecs
		END IF	
		
		Session("Duration")=Session("Duration")&DSecs
END FUNCTION

FUNCTION CALCavg()
	'-----Get the Averages
		aDMins=INT(aMDuration/60)
		aDSecs=INT(aSDuration/60)
			
		'-----Get the minustes and seconds in sync
		aDSecs=INT(aSDuration/60)
		
		Do WHILE aDSecs => 60 
				aDSecs=aDsecs - 60
				aDMins=aDMins + 1
		LOOP
			
		IF LEN(aDSecs)=1 THEN
			aDSecs="0" & aDSecs
		END IF	
		
		IF LEN(aDMins)=1 THEN
			aDMins="0" & aDMins
		END IF
		
		Session("avgDURATION")=aDMins&":"&aDSecs
END FUNCTION

Function PCase(strInput)
	
		Dim iPosition  ' Our current position in the string (First character = 1)
		Dim iSpace     ' The position of the next space after our iPosition
		Dim strOutput  ' Our temporary string used to build the function's output

		If InStr(strInput, "-") Then strInput = Replace(strInput, "-", " ")
		'If InStr(strInput, "~") Then strInput = Replace(strInput, "~", "-")
		
		iPosition = 1
	
		Do While InStr(iPosition, strInput, " ", 1) <> 0
			
			iSpace = InStr(iPosition, strInput, " ", 1)
		
			strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
			strOutput = strOutput & LCase(Mid(strInput, iPosition + 1, iSpace - iPosition))
			iPosition = iSpace + 1
			
		Loop
		
		strOutput = strOutput & UCase(Mid(strInput, iPosition, 1))
		strOutput = strOutput & LCase(Mid(strInput, iPosition + 1))
		
		'strOutput = PCaseDash(strOutput)
		
		PCase = strOutput
		
	End Function
	
Function IsEmailValid(strEmail) 
		
		blnIsItValid = True 
		strArray = Split(strEmail, "@") 
		
		If UBound(strArray) <> 1 Then
			blnIsItValid = False
			IsEmailValid = blnIsItValid
			Exit Function
		End If
		
		For Each strItem In strArray
			
			If Len(strItem) <= 0 Then
				blnIsItValid = False
				IsEmailValid = blnIsItValid
				Exit Function
			End If
			
			For i = 1 To Len(strItem)
				c = LCase(Mid(strItem, i, 1))
				If InStr("abcdefghijklmnopqrstuvwxyz_-.", c) <= 0 And Not IsNumeric(c) Then
					blnIsItValid = False
					IsEmailValid = blnIsItValid
					Exit Function
				End If
			Next
			
			If Left(strItem, 1) = "." Or Right(strItem, 1) = "." Then
				blnIsItValid = False
				IsEmailValid = blnIsItValid
				Exit Function
			End If
		
		Next
		
		If InStr(strArray(1), ".") <= 0 Then
			blnIsItValid = False
			IsEmailValid = blnIsItValid
			Exit Function
		End If
		
		i = Len(strArray(1)) - InStrRev(strArray(1), ".")
		
		If i <> 2 And i <> 3 And i <> 4 Then
			blnIsItValid = False
			IsEmailValid = blnIsItValid
			Exit Function
		End If
		
		If InStr(strEmail, "..") > 0 Then
			blnIsItValid = False
			IsEmailValid = blnIsItValid
			Exit Function
		End If
		
		IsEmailValid = blnIsItValid
	
	End Function
	
	Function QBLink (qb_Name)
	
		qb_SafeName = LCase(qb_Name)
		If InStr(qb_SafeName, ".") Then qb_SafeName = Replace(qb_SafeName, ".", "")
		If InStr(qb_SafeName, " ") Then qb_SafeName = Replace(qb_SafeName, " ", "-")
		
		
		QBLink = qb_SafeName
	
	End Function
%>