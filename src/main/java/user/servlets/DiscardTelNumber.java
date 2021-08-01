package user.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import connection.ConnectionDb;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DiscardTelNumber
 */
@WebServlet("/discardtelnumber")
public class DiscardTelNumber extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Connection con=ConnectionDb.getConnection();
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date date = new java.sql.Date(utilDate.getTime());
			String telid = request.getParameter("tel_id");
			String step1 = request.getParameter("step2");
			String uid=request.getParameter("id");
			int req_id=0;
			
			PreparedStatement ps = con.prepareStatement("update digituser set step=?,req_id=? where tel_id=?");
			ps.setString(3, telid);
			ps.setString(1, step1);
			ps.setInt(2, req_id);
			System.out.println(telid + " "+step1 + " "+ date+" "+req_id+" "+uid);
			int i = ps.executeUpdate();
			if(i>0) {
				
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Changes Discarded!');");
				pw.println("window.location.href = \"approved-tel-list.jsp?id="+uid+"\";");
				pw.println("</script>"); 
			}
			else {
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('Something Went Wrong');");
				pw.println("window.location.href = \"approved-tel-list.jsp?id="+uid+"\";");
				pw.println("</script>"); 
			}
			
		}
		
		
		
		catch (Exception e){
			e.printStackTrace();
		}	
		
	}

}
