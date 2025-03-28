package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;

import model.vo.Member;

/**
 * Servlet implementation class AjaxController3
 */
@WebServlet("/jqAjax3.do")
public class AjaxController3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxController3() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userNo = request.getParameter("userNo");
		
		// Member m = new MemberServiceImpl().selectMember(userNo);
		
		Member m = new Member(Integer.parseInt(userNo), "아이유", "iu0322", "서울시 논현동");
		
		// vo 객체로 전달 (응답)하고자 할때 => JSONObject 형태로 전달해줘야 함!!!
		/*
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("userNo", m.getUserNo());
		jsonObj.put("userName", m.getName());
		jsonObj.put("userId", m.getUserId());
		jsonObj.put("address", m.getAddress());
		// 데이터를 객체로 저장하려면 .setContentType("application/json; charset=utf-8");
		// 아니면 그냥 문자열로 저장됨
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(jsonObj);
		*/
		
		// => 좀 더 간단한 방법으로 처리 gson : google json
		Gson gson = new Gson();
		
		//문서 타입 지정
		response.setContentType("application/json; charset=utf-8");
		
		// 객체 응답 Gson객체.toJson(vo객체, 응답시사용되는 스트림)
		gson.toJson(m, response.getWriter());
		/**
		 * Gson 사용 시 vo 객체를 응답하는 경우 JSONObject 형태로 전달
		 * 		이때 키값은 vo 객체의 필드명으로 전달
		 * 
		 * ArrayList/배열 데이터를 응답하는 경우 JSONArray 형태로 전달
		 */
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
