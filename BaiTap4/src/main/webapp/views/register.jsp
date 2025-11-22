<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Register" />

<!-- BEGIN CONTENT -->
<div class="col-md-9 col-sm-9">
    <h1>Register</h1>

    <div class="content-form-page">
        <div class="row">
        
            <!-- FORM REGISTER -->
            <div class="col-md-7 col-sm-7">

                <form class="form-horizontal form-without-legend"
                      role="form"
                      action="${pageContext.request.contextPath}/register"
                      method="post">

                    <!-- HIỂN THỊ ALERT -->
                    <c:if test="${alert != null}">
                        <div class="alert alert-danger">${alert}</div>
                    </c:if>

                    <!-- Username -->
                    <div class="form-group">
                        <label class="col-lg-4 control-label">
                            Username <span class="require">*</span>
                        </label>
                        <div class="col-lg-8">
                            <input type="text"
                                   class="form-control"
                                   name="username"
                                   value="${param.username}"
                                   required>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label class="col-lg-4 control-label">
                            Password <span class="require">*</span>
                        </label>
                        <div class="col-lg-8">
                            <input type="password"
                                   class="form-control"
                                   name="password"
                                   required>
                        </div>
                    </div>

                    <!-- Fullname -->
                    <div class="form-group">
                        <label class="col-lg-4 control-label">
                            Full Name <span class="require">*</span>
                        </label>
                        <div class="col-lg-8">
                            <input type="text"
                                   class="form-control"
                                   name="fullname"
                                   value="${param.fullname}"
                                   required>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label class="col-lg-4 control-label">
                            Email <span class="require">*</span>
                        </label>
                        <div class="col-lg-8">
                            <input type="email"
                                   class="form-control"
                                   name="email"
                                   value="${param.email}"
                                   required>
                        </div>
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label class="col-lg-4 control-label">
                            Phone <span class="require">*</span>
                        </label>
                        <div class="col-lg-8">
                            <input type="text"
                                   class="form-control"
                                   name="phone"
                                   value="${param.phone}"
                                   required>
                        </div>
                    </div>

                    <!-- Register button -->
                    <div class="row">
                        <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
                            <button type="submit" class="btn btn-primary">Register</button>
                        </div>
                    </div>

                    <!-- LOGIN LINK -->
                    <div class="row">
                        <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
                            Already have an account?
                            <a href="${pageContext.request.contextPath}/login">Login</a>
                        </div>
                    </div>

                </form>
            </div>

            <!-- RIGHT BOX -->
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
