package com.kh.depaertment.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.depaertment.model.service.DepartmentService;
import com.kh.depaertment.model.service.DepartmentServiceImpl;
import com.kh.depaertment.model.vo.Department;

@WebServlet("/dept.do")
public class DepartmentPageController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DepartmentService dService = new DepartmentServiceImpl();
		ArrayList<Department> dList = dService.selectDepartmentList();
		
		request.setAttribute("dList", dList);
		
		request.getRequestDispatcher("WEB-INF/views/department/departmentList.jsp").forward(request, response);
	}
	
}
