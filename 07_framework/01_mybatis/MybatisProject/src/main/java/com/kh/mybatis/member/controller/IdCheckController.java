package com.kh.mybatis.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mybatis.member.service.MemberServiceImpl;

/**
 * Servlet implementation class IdCheckController
 */
@WebServlet("/idCheck")
public class IdCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IdCheckController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 전달된 데이터 추출
		String userId = request.getParameter("userId");
		
		// service 객체에 전달하여 작업 요청
		int count = new MemberServiceImpl().countMemberByUserId(userId);
		
		// 결과에 따른 처리
		if(count ==0) {
			response.getWriter().print("YYY");
		// count ==0  'YYY' 값을 응답
		}else {
			response.getWriter().print("NNN");
		// count !=0  'NNN' 값을 응답
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
