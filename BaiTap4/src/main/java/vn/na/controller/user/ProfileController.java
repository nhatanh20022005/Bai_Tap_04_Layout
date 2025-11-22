package vn.na.controller.user;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.na.entity.UserEntity;
import vn.na.service.IUserService;
import vn.na.service.impl.UserService;
import vn.na.utils.Constant;

@WebServlet(urlPatterns = "/user/profile")
@MultipartConfig
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_LOGIN) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_LOGIN) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        UserEntity sessionUser = (UserEntity) session.getAttribute(Constant.SESSION_LOGIN);

        String username = sessionUser.getUsername();
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        Part imagePart = req.getPart("images");

        try {
            // Lấy user từ DB
            UserEntity user = userService.findById(username);

            user.setFullname(fullname);
            user.setPhone(phone);

            // Xử lý upload file ảnh
            if (imagePart != null && imagePart.getSize() > 0) {

                // Lấy đường dẫn thực tế uploads/user
                String uploadPath = req.getServletContext().getRealPath("/uploads/user/");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                // Lấy tên file
                String fileName = imagePart.getSubmittedFileName();
                String savedFile = System.currentTimeMillis() + "_" + fileName;

                // Lưu file
                imagePart.write(uploadPath + savedFile);

                // Ghi tên file vào DB
                user.setImages(savedFile);
            }

            // Cập nhật DB
            userService.update(user);

            // cập nhật lại session
            session.setAttribute(Constant.SESSION_LOGIN, user);

            req.setAttribute("alert", "Cập nhật hồ sơ thành công!");
            req.setAttribute("user", user);

            req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
        }
    }
}
