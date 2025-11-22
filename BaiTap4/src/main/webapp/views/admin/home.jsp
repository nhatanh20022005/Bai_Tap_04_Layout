<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .welcome-banner {
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
            color: white;
            padding: 2.5rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(78, 115, 223, 0.3);
        }
        .dashboard-card {
            border: none;
            border-radius: 12px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            height: 100%;
            text-decoration: none;
            display: block;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .icon-box {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        .bg-blue-soft { background-color: #e1f0ff; color: #0d6efd; }
        .bg-green-soft { background-color: #d1e7dd; color: #198754; }
        .bg-purple-soft { background-color: #e0cffc; color: #6f42c1; }
        .bg-red-soft { background-color: #f8d7da; color: #dc3545; }

        .card-title {
            color: #333;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .card-desc {
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>
</head>
<body class="container mt-4 mb-5">

    <!-- Welcome -->
    <div class="welcome-banner d-flex justify-content-between align-items-center">
        <div>
            <h2 class="mb-1">Xin chào, ${username}! 👋</h2>
            <p class="mb-0 opacity-75">Chào mừng trở lại hệ thống quản trị.</p>
        </div>
        <div class="d-none d-md-block">
            <i class="fa-solid fa-user-shield fa-3x opacity-50"></i>
        </div>
    </div>

    <h5 class="text-muted mb-4 ms-1">DANH MỤC QUẢN LÝ</h5>

    <div class="row g-4">

        <!-- Category -->
        <div class="col-md-6 col-lg-4">
            <a href="${pageContext.request.contextPath}/admin/category" class="card dashboard-card">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center">
                        <div class="icon-box bg-blue-soft me-3">
                            <i class="fa-solid fa-layer-group"></i>
                        </div>
                        <div>
                            <h5 class="card-title mb-1">Quản lý Category</h5>
                            <p class="card-desc mb-0">Thêm, sửa, xóa danh mục video</p>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Video -->
        <div class="col-md-6 col-lg-4">
            <a href="${pageContext.request.contextPath}/admin/video" class="card dashboard-card">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center">
                        <div class="icon-box bg-green-soft me-3">
                            <i class="fa-solid fa-film"></i>
                        </div>
                        <div>
                            <h5 class="card-title mb-1">Quản lý Video</h5>
                            <p class="card-desc mb-0">Danh sách video, đăng video mới</p>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- User -->
        <div class="col-md-6 col-lg-4">
            <a href="${pageContext.request.contextPath}/admin/users" class="card dashboard-card">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center">
                        <div class="icon-box bg-purple-soft me-3">
                            <i class="fa-solid fa-users"></i>
                        </div>
                        <div>
                            <h5 class="card-title mb-1">Quản lý Người dùng</h5>
                            <p class="card-desc mb-0">Tài khoản và phân quyền</p>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <!-- Logout -->
        <div class="col-md-6 col-lg-4">
            <a href="${pageContext.request.contextPath}/logout"
               class="card dashboard-card border-danger border-opacity-25">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center">
                        <div class="icon-box bg-red-soft me-3">
                            <i class="fa-solid fa-right-from-bracket"></i>
                        </div>
                        <div>
                            <h5 class="card-title text-danger mb-1">Đăng xuất</h5>
                            <p class="card-desc mb-0">Thoát khỏi hệ thống</p>
                        </div>
                    </div>
                </div>
            </a>
        </div>

    </div>

</body>
</html>
