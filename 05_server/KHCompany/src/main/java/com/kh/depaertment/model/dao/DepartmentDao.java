package com.kh.depaertment.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;

import com.kh.depaertment.model.vo.Department;
import com.kh.template.JDBCTemplate;

public class DepartmentDao {
	private Properties prop = new Properties();
	
	public DepartmentDao() {
		String filepath = DepartmentDao.class.getResource("sql/department-mapper").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filepath));
			
			
		} catch (InvalidPropertiesFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public ArrayList<Department> selectDepartmentList(Connection conn){
		ArrayList<Department> dList = new ArrayList<>();
		Statement stmt = null;
		ResultSet rset = null;
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(prop.getProperty("selectDepartmentList"));
			
			while(rset.next()) {
				Department d = new Department(
						 rset.getString("EMP_NAME"),
						 rset.getString("DEPT_ID"),
						 rset.getString("DEPT_TITLE"),
						 rset.getString("LOCATION_ID"),
						 rset.getString("NATIONAL_NAME")
						);
			dList.add(d);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		return dList; 
	}
}
