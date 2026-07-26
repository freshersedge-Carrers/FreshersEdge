import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RejectPaymentServlet")
public class RejectPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            "UPDATE payments SET status='Rejected' WHERE id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setInt(1, Integer.parseInt(id));
            ps.executeUpdate();

            ps.close();

            con.close();

            response.sendRedirect("admin-dashboard.jsp");

        }
        catch(Exception e){

            e.printStackTrace();

            response.getWriter().println("Error : " + e.getMessage());

        }

    }

}