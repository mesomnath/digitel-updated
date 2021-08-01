
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete User</title>
</head>
<body>



<%
String id=request.getParameter("id");

Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "SYSTEM", "Password1234");
PreparedStatement pi=conn.prepareStatement("select sup_id from digitadmin where user_id='"+id+"'");
ResultSet rs=pi.executeQuery();
if(rs.next()){
String sup_id=rs.getString("sup_id");
Statement st=conn.createStatement();
int i = st.executeUpdate("DELETE FROM digitadmin WHERE user_id='"+id+"'");

if(i>0){
	out.println("<script type=\"text/javascript\">");
    out.println("alert('User has been deleted successfully!');");
    out.println("window.location.href = \"view-users.jsp?id="+sup_id+"\";");
    out.println("</script>");
}
else{
	out.println("Error occured");
}
}

%>
</body>
</html>