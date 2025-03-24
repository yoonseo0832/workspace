package com.kh.depaertment.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.depaertment.model.dao.DepartmentDao;
import com.kh.depaertment.model.vo.Department;

import static com.kh.template.JDBCTemplate.*;
public class DepartmentServiceImpl implements DepartmentService {
	private DepartmentDao dDao = new DepartmentDao();

	@Override
	public ArrayList<Department> selectDepartmentList() {
		Connection conn = getConnection();
		
		ArrayList<Department> dList = dDao.selectDepartmentList(conn);
		
		close(conn);
		
		return dList;
		
	}

	@Override
	public Department selectEmployee(int empName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertEmployee(Department d) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateEmployee(Department d) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteEmployee(Department d) {
		// TODO Auto-generated method stub
		return 0;
	}

}
