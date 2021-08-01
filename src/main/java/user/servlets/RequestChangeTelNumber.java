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
 * Servlet implementation class RequestChangeTelNumber
 */
@WebServlet("/requesttelchange")
public class RequestChangeTelNumber extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			Connection con = ConnectionDb.getConnection();
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date date = new java.sql.Date(utilDate.getTime());
		    String uid =request.getParameter("u_id");
		    String telid =request.getParameter("tel_id");
		    int req_id = 1;
		    String step2 =request.getParameter("step2");
			System.out.println(telid + " "+step2 + " "+ date+" "+ req_id);
			PreparedStatement ps = con.prepareStatement("update digituser set step2=?, date_updated=?, req_id=? where tel_id=?");
			
			
			ps.setString(4, telid);
			ps.setString(1, step2);
			ps.setDate(2, date);
			ps.setInt(3, req_id);
			System.out.println(telid + " "+step2 + " "+ date+" "+req_id);
			
			int i = ps.executeUpdate();
			if(i>0) {
				
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Modification has been sent for Approval');");
				pw.println("window.location.href = \"list-tel-number.jsp?id="+uid+"\";");
				pw.println("</script>"); 
			}
			else {
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Something Went Wrong');");
				pw.println("window.location.href = \"edit-tel-number.jsp?id="+telid+"\";");
				pw.println("</script>"); 
			}
					
			
			
		}
		
		catch (SQLException e) {
		      e.printStackTrace();
		 }
	}

}
