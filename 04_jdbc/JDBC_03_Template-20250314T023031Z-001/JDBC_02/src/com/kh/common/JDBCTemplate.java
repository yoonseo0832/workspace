package com.kh.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCTemplate {
	/*
	 * ���� ���÷�
	 * 
	 * �ش� ��ü�� �Ź� ���� �ƴ� ȣ��
	 * ��� �޼ҵ� static 
	 */
	/**
	 * Connection ��ü ����
	 * @return
	 */
	public static Connection getConnection() {
		Connection conn = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "C##JDBC", "JDBC");
			conn.setAutoCommit(false);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	/**
	 * Connection ��ü �ݳ�(close ó��)
	 * @param conn
	 */
	public static void close(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	/**
	 * Statement ���� ��ü ���� �޾� close ó��
	 * @param stst
	 */
	public static void close(Statement stat) {
		try {
			if(stat != null && !stat.isClosed())
				stat.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	/**
	 * ResultSet ��ü ���޹޾� close ó��
	 * @param rset
	 */
	public static void close(ResultSet rset) {
		try {
			if(rset != null && !rset.isClosed())
				rset.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public static void commit(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public static void rollback(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
