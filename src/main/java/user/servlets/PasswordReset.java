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
 * Servlet implementation class PasswordReset
 */
@WebServlet("/resetpassword")
public class PasswordReset extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			Connection con = ConnectionDb.getConnection();
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date date = new java.sql.Date(utilDate.getTime());
		    String email =request.getParameter("email");
			long tel_number= Long.parseLong(request.getParameter("tel_number"));
			String password = request.getParameter("password");
			PreparedStatement ps = con.prepareStatement("update digitadmin  set password=?, date_updated=? where tel_number=? and email=?");
			ps.setLong(3,tel_number);
			ps.setString(4, email);
			ps.setString(1, password);
			ps.setDate(2, date);
			int i = ps.executeUpdate();
			if(i>0) {
				
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Password Updated Successfully!');");
				pw.println("window.location.href = \"login.jsp\";");
				pw.println("</script>"); 
			}
			else {
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Registered Mobile Number and Email ID is MISMATCH!');");
				pw.println("window.location.href = \"forget-password.jsp\";");
				pw.println("</script>"); 
			}
					
			
			
		}
		
		catch (SQLException e) {
		      e.printStackTrace();
		 }
	}

}
