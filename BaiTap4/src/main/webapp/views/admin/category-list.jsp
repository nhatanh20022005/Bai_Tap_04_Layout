<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Category</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

    <style>
        body {
            background-color: #f7f7f7;
        }
        .page-title {
            color: #2c3e50;
            font-weight: 600;
        }
        .cate-img {
            width: 55px;
            height: 55px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #eee;
        }
        .card-custom {
            border-radius: 12px;
            border: none;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .btn-add {
            background-color: #0d6efd;
            color: white;
        }
        .btn-add:hover {
            background-color: #0b5ed7;
        }
        .modal-header {
            background: #0d6efd;
            color: white;
        }
        .table th {
            background: #fafafa;
        }
    </style>
</head>

<body class="container mt-4">

    <h3 class="page-title mb-4">📂 Quản lý Category</h3>

    <!-- Alert -->
    <c:if test="${alert != null}">
        <div class="alert alert-warning">${alert}</div>
    </c:if>

    <div class="card card-custom p-4">

        <!-- Button mở modal Add -->
        <button class="btn btn-add mb-3"
                data-bs-toggle="modal"
                data-bs-target="#modalAdd">
            + Thêm Category
        </button>

        <!-- Table -->
        <table class="table table-hover align-middle">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên Category</th>
                <th>Code</th>
                <th>Ảnh</th>
                <th>Status</th>
                <th class="text-center">Hành động</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="c" items="${list}">
                <tr>
                    <td>${c.categoryId}</td>
                    <td>${c.categoryName}</td>
                    <td>${c.categoryCode}</td>

                    <td>
                        <img src="${pageContext.request.contextPath}/uploads/${c.images}"
                             class="cate-img"
                             onerror="this.src='https://via.placeholder.com/55'">
                    </td>

                    <td>
                        <span class="badge ${c.status ? 'bg-success' : 'bg-secondary'}">
                            ${c.status ? 'Active' : 'Inactive'}
                        </span>
                    </td>

                    <td class="text-center">
                        <button class="btn btn-warning btn-sm"
                                data-bs-toggle="modal"
                                data-bs-target="#modalEdit${c.categoryId}">
                            Sửa
                        </button>

                        <form action="${pageContext.request.contextPath}/admin/categories"
                              method="post"
                              style="display:inline">

                            <input type="hidden" name="categoryid" value="${c.categoryId}">
                            <input type="hidden" name="action" value="delete">

                            <button class="btn btn-danger btn-sm"
                                    onclick="return confirm('Xóa category này?')">
                                Xóa
                            </button>
                        </form>
                    </td>
                </tr>

                <!-- Modal Edit -->
                <div class="modal fade" id="modalEdit${c.categoryId}">
                    <div class="modal-dialog modal-lg">
                        <form class="modal-content"
                              action="${pageContext.request.contextPath}/admin/categories"
                              method="post" enctype="multipart/form-data">

                            <div class="modal-header">
                                <h5 class="modal-title">Sửa Category</h5>
                                <button type="button" class="btn-close"
                                        data-bs-dismiss="modal"></button>
                            </div>

                            <div class="modal-body">

                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="categoryid" value="${c.categoryId}">

                                <div class="mb-3">
                                    <label class="form-label">Tên Category</label>
                                    <input type="text" name="categoryname"
                                           value="${c.categoryName}"
                                           class="form-control" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Code</label>
                                    <input type="text" name="categorycode"
                                           value="${c.categoryCode}"
                                           class="form-control">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Status</label>
                                    <input type="checkbox"
                                           name="status"
                                           ${c.status ? "checked" : ""}> Active
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Ảnh</label>
                                    <input type="file" name="images" class="form-control">
                                </div>

                                <div>
                                    <img src="${pageContext.request.contextPath}/uploads/${c.images}"
                                         class="cate-img">
                                </div>

                            </div>

                            <div class="modal-footer">
                                <button class="btn btn-primary">Lưu thay đổi</button>
                                <button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Đóng</button>
                            </div>

                        </form>
                    </div>
                </div>

            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Modal Add -->
    <div class="modal fade" id="modalAdd">
        <div class="modal-dialog modal-lg">
            <form class="modal-content"
                  action="${pageContext.request.contextPath}/admin/categories"
                  method="post"
                  enctype="multipart/form-data">

                <div class="modal-header">
                    <h5 class="modal-title">Thêm Category</h5>
                    <button type="button" class="btn-close"
                            data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <input type="hidden" name="action" value="create">

                    <div class="mb-3">
                        <label class="form-label">Tên Category</label>
                        <input type="text" name="categoryname"
                               class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Code</label>
                        <input type="text" name="categorycode" class="form-control">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <input type="checkbox" name="status"> Active
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Ảnh</label>
                        <input type="file" name="images" class="form-control" required>
                    </div>

                </div>

                <div class="modal-footer">
                    <button class="btn btn-primary">Thêm</button>
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Đóng</button>
                </div>

            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
