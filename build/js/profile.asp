<script>
$(function () {

	$("#buy_slide").slider({
		tooltip: 'hide'
	});
	$("#buy_slide").on("slide", function(slideEvt) {
		$("#buy_slide_value").text(slideEvt.value);
		$("#buy_total_cost").text(currencyFormat(slideEvt.value * <%= qb_Stock_Price %>));
	});
	
	$("#sell_slide").slider({
		tooltip: 'hide'
	});
	$("#sell_slide").on("slide", function(slideEvt) {
		$("#sell_slide_value").text(slideEvt.value);
		$("#sell_total_cost").text(currencyFormat(slideEvt.value * <%= qb_Stock_Price %>));
	});
	
	var chart_options = {
		scaleOverride : true,
		scaleSteps : 5,
		scaleStepWidth : 20,
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
	
	var canvas_2015 = $("#2015_Values").get(0).getContext("2d");
	var chart_2015 = new Chart(canvas_2015);
<%
		Response.Write("var chart_2015_data = {labels:[")
		
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
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2015 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					game_Count = 0
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						game_Count = game_Count + 1
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(",")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
	
	
	var canvas_2015_against_average = $("#2015_Values_Against_Average").get(0).getContext("2d");
	var chart_2015_against_average = new Chart(canvas_2015_against_average);
	var chart_2015_against_average_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("highlightFill: ""#fff"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2015 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("},")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""#ccc"",")
				Response.Write("strokeColor: ""#ccc"",")
				Response.Write("highlightFill: ""#ccc"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT average_Price FROM qbx_averages WHERE game_Year = 2015 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("average_Price") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	If played2014 = 1 Then
%>
	var canvas_2014 = $("#2014_Values").get(0).getContext("2d");
	var chart_2014 = new Chart(canvas_2014);
	var chart_2014_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointStrokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointHighlightFill: ""#fff"",")
				Response.Write("pointHighlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2014 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	End If
	
	If played2014 = 1 Then
%>
	var canvas_2014_against_average = $("#2014_Values_Against_Average").get(0).getContext("2d");
	var chart_2014_against_average = new Chart(canvas_2014_against_average);
	var chart_2014_against_average_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("highlightFill: ""#fff"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2014 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("},")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""#ccc"",")
				Response.Write("strokeColor: ""#ccc"",")
				Response.Write("highlightFill: ""#ccc"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT average_Price FROM qbx_averages WHERE game_Year = 2014 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("average_Price") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	End If
	
	If played2013 = 1 Then
%>
	var canvas_2013 = $("#2013_Values").get(0).getContext("2d");
	var chart_2013 = new Chart(canvas_2013);
	var chart_2013_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointStrokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointHighlightFill: ""#fff"",")
				Response.Write("pointHighlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2013 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	End If
	
	If played2013 = 1 Then
%>
	var canvas_2013_against_average = $("#2013_Values_Against_Average").get(0).getContext("2d");
	var chart_2013_against_average = new Chart(canvas_2013_against_average);
	var chart_2013_against_average_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("highlightFill: ""#fff"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2013 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("},")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""#ccc"",")
				Response.Write("strokeColor: ""#ccc"",")
				Response.Write("highlightFill: ""#ccc"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT average_Price FROM qbx_averages WHERE game_Year = 2013 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("average_Price") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	End If
	
	If played2012 = 1 Then
%>
	var canvas_2012 = $("#2012_Values").get(0).getContext("2d");
	var chart_2012 = new Chart(canvas_2012);
	var chart_2012_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointStrokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointHighlightFill: ""#fff"",")
				Response.Write("pointHighlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2012 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	End If
	
	If played2012 = 1 Then
%>
	var canvas_2012_against_average = $("#2012_Values_Against_Average").get(0).getContext("2d");
	var chart_2012_against_average = new Chart(canvas_2012_against_average);
	var chart_2012_against_average_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("highlightFill: ""#fff"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2012 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("},")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""#ccc"",")
				Response.Write("strokeColor: ""#ccc"",")
				Response.Write("highlightFill: ""#ccc"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT average_Price FROM qbx_averages WHERE game_Year = 2012 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("average_Price") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	End If
	
	If played2011 = 1 Then
%>
	var canvas_2011 = $("#2011_Values").get(0).getContext("2d");
	var chart_2011 = new Chart(canvas_2011);
	var chart_2011_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointStrokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointHighlightFill: ""#fff"",")
				Response.Write("pointHighlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2011 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	End If
	
	If played2011 = 1 Then
%>
	var canvas_2011_against_average = $("#2011_Values_Against_Average").get(0).getContext("2d");
	var chart_2011_against_average = new Chart(canvas_2011_against_average);
	var chart_2011_against_average_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("highlightFill: ""#fff"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2011 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("},")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""#ccc"",")
				Response.Write("strokeColor: ""#ccc"",")
				Response.Write("highlightFill: ""#ccc"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT average_Price FROM qbx_averages WHERE game_Year = 2011 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("average_Price") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	End If
	
	If played2010 = 1 Then
%>
	var canvas_2010 = $("#2010_Values").get(0).getContext("2d");
	var chart_2010 = new Chart(canvas_2010);
	var chart_2010_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointStrokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("pointHighlightFill: ""#fff"",")
				Response.Write("pointHighlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2010 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% 
	End If
	
	If played2010 = 1 Then
%>
	var canvas_2010_against_average = $("#2010_Values_Against_Average").get(0).getContext("2d");
	var chart_2010_against_average = new Chart(canvas_2010_against_average);
	var chart_2010_against_average_data = {labels:["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21",""],
<%
		Response.Write("datasets: [")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""rgba(60,141,188,0.5)"",")
				Response.Write("strokeColor: ""rgba(60,141,188,1)"",")
				Response.Write("highlightFill: ""#fff"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT * FROM qbx_prices WHERE qb_ID = " & Session.Contents("QBX_Current_QB_ID") & " AND game_Year = 2010 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("price_Value") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("},")
			Response.Write("{")
				Response.Write("label: """ & Session.Contents("QBX_Current_QB_Name") & """,")
				Response.Write("fillColor: ""#ccc"",")
				Response.Write("strokeColor: ""#ccc"",")
				Response.Write("highlightFill: ""#ccc"",")
				Response.Write("highlightStroke: ""rgba(60,141,188,1)"",")
				Response.Write("data: [")
				
					sqlGetData = "SELECT average_Price FROM qbx_averages WHERE game_Year = 2010 ORDER BY game_Week ASC"
					Set rsData = sqlSameLevel.execute(sqlGetData)
					
					Do While Not rsData.Eof
					
						Response.Write("""" & rsData("average_Price") & """")
						rsData.MoveNext
						If Not rsData.Eof Then Response.Write(", ")
					
					Loop
				
				Response.Write("]")
			Response.Write("}")
		Response.Write("]")
%>
	};
<% End If %>

	var qb_2015_Chart = chart_2015.Line(chart_2015_data, chart_options);
	<% If played2014 = 1 Then %>var qb_2014_Chart = chart_2014.Line(chart_2014_data, chart_options);<% End If %>
	<% If played2013 = 1 Then %>var qb_2013_Chart = chart_2013.Line(chart_2013_data, chart_options);<% End If %>
	<% If played2012 = 1 Then %>var qb_2012_Chart = chart_2012.Line(chart_2012_data, chart_options);<% End If %>
	<% If played2011 = 1 Then %>var qb_2011_Chart = chart_2011.Line(chart_2011_data, chart_options);<% End If %>
	<% If played2010 = 1 Then %>var qb_2010_Chart = chart_2010.Line(chart_2010_data, chart_options);<% End If %>
	
	var qb_2015_Chart_Against_Average = chart_2015_against_average.Bar(chart_2015_against_average_data, chart_options);
	<% If played2014 = 1 Then %>var qb_2014_Chart_Against_Average = chart_2014_against_average.Bar(chart_2014_against_average_data, chart_options);<% End If %>
	<% If played2013 = 1 Then %>var qb_2013_Chart_Against_Average = chart_2013_against_average.Bar(chart_2013_against_average_data, chart_options);<% End If %>
	<% If played2012 = 1 Then %>var qb_2012_Chart_Against_Average = chart_2012_against_average.Bar(chart_2012_against_average_data, chart_options);<% End If %>
	<% If played2011 = 1 Then %>var qb_2011_Chart_Against_Average = chart_2011_against_average.Bar(chart_2011_against_average_data, chart_options);<% End If %>
	<% If played2010 = 1 Then %>var qb_2010_Chart_Against_Average = chart_2010_against_average.Bar(chart_2010_against_average_data, chart_options);<% End If %>
	
});

function updateBuy() {
	
	document.getElementById("submitBuyLoading").style.display = "block";
	document.getElementById("submitBuyLoading").className = "overlay";
	
	setTimeout(3000);
	
	$.ajax({
		url: '/build/asp/ajax/updateBuy.asp',
		dataType: 'text',
		type: 'get',
		success: function( data, textStatus, jQxhr ){
			
			document.getElementById("submitBuyLoading").style.display = "none";
			document.getElementById("submitBuyLoading").className = "";
			
			$('#submitBuyBlock').html( data );
			$("#buy_slide").slider({
				tooltip: 'hide'
			});
			$("#buy_slide").on("slide", function(slideEvt) {
				$("#buy_slide_value").text(slideEvt.value);
				$("#buy_total_cost").text(currencyFormat(slideEvt.value * <%= qb_Stock_Price %>));
			});
			
		},
		error: function( jqXhr, textStatus, errorThrown ){ console.log( errorThrown ); }
	});
	
}

function submitBuy() {
	
	document.getElementById("submitBuyLoading").style.display = "block";
	document.getElementById("submitBuyLoading").className = "overlay";
	
	setTimeout(3000);
	
	$.ajax({
		url: '/build/asp/ajax/buyShares.asp',
		dataType: 'text',
		type: 'post',
		contentType: 'application/x-www-form-urlencoded',
		data: $("#submitBuyForm").serialize(),
		success: function( data, textStatus, jQxhr ){
			
			document.getElementById("submitBuyLoading").style.display = "none";
			document.getElementById("submitBuyLoading").className = "";
			
			$('#submitBuyBlock').html( data );
			
			$("#buy_slide").slider({
				tooltip: 'hide'
			});
			
			$("#buy_slide").on("slide", function(slideEvt) {
				$("#buy_slide_value").text(slideEvt.value);
				$("#buy_total_cost").text(currencyFormat(slideEvt.value * <%= qb_Stock_Price %>));
			});
			
			updateSell();
			updateHoldings();
			
			$('#successMessage').delay(3000).fadeOut();
			
		},
		error: function( jqXhr, textStatus, errorThrown ){ console.log( errorThrown ); }
	});
	
}

function updateSell() {
	
	document.getElementById("submitSellLoading").style.display = "block";
	document.getElementById("submitSellLoading").className = "overlay";
	
	setTimeout(3000);
	
	$.ajax({
		url: '/build/asp/ajax/updateSell.asp',
		dataType: 'text',
		type: 'get',
		success: function( data, textStatus, jQxhr ){
			
			document.getElementById("submitSellLoading").style.display = "none";
			document.getElementById("submitSellLoading").className = "";
			
			$('#submitSellBlock').html( data );
			$("#sell_slide").slider({
				tooltip: 'hide'
			});
			$("#sell_slide").on("slide", function(slideEvt) {
				$("#sell_slide_value").text(slideEvt.value);
				$("#sell_total_cost").text(currencyFormat(slideEvt.value * <%= qb_Stock_Price %>));
			});
			
		},
		error: function( jqXhr, textStatus, errorThrown ){ console.log( errorThrown ); }
	});
	
}

function submitSell() {
	
	document.getElementById("submitSellLoading").style.display = "block";
	document.getElementById("submitSellLoading").className = "overlay";
	
	setTimeout(3000);
	
	$.ajax({
		url: '/build/asp/ajax/sellShares.asp',
		dataType: 'text',
		type: 'post',
		contentType: 'application/x-www-form-urlencoded',
		data: $("#submitSellForm").serialize(),
		success: function( data, textStatus, jQxhr ){
			
			document.getElementById("submitSellLoading").style.display = "none";
			document.getElementById("submitSellLoading").className = "";
			
			$('#submitSellBlock').html( data );
			
			$("#sell_slide").slider({
				tooltip: 'hide'
			});
			
			$("#sell_slide").on("slide", function(slideEvt) {
				$("#sell_slide_value").text(slideEvt.value);
				$("#sell_total_cost").text(currencyFormat(slideEvt.value * <%= qb_Stock_Price %>));
			});
			
			updateBuy();
			updateHoldings();
			
			$('#sellMessage').delay(3000).fadeOut();
			
		},
		error: function( jqXhr, textStatus, errorThrown ){ console.log( errorThrown ); }
	});
	
}

function updateHoldings() {
	
	document.getElementById("submitHoldingsLoading").style.display = "block";
	document.getElementById("submitHoldingsLoading").className = "overlay";
	
	setTimeout(3000);
	
	$.ajax({
		url: '/build/asp/ajax/updateHoldings.asp',
		dataType: 'text',
		type: 'get',
		success: function( data, textStatus, jQxhr ){
			
			document.getElementById("submitHoldingsLoading").style.display = "none";
			document.getElementById("submitHoldingsLoading").className = "";
			
			$('#holdingsBlock').html( data );
			
		},
		error: function( jqXhr, textStatus, errorThrown ){ console.log( errorThrown ); }
	});
	
}

function submitSellEverything() {
	
	document.getElementById("submitHoldingsLoading").style.display = "block";
	document.getElementById("submitHoldingsLoading").className = "overlay";
	
	setTimeout(3000);
	
	$.ajax({
		url: '/build/asp/ajax/sellEverything.asp',
		dataType: 'text',
		type: 'post',
		contentType: 'application/x-www-form-urlencoded',
		data: $("#submitSellEverythingForm").serialize(),
		success: function( data, textStatus, jQxhr ){
			
			document.getElementById("submitHoldingsLoading").style.display = "none";
			document.getElementById("submitHoldingsLoading").className = "";
			
			$('#holdingsBlock').html( data );
			
			$("#sell_slide").slider({
				tooltip: 'hide'
			});
			
			$("#sell_slide").on("slide", function(slideEvt) {
				$("#sell_slide_value").text(slideEvt.value);
				$("#sell_total_cost").text(currencyFormat(slideEvt.value * <%= qb_Stock_Price %>));
			});
			
			updateBuy();
			updateSell();
			
			$('#sellMessage').delay(3000).fadeOut();
			
		},
		error: function( jqXhr, textStatus, errorThrown ){ console.log( errorThrown ); }
	});
	
}

function currencyFormat (num) {
    return "$" + num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")
}
	
</script>