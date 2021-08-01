<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
 <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Telephone Number</title>
    <!--Bootstrap CDN-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&display=swap" rel="stylesheet">
</head>

<style>
    *{
        font-family: 'Lato',sans-serif;
        
    }
    .btn:focus{
    box-shadow:none !important;
     }
     input[type="text"], textarea, select,input[type="password"] {
       outline: none;
       box-shadow:none !important;
       border:1px solid #ccc !important;
       }
       .btn,  input[type="text"], textarea, select, .card, .card-body,.card-footer{
       border-radius:0px !important;
       }
       
       .invalid {
		  color: red;
		}
		.valid{
		color: green;
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
    try
    {
   	 
   	// Class.forName("oracle.jdbc.driver.OracleDriver");
   	 con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "SYSTEM", "Password1234");
   	 stmt=con.createStatement();
   	 String query;
     query="SELECT  * from digituser where tel_id='"+userid+"'";
   	 
   	 rs=stmt.executeQuery(query);
   	 while (rs.next())
   	 {

%>
    <nav class="navbar navbar-expand-lg navbar-dark justify-content-center" style="background-color: #044068;">
        <a class="navbar-brand" style="font-size: 38px; font-weight: bold;" href="#">DigiTel</a>
    </nav>
    <div class="container p-4">
        <div class="row"style="margin-top:100px">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <form action="requesttelchange" method="post">
                <div class="card">
                    <div class="card-header text-white h3" style="background-color: #232F3E;"><b>Edit Details</b></div>
                    <div class="card-body">
                    	
                    	    <div class="form-group mt-2">
                             
                              <input type="text" class="form-control mt-0 disabled" hidden name="tel_id" value="<%=userid%>">                            
                            </div>
                        
                            <div class="form-group mt-2">
                              <label class="mb-0"><b>Telephone Number</b></label>
                              <input type="number" class="form-control mt-0 disabled" disabled name="number" value="<%=rs.getString("tel_number")%>">
                            
                            </div>
                            <div class="form-group mt-2">
                              <label class="mb-0"><b>Current Stage</b></label>
                              <input type="text" class="form-control disabled" disabled name="step" value="<%=rs.getString("step") %>">
                            </div>
                            <div class="form-group mt-2">
                                <label class="mb-0"><b>Select  Stage</b></label>
                                <select name="step2" class="form-control" required>
                                    <option value="Initial">Initial</option>
                                    <option value="Ready to Provision">Ready to Provision</option>
                                    <option value="Provisioned">Provisioned</option>
                                    <option value="Active">Active</option>
                                    <option value="Suspended">Suspended</option>
                                    <option value="Deactivate">Deactivate</option>
                                </select>
                            </div>
                            <input type="text" name="u_id"  value="<%=rs.getString("user_id")%>" hidden>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-success float-right">Update Details</button>
                    </div>
                </div>
                </form>
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
