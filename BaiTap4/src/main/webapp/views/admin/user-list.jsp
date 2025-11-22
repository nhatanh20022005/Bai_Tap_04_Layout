<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý tài khoản</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>

    <style>
        body { background-color: #f4f6fa; }
        .avatar-img { width: 60px; height: 60px; border-radius: 50%; object-fit: cover; }
        .btn-add { background-color: #28a745; color: white; }
        .btn-add:hover { background-color: #218838; }
        .page-title { color: #333; font-weight: 600; }
    </style>
</head>

<body class="container mt-4">

<h3 class="page-title">
    <i class="fa-solid fa-users me-2"></i>Quản lý người dùng
</h3>

<c:if test="${alert != null}">
    <div class="alert alert-warning">${alert}</div>
</c:if>

<!-- BUTTON ADD -->
<div class="text-end mb-3">
    <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#addModal">
        <i class="fa-solid fa-plus me-1"></i>Thêm tài khoản
    </button>
</div>

<!-- USER TABLE -->
<div class="card shadow-sm">
    <div class="card-body">

        <table class="table table-hover align-middle">
            <thead class="table-light">
            <tr>
                <th>Avatar</th>
                <th>Username</th>
                <th>Họ tên</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Admin</th>
                <th>Active</th>
                <th>Thao tác</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="u" items="${list}">
                <tr>
                    <td>
                        <img src="${pageContext.request.contextPath}/uploads/user/${u.images}"
                             class="avatar-img"
                             onerror="this.src='https://via.placeholder.com/60?text=No+Img'">
                    </td>

                    <td>${u.username}</td>
                    <td>${u.fullname}</td>
                    <td>${u.email}</td>
                    <td>${u.phone}</td>

                    <td>
                        <span class="badge ${u.admin ? 'bg-success' : 'bg-secondary'}">
                            ${u.admin ? 'Admin' : 'User'}
                        </span>
                    </td>

                    <td>
                        <span class="badge ${u.active ? 'bg-primary' : 'bg-dark'}">
                            ${u.active ? 'Yes' : 'No'}
                        </span>
                    </td>

                    <td>
                        <!-- EDIT -->
                        <a href="${pageContext.request.contextPath}/admin/users?action=edit&username=${u.username}"
                           class="btn btn-warning btn-sm">
                            <i class="fa-solid fa-pen"></i>
                        </a>

                        <!-- DELETE -->
                        <form class="d-inline" method="post"
                              action="${pageContext.request.contextPath}/admin/users">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="username" value="${u.username}"/>
                            <button class="btn btn-danger btn-sm"
                                    onclick="return confirm('Xóa tài khoản này?')">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>

        </table>

    </div>
</div>

<!-- ======================== ADD MODAL ======================== -->
<div class="modal fade" id="addModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <form method="post" enctype="multipart/form-data"
                  action="${pageContext.request.contextPath}/admin/users">

                <input type="hidden" name="action" value="create"/>

                <div class="modal-header">
                    <h5 class="modal-title">Thêm tài khoản</h5>
                    <button class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-6">

                            <label class="form-label">Username</label>
                            <input type="text" name="username" required class="form-control"/>

                            <label class="form-label mt-3">Password</label>
                            <input type="password" name="password" required class="form-control"/>

                            <label class="form-label mt-3">Fullname</label>
                            <input type="text" name="fullname" required class="form-control"/>

                            <label class="form-label mt-3">Phone</label>
                            <input type="text" name="phone" required class="form-control"/>

                        </div>

                        <div class="col-md-6">

                            <label class="form-label">Email</label>
                            <input type="email" name="email" required class="form-control"/>

                            <label class="form-label mt-3">Avatar</label>
                            <input type="file" name="avatar" class="form-control" accept="image/*"/>

                            <div class="form-check mt-3">
                                <input class="form-check-input" type="checkbox" name="admin">
                                <label class="form-check-label">Admin?</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="active" checked>
                                <label class="form-check-label">Active</label>
                            </div>

                        </div>

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

<!-- ======================== EDIT MODAL ======================== -->
<c:if test="${not empty userEdit}">
<script>
    new bootstrap.Modal(document.getElementById("editModal")).show();
</script>

<div class="modal fade" id="editModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <form method="post" enctype="multipart/form-data"
                  action="${pageContext.request.contextPath}/admin/users">

                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="username" value="${userEdit.username}"/>
                <input type="hidden" name="avatarOld" value="${userEdit.images}"/>

                <div class="modal-header">
                    <h5 class="modal-title">Cập nhật tài khoản</h5>
                    <button class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-6">

                            <label class="form-label">Password</label>
                            <input type="password" name="password"
                                   value="${userEdit.password}" required class="form-control"/>

                            <label class="form-label mt-3">Fullname</label>
                            <input type="text" name="fullname"
                                   value="${userEdit.fullname}" required class="form-control"/>

                            <label class="form-label mt-3">Phone</label>
                            <input type="text" name="phone"
                                   value="${userEdit.phone}" required class="form-control"/>

                        </div>

                        <div class="col-md-6">

                            <label class="form-label">Email</label>
                            <input type="email" name="email"
                                   value="${userEdit.email}" required class="form-control"/>

                            <label class="form-label mt-3">Avatar</label>
                            <input type="file" name="avatar" class="form-control" accept="image/*"/>

                            <img src="${pageContext.request.contextPath}/uploads/user/${userEdit.images}"
                                 class="avatar-img mt-2 mb-2">

                            <div class="form-check mt-3">
                                <input class="form-check-input" type="checkbox" name="admin"
                                       <c:if test="${userEdit.admin}">checked</c:if>>
                                <label class="form-check-label">Admin?</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="active"
                                       <c:if test="${userEdit.active}">checked</c:if>>
                                <label class="form-check-label">Active</label>
                            </div>

                        </div>

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
