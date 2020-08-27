/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sg.capstoneblog.controller;

import com.sg.capstoneblog.dao.BlogDao;
import javax.inject.Inject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author tjsut
 */
@Controller
public class LoginController {
    
    BlogDao dao;
    
    @Inject
    public LoginController(BlogDao dao){
        this.dao = dao;
    }
    
    @RequestMapping(value="/displayLogin", method=RequestMethod.GET)
    public String loadLoginPage(Model model) {
        
        return "login";
    }
    
}
