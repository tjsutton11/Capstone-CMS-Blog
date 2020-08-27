DROP DATABASE IF EXISTS cmsblog;

CREATE DATABASE cmsblog;

USE cmsblog;

CREATE TABLE `users` (
	userId INT NOT NULL auto_increment,
    `username` VARCHAR(30) NOT NULL,
    `password` VARCHAR(60) NOT NULL,
    PRIMARY KEY(userId),
    UNIQUE KEY `username` (`username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE `roles` (
	`username` VARCHAR(30) NOT NULL,
    `roleName` VARCHAR(15) NOT NULL,
    KEY(`username`),
    FOREIGN KEY(`username`) REFERENCES `users`(`username`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE `approval` (
	approvalId TINYINT NOT NULL auto_increment,
    `description` VARCHAR(50) NOT NULL,
    PRIMARY KEY(approvalId)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE `article` (
	articleId INT NOT NULL auto_increment,
    `title` VARCHAR(100) NOT NULL,
    `content` VARCHAR(2000) NOT NULL,
    postDate DATE NOT NULL,
    approvalId TINYINT NOT NULL,
    imageLink VARCHAR(200) NULL,
    userId INT NOT NULL,
    PRIMARY KEY(articleId),
    FOREIGN KEY(approvalId) REFERENCES `approval`(approvalId),
    FOREIGN KEY(userId) REFERENCES `users`(userId)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE `category` (
	categoryId INT NOT NULL auto_increment,
    `description` VARCHAR(25) NOT NULL,
    PRIMARY KEY(categoryId)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE article_category (
	id INT NOT NULL auto_increment,
    articleId INT NOT NULL,
    categoryId INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(articleId) REFERENCES `article`(articleId),
    FOREIGN KEY(categoryId) REFERENCES `category`(categoryId)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

INSERT INTO `users` (`username`, `password`)
values ("admin", "$2a$10$z3as2YVoqZy/1w7i4WxQ4O7sgi6pP6VwSEe6V0wV.G22Uz7yxfLbq"), 
("editor", "$2a$10$bbn1b5W.BjmwqPA.GifmaeZ2pDgR9W7WEJSYqBARgcxjdzyMfgseq"), 
("anon", "$2a$10$2Z1Se2eX.UoSE7ruPXF4MuXc5dhXJp.V8zaUzaqyjnNiQBjGNjQ3S");

INSERT INTO `roles` (`username`, `roleName`)
values ("admin", "ROLE_ADMIN"), ("admin", "ROLE_EDITOR"), ("admin", "ROLE_USER"), ("editor", "ROLE_EDITOR"), ("anon", "ROLE_USER");

INSERT INTO `approval` (`description`)
values ("Pending Approval"), ("Approved");

INSERT INTO `article` (`title`, `content`, postDate, approvalId, imageLink, userId)
values ("Test Article #1", "Bacon ipsum dolor amet nisi chicken et ullamco ball tip proident dolore burgdoggen, turducken nostrud est t-bone tempor. Ground round prosciutto et minim cupidatat rump capicola burgdoggen dolore occaecat beef ribs pig flank pork loin incididunt. In ut t-bone frankfurter. Non consectetur adipisicing in jerky beef ribs, minim qui frankfurter. Chislic pork chop landjaeger, ground round cow sausage buffalo shoulder jowl spare ribs id est meatloaf swine. Ham boudin t-bone velit in, quis chuck esse culpa dolore ex. Ground round ipsum venison mollit shoulder ham, jerky drumstick turducken consectetur prosciutto picanha lorem in ullamco. Laboris jowl labore cupidatat ipsum capicola dolore sint non reprehenderit pastrami shoulder id shank. Veniam dolore dolor sint bacon. Capicola et picanha est swine brisket chuck shank. Spare ribs hamburger pork chop beef ribs dolor boudin consectetur eu. In id chicken, occaecat hamburger voluptate cupim short ribs. Tempor t-bone frankfurter pariatur do turducken laborum pork loin pastrami et. Tenderloin sunt burgdoggen pork belly.", "2020/06/13", 2, "https://woodcraft-production-weblinc.netdna-ssl.com/product_images/woodworking-project-paper-plan-to-build-splined-ornamental-box/5843c4d469702d0253000bbd/detail.jpg?c=1480836308", 1),
("Test Article #2", "This is my second blog post. I am not sure why I wrote about meat so much in my last post.", "2020/08/05", 1, "", 1);

INSERT INTO `category` (`description`)
values ("#test"), ("#pizza"), ("#gaming");

INSERT INTO article_category (articleId, categoryId)
values (1, 1), (1, 2), (1, 3);
