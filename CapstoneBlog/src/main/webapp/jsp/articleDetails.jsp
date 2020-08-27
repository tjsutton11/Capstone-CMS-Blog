<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Article</title>
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
                <div class="col-md-6 col-md-offset-2">
                    <article>
                        <img src="<c:out value="${article.imageLink}"/>">
                        <h2 id="articleTitle"><c:out value="${article.title}"/></h2>
                        <p>
                            Written By: <c:out value="${article.author.username}"/> on <c:out value="${article.date}"/>
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                (<a href="${pageContext.request.contextPath}/deletePost?id=${article.id}">Delete</a>)
                            </sec:authorize>
                        </p>
                        <p><c:out value="${article.content}" escapeXml="false"/></p>
                        <p>Tags:
                            <c:choose>
                                <c:when test="${article.categories == null}">

                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="currentCat" items="${article.categories}">
                                        <c:out value="${currentCat.name}"/> 
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <hr/>
                    </article>
                </div>
            </div>
        </div>
    </body>
</html>
