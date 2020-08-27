<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Article Preview</title>
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
                    <li role="presentation"><a href="${pageContext.request.contextPath}/displayPostingPage">Post New Article</a></li>
                    <li role="presentation"><a href="${pageContext.request.contextPath}/displayAdminPage">Admin</a></li>
                    <li role="presentation"><a href="${pageContext.request.contextPath}/displayLogin">Login</a></li>
                </ul>    
            </div>
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <h4 style="text-align: right">Hello ${pageContext.request.userPrincipal.name}
                    | <a href="<c:url value="/j_spring_security_logout" />" > Logout</a>
                </h4>
            </c:if>
            <sf:form class="form-horizontal" role="form" modelAttribute="article" action="approveArticle" method="POST">
                <div class="form-group">
                    <label for="article-title" class="col-md-4 control-label">Title:</label>
                    <div class="col-md-6">
                        <sf:input type="text" class="form-control" id="article-title" path="title"/>
                        <sf:errors path="title" cssclass="error"></sf:errors>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="article-content" class="col-md-4 control-label">Content:</label>
                        <div class="col-md-6">
                        <sf:textarea rows="5" cols="10" class="form-control" id="article-content" path="content"/>
                        <sf:errors path="content" cssclass="error"></sf:errors>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="article-date" class="col-md-4 control-label">Date:</label>
                        <div class="col-md-6">
                        <sf:input type="date" class="form-control" id="article-date" path="date"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="article-image-link" class="col-md-4 control-label">Image Link:</label>
                    <div class="col-md-6">
                        <sf:input type="text" class="form-control" id="article-image-link" path="imageLink"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="article-approval" class="col-md-4 control-label">Approval Status:</label>
                    <div class="col-md-6">
                        <sf:select id="article-approval" path="approvalId">
                            <sf:options items="${approvalMap}"/>
                        </sf:select>
                        <sf:hidden path="id"/>
                        <sf:hidden path="author.id"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-4 col-md-8">
                        <input type="submit" class="btn btn-default" value="Update Article"/>
                    </div>
                </div>
            </sf:form>

        </div>
    </body>
</html>
