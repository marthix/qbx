<script>
$(function () {
	
	$("#listHoldings").dataTable(
		{
			"paging": false,
			"info": false,
			"searching": false
		}
	);
	
	$("#listTransactions").dataTable(
		{
			"lengthMenu": [[10, 25, 50], [10, 25, 50]],
			"order": [[ 1, "desc" ]]
		}
	);
	
	var chart_options = {
		scaleOverride : true,
		scaleSteps : 10,
		scaleStepWidth : 20000,
		scaleStartValue : 0,
		scaleShowGridLines: true,
		scaleGridLineColor: "rgba(0,0,0,.05)",
		scaleGridLineWidth: 1,
		scaleShowHorizontalLines: true,
		scaleShowVerticalLines: true,
		bezierCurve: true,
		bezierCurveTension: 0.3,
		pointDot: true,
		pointDotRadius: 3,
		pointDotStrokeWidth: 1,
		pointHitDetectionRadius: 5,
		datasetStroke: true,
		datasetStrokeWidth: 3,
		datasetFill: true,
		maintainAspectRatio: false,
		responsive: true
	};
	
	var portfolio_History = $("#Portfolio_History").get(0).getContext("2d");
	var portfolio_History = new Chart(portfolio_History);
	
<%
		If viewPortfolio = 1 Then
			this_Portfolio_ID = Session.Contents("QBX_View_User_ID")
		Else
			this_Portfolio_ID = Session.Contents("QBX_ID")
		End If
		
		Response.Write("var portfolio_History_data = {labels:[")
		
			WeekCount = 1
			Do While WeekCount <= CInt(Session.Contents("QBX_Current_Week"))
			
				Response.Write("""" & WeekCount & """")
				WeekCount = WeekCount + 1
				If WeekCount <= Session.Contents("QBX_Current_Week") Then Response.Write(",")
			
			Loop
		
		Response.Write("],")
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointStrokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointHighlightFill: ""#000"",")
				Response.Write("pointHighlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetDataCount = "SELECT COUNT(*) AS TotalRecords FROM samelevel.qbx_portfolios WHERE user_ID = " & this_Portfolio_ID
					Set rsDataCount = sqlSameLevel.execute(sqlGetDataCount)
					
					If Not rsDataCount.Eof Then
					
						TotalRecords = CInt(rsDataCount("TotalRecords"))
						
						rsDataCount.Close
						Set rsDataCount = Nothing
					
					End If
					
					MissedRecords = CInt(Session.Contents("QBX_Current_Week")) - TotalRecords
					
					Do While MissedRecords > 0
					
						Response.Write("""10000""")
						MissedRecords = MissedRecords - 1
						If MissedRecords >= 0 Then Response.Write(",")
					
					Loop
					
					sqlGetData = "SELECT *, ROUND(cash_Value + share_Value, 2) AS NetWorth FROM samelevel.qbx_portfolios WHERE user_ID = " & this_Portfolio_ID & " ORDER BY date_Calculated asc"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("NetWorth") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(",")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
	
	var portfolio_History_Chart = portfolio_History.Line(portfolio_History_data, chart_options);
	
	//alert(<%= MissedRecords %>);
	
});

	
</script>