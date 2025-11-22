<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Login" />

<!-- BEGIN CONTENT -->
<div class="col-md-9 col-sm-9">
    <h1>Login</h1>

    <div class="content-form-page">
        <div class="row">
            <!-- FORM LOGIN -->
            <div class="col-md-7 col-sm-7">

                <!-- FORM: submit đúng Controller -->
                <form class="form-horizontal form-without-legend"
                      role="form"
                      action="${pageContext.request.contextPath}/login"
                      method="post">

                    <!-- HIỂN THỊ ALERT -->
                    <c:if test="${alert != null}">
                        <div class="alert alert-danger">${alert}</div>
                    </c:if>

                    <div class="form-group">
                        <label for="email" class="col-lg-4 control-label">
                            Username <span class="require">*</span>
                        </label>
                        <div class="col-lg-8">
                            <input type="text"
                                   class="form-control"
                                   id="email"
                                   name="uname"
                                   value="${rememberedUser}"
                                   required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password" class="col-lg-4 control-label">
                            Password <span class="require">*</span>
                        </label>
                        <div class="col-lg-8">
                            <input type="password"
                                   class="form-control"
                                   id="password"
                                   name="psw"
                                   required>
                        </div>
                    </div>

                    <!-- Remember me -->
                    <div class="row">
                        <div class="col-lg-8 col-md-offset-4 padding-left-0">
                            <label>
                                <input type="checkbox" 
                                       name="remember"
                                       ${rememberedUser != null ? "checked" : ""}>
                                Remember me
                            </label>
                        </div>
                    </div>

                    <!-- QUÊN MẬT KHẨU -->
                    <div class="row">
                        <div class="col-lg-8 col-md-offset-4 padding-left-0">
                            <a href="${pageContext.request.contextPath}/forget">
                                Forgot Password?
                            </a>
                        </div>
                    </div>

                    <!-- BUTTON LOGIN -->
                    <div class="row">
                        <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
                            <button type="submit" class="btn btn-primary">Login</button>
                        </div>
                    </div>

                    <!-- SOCIAL LOGIN -->
                    <div class="row">
                        <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-10 padding-right-30">
                            <hr>
                            <div class="login-socio">
                                <p class="text-muted">or login using:</p>
                                <ul class="social-icons">
                                    <li><a href="#" class="facebook" title="facebook"></a></li>
                                    <li><a href="#" class="twitter" title="Twitter"></a></li>
                                    <li><a href="#" class="googleplus" title="Google Plus"></a></li>
                                    <li><a href="#" class="linkedin" title="LinkedIn"></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </form>
            </div>

            <!-- BÊN PHẢI -->
            <div class="col-md-4 col-sm-4 pull-right">
                <div class="form-info">
                    <h2><em>Important</em> Information</h2>
                    <p>Duis autem vel eum iriure at dolor vulputate velit esse vel molestie at dolore.</p>

                    <button type="button" class="btn btn-default">More details</button>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- END CONTENT -->
