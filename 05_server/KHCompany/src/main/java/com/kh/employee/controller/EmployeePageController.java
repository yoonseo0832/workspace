package com.kh.employee.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.employee.model.vo.Employee;
import com.kh.employee.service.EmployeeService;
import com.kh.employee.service.EmployeeServiceImpl;

@WebServlet("/emp.do")
public class EmployeePageController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1) 사원 정보 조회
		EmployeeService eService = new EmployeeServiceImpl();
		ArrayList<Employee> list = eService.selectEmployeeList();
		
		//2) 조회된 정보를 request영역에 저장
		request.setAttribute("list", list);
		//3) employeeList.jsp 페이지로 포워딩(응답)
		request.getRequestDispatcher("WEB-INF/views/employee/employeeList.jsp").forward(request, response);
	}
	
}
