package com.kh.depaertment.model.service;

import java.util.ArrayList;

import com.kh.depaertment.model.vo.Department;
import com.kh.employee.model.vo.Employee;

public interface DepartmentService {
	public ArrayList<Department> selectDepartmentList();
	
	/* 사원 정보 조회 */
	Department selectEmployee(int empName);
	
	/* 사원 정보 추가*/
	int insertEmployee(Department d);
	
	/* 사원 정보 수정*/
	int updateEmployee(Department d);
	
	/* 사원 정보 삭제(퇴사여부)보다는 update*/
	int deleteEmployee(Department d);
}
