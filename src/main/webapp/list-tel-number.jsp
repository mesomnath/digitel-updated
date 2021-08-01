<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lists of Telephone Numbers</title>
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
                                <b><i class="bi bi-people-fill"></i>&nbsp;Telephone Number list</b>
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
                        <!-- -Exporting data table--- -->
                        
                        <div class="float-right">
                        <a href="./export.jsp?id=<%=userid %>" class="btn bg-primary text-white mb-2"><i class="bi bi-file-earmark-excel-fill"></i> Export List</a>
                        </div>
                        <!-- ---- -->
                        <table class="table table-bordered">
                            <thead>
                              <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Telephone Number</th>
                                <th scope="col">State</th>
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
						     String id=request.getParameter("id");
						     try
						     {
						    	 
						    	// Class.forName("oracle.jdbc.driver.OracleDriver");
						    	 con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "SYSTEM", "Password1234");
						    	 stmt=con.createStatement();
						    	 String search=request.getParameter("search");
						    	 String query;
						    
						    	 if(search!=null){
						    	  query = "SELECT * FROM digituser WHERE tel_id like '%"+search+"%' OR tel_number like'%"+search+"%'";
						    	 }
						    	 else{
						    	   query="SELECT tel_id, tel_number, step, req_id,date_created,date_updated from digituser where user_id='"+id+"'";
						    	 }
						    	 rs=stmt.executeQuery(query);
						    	 while(rs.next())
						    	 {
						   %>
						              <tr>
						                <td scope="row"> <%=Integer.parseInt(rs.getString("tel_id"))%></td>
						                <td> <%=rs.getString("tel_number") %></td>						                
						                <td style="text-transform:uppercase"> <%=rs.getString("step") %></td>
						                <td> <%=rs.getDate("DATE_CREATED") %></td>
						                <td> <%=rs.getDate("DATE_UPDATED") %></td>
						                <td>
						                <% if ((rs.getInt("req_id")==1)){%>
						                	
						                	<a class="btn btn-sm bg-primary text-white disabled"> &nbsp;Requested for Change</a><%
						                } else{%>
						                	<a href="./edit-tel-number.jsp?id=<%=rs.getInt("tel_id")%>" class="btn btn-sm bg-warning text-dark"><i class="bi bi-pencil-square"></i>&nbsp;Edit</a>
						               <% }%>
		                                    
		                                    <a href="./delete-tel-number.jsp?id=<%=rs.getInt("tel_id")%>" class="btn btn-sm bg-danger text-white"><i class="bi bi-trash-fill"></i>&nbsp;Delete</a>
		                                    
		                                </td>
						               </tr>
						         <% 
						    	 }
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
                   
                        <a href="./logout" class="btn btn-danger  ml-2"><i class="bi bi-arrow-bar-left"></i>&nbsp;Logout</a>
                        <a href="./dashboard.jsp?id=<%=userid %>" class="btn btn-dark  ml-2"><i class="bi bi-arrow-left"></i>&nbsp;Back to Dashboard</a>
                        <a href="./add-tel-number.jsp?id=<%=userid %>" class="btn btn-success float-right"><i class="bi bi-person-plus-fill"></i>&nbsp;Entry a New Tele Number</a>
                        
                    </div>
                    
                </div>
                
            </div>
            <div class="col-md-1"></div>
        </div>
        
    </div>
</body>
</html>