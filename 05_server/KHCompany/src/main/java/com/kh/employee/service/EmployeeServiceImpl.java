package com.kh.employee.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.employee.model.dao.EmployeeDao;
import com.kh.employee.model.vo.Employee;
import static com.kh.template.JDBCTemplate.*;
// => JDBCTemplate 클래스의 모든 static 메소드 임포트 가능! 클래스명 생략하고 메소드 호출 가능
public class EmployeeServiceImpl implements EmployeeService{
	private EmployeeDao eDao = new EmployeeDao();
	/**
	 * 사원 전체 목록 조회
	 * @return
	 */
	@Override
	public ArrayList<Employee> selectEmployeeList(){
		//connection 객체 생성
		Connection conn = getConnection();
		//DAO로 connecion객체 전달
		ArrayList<Employee> list = eDao.selectEmployeeList(conn);
		//connecion 객체 반납
		close(conn);
		//결과 리턴
		return list;

	}
	@Override
	public Employee selectEmployee(int empId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertEmployee(Employee e) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateEmployee(Employee e) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteEmployee(Employee e) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
