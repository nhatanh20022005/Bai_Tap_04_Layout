<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Video</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body { background-color: #f4f6fa; }
        .page-title { color: #4a4a4a; font-weight: 600; }
        .poster-img { width: 70px; height: 50px; object-fit: cover; border-radius: 6px; }
        .modal-title { font-weight: bold; }
        .btn-add { background-color: #28a745; color: white; }
        .btn-add:hover { background-color: #218838; }
    </style>
</head>

<body class="container mt-4">

    <h3 class="page-title mb-3">
        <i class="fa-solid fa-film me-2"></i>Quản lý Video
    </h3>

    <!-- ALERT -->
    <c:if test="${alert != null}">
        <div class="alert alert-warning text-center">${alert}</div>
    </c:if>

    <!-- SEARCH + ADD BUTTON -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <form class="d-flex" method="get" action="${pageContext.request.contextPath}/admin/videos">
            <input type="text" class="form-control" name="q" placeholder="Tìm theo tiêu đề..."
                   value="${q}" style="width: 260px;">
            <button class="btn btn-primary ms-2">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </form>

        <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addModal">
            <i class="fa-solid fa-plus me-1"></i>Thêm Video
        </button>
    </div>

    <!-- VIDEO LIST TABLE -->
    <div class="card shadow-sm">
        <div class="card-body">

            <c:if test="${empty list}">
                <div class="text-center text-muted py-4">
                    <i class="fa-regular fa-folder-open fa-3x mb-3"></i>
                    <p>ko có video nào.</p>
                </div>
            </c:if>

            <c:if test="${not empty list}">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Tiêu đề</th>
                        <th>Poster</th>
                        <th>Category</th>
                        <th>Lượt xem</th>
                        <th>Active</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="v" items="${list}">
                        <tr>
                            <td>${v.videoId}</td>
                            <td>${v.title}</td>

                            <td>
                                <img src="${pageContext.request.contextPath}/uploads/video/${v.poster}"
                                     class="poster-img"
                                     onerror="this.src='https://via.placeholder.com/70x50?text=No+Img'">
                            </td>

                            <td>${v.category.categoryName}</td>
                            <td>${v.views}</td>
                            <td>
                                <span class="badge ${v.active ? 'bg-success' : 'bg-secondary'}">
                                    ${v.active ? 'Yes' : 'No'}
                                </span>
                            </td>

                            <td>
                                <!-- EDIT BUTTON -->
                                <a href="${pageContext.request.contextPath}/admin/videos?action=edit&id=${v.videoId}"
                                   class="btn btn-warning btn-sm">
                                    <i class="fa-solid fa-pen"></i>
                                </a>

                                <!-- DELETE -->
                                <form action="${pageContext.request.contextPath}/admin/videos" 
                                      method="post" class="d-inline">
                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="videoid" value="${v.videoId}"/>
                                    <button class="btn btn-danger btn-sm"
                                            onclick="return confirm('Bạn chắc chắn muốn xóa video này?')">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>

        </div>
    </div>


    <!-- ================================================================= -->
    <!--                       ADD VIDEO MODAL                             -->
    <!-- ================================================================= -->
    <div class="modal fade" id="addModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <form method="post" enctype="multipart/form-data"
                      action="${pageContext.request.contextPath}/admin/videos">

                    <input type="hidden" name="action" value="create"/>

                    <div class="modal-header">
                        <h5 class="modal-title">Thêm Video mới</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">

                        <div class="mb-3">
                            <label class="form-label">Tiêu đề</label>
                            <input type="text" name="title" class="form-control" required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select name="categoryid" class="form-select" required>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.categoryId}">
                                        ${c.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Poster (ảnh)</label>
                            <input type="file" name="posterFile" class="form-control" accept="image/*" required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea name="description" rows="3" class="form-control"></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Lượt xem</label>
                            <input type="number" name="views" class="form-control" value="0" required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Active</label>
                            <input type="checkbox" name="active"/>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button class="btn btn-success">Lưu</button>
                    </div>

                </form>

            </div>
        </div>
    </div>


    <c:if test="${not empty video}">
    <script>
        window.addEventListener("load", function () {
            new bootstrap.Modal(document.getElementById("editModal")).show();
        });
    </script>

    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <form method="post" enctype="multipart/form-data"
                      action="${pageContext.request.contextPath}/admin/videos">

                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="videoid" value="${video.videoId}"/>
                    <input type="hidden" name="posterOld" value="${video.poster}"/>

                    <div class="modal-header">
                        <h5 class="modal-title">Chỉnh sửa Video</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">

                        <div class="mb-3">
                            <label class="form-label">Tiêu đề</label>
                            <input type="text" name="title"
                                   value="${video.title}"
                                   class="form-control" required/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select name="categoryid" class="form-select">
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.categoryId}"
                                            <c:if test="${c.categoryId == video.category.categoryId}">selected</c:if>>
                                        ${c.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Poster hiện tại</label><br>
                            <img src="${pageContext.request.contextPath}/uploads/video/${video.poster}"
                                 class="poster-img mb-2">
                            <input type="file" name="posterFile" class="form-control" accept="image/*"/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea name="description" class="form-control"
                                      rows="3">${video.description}</textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Lượt xem</label>
                            <input type="number" name="views" class="form-control"
                                   value="${video.views}"/>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Active</label>
                            <input type="checkbox" name="active"
                                   <c:if test="${video.active}">checked</c:if> />
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button class="btn btn-primary">Cập nhật</button>
                    </div>

                </form>

            </div>
        </div>
    </div>

    </c:if>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
