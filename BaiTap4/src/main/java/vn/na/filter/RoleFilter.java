package vn.na.filter;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import vn.na.entity.UserEntity;
import vn.na.utils.Constant;

@WebFilter(urlPatterns = "/*")
public class RoleFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI();
        String ctx = req.getContextPath();

        HttpSession session = req.getSession(false);
        UserEntity user = (session == null) ? null :
                (UserEntity) session.getAttribute(Constant.SESSION_LOGIN);

        // Nếu chưa login → AuthFilter xử lý rồi → cứ cho qua
        if (user == null) {
            chain.doFilter(request, response);
            return;
        }

        boolean isAdmin = user.isAdmin(); // lấy đúng theo database

        // Chặn user thường vào /admin/*
        if (path.startsWith(ctx + "/admin")) {
            if (!isAdmin) {
                resp.sendRedirect(ctx + "/user/home");
                return;
            }
        }

        // Chặn admin vào /user/*
        if (path.startsWith(ctx + "/user")) {
            if (isAdmin) {
                resp.sendRedirect(ctx + "/admin/home");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
