package com.kh.mybatis.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mybatis.member.service.MemberService;
import com.kh.mybatis.member.service.MemberServiceImpl;

/**
 * Servlet implementation class MemberPwdUpdate
 */
@WebServlet("/updatePwd.me")
public class MemberPwdUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberPwdUpdate() {
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
		// POST 방식인 경우 인코딩 처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 데이터 추출 (아이디/현재비번/바뀐비번)
		String id = request.getParameter("userId");
		String pwd = request.getParameter("userPwd");
		String newPwd = request.getParameter("newPwd");
		
		MemberService mService = new MemberServiceImpl();
		
		int result = mService.updatePassword(id, pwd, newPwd);
		
		if(result > 0) {
			// 비번 변경 성공
			
			// 비번 변경 성공 시 로그아웃 처리 => 세션 영역을 비워두기
			request.getSession().invalidate();
			
			request.getSession().setAttribute("alertMsg", "비밀번호가 변경되었습니다");
			
			response.sendRedirect(request.getContextPath());
		}else {
			// 비번 변경 실패
			request.getSession().setAttribute("errorMsg", "비밀번호가 변경 실패했습니다");
			request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
		}
	}

}
