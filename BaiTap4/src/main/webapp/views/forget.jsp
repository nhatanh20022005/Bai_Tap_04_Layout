<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #74ABE2, #5563DE);
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0;
    }

    form {
        background-color: #fff;
        border-radius: 15px;
        box-shadow: 0 4px 25px rgba(0, 0, 0, 0.2);
        padding: 40px 50px;
        width: 380px;
        animation: fadeIn 0.6s ease-in-out;
    }

    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(-20px);}
        to {opacity: 1; transform: translateY(0);}
    }

    h2 {
        text-align: center;
        color: #333;
        margin-bottom: 25px;
    }

    label {
        font-weight: bold;
        color: #333;
        display: block;
        margin-top: 10px;
        margin-bottom: 5px;
    }

    input[type=email] {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 14px;
        transition: 0.3s ease;
    }

    input[type=email]:focus {
        border-color: #5563DE;
        box-shadow: 0 0 5px rgba(85, 99, 222, 0.5);
        outline: none;
    }

    button[type=submit] {
        background-color: #5563DE;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        padding: 12px;
        width: 100%;
        font-size: 15px;
        margin-top: 20px;
        transition: background 0.3s ease;
    }

    button[type=submit]:hover {
        background-color: #3c4bc5;
    }

    .alert-error {
        text-align: center;
        color: white;
        background-color: #e74c3c;
        padding: 10px;
        border-radius: 8px;
        margin-bottom: 15px;
        font-size: 14px;
    }

    .alert-success {
        text-align: center;
        color: white;
        background-color: #2ecc71;
        padding: 10px;
        border-radius: 8px;
        margin-bottom: 15px;
        font-size: 14px;
    }

    .login-link {
        text-align: center;
        margin-top: 15px;
    }

    .login-link a {
        text-decoration: none;
        color: #5563DE;
        font-weight: bold;
        transition: 0.2s;
    }

    .login-link a:hover {
        text-decoration: underline;
    }
</style>
</head>

<body>

<form action="${pageContext.request.contextPath}/forget" method="post">

    <h2>🔑 Forgot Password</h2>

    <!-- Hiển thị lỗi -->
    <c:if test="${alert != null && alert.contains('ko')}">
        <div class="alert-error">${alert}</div>
    </c:if>

    <!-- Hiển thị password -->
    <c:if test="${alert != null && !alert.contains('ko')}">
        <div class="alert-success">${alert}</div>
    </c:if>

    <label>Email</label>
    <input type="email" name="email" placeholder="Enter your email" required>

    <button type="submit">Retrieve Password</button>

    <div class="login-link">
        <a href="${pageContext.request.contextPath}/login">⬅ Back to Login</a>
    </div>

</form>

</body>
</html>
