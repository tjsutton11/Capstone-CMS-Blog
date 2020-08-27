# Capstone-CMS-Blog

Capstone project for the Java bootcamp I completed at the Software Guild. 

The project was to create a Content Management Site that simualted a blog for a small company. Upon loading the site,
users were shown the Home page of the site, displaying the blog posts created by the business owner. The only other navigation tab visible was for a login portal.
Once logged in, more functionality was revealed based on the user's permission level. 

### Admin
As an admininstrator, the user had access to a page that allowed them to create a new blog post via a TinyMCE editor. 
There is also an administrator page which allows the admin to delete users and approve blog posts that were created
by the Editor. Blog posts also have hashtags (categories) that are searchable to see all posts about a given topic.

### Editor
As an editor, the user could login and create new blog posts for the administrator. When they submit a new blog post,
it does not automatically go live. It goes into a pending queue that must be approved by the administrator.

### Users
Users have no permissions on the site other than the ability to make an account.

## Technologies
Front End: HTML (mainly JSPs), CSS (Bootstrap)
Back End: Java
Database: MySQL

Utilizes Spring Security to authenticate users upon login attempt
