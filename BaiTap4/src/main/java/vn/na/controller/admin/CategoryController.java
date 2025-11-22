package vn.na.controller.admin;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import vn.na.entity.CategoryEntity;
import vn.na.service.ICategoryService;
import vn.na.service.impl.CategoryService;
import vn.na.utils.Constant;

@WebServlet(urlPatterns = "/admin/categories")
@MultipartConfig
public class CategoryController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ICategoryService service = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("edit".equals(action) && id != null) {
            req.setAttribute("cate", service.findById(Integer.parseInt(id)));
        }

        req.setAttribute("list", service.findAll());
        req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        try {
            if ("create".equals(action)) {
                CategoryEntity c = extract(req);
                service.create(c);
            } else if ("update".equals(action)) {
                CategoryEntity c = extract(req);
                c.setCategoryId(Integer.parseInt(req.getParameter("categoryid")));
                service.update(c);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("categoryid"));
                service.delete(id);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/categories");

        } catch (Exception e) {
            req.setAttribute("alert", e.getMessage());
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        }
    }

    private CategoryEntity extract(HttpServletRequest req) throws IOException, ServletException {

        CategoryEntity c = new CategoryEntity();

        c.setCategoryName(req.getParameter("categoryname"));
        c.setCategoryCode(req.getParameter("categorycode"));
        c.setStatus(req.getParameter("status") != null);

        Part img = req.getPart("images");
        if (img != null && img.getSize() > 0) {
            Files.createDirectories(Paths.get(Constant.DIR));
            String name = System.currentTimeMillis() + "_" + img.getSubmittedFileName();
            img.write(Constant.DIR + "/" + name);
            c.setImages(name);
        }

        return c;
    }
}
