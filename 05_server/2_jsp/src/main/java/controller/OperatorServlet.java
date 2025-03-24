package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.vo.Student;

/**
 * Servlet implementation class OperatorServlet
 */
@WebServlet("/operator.do")
public class OperatorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OperatorServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setAttribute("big", 10000);
		request.setAttribute("small", 10);
		
		request.setAttribute("s1", "졸리다");
		request.setAttribute("s2", "");
		request.setAttribute("s3", "안녕하세용!");
		request.setAttribute("s4", "");
		request.setAttribute("student1", new Student("신지수", 24, "여자"));
		
		request.setAttribute("student2", null);
		ArrayList<String> list1 = new ArrayList<>();
		request.setAttribute("list1", list1);
		
		ArrayList<String> list2 = new ArrayList<>();
		list2.add("빵빵이");
		list2.add("옥지");
		request.setAttribute("list2", list2);
		
		// 2__elOperator.jsp 페이지로 응답하기(포워딩)
		request.getRequestDispatcher("/views/2_EL/2_elOperator.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
