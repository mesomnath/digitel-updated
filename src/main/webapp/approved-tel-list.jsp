<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Entry modification request</title>
    <!--Bootstrap CDN-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
</head>
<style>
    *{
        font-family: 'Lato',sans-serif;
        
    }
    .btn:focus{
    box-shadow:none !important;
     }
     input[type="text"], textarea, select {
       outline: none;
       box-shadow:none !important;
       border:1px solid #ccc !important;
       }
       .btn,  input[type="text"], textarea, select, .card, .card-body,.card-footer{
       border-radius:0px !important;
       
       }
       .bg-primary{
       background-color: #044068 !important;
       
       }
       
</style>

<body style="background-color: #F4F1EA;">
<%
 
	//response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	//response.setHeader("Pragma", "no-cache");
	//response.setHeader("Expires","0");
	// String tel_number=request.getParameter("tel_number");
	
	String userid=request.getParameter("id");
	//if(session.getAttribute("tel_number")==null)
		//response.sendRedirect("login.jsp");

%>
    <nav class="navbar navbar-expand-lg navbar-dark justify-content-center" style="background-color: #044068;">
        <a class="navbar-brand" style="font-size: 38px; font-weight: bold;" href="#">DigiTel</a>
    </nav>
    <div class="container p-4">
        <div class="row mt-2">
            <div class="col-md-1"></div>
            <div class="col-md-12">
               
                <div class="card">
                    <div class="card-header text-white h3" style="background-color: #232F3E;">
                     <div class="row">
                            <div class="col-9">
                                <b>Entries for Approval</b>
                            </div>
                            <div class="col-3">
                                <form action="" method="get">
                                    <input type="text" name="id" value="<%=userid%>" class="form-control" hidden/>
                                    <div class="input-group">
									   <input type="text" name="search" placeholder="Search..." class="form-control"/>
									    <div class="input-group-append">
									      <button type="submit" class="btn">SEARCH</button>
									    </div>
									  </div>
                                </form> 
                            </div>
                        </div>
                    </div>
                    <div class="card-body overflow-scroll" style="max-height:480px;overflow-y:scroll">
                        <!-- -Exporting data table--- --
                        
                        <div class="float-right">
                        <a href="./export.jsp?id=" class="btn btn-success mb-2"><i class="bi bi-file-earmark-excel-fill"></i> Export Users List</a>
                        </div>
                        -- ---- -->
                        <table class="table table-bordered">
                            <thead>
                              <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Telephone Number</th>
                                <th scope="col">Current Stage</th>
                                <th scope="col">Requested Stage</th>
                                <th scope="col">Requested By</th>
                                <th scope="col">Created On</th>
                                <th scope="col">Last Updated On</th>
                                <th scope="col">Action</th>
                              </tr>
                            </thead>
                            <tbody>
                            <%
                             Connection con;
						     Statement stmt;
						     ResultSet rs;
						     ResultSet rs2;
						     String id=request.getParameter("id");
						     try
						     {
						    	 
						    	// Class.forName("oracle.jdbc.driver.OracleDriver");
						    	 con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "SYSTEM", "Password1234");
						    	 stmt=con.createStatement();
						    	 String search=request.getParameter("search");
						    	 String query;
						    	 query = "select user_id,name from digitadmin where sup_id='"+id+"'";
						    	 rs2= stmt.executeQuery(query);
						    	 
						    	 while(rs2.next()){
						    		 String u_id = rs2.getString("user_id");
						    		 String name=rs2.getString("name");
						    		 
						    	 if(u_id != null){
						    	  
						    	 if(search!=null){
						    	  query = "SELECT * FROM digituser WHERE user_id like '%"+search+"%' OR name like '%"+search+"%' OR tel_number like'%"+search+"%'";
						    	 }
						    	 else{
						    	   query="SELECT * FROM Digituser where req_id=1";
						    	 }
						    	 rs=stmt.executeQuery(query);
						    	 while(rs.next())
						    	 {
						   %>
						              <tr>
						                <td scope="row"> <%=Integer.parseInt(rs.getString("tel_id"))%></td>
						                <td> <%=rs.getString("tel_number") %></td>
						                <td> <%=rs.getString("step") %></td>
						                <td> <%=rs.getString("step2") %></td>
						                <td> <%=name%></td>
						                <td> <%=rs.getDate("DATE_CREATED") %></td>
						                <td> <%=rs.getDate("DATE_UPDATED") %></td>
						                <td>
						                	<a href="./approvedtelnumber?id=<%=userid %>&&tel_id=<%=Integer.parseInt(rs.getString("tel_id")) %>&&step2=<%=rs.getString("step2") %>" class="btn btn-sm bg-success text-white mt-2"><i class="bi bi-eye"></i>&nbsp;Approve</a>
		                                    <a href="./discardtelnumber?id=<%=userid %>&&tel_id=<%=Integer.parseInt(rs.getString("tel_id")) %>&&step2=<%=rs.getString("step") %>" class="btn btn-sm bg-warning text-dark mt-2"><i class="bi bi-pencil-square"></i>&nbsp;Discard</a>
		                                </td>
						               </tr>
						         <% 
						    	 } }}
						    	 con.close();   		 
						    	 }
						    	 catch(Exception e)
						    	 {
						    	 out.print(e);
						    	 }
						         %>
                              
                          </table>
                          
                    </div>
                   
                    <div class="card-footer">
                    <%
                             Connection conn;
						     Statement stmt1;
						     ResultSet rs1;
						     String uid=request.getParameter("id");
						     try
						     {
						    	 
						    	 Class.forName("oracle.jdbc.driver.OracleDriver");
						    	 conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "SYSTEM", "Password1234");
						    	 stmt1=conn.createStatement();
						    	 // String tel_number=request.getParameter("tel_number");
						    	 String query="SELECT DATE_UPDATED FROM Digitadmin where user_id="+uid;
						    	 
						    	 rs1=stmt1.executeQuery(query);
						    	 java.util.Date utilDate = new java.util.Date();
								 java.sql.Date date = new java.sql.Date(utilDate.getTime());
								 
						    	 while(rs1.next())
						    	 {

							    	 Date udate = rs1.getDate("date_updated");
						    		 long date1 = date.getTime();
							    	  long date2 = udate.getTime();
							    	  //long timediff = 0;
							    	  long timediff = date1 -date2;
							    	  int daysdiff =(int)(timediff /(1000*60*60*24));
							    	  int leftday = (int)(60-daysdiff);
							    	  System.out.println(leftday);
						   %>
						   <b>Password Will Expired <%=leftday %> in Days!</b>
						   <% 
						    	 }
						    	 conn.close();   		 
						    	 }
						    	 catch(Exception e)
						    	 {
						    	 out.print(e);
						    	 }
						         %>                    
                        <a href="./forget-password.jsp?id=<%=uid %>" class="text-warning font-weight-bold text-decoration-underline  "><u><i class="bi bi-key-fill"></i>&nbsp;Change Password</u></a>
                        <a href="./logout" class="btn btn-danger  ml-2"><i class="bi bi-arrow-bar-left"></i>&nbsp;Logout</a>
                        <a href="./dashboard.jsp?id=<%=userid%>" class="btn bg-dark text-white float-right"><i class="bi bi-arrow-left"></i>&nbsp;Back to Dashboard</a>
                        
                    </div>
                    
                </div>
                
            </div>
            <div class="col-md-1"></div>
        </div>
        
    </div>
</body>
</html>