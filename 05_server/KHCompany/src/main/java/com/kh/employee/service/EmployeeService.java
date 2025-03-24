package com.kh.employee.service;

import static com.kh.template.JDBCTemplate.close;
import static com.kh.template.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.employee.model.dao.EmployeeDao;
import com.kh.employee.model.vo.Employee;

public interface EmployeeService {
	// 인터페이스 구성: 
	//		+ 상수 변수(public static final)
	//		+ 추상 메소드(몸체 없는 메소드: public abstract)
	
	/* 사원 목록 조회 */
	public ArrayList<Employee> selectEmployeeList();
	/* 사원 정보 조회 */
	Employee selectEmployee(int empId);
	
	/* 사원 정보 추가*/
	int insertEmployee(Employee e);
	
	/* 사원 정보 수정*/
	int updateEmployee(Employee e);
	
	/* 사원 정보 삭제(퇴사여부)보다는 update*/
	int deleteEmployee(Employee e);

	
}
