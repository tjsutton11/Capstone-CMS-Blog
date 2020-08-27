<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
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
                    <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/displayAdminPage">Admin</a></li>
                    <li role="presentation"><a href="${pageContext.request.contextPath}/displayLogin">Login</a></li>
                </ul>    
            </div>
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <h4 style="text-align: right">Hello ${pageContext.request.userPrincipal.name}
                    | <a href="<c:url value="/j_spring_security_logout" />" > Logout</a>
                </h4>
            </c:if>
            <div class="row">
                <div class="col-md-6">
                    <h2>Users</h2>
                    <table id="userTable" class="table table-hover">
                        <tr>
                            <th width="50%">Username</th>
                            <th width="50%"></th>
                        </tr>
                        <c:forEach var="currentUser" items="${userList}">
                            <tr>
                                <td>
                                    <c:out value="${currentUser.username}"/>
                                </td>
                                <td><a href="deleteUser?username=${currentUser.username}">Delete User</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <div class="col-md-6">
                    <h2>Posts Pending Approval</h2>
                    <table id="postTable" class="table table-hover">
                        <tr>
                            <th width="60%">Title</th>
                            <th width="40%"></th>
                        </tr>
                        <c:forEach var="currentArticle" items="${pendingList}">
                            <tr>
                                <td>
                                    <c:out value="${currentArticle.title}"/>
                                </td>
                                <td>
                                    <a href="displayApprovalForm?articleId=${currentArticle.id}">Preview</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
