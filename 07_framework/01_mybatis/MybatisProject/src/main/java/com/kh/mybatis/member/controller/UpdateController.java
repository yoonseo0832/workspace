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
		//String birthday = request.getParameter("birthday");
		
		//  -> Member 객체로 가공하는 단계, 수정할 객체를 회원 정보
		Member updateMem = new Member(userId, email, gender, phone, address);
		
		// Service 객체에 전달
		MemberService mService = new MemberServiceImpl();
		
		// + 회원 정보 수정 요청
		int result = mService.updateMember(updateMem);
		// 결과에 따라 
			
		if(result >0) {
			// 결과에 따라 변경된 회원의 정보를 조회하여 session영역에 저장 (loginUser)
			HttpSession session = request.getSession();
			
			// id/pwd -> session 영역에 저장되어 있는 loginUser 키값에 대한 데이터
			Member m = (Member)session.getAttribute("loginUser");
			
			Member updMem = mService.selectMember(m);
			// 수정 사항이 반영된 회원 정보
			session.setAttribute("loginUser", updMem);
			
			// 수정 성공시 "수정 성공" 메세지 저장 , 마이페이지로 url 재요청
			request.getSession().setAttribute("alertMsg", "수정 성공!");
			// /mybatis/mypage.me
			response.sendRedirect(request.getContextPath()+ "/mypage.me");
			
		}else {
			request.setAttribute("errorMsg", "수정 실패");
			request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
		}
			// 수정 실패시 "수정 실패" 메세지 저장 , 에러페이지 응답
	}

}
