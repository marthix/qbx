<%
	strMonth=MONTHNAME(MONTH(DATE))
		MonthNo=MONTH(DATE)
		DayNo=DAY(DATE)
		YearNo=YEAR(DATE)

		'----- Physical Days in Month (Thru Dec 2011) -----

	   	SELECT Case MonthNo
	 		Case 1, 3, 5, 7, 8, 10, 12
	  			DaysinMonth=31
	 		Case 2
				IF YearNo=2004 OR YearNo=2008 OR YearNo=2012 OR YearNo=2016 OR YearNo=2020 THEN
					DaysinMonth=29
				ELSE
					DaysinMonth=28
				END IF
			Case 4, 6, 9, 11
				DaysinMonth=30
		END SELECT
		Holidays="#7/4/2003#, #9/1/2003#, #11/27/2003#, #12/25/2003#, #1/1/2004#, #5/31/2004#, #7/5/2004#, #9/6/2004#, #11/25/2004#, #11/26/2004#, #12/24/2004#, #12/31/2004#, #5/30/2005#, #7/4/2005#, #9/5/2005#, #11/24/2005#, #11/25/2005#, #12/26/2005#, #12/27/2005#, #12/28/2005#, #12/29/2005#, #12/30/2005#, #1/2/2006#, #5/29/2006#, #7/4/2006#, #9/4/2006#, #11/23/2006#, #11/24/2006#, #12/25/2006#, #12/26/2006#, #12/27/2006#, #12/28/2006#, #12/29/2006#, #1/1/2007#, #7/4/2007#, #9/3/2007#, #11/22/2007#, #11/23/2007#, #12/24/2007#, #12/25/2007#, #12/26/2007#, #12/27/2007#, #12/28/2007#, #1/1/2008#, #5/26/2008#, #7/4/2008#, #9/1/2008#, #11/27/2008#, #11/28/2008#, #12/25/2008#, #12/26/2008#, #12/29/2008#, #12/30/2008#, #12/31/2008#, #1/1/2009#, #1/2/2009#, #5/25/2009#, #7/3/2009#, #9/7/2009#, #11/26/2009#, #11/27/2009#, #12/25/2009#, #12/28/2009#, #12/29/2009#, #12/30/2009#, #12/31/2009#, #1/1/2010#, #5/31/2010#, #7/5/2010#, #9/6/2010#, #11/25/2010#, #11/26/2010#, #12/27/2010#, #12/28/2010#, #12/29/2010#, #12/30/2010#, #12/31/2010#, #1/1/2011#, #5/30/2011#, #7/4/2011#, #9/5/2011#, #11/24/2011#, #11/25/2011#, #12/26/2011#, #12/27/2011#, #12/28/2011#, #12/29/2011#, #12/30/2011#, #1/2/2012#, #5/28/2012#, #7/4/2012#, #9/3/2012#, #11/22/2012#, #11/23/2012#, #12/24/2012#, #12/25/2012#, #12/26/2012#, #12/27/2012#, #12/28/2012#, #1/1/2013#, #5/27/2013#, #7/4/2013#, #9/2/2013#, #11/28/2013#, #11/29/2013#, #12/25/2013#, #12/26/2013#, #12/27/2013#, #12/30/2013#, #12/31/2013#, #1/1/2014#, #5/26/2014#, #7/4/2014#, #9/1/2014#, #11/27/2014#, #11/28/2014#, #12/25/2014#, #12/26/2014#, #12/29/2014#, #12/30/2014#, #12/31/2014#, #1/1/2015#, #5/25/2015#, #7/3/2015#, #7/4/2015#, #9/7/2015#, #11/26/2015#, #12/25/2015#, #1/1/2016#, #5/30/2016#, #7/4/2016#, #9/5/2016#, #11/24/2016#, #12/25/2016#"

		'------ Determine Total Working Days in Month ----------------

		StartDate=DATE+1-DAY(DATE)
		EndDate=MonthNo & "/" & DaysinMonth & "/" & Yearno	
				
		nLoop = DateDiff("d", StartDate,EndDate)  																	'calculate how many days to loop through

		For x = 0  To nLoop                          																	'loop those many days
			IF Weekday(StartDate)<>vbSaturday AND Weekday(StartDate)<>vbSunday AND INSTR(Holidays,"#" & StartDate & "#")=0 THEN		'Exclude Sat/Sun
				nTotalWorkDayCounter = nTotalWorkDayCounter + 1																	'Count Weekdays
			END IF
			StartDate = StartDate + 1																					'increment 1 day at a time
		Next
		
		'------ Determine Working Days Remaining ----------------

		StartDate=DATE
		EndDate=Monthno & "/" & DaysinMonth & "/" & Yearno	
				
		nLoop = DateDiff("d", StartDate,EndDate)  'calculate how many days to loop through

		For x = 0  To nLoop                          																	'loop those many days
			IF Weekday(StartDate)<>vbSaturday AND Weekday(StartDate)<>vbSunday AND INSTR(Holidays,"#" & StartDate & "#")=0 THEN		'Exclude Sat/Sun
				nWorkdayCounter = nWorkdayCounter + 1																	'Count Weekdays
			END IF
			StartDate = StartDate + 1																					'increment 1 day at a time
		Next
%>