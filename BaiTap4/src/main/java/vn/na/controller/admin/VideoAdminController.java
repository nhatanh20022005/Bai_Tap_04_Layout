package vn.na.controller.admin;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.na.entity.CategoryEntity;
import vn.na.entity.VideoEntity;
import vn.na.service.ICategoryService;
import vn.na.service.IVideoService;
import vn.na.service.impl.CategoryService;
import vn.na.service.impl.VideoService;

@WebServlet(urlPatterns = "/admin/videos")
@MultipartConfig
public class VideoAdminController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private IVideoService videoService = new VideoService();
    private ICategoryService cateService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String idStr  = req.getParameter("id");
        String keyword = req.getParameter("q"); // tìm kiếm

        if ("edit".equals(action) && idStr != null) {
            int id = Integer.parseInt(idStr);
            req.setAttribute("video", videoService.findById(id));
        }

        req.setAttribute("categories", cateService.findAll());
        req.setAttribute("list",
                (keyword == null) ? videoService.findAll()
                                  : videoService.search(keyword));

        req.setAttribute("q", keyword); // giữ lại giá trị search
        req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        try {
            if ("create".equals(action)) {
                VideoEntity v = extractVideo(req, false);
                videoService.create(v);

            } else if ("update".equals(action)) {
                VideoEntity v = extractVideo(req, true);
                videoService.update(v);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("videoid"));
                videoService.delete(id);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/videos");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("alert", e.getMessage());
            doGet(req, resp);  // load lại list + form
        }
    }

    private VideoEntity extractVideo(HttpServletRequest req, boolean isUpdate)
            throws IOException, ServletException {

        VideoEntity v = new VideoEntity();

        if (isUpdate) {
            v.setVideoId(Integer.parseInt(req.getParameter("videoid")));
        }

        v.setTitle(req.getParameter("title"));
        v.setDescription(req.getParameter("description"));
        v.setViews(Integer.parseInt(req.getParameter("views")));
        v.setActive("on".equals(req.getParameter("active")));

        // category
        int cateId = Integer.parseInt(req.getParameter("categoryid"));
        CategoryEntity cate = new CategoryEntity();
        cate.setCategoryId(cateId);
        v.setCategory(cate);

        // upload poster
        Part posterPart = req.getPart("posterFile");
        if (posterPart != null && posterPart.getSize() > 0) {

            String uploadPath = req.getServletContext()
                                   .getRealPath("/uploads/video/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String fileName = posterPart.getSubmittedFileName();
            String savedName = System.currentTimeMillis() + "_" + fileName;

            posterPart.write(uploadPath + savedName);

            v.setPoster(savedName);
        } else {
            // khi update, nếu ko chọn ảnh mới thì giữ ảnh cũ
            if (isUpdate) {
                v.setPoster(req.getParameter("posterOld"));
            }
        }

        return v;
    }
}
