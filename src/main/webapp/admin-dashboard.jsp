<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
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
	
	Connection con;
    Statement stmt;
    ResultSet rs;
    String id=request.getParameter("id");
    
    try
    {
   	 
   	// Class.forName("oracle.jdbc.driver.OracleDriver");
   	 con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "SYSTEM", "Password1234");
   	 stmt=con.createStatement();
   	 String query;
     query="SELECT date_updated from digitadmin where user_id='"+userid+"'";
   	 
   	 rs=stmt.executeQuery(query);
   	 java.util.Date utilDate = new java.util.Date();
	 java.sql.Date date = new java.sql.Date(utilDate.getTime());
   	 while (rs.next())
   	 {
   		 Date udate = rs.getDate("date_updated");
		 long date1 = date.getTime();
    	  long date2 = udate.getTime();
    	  //long timediff = 0;
    	  long timediff = date1 -date2;
    	  int daysdiff =(int)(timediff /(1000*60*60*24));
    	  int leftday = (int)(60-daysdiff);
    	  System.out.println(leftday);

%>
    <nav class="navbar navbar-expand-lg navbar-dark justify-content-center" style="background-color: #044068;">
        <a class="navbar-brand" style="font-size: 38px; font-weight: bold;" href="#">DigiTel</a>
    </nav>
    <div class="container p-4">
        <div class="row"style="margin-top:100px">
            <div class="col-md-3"></div>
            <div class="col-md-6">
               
                <div class="card">
                    <div class="card-header text-white h3" style="background-color: #232F3E;"><b>Dashboard</b></div>
                    <div class="card-body">
                    	
                    	<a href="./view-users.jsp?id=<%=userid %>" class="btn">View Users</a>
                    	<a href="./add-tel-number.jsp?id=<%=userid %>" class="btn">Pending Requests</a>
                    	<a href="./create-user.jsp?id=<%=userid %>" class="btn">Add New User</a>
                    	   
                    </div>
                    <div class="card-footer">
                    	<b>Password Will Expired <%=leftday %> in Days!</b>
						                     
                        <a href="./reset-password.jsp?id=<%= userid %>" class="text-warning font-weight-bold text-decoration-underline  "><u><i class="bi bi-key-fill"></i>&nbsp;Change Password</u></a>
                        <a href="./Logout" class="btn btn-danger  float-right"><i class="bi bi-arrow-bar-left"></i>&nbsp;Logout</a>
                    </div>
                </div>
              
            </div>
            <div class="col-md-3"></div>
        </div>
        
    </div>
    <% 
   	 }
   	 con.close();   		 
   	 }
   	 catch(Exception e)
   	 {
   	 out.print(e);
   	 }
        %>
</body>
</html>