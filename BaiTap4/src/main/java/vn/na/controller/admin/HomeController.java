package vn.na.controller.admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.na.entity.CategoryEntity;
import vn.na.entity.UserEntity;
import vn.na.service.ICategoryService;
import vn.na.service.impl.CategoryService;
import vn.na.utils.Constant;

@WebServlet(urlPatterns = "/admin/home")
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    ICategoryService cateService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession ses = req.getSession(false);
        if (ses == null || ses.getAttribute(Constant.SESSION_LOGIN) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        UserEntity user = (UserEntity) ses.getAttribute(Constant.SESSION_LOGIN);

        if (!user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/user/home");
            return;
        }

        List<CategoryEntity> list = cateService.findAll();
        req.setAttribute("listcate", list);

        req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
    }
}
