package com.kh.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

@CrossOrigin(origins="http://localhost:8080")
@Controller
public class MapController {

    @GetMapping("/")
    public String index() {
        return "index"; 
    }
}