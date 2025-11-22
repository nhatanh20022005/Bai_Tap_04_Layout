package vn.Quan.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.Quan.entity.UserEntity;
import vn.Quan.service.IUserService;
import vn.Quan.service.impl.UserService;

@WebServlet(urlPatterns = "/admin/users")
@MultipartConfig
public class AdminUserController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserService();

    private static final String UPLOAD_DIR =
            System.getProperty("user.dir")
                    + File.separator + "src"
                    + File.separator + "main"
                    + File.separator + "webapp"
                    + File.separator + "uploads"
                    + File.separator + "user";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String username = req.getParameter("username");

        if ("edit".equals(action) && username != null) {
            UserEntity user = userService.findById(username);
            req.setAttribute("userEdit", user);
        }

        List<UserEntity> list = userService.findAll();
        req.setAttribute("list", list);

        req.getRequestDispatcher("/views/admin/user-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        switch (action) {

            case "create":
                createUser(req, resp);
                break;

            case "update":
                updateUser(req, resp);
                break;

            case "delete":
                deleteUser(req, resp);
                break;
        }
    }

    private void createUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String fullname = req.getParameter("fullname");
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");
            boolean admin = req.getParameter("admin") != null;
            boolean active = req.getParameter("active") != null;

            Part avatarPart = req.getPart("avatar");

            UserEntity u = new UserEntity();
            u.setUsername(username);
            u.setPassword(password);
            u.setPhone(phone);
            u.setFullname(fullname);
            u.setEmail(email);
            u.setAdmin(admin);
            u.setActive(active);

            // SAVE AVATAR
            if (avatarPart != null && avatarPart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" +
                        Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();

                Files.createDirectories(Paths.get(UPLOAD_DIR));

                avatarPart.write(UPLOAD_DIR + File.separator + fileName);

                u.setImages(fileName);
            } else {
                u.setImages("default.png");
            }

            userService.create(u);

            resp.sendRedirect("users");

        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("alert", ex.getMessage());
            doGet(req, resp);
        }
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String fullname = req.getParameter("fullname");
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");
            boolean admin = req.getParameter("admin") != null;
            boolean active = req.getParameter("active") != null;

            String avatarOld = req.getParameter("avatarOld");

            Part avatarPart = req.getPart("avatar");

            UserEntity u = userService.findById(username);

            u.setPassword(password);
            u.setPhone(phone);
            u.setFullname(fullname);
            u.setEmail(email);
            u.setAdmin(admin);
            u.setActive(active);

            if (avatarPart != null && avatarPart.getSize() > 0) {

                String fileName = System.currentTimeMillis() + "_" +
                        Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();

                Files.createDirectories(Paths.get(UPLOAD_DIR));

                avatarPart.write(UPLOAD_DIR + File.separator + fileName);

                u.setImages(fileName);
            } else {
                u.setImages(avatarOld);
            }

            userService.update(u);

            resp.sendRedirect("users");

        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("alert", ex.getMessage());
            doGet(req, resp);
        }
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String username = req.getParameter("username");

        try {
            userService.delete(username);
            resp.sendRedirect("users");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
