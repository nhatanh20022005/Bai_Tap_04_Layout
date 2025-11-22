<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>

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
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(45deg, #4e73df, #224abe);
            color: white;
            padding: 1rem 1.5rem;
            font-weight: 600;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .preview-img {
            width: 120px;
            height: 120px;
            object-fit: contain;
            border: 1px solid #dee2e6;
            background: white;
            padding: 6px;
            border-radius: 6px;
            display: none;
        }
    </style>
</head>

<body class="py-5">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">

                <div class="card">
                    <div class="card-header">
                        <i class="fa-solid fa-plus-circle me-2"></i> Thêm danh mục mới
                    </div>
                    
                    <div class="card-body p-4">

                        <!-- FORM MULTIPART -->
                        <form action="${pageContext.request.contextPath}/admin/categories/add"
                              method="post"
                              enctype="multipart/form-data">

                            <!-- Tên danh mục -->
                            <div class="mb-4">
                                <label class="form-label">
                                    <i class="fa-solid fa-tag me-2"></i>Tên danh mục <span class="text-danger">*</span>
                                </label>
                                <input type="text"
                                       class="form-control form-control-lg"
                                       name="cate_name"
                                       placeholder="Ví dụ: Điện thoại, Thời trang..."
                                       required>
                            </div>

                            <!-- Upload icon -->
                            <div class="mb-4">
                                <label class="form-label">
                                    <i class="fa-solid fa-image me-2"></i>Icon (hình ảnh)
                                </label>
                                <input type="file"
                                       class="form-control"
                                       name="iconFile"
                                       id="iconFile"
                                       accept="image/*"
                                       required>

                                <!-- Preview -->
                                <div class="mt-3">
                                    <img id="preview" class="preview-img">
                                </div>

                                <div class="form-text text-muted small">
                                    Chấp nhận: JPG, PNG, GIF — tải ảnh icon của danh mục.
                                </div>
                            </div>

                            <hr class="my-4">

                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/categories"
                                   class="btn btn-light text-secondary border">
                                   <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                                </a>

                                <button type="submit" class="btn btn-primary px-4 fw-bold">
                                    <i class="fa-solid fa-save me-1"></i> Lưu lại
                                </button>
                            </div>

                        </form>

                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Script Preview Ảnh -->
    <script>
        document.getElementById('iconFile').addEventListener('change', function(event) {
            const preview = document.getElementById('preview');
            const file = event.target.files[0];

            if (file) {
                preview.src = URL.createObjectURL(file);
                preview.style.display = 'block';
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
