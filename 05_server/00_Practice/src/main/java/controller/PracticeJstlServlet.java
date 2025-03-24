package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.vo.Exhibit;

/**
 * Servlet implementation class PracticeJstlServlet
 */
@WebServlet("/practice.jstl")
public class PracticeJstlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PracticeJstlServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.getSession().setAttribute("nickname", "User-" + (int)(Math.random()*100+1));
		
		
		int size = (int)(Math.random()*5);
		
		ArrayList<Exhibit> list = new ArrayList<>();
		list.add(new Exhibit("피에르 위그 개인전", "2025.02.27 ~ 2025.07.06", "리움미술관"));
		list.add(new Exhibit("프라다 칼로 레플리카 전", "2025.12.13 ~ 2025.03.16", "큐브미술관, 성남"));
		list.add(new Exhibit("엘름그린&드라그셋 《Spaces》", "2024.09.03 ~ 2025.02.23", "아모레퍼시픽 미술관, 서울"));
		list.add(new Exhibit("2025 서울커피 엑스포", "2025.04.02 ~ 2025.04.05", "코엑스"));
		list.add(new Exhibit("위대한 뮤지션 100인 전 Vol.1", "2025.02.15 ~2025.05.11", "현대백화점 무역센터점 10층 문화홀"));
		
		ArrayList<Exhibit> eList = new ArrayList<>();
		for(int i=0; i<size; i++) {
			eList.add(list.get(i));
		}
		
		request.setAttribute("eList", eList);

		
		// TODO: practice_jstl.jsp 페이지로 포워딩
		request.getRequestDispatcher("views/practice_jstl.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}