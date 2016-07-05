<div class="modal fade" id="modalOffices" tabindex="-1" role="dialog" aria-labelledby="modalOffices" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="myModalLabel"><i class="fa fa-building"></i> &nbsp;Claims Pages Office Directory</h4>
			</div>
			<div class="modal-body">
				<div class="row">
<%
					sqlGetOffices = "SELECT * FROM tbllocation WHERE lc_recno <> 7 AND lc_recno <> 5 ORDER BY lc_location"
					Set rsOffices = sqlRecorder.Execute(sqlGetOffices)
					
					Do While Not rsOffices.Eof
%>
					
						<div class="col-md-6">
						
							<div style="padding-left: 10px; padding-right: 10px;">
								<h3><%=rsOffices("lc_location")%></h3>
								<div style="margin-top: -5px;"><%=rsOffices("lc_locaddress1")%></div>
								<div><%=rsOffices("lc_locaddress2")%></div>
								<div><%=rsOffices("lc_loccity")%>,&nbsp;<%=rsOffices("lc_locstate")%>&nbsp;&nbsp;<%=rsOffices("lc_loczip")%></div>
								<div style="margin-top: 5px;"><i class="fa fa-phone fa-fw"></i> <%=rsOffices("lc_locphone")%></div>
								<% If rsOffices("lc_localtphone") > "" Then %><div><i class="fa fa-phone fa-fw"></i> <%=rsOffices("lc_localtphone")%></div><% End If %>
								<div><i class="fa fa-fax fa-fw"></i> <%=rsOffices("lc_locfax")%></div>
							</div>
								
						</div>
<%
						rsOffices.MoveNext
						
					Loop
					
					rsOffices.Close
					Set rsOffices = Nothing
%>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close Office Directory</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade bs-example-modal-lg" id="modalPhonebook" tabindex="-1" role="dialog" aria-labelledby="modalPhonebook" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="myModalLabel"><i class="fa fa-phone"></i> &nbsp;Claims Pages Phonebook</h4>
			</div>
			<div class="modal-body">
				<table id="employeePhonebook" class="table table-bordered table-hover">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Phone</th>
							<th>Office</th>
							<th>Department</th>
							<th>Title</th>
						</tr>
					</thead>
					<tbody>
<%
						sqlGetEmployees = "SELECT * FROM tblEmployee, tbllocation, tbljobtitle, tbldepartment WHERE (tblEmployee.em_title=tbljobtitle.jb_recno) AND (tblEmployee.em_location=tbllocation.lc_recno) AND (tblEmployee.em_depart=tbldepartment.dp_recno) AND (em_phoneext IS NULL OR em_phoneext<'999') AND em_Company<>6 AND (em_Active=1) ORDER BY tblEmployee.em_RecNo ASC"
						Set rsEmployees = sqlRecorder.Execute(sqlGetEmployees)
						
						Do While Not rsEmployees.Eof
%>
							<tr>
								<td><%= rsEmployees("em_RecNo") %></td>
								<td>
<%
									If rsEmployees("em_nickname") > "" Then
										aename=rsEmployees("em_last") & ", " & rsEmployees("em_nickname")
										friendlyaename=rsEmployees("em_nickname") & " " & rsEmployees("em_last")
									Else
										aename=rsEmployees("em_last") & ", " & rsEmployees("em_first") & " " & rsEmployees("em_middle")
										friendlyaename=rsEmployees("em_first") & " " & rsEmployees("em_middle") & " " & rsEmployees("em_last")
									End If
									
									Response.Write(friendlyaename)
%>
								</td>
								<td>
									<% If rsEmployees("lc_localtphone") > "" Then Response.Write(rsEmployees("lc_localtphone")) Else Response.Write(rsEmployees("lc_locphone")) End If %>
									<% If rsEmployees("em_phoneext") > "" Then Response.Write(" (" & rsEmployees("em_phoneext") & ")" ) End If %>
								</td>
								<td><%= rsEmployees("lc_location") %></td>
								<td><%= LEFT(rsEmployees("dp_deptname"),15) %></td>
								<td><%= rsEmployees("jb_jobtitle") %></td>
							</tr>
<%
							rsEmployees.MoveNext
							
						Loop
%>
					</tbody>
					
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close Phonebook</button>
			</div>
		</div>
	</div>
</div>