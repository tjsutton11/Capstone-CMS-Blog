/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.capstoneblog.controller;

import com.sg.capstoneblog.dao.BlogDao;
import com.sg.capstoneblog.model.User;
import java.util.ArrayList;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author tjsut
 */
@Controller
public class UserController {

    private BlogDao dao;
    private PasswordEncoder encoder;

    @Inject
    public UserController(BlogDao dao, PasswordEncoder encoder) {
        this.dao = dao;
        this.encoder = encoder;
    }

    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    public String addUser(HttpServletRequest req) {
        User newUser = new User();
        newUser.setUsername(req.getParameter("username"));
        String clearPw = req.getParameter("password");
        String hashPw = encoder.encode(clearPw);
        newUser.setPassword(hashPw);
        ArrayList<String> roles = new ArrayList<>();
        roles.add("ROLE_USER");
        newUser.setRoles(roles);
        dao.addUser(newUser);

        return "redirect:/";
    }

    @RequestMapping(value = "/deleteUser", method = RequestMethod.GET)
    public String deleteUser(HttpServletRequest request) {
        String username = request.getParameter("username");
        dao.deleteUser(username);
        return "redirect:displayAdminPage";
    }

    @RequestMapping(value = "/displayUserForm", method = RequestMethod.GET)
    public String displayUserForm(Map<String, Object> model) {
        return "addUserForm";
    }

}
