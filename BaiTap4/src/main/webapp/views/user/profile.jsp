<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #fffbea; }

        .banner {
            background: linear-gradient(135deg, #ffc107, #ff9800);
            color: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(255,152,0,0.35);
        }

        .profile-img {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #ffe08a;
            margin-bottom: 10px;
        }

        .form-control {
            border-radius: 10px;
        }

        .btn-save {
            background-color: #ffa000;
            border: none;
        }
        .btn-save:hover {
            background-color: #ff8f00;
        }

        .btn-logout {
            background-color: #ff7043;
            border: none;
        }
        .btn-logout:hover {
            background-color: #e64a19;
        }

        .alert-box {
            background: #ff5252;
            color: white;
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 15px;
        }

    </style>
</head>

<body class="container mt-4">

    <!-- Banner -->
    <div class="banner d-flex justify-content-between align-items-center">
        <div>
            <h2 class="mb-1">Trang cá nhân</h2>
            <p class="mb-0">Chào mừng, <b>${sessionScope.account.username}</b> 👋</p>
        </div>
        <i class="fa-solid fa-user fa-3x opacity-75"></i>
    </div>

    <div class="card p-4 shadow-sm">

        <c:if test="${alert != null}">
            <div class="alert alert-warning text-center">${alert}</div>
        </c:if>

        <div class="text-center">
            <img src="${pageContext.request.contextPath}/uploads/user/${sessionScope.account.images}"
                 class="profile-img"
                 onerror="this.src='https://via.placeholder.com/130?text=No+Img'">
        </div>

        <!-- FORM UPDATE PROFILE -->
        <form action="${pageContext.request.contextPath}/user/profile"
              method="post"
              enctype="multipart/form-data">

            <div class="mb-3">
                <label class="form-label">Họ & tên</label>
                <input type="text" class="form-control"
                       name="fullname"
                       value="${sessionScope.account.fullname}"
                       required>
            </div>

            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <input type="text" class="form-control"
                       name="phone"
                       value="${sessionScope.account.phone}"
                       required>
            </div>

            <div class="mb-3">
                <label class="form-label">Ảnh đại diện</label>
                <input type="file" class="form-control" name="images" accept="image/*">
            </div>

            <button class="btn btn-save text-white px-4" type="submit">
                <i class="fa-solid fa-save me-2"></i>Lưu thay đổi
            </button>

            <a href="${pageContext.request.contextPath}/logout"
               class="btn btn-logout text-white float-end px-4">
                <i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất
            </a>

        </form>
    </div>

</body>
</html>
