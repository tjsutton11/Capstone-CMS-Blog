/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.capstoneblog.dao;

import com.sg.capstoneblog.model.Article;
import com.sg.capstoneblog.model.Category;
import com.sg.capstoneblog.model.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author 13044
 */
public class BlogDaoJdbcTemplateImpl implements BlogDao {
    
    private JdbcTemplate jdbcTemplate;
    
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    // ================================
    // User Related Prepared Statements
    // ================================
    
    private static final String SQL_INSERT_USER
            = "insert into users (`username`, `password`) values (?, ?)";
    
    private static final String SQL_UPDATE_USER
            = "update users set `username` = ?, `password` = ? where userId = ?";
    
    private static final String SQL_DELETE_USER
            = "delete from users where username = ?";
    
    private static final String SQL_GET_USER
            = "select * from users where userId = ?";
    
    private static final String SQL_GET_USER_BY_NAME
            = "select * from users where `username` = ?";
    
    private static final String SQL_GET_ALL_USERS
            = "select * from users";
    
    private static final String SELECT_USER_ID_BY_ARTICLE_ID
            = "select userId from article where articleId = ?";
    
    // ================================
    // Role Related Prepared Statements
    // ================================
    
    private static final String SQL_INSERT_ROLE
            = "insert into roles (`username`, `roleName`) values (?, ?)";
    
    private static final String SQL_DELETE_ROLES
            = "delete from roles where username = ?";
    
    // ===================================
    // Article Related Prepared Statements
    // ===================================
    
    private static final String SQL_INSERT_ARTICLE
            = "insert into article (`title`, `content`, postDate, approvalId, imageLink, userId) "
            + "values (?, ?, ?, ?, ?, ?)";
    
    private static final String SQL_UPDATE_ARTICLE
            = "update article set `title` = ?, `content` = ?, postDate = ?, "
            + "approvalId = ?, imageLink = ?, userId = ? where articleId = ?";
    
    private static final String SQL_DELETE_ARTICLE
            = "delete from article where articleId = ?";
    
    private static final String SQL_GET_ARTICLE
            ="select * from article where articleId = ?";
    
    private static final String SQL_GET_ALL_ARTICLES
            = "select * from article order by articleId desc";
    
    private static final String SQL_GET_UNAPPROVED_ARTICLES
            = "select * from article where approvalId = 1";

    // ====================================
    // Cateogry Related Prepared Statements
    // ====================================
    
    private static final String SQL_INSERT_CATEGORY
            = "insert into category (`description`) values (?)";
    
    private static final String SQL_GET_CATS_FOR_ARTICLE
            = "select c.categoryId, c.description from category c "
            + "join article_category ac on c.categoryId = ac.categoryId "
            + "where ac.articleId = ?";
    
    private static final String SQL_GET_ALL_CATEGORIES
            = "select * from category";
    
    private static final String SQL_GET_MATCHING_ARTICLES
            = "select a.articleId, a.title, a.content, a.postDate, a.approvalid, a.imageLink, a.userId from article a " +
              "join article_category ac on a.articleId = ac.articleId " +
              "where ac.categoryId = ?";

    // ===============================
    // Bridge Table Related Statements
    // ===============================
    
    private static final String SQL_INSERT_ARTICLE_CATEGORY
            = "insert into article_category (articleId, categoryId) values (?, ?)";
    
    private static final String SQL_DELETE_ARTICLE_CATEGORY
            = "delete from article_category where articleId = ?";
    
    // ============
    // User Methods
    // ============
    
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public User addUser(User newUser) {
        
        // Creates User object in database
        jdbcTemplate.update(SQL_INSERT_USER,
                newUser.getUsername(),
                newUser.getPassword());
        
        // Retrieves latest insertion into database and assigns user ID to object
        newUser.setId(jdbcTemplate.queryForObject("select LAST_INSERT_ID()", Integer.class));
        
        // Finally, inserts the user's roles into the Roles table
        ArrayList<String> roles = newUser.getRoles();
        roles.forEach((role) -> {
            jdbcTemplate.update(SQL_INSERT_ROLE,
                    newUser.getUsername(),
                    role);
        });
        
        return newUser;
        
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void deleteUser(String username) {
        // Deletes all roles of user from table
        jdbcTemplate.update(SQL_DELETE_ROLES, username);
        // Deletes user from table
        jdbcTemplate.update(SQL_DELETE_USER, username);
    }

    @Override
    public User getUserById(int id) {
        try {
            return jdbcTemplate.queryForObject(SQL_GET_USER, new UserMapper(), id);
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
        
    }
    
    @Override
    public User getUserByName(String username) {
        try {
            return jdbcTemplate.queryForObject(SQL_GET_USER_BY_NAME, new UserMapper(), username);
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
        
    }

    @Override
    public List<User> getAllUsers() {
        return jdbcTemplate.query(SQL_GET_ALL_USERS, new UserMapper());
    }

    // ===============
    // Article Methods
    // ===============
    
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Article addArticle(Article newArticle) {
        jdbcTemplate.update(SQL_INSERT_ARTICLE,
                newArticle.getTitle(),
                newArticle.getContent(),
                java.sql.Date.valueOf(newArticle.getDate()),
                newArticle.getApprovalId(),
                newArticle.getImageLink(),
                newArticle.getAuthor().getId());
        
        newArticle.setId(jdbcTemplate.queryForObject("select LAST_INSERT_ID()",
                Integer.class));
        
        addCategories(newArticle.getCategories());
        
        addArticleCategoriesEntries(newArticle);
        
        return newArticle;
    }
    
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Article editArticle(Article article) {
        jdbcTemplate.update(SQL_UPDATE_ARTICLE,
                article.getTitle(),
                article.getContent(),
                java.sql.Date.valueOf(article.getDate()),
                article.getApprovalId(),
                article.getImageLink(),
                article.getAuthor().getId(),
                article.getId());
        
        return article;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public void deleteArticle(int id) {
        jdbcTemplate.update(SQL_DELETE_ARTICLE_CATEGORY, id);
        jdbcTemplate.update(SQL_DELETE_ARTICLE, id);
    }

    @Override
    public Article getArticleById(int id) {
        try {
            return jdbcTemplate.queryForObject(SQL_GET_ARTICLE, new ArticleMapper(), id);
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    @Override
    public List<Article> getAllArticles() {
        return jdbcTemplate.query(SQL_GET_ALL_ARTICLES, new ArticleMapper());
    }
    
    @Override
    public List<Article> getUnapprovedArticles() {
        return jdbcTemplate.query(SQL_GET_UNAPPROVED_ARTICLES, new ArticleMapper());
    }

    // ================
    // Category Methods
    // ================
    
    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = false)
    public Category addCategory(Category category) {
        jdbcTemplate.update(SQL_INSERT_CATEGORY, category.getName());
        category.setCategoryId(jdbcTemplate.queryForObject("select LAST_INSERT_ID()",
                Integer.class));
        return category;
    }
    
    @Override
    public List<Category> getAllCategories() {
        return jdbcTemplate.query(SQL_GET_ALL_CATEGORIES, new CategoryMapper());
    }
    
    @Override
    public List<Article> getMatchingArticles(int id) {
        return jdbcTemplate.query(SQL_GET_MATCHING_ARTICLES, new ArticleMapper(), id);
    }
    
    // ==============
    // Helper Methods
    // ==============
    
    private void addCategories(List<Category> categories) {
        categories.forEach((currentCategory) -> {
            this.addCategory(currentCategory);
        });
    }
    
    private void addArticleCategoriesEntries(Article article) {
        List<Category> categories = article.getCategories();
        
        categories.forEach((currentCategory) -> {
            jdbcTemplate.update(SQL_INSERT_ARTICLE_CATEGORY,
                    article.getId(),
                    currentCategory.getCategoryId());
        });
    }
    
    @Override
    public User findAuthorOfArticle(Article article) {
        int userId = jdbcTemplate.queryForObject(SELECT_USER_ID_BY_ARTICLE_ID,
                new UserIdMapper(), article.getId());
        
        User u = this.getUserById(userId);
        
        return u;
    }
    
    @Override
    public List<Category> getCategoriesForArticle(Article art) {
        return jdbcTemplate.query(SQL_GET_CATS_FOR_ARTICLE, new CategoryMapper(), art.getId());
    }
    
    private static final class UserMapper implements RowMapper<User> {
        
        @Override
        public User mapRow(ResultSet rs, int i) throws SQLException {
            User u = new User();
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setId(rs.getInt("userId"));
            
            return u;
        }
    }
    private static final class UserIdMapper implements RowMapper<Integer> {
        
        @Override
        public Integer mapRow(ResultSet rs, int i) throws SQLException {

            return rs.getInt("userId");
        }
    }
    
    private static final class ArticleMapper implements RowMapper<Article> {
        
        @Override
        public Article mapRow(ResultSet rs, int i) throws SQLException {
            Article a = new Article();
            a.setTitle(rs.getString("title"));
            a.setContent(rs.getString("content"));
            a.setDate(rs.getTimestamp("postDate").toLocalDateTime().toLocalDate());
            a.setApprovalId(rs.getInt("approvalId"));
            a.setImageLink(rs.getString("imageLink"));
            a.setId(rs.getInt("articleId"));
            
            return a;
        }
    }
    
    private static final class CategoryMapper implements RowMapper<Category> {
        
        @Override
        public Category mapRow(ResultSet rs, int i) throws SQLException {
            Category c = new Category();
            c.setName(rs.getString("description"));
            c.setCategoryId(rs.getInt("categoryId"));
            
            return c;
        }
    }
    
}
