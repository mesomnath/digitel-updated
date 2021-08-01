package user.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import connection.ConnectionDb;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateTelNumber
 */
@WebServlet("/addtelnumber")
public class CreateTelNumber extends HttpServlet {
	private static final long serialVersionUID = 1L;

  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
try {
			
			Connection connection = ConnectionDb.getConnection();
			
			long tel_number = Long.parseLong(request.getParameter("tel_number"));
			String step = request.getParameter("step");
			String u_id = request.getParameter("u_id");
			
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date date = new java.sql.Date(utilDate.getTime());
			
			
			String step2 = null;
			int tel_id=2000; 
			int req_id=0;
			
			
			
			/**
			 * Incrementing User id sending data to database.
			 */
			PreparedStatement pi=connection.prepareStatement("select max(tel_id) from digituser");
			ResultSet rs=pi.executeQuery();
			
			
			
			if(rs.next()) {
				tel_id=rs.getInt(1);
				tel_id++;
				
				PreparedStatement ps=connection.prepareStatement("insert into digituser values(?,?,?,?,?,?,?,?)");
				ps.setString(1, u_id);
				ps.setLong(2, tel_number);
				ps.setString(3, step);
				ps.setDate(4, (java.sql.Date) date);
				ps.setDate(5, (java.sql.Date) date);
				ps.setInt(6, req_id);
				ps.setInt(7,tel_id);
				ps.setString(8, step2);
				
				
				int i=ps.executeUpdate();
				
				if(i>0) {
					response.setContentType("text/html");
					PrintWriter pw=response.getWriter();
					pw.println("<script type=\"text/javascript\">");
					pw.println("alert('Entry has been Recorded!');");
					pw.println("window.location.href = \"add-tel-number.jsp?id="+u_id+"\";");
					pw.println("</script>");
				}
				else {
					response.sendRedirect("error.jsp");
				}
			}
			
			
			}
			catch (Exception e){
				e.printStackTrace();
			}
		}

}
