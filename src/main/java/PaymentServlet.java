import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        String fullName = request.getParameter("fullName");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String service = request.getParameter("service");
        String amount = request.getParameter("amount");
        String bank = request.getParameter("bank");
        String upi = request.getParameter("upi");
        String utr = request.getParameter("utr");

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {
                response.getWriter().println("<h2>Database Connection Failed</h2>");
                return;
            }

            String sql =
            "INSERT INTO payments(full_name,mobile,email,service,amount,bank_name,upi_id,utr,screenshot,status) VALUES(?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, fullName);
            ps.setString(2, mobile);
            ps.setString(3, email);
            ps.setString(4, service);
            ps.setDouble(5, Double.parseDouble(amount));
            ps.setString(6, bank);
            ps.setString(7, upi);
            ps.setString(8, utr);

            // No screenshot
            ps.setString(9, "");

            ps.setString(10, "Pending");

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            if (rows > 0) {
                response.sendRedirect("success.html");
            } else {
                response.getWriter().println("<h2>Payment Not Saved</h2>");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println("<h2>Error</h2>");
            response.getWriter().println(e.getMessage());

        }

    }
}