package com.kh.test.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {
	
	@GetMapping("test1")
	public String test1() {
		return "test1 호출됨";
	}
	
	@GetMapping("test2")
	public String test2(String name) {
		return name + "님 반갑습니다!";
		//		http://localhost:8080/test2?name=윤서
		// 		윤서님 반갑습니다!	param :: [윤서]
	}
}
