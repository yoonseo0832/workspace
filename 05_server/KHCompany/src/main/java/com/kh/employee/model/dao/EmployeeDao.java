package com.kh.employee.model.dao;

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

import com.kh.employee.model.vo.Employee;
import com.kh.template.JDBCTemplate;

public class EmployeeDao {
	private Properties prop = new Properties();
	
	public EmployeeDao() {
		try {
			// employee-mapper.xml 파일 경로
			String filepath=EmployeeDao.class.getResource("/sql/employee-mapper.xml").getPath();
			
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
/*
 * Statement 객체 생성 (=> Connection 객체 사용)
 * 
 * 쿼리문(SQL문, 명령문 등) 실행 후 결과 받기
 * 
 * 결과에 대한 처리
 * - DQL : ResultSet 객체로 받아서 필요한 데이터를 차곡차곡 저장
 * - DML : int 로 결과 받아 리턴(=> 트랜잭션 처리는 서비스 담당)
 * 
 * 객체 반납(close) => Statement, Resultset 있는지 확인
 * 
 * 리턴은 항상 마지막에 위치 
 */
	public ArrayList<Employee> selectEmployeeList(Connection conn) {
		ArrayList<Employee> list = new ArrayList<>();
		Statement stmt = null;
		ResultSet rset = null;
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(prop.getProperty("selectEmployeeList"));
			
			while(rset.next()) {
				// Employee객체에 조회 결과를 담기
				Employee e = new Employee(
						rset.getInt("EMP_ID"),
						rset.getString("EMP_NAME"),
						rset.getString("DEPT_TITLE"),
						rset.getString("JOB_NAME"),
						rset.getString("HIRE_DATE")
						);
				// ArrayList에 담아둔 데이터 추가
			list.add(e); // 리스트에 담아야 함, list.add("변수명");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		return list;
	}

}
