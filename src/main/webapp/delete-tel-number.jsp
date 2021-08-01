
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
<title>Delete Tel Number</title>
</head>
<body>



<%
String id=request.getParameter("id");

Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "SYSTEM", "Password1234");
PreparedStatement pi=conn.prepareStatement("select user_id from digituser where tel_id='"+id+"'");
ResultSet rs=pi.executeQuery();
if(rs.next()){
String user_id=rs.getString("user_id");
Statement st=conn.createStatement();
int i = st.executeUpdate("DELETE FROM digituser WHERE tel_id='"+id+"'");

if(i>0){
	out.println("<script type=\"text/javascript\">");
    out.println("alert('Telephone Number has been deleted successfully!');");
    out.println("window.location.href = \"list-tel-number.jsp?id="+user_id+"\";");
    out.println("</script>");
}
else{
	out.println("Error occured");
}
}

%>
</body>
</html>