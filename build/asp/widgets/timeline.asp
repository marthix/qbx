<ul class="timeline" style="padding-bottom: 15px;">
<%
	sqlGetTimeline = "SELECT samelevel.qbx_dashboard_types.dashboard_type_title, samelevel.qbx_dashboard_types.dashboard_Type_ID, samelevel.qbx_dashboard_types.dashboard_icon_class, samelevel.qbx_dashboard.dashboard_DateTime, samelevel.qbx_dashboard.dashboard_Header, samelevel.qbx_dashboard.dashboard_Body, samelevel.qbx_dashboard.dashboard_Footer FROM samelevel.qbx_dashboard INNER JOIN samelevel.qbx_dashboard_types ON samelevel.qbx_dashboard.dashboard_Type_ID = samelevel.qbx_dashboard_types.dashboard_Type_ID ORDER BY DASHBOARD_DATETIME DESC LIMIT 2"
	Set rsTimeline = sqlSameLevel.Execute(sqlGetTimeline)
	
	Do While Not rsTimeline.Eof
	
		type_ID = rsTimeline("dashboard_Type_ID")
		date_Timestamp = rsTimeline("dashboard_DateTime")
		now_Timestamp = Now()
		is_Plural = 0
		
		If DateDiff("M", date_Timestamp, now_Timestamp) >= 1 Then
			display_Timestamp = DateDiff("M", date_Timestamp, now_Timestamp) & " month"
			If DateDiff("M", date_Timestamp, now_Timestamp) > 1 Then display_Timestamp = display_Timestamp & "s"
			display_Timestamp = display_Timestamp & " ago"
		ElseIf DateDiff("D", date_Timestamp, now_Timestamp) >= 1 Then
			display_Timestamp = DateDiff("D", date_Timestamp, now_Timestamp) & " day"
			If DateDiff("D", date_Timestamp, now_Timestamp) > 1 Then display_Timestamp = display_Timestamp & "s"
			display_Timestamp = display_Timestamp & " ago"
		ElseIf DateDiff("H", date_Timestamp, now_Timestamp) >= 1 Then
			display_Timestamp = DateDiff("H", date_Timestamp, now_Timestamp) & " hour"
			If DateDiff("H", date_Timestamp, now_Timestamp) > 1 Then display_Timestamp = display_Timestamp & "s"
			display_Timestamp = display_Timestamp & " ago"
		ElseIf DateDiff("N", date_Timestamp, now_Timestamp) >= 1 Then
			display_Timestamp = DateDiff("N", date_Timestamp, now_Timestamp) & " minute"
			If DateDiff("N", date_Timestamp, now_Timestamp) > 1 Then display_Timestamp = display_Timestamp & "s"
			display_Timestamp = display_Timestamp & " ago"
		ElseIf DateDiff("S", date_Timestamp, now_Timestamp) >= 1 Then
			display_Timestamp = DateDiff("S", date_Timestamp, now_Timestamp) & " second"
			If DateDiff("S", date_Timestamp, now_Timestamp) > 1 Then display_Timestamp = display_Timestamp & "s"
			display_Timestamp = display_Timestamp & " ago"
		End If
		
%>
		<li>
	
			<i class="<%= rsTimeline("dashboard_icon_class") %>"></i>
			
			<div class="timeline-item">
			
				<span class="time"><i class="fa fa-clock-o"></i> &nbsp;<%= display_Timestamp %></span>
<%
				If type_ID > 1 Then
%>
					<h3 class="timeline-header"><%= rsTimeline("dashboard_Header") %></h3>
					<div class="timeline-body"><%= rsTimeline("dashboard_Body") %></div>
<%
				Else
%>
					<h3 class="timeline-header"><%= rsTimeline("dashboard_Header") %> joined QBx</h3>
<%
				End If
				
				If Len(rsTimeline("dashboard_Footer")) > 0 Then
%>
					<div class="timeline-footer"><%= rsTimeline("dashboard_Footer") %></div>
<%
				End If
%>
			</div>
			
		</li>
<%
		rsTimeline.MoveNext
		
	Loop
	
	rsTimeline.Close
	Set rsTimeline = Nothing
%>
	<li>
		<i class="fa fa-clock-o bg-gray"></i>
	</li>

</ul>