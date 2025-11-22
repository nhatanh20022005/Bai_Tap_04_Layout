package vn.na.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.na.entity.UserEntity;
import vn.na.service.IUserService;
import vn.na.service.impl.UserService;

@WebServlet(urlPatterns = {"/forget"})
public class ForgetPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    IUserService service = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/forget.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");

        if (email == null || email.isEmpty()) {
            req.setAttribute("alert", "Email ko được rỗng!");
            req.getRequestDispatcher("/views/forget.jsp").forward(req, resp);
            return;
        }

        UserEntity user = service.findByEmail(email);

        if (user == null) {
            req.setAttribute("alert", "Email ko tồn tại!");
            req.getRequestDispatcher("/views/forget.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("alert", "Mật khẩu của bạn là: " + user.getPassword());
        req.getRequestDispatcher("/views/forget.jsp").forward(req, resp);
    }
}
