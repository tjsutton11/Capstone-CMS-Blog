<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>New Blog Post</title>
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
                    <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/displayPostingPage">Post New Article</a></li>
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
            <div>
                <h2>Create a New Blog Post</h2>
                <form class="form-horizontal" role="form" method="post" action="createPost">
                    <div class="form-group">
                        <label for="new-post-title" class="col-md-4 control-label title-label">Title:</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" name="title" placeholder="Title" required/>
                        </div> 
                    </div>
                    <div class="form-group">
                        <textarea name="content" id="newBlogPost">This is a test of TinyMCE editor!</textarea>
                    </div>
                    <div class="form-group">
                        <label for="post-date" class="col-md-4 control-label">Date:</label> 
                        <div class="col-md-6">
                            <input type="date" class="form-control" name="date" required/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="post-graphic" class="col-md-4 control-label">Photo Link:</label>
                        <div class="col-md-6">
                            <input type="url" class="form-control" name="imageLink" placeholder="www.example.com/image.jpg"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="post-tags" class="col-md-4 control-label">Tags:</label>
                        <div class="col-md-6">
                            <input type="text" class="form-control" name="tags" placeholder="#Woodworking, #meat, #stuff"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-4 col-md-4">
                            <input type="submit" class="btn btn-default" value="Post!"/>
                        </div>
                    </div>
                </form>
            </div>    

        </div>

        <script src="https://cdn.tiny.cloud/1/dxomf1u6xpdm88qvnuy9le6u396z7q1a68msl4fpjhmdudat/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script>
            tinymce.init({
                selector: '#newBlogPost',
                height: 500,
                toolbar: 'undo redo | styleselect | bold italic | alignleft aligncenter alightright alignjustify\n\
                | bullist numlist outdent indent',
                toolbar_mode: 'floating',
                tinycomments_mode: 'embedded',
                tinycomments_author: 'Author name'
            });
        </script>
    </body>
</html>
