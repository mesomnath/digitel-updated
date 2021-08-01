package user.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import connection.ConnectionDb;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateUser
 */
@WebServlet("/updateuser")
public class UpdateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			Connection con = ConnectionDb.getConnection();
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date date = new java.sql.Date(utilDate.getTime());
		    String email =request.getParameter("email");
		    String name =request.getParameter("name");
		    String role =request.getParameter("role");
		    String supid =request.getParameter("sup_id");
		    String uid =request.getParameter("u_id");
			long tel_number= Long.parseLong(request.getParameter("tel_number"));
			
			PreparedStatement ps = con.prepareStatement("update digitadmin  set name=?, email=?,tel_number=?,date_updated=?,access_id=?,sup_id=? where user_id=?");
			ps.setString(7, uid);
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setLong(3,tel_number);
			ps.setDate(4, date);
			ps.setString(5, role);
			ps.setString(6, supid);
			int i = ps.executeUpdate();
			if(i>0) {
				
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('User Updated Successfully!');");
				pw.println("window.location.href = \"view-users.jsp?id="+supid+"\";");
				pw.println("</script>"); 
			}
			else {
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Something went wrong!');");
				pw.println("window.location.href = \"view-users.jsp?id="+supid+"\";");
				pw.println("</script>"); 
			}
					
			
			
		}
		
		catch (SQLException e) {
		      e.printStackTrace();
		 }
	}

}
