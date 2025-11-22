<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật danh mục</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .card-header {
            background: linear-gradient(45deg, #f6c23e, #fd7e14);
            color: white;
            padding: 1rem 1.5rem;
            font-weight: 600;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .preview-img {
            width: 130px;
            height: 130px;
            object-fit: contain;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            padding: 6px;
            background: white;
        }
    </style>
</head>

<body class="py-5">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                
                <div class="card">
                    <div class="card-header">
                        <span><i class="fa-solid fa-pen-to-square me-2"></i> Cập nhật danh mục</span>
                        <span class="badge bg-light text-dark float-end">ID: ${cate.cateId}</span>
                    </div>

                    <div class="card-body p-4">
                        
                        <form action="${pageContext.request.contextPath}/admin/categories/edit" 
                              method="post" 
                              enctype="multipart/form-data">

                            <input type="hidden" name="cate_id" value="${cate.cateId}">

                            <!-- Tên danh mục -->
                            <div class="mb-4">
                                <label class="form-label">
                                    <i class="fa-solid fa-tag me-2"></i>Tên danh mục <span class="text-danger">*</span>
                                </label>
                                <input type="text" 
                                       class="form-control form-control-lg" 
                                       name="cate_name" 
                                       value="${cate.cateName}" 
                                       required>
                            </div>

                            <!-- Icon hiện tại -->
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fa-solid fa-image me-2"></i>Icon hiện tại
                                </label>
                                <div>
                                    <img src="${pageContext.request.contextPath}/uploads/category/${cate.icons}" 
                                         class="preview-img"
                                         alt="ko có icon">
                                </div>
                            </div>

                            <!-- Upload icon mới -->
                            <div class="mb-4">
                                <label class="form-label">
                                    <i class="fa-solid fa-upload me-2"></i>Chọn icon mới (tùy chọn)
                                </label>
                                <input type="file"
                                       class="form-control"
                                       name="iconFile"
                                       id="iconFile"
                                       accept="image/*">

                                <!-- Preview -->
                                <div class="mt-3">
                                    <img id="preview" class="preview-img" style="display:none;">
                                </div>

                                <div class="form-text text-muted small">
                                    Nếu ko chọn ảnh mới → icon cũ sẽ được giữ nguyên.
                                </div>
                            </div>

                            <hr class="my-4">

                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/categories" 
                                   class="btn btn-light text-secondary border">
                                    <i class="fa-solid fa-arrow-left me-1"></i> Hủy bỏ
                                </a>
                                
                                <button type="submit" class="btn btn-warning text-white fw-bold px-4">
                                    <i class="fa-solid fa-check me-1"></i> Cập nhật
                                </button>
                            </div>

                        </form>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Preview ảnh mới -->
    <script>
        document.getElementById('iconFile').addEventListener('change', function(e) {
            const preview = document.getElementById('preview');
            const file = e.target.files[0];

            if (file) {
                preview.src = URL.createObjectURL(file);
                preview.style.display = 'block';
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
