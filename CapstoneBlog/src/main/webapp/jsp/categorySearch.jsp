<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Category Search</title>
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
                        <sec:authorize access="hasRole('ROLE_EDITOR')">
                        <li role="presentation"><a href="${pageContext.request.contextPath}/displayPostingPage">Post New Article</a></li>
                        </sec:authorize>
                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <li role="presentation"><a href="${pageContext.request.contextPath}/displayAdminPage">Admin</a></li>
                        </sec:authorize>
                    <li role="presentation"><a href="${pageContext.request.contextPath}/displayLogin">Login</a></li>
                </ul>    
            </div>
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <h4 style="text-align: right">Hello ${pageContext.request.userPrincipal.name}
                    | <a href="<c:url value="/j_spring_security_logout" />" > Logout</a>
                </h4>
            </c:if>
            <div class="row">
                <h2>Articles with Matching Tag:</h2>
                <table id="userTable" class="table table-hover">
                    <tr>
                        <th width="50%">Title</th>
                        <th width="50%"></th>
                    </tr>
                    <c:forEach var="currentArticle" items="${matchingList}">
                        <tr>
                            <td>
                                <a href="displayArticleDetails?articleId=${currentArticle.id}"/><c:out value="${currentArticle.title}"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </body>
</html>
