<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html>
<body>
<%
 
	//response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	//response.setHeader("Pragma", "no-cache");
	//response.setHeader("Expires","0");
	// String tel_number=request.getParameter("tel_number");
	
	//String userid=request.getParameter("id");
	
	
	if(session.getAttribute("tel_number")==null)
		response.sendRedirect("login.jsp");
	


%>
</body>
</html>
