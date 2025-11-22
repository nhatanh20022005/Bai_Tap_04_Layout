package vn.na.filter;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import vn.na.entity.UserEntity;
import vn.na.utils.Constant;

@WebFilter(urlPatterns = "/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI();
        String ctx = req.getContextPath();

        boolean isPublic =
               path.startsWith(ctx + "/login")
            || path.startsWith(ctx + "/register")
            || path.startsWith(ctx + "/forget")
            || path.contains("/uploads/")
            || path.contains("/css/")
            || path.contains("/js/")
            || path.contains("/images/")
            || path.contains("/fonts/");

        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        UserEntity user = (session == null) ? null :
                (UserEntity) session.getAttribute(Constant.SESSION_LOGIN);

        if (user == null) {
            resp.sendRedirect(ctx + "/login");
            return;
        }

        chain.doFilter(request, response);
    }
}

