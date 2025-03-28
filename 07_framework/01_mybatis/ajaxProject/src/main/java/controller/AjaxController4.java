package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.vo.Member;

/**
 * Servlet implementation class AjaxController4
 */
@WebServlet("/jqAjax4.do")
public class AjaxController4 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxController4() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 데이터 추출 생략 없어서 
		
		// 응답 데이터 생성
		// - ArrayList 객체 생성
		// - 생성한 리스트 객체에 Member 객체를 저장(추가)
		
		// 생성한 데이터를 응답(*전송) => Gson
		//Member m = new Member();
		ArrayList<Member> list = new ArrayList<>();
		list.add(new Member(100, "김우빈", "woobin2", "서울시 강남구"));
		list.add(new Member(101, "홍화연", "hongg28", "서울시 이촌"));
		list.add(new Member(102, "조해솔", "sunsun11", "서울시 목동"));
		
		response.setContentType("application/json; charset=utf-8");
		
		Gson gson = new Gson();
		
		gson.toJson(list, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
