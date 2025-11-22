package vn.na.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.na.entity.UserEntity;
import vn.na.service.IUserService;
import vn.na.service.impl.UserService;
import vn.na.utils.Constant;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    IUserService service = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_LOGIN) != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // đọc cookie remember me
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals(Constant.COOKIE_REMEMBER)) {
                    req.setAttribute("rememberedUser", c.getValue());
                }
            }
        }

        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("uname");
        String password = req.getParameter("psw");
        String remember = req.getParameter("remember");

        boolean isRememberMe = "on".equals(remember);

        if (username.isEmpty() || password.isEmpty()) {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu ko được rỗng");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        UserEntity user = service.login(username, password);

        if (user == null) {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu ko đúng");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        if (!user.isActive()) {
            req.setAttribute("alert", "Tài khoản của bạn đã bị khóa!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        // tạo session
        HttpSession session = req.getSession(true);
        session.setAttribute(Constant.SESSION_LOGIN, user);

        // xử lý cookie
        if (isRememberMe) {
            saveRememberMe(resp, username);
        } else {
            clearRememberMe(resp);
        }

        if (user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/admin/home");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/profile");
        }
    }

    private void saveRememberMe(HttpServletResponse resp, String username) {
        Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username);
        cookie.setMaxAge(7 * 24 * 60 * 60);
        cookie.setPath("/");
        resp.addCookie(cookie);
    }

    private void clearRememberMe(HttpServletResponse resp) {
        Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        resp.addCookie(cookie);
    }
}
