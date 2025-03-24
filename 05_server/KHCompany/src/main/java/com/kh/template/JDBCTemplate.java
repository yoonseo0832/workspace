package com.kh.template;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCTemplate {
	//Connecion 객체 생성
	public static Connection getConnection() {
		Connection conn = null;
		
		Properties prop = new Properties();
		
		try {
			String filepath = JDBCTemplate.class.getResource("/settings.properties").getPath();
			// 클래스명.class: class 객체로 접근. 모든 클래스는 실행 시 Class 객체로 표현됨
			// - 클래스 정보를 확인할 때 사용
			// - 객체 생성 또는 타입 비교 시 사용
			
			// getResource() : 리소드 파일을 읽어오기 위해 사용된 메소드
			
			prop.load(new FileInputStream(filepath));
			
			//1) jdbc 드라이버 등록
			Class.forName(prop.getProperty("driver"));
			
			// 2) connection 객체 생성, 변수에 저장
			conn = DriverManager.getConnection(prop.getProperty("url")
										, prop.getProperty("username")
										, prop.getProperty("password"));
			
			conn.setAutoCommit(false);
			// => 트랜잭션 처리를 직접하기 위한 설정
		} catch (ClassNotFoundException |SQLException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	/*commit 처리*/
	public static void commit(Connection conn) {
		try {
			if(conn !=null && !conn.isClosed())
				conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	/*rollback 처리*/
	public static void rollback(Connection conn) {
		try {
			if(conn !=null && !conn.isClosed())
				conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// close 처리
	// - Connection, [Prepared]Statement, ResultSet
	public static void close(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static void close(Statement stmt) {
		try {
			if(stmt != null && !stmt.isClosed())
				stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rset) {
		try {
			if(rset != null && !rset.isClosed())
				rset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
