<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet"> 
    </head>
    <body>
        <div class="container">
            <h1>Very Good Building and Development Company Blog</h1>
            <hr/>
            <div class="navbar">
                <ul class="nav nav-tabs">
                    <li role="presentation"><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/displayLogin">Login</a></li>
                </ul>    
            </div>
            <div class="row">
                <c:if test="${param.login_error == 1}">
                    <h3>Wrong id or password!</h3>
                </c:if>
                <form class="form-horizontal" 
                      role="form" 
                      method="post" 
                      action="j_spring_security_check">
                    <div class="form-group">
                        <label for="j_username" class="col-md-4 control-label">Username:</label>
                        <div class="col-md-8">
                            <input type="text" class="form-control" name="j_username" placeholder="Username"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="j_password" class="col-md-4 control-label">Password:</label>
                        <div class="col-md-8">
                            <input type="password" class="form-control" name="j_password" placeholder="Password"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-4 col-md-8">
                            <input type="submit" class="btn btn-default" id="search-button" value="Sign In"/>
                        </div>
                    </div>
                </form>
                <a href="displayUserForm">Create Account</a><br/>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    </body>
</html>
