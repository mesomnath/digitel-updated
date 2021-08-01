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
 * Servlet implementation class CreateUser
 */
@WebServlet("/adduser")
public class CreateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			Connection connection = ConnectionDb.getConnection();
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			long tel_number = Long.parseLong(request.getParameter("tel_number"));
			String role = request.getParameter("role");
			String sup_id = request.getParameter("sup_id");
			
			java.util.Date utilDate = new java.util.Date();
		    java.sql.Date date = new java.sql.Date(utilDate.getTime());
			
			
			
			/**
			 * Random password function from RandomPwdGenerator class
			 *
			 */
			RandomPwdGenerator pwd = new RandomPwdGenerator();
			String password = pwd.generateRandomChars("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvxyz#$%!@*()^",8);
			
			/**
			 * 
			 * Random userid creation field
			 */
			
			
			int user_id=10; 
			// int access_id=2;
			
			
			
			/**
			 * Incrementing User id sending data to database.
			 */
			PreparedStatement pi=connection.prepareStatement("select max(user_id) from digitadmin");
			ResultSet rs=pi.executeQuery();
			
			
			
			if(rs.next()) {
				user_id=rs.getInt(1);
				user_id++;
				
				PreparedStatement ps=connection.prepareStatement("insert into digitadmin values(?,?,?,?,?,?,?,?,?)");
				ps.setInt(1, user_id);
				ps.setString(2, name);
				ps.setString(3, email);
				ps.setLong(4, tel_number);
				ps.setDate(5, (java.sql.Date) date);
				ps.setDate(6, (java.sql.Date) date);
				ps.setString(7, role);
				ps.setString(8,password);
				ps.setString(9,sup_id);
				
				
				int i=ps.executeUpdate();
				
				if(i>0) {
					response.setContentType("text/html");
					PrintWriter pw=response.getWriter();
					pw.println("<script type=\"text/javascript\">");
					pw.println("alert('New user has been created!');");
					pw.println("window.location.href = \"dashboard.jsp?id="+sup_id+"\";");
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


