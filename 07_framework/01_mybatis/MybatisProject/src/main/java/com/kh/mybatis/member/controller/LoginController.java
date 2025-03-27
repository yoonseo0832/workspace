package com.kh.mybatis.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mybatis.member.model.vo.Member;
import com.kh.mybatis.member.service.MemberService;
import com.kh.mybatis.member.service.MemberServiceImpl;

// login.me 요청 받아 아이디, 비번 추출 -> 출력
@WebServlet("/login.me")

/*
 * 일반 클래스에서 
 * 	1) extends HttpServlet 상속
 * 	2) @WebServlet("요청받을 url") => url mapping
 * 	3) 요청방식에 따라 doGet() 또는 doPost()
 */
public class LoginController extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// post 요청 시 데이터가 한글이 포함된 경우를 위해 인코딩 처리 필요
		request.setCharacterEncoding("UTF-8");
		
		// 아이디, 비번 데이터 추출
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");

		//Service 객체에게 요청하기 위해 데이터 가공처리(=> Member 객체 생성)
		Member m = new Member();
		m.setUserId(userId);
		m.setUserPwd(userPwd);
		
		MemberService service = new MemberServiceImpl();
		Member loginUser = service.selectMember(m);
		
		// => 조회된 결과가 있을 경우 Member 객체 전달
		//				없을 경우 null값이 전달
		 if(loginUser != null) {
			
			 //로그인 성공 시 (조회된 결과가 있을 것임)
			 // Session 영역에 loginUser 키값으로 조회된 결과 저장
			 HttpSession session = request.getSession();
			 session.setAttribute("loginUser", loginUser);
			//"로그인 성공" 메세지 저장 ->Session 영역.alertMsg
			 session.setAttribute("alertMsg", "로그인 성공했습니다.");
			//메인 페이지로 url 재요청 -> /mybatis 동일
			 //response.sendRedirect("/mybatis"); == .getContextPath()
			 response.sendRedirect(request.getContextPath());
		 }else{
			 //로그인 실패 시(null 값이 경우)
			//"로그인 실패" 메세지 저장 -> 에러페이지에 출력하기 위해 request 영역
			 request.setAttribute("errorMsg", "로그인에 실패했습니다.");
			//에러 페이지로 포워딩(응답)
			 request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
		}
		 
	}

	
	
}
