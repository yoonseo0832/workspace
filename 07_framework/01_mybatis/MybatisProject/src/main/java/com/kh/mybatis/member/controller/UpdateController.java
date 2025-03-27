package com.kh.mybatis.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mybatis.member.model.vo.Member;
import com.kh.mybatis.member.service.MemberService;
import com.kh.mybatis.member.service.MemberServiceImpl;

/**
 * Servlet implementation class UpdateController
 */
@WebServlet("/update.me")
public class UpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// POST 요청 시 인코딩 설정
		request.setCharacterEncoding("UTF-8");
		// 전달된 데이터 추출(id, email, gender, phone, address 필수)
		String userId = request.getParameter("userId");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		// Service 객체에 전달
		
		Member m = new Member(userId, email, gender, phone, address);
		
		int result  = new MemberServiceImpl().updateMember(m);
		
		// 결과에 따라 
			// 수정 성공시 "수정 성공" 메세지 저장 , 마이페이지로 url 재요청
		if(result >0) {
			request.getSession().setAttribute("alertMsg", "수정 성공!");
			response.sendRedirect(request.getContextPath());
		}else {
			request.getSession().setAttribute("alertMsg", "수정 실패");
			response.sendRedirect("WEB-INF/views/common/errorPage.jsp");
		}
			// 수정 실패시 "수정 실패" 메세지 저장 , 에러페이지 응답
	}

}
