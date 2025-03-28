package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AjaxController1
 */
@WebServlet("/jqAjax1.do")
public class AjaxController1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxController1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 데이터 추출
		String data = request.getParameter("data");
		
		// 결과 데이터 가공
		String result = "전달된 값: "+ data + ", 길이: "+ data.length();
		// setContentType(인코딩+텍스트타입 지정가능)
		response.setContentType("text/html; charset=utf-8");
		// 데이터로 응답
		response.getWriter().print(result);
	}

}
