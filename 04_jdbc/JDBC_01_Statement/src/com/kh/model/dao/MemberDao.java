package com.kh.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.kh.model.vo.Member;

/*
 * DAO (Data Access Object)
 * : DB에 직접 접근하여 사용자의 요청에 맞는 SQL문 실행 후 결과 반환
 * 	-> JDBC 사용
 */
public class MemberDao {
	// DB 정보: 서버주소, 사용자명, 비밀번호
	private final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private final String USER_NAME = "C##JDBC";
	private final String PASSWORD = "JDBC";
	
	/**
	 * 회원 전체 목록을 조회하여 반환하는 메소드
	 * @return 전체 회원 목록
	 */
	public ArrayList<Member> selectAllList(){
		ArrayList<Member> list = new ArrayList<>(); //[] 객체 생성 시 비어있음
		
		// DQL(SELECT)문 실행 여러 행 조회 ---> ResultSet 객체 --> ArrayList에 담기
		
		// JDBC 객체 선언
		Connection conn=null;
		Statement stat=null;
		ResultSet rset=null;
		
		// 실행할 쿼리문
		String sql = "SELECT * FROM MEMBER";
		
		
		try {
			//1) jdbc 드라이버 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//2) connection 객체 생성
			conn=DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			
			// 3) statement 객체 생성
			stat = conn.createStatement();
			
			//4),5) SQL 실행 및 결과 받기
			rset=stat.executeQuery(sql);
			
			//6) ResultSet 에 담겨져있는 데이터를 하나하나 추출
			while(rset.next()) {
				// 1] 데이터를 추출하여 Member 객체에 담기(생성)
				Member m = new Member(
							rset.getInt("MEMBERNO"),
							rset.getString("MEMBERID"),
							rset.getString("MEMBERPW"),
							rset.getString("GENDER").charAt(0),
							rset.getInt("AGE"),
							rset.getString("EMAIL"),
							rset.getString("ADDRESS"),
							rset.getString("PHONE"),
							rset.getString("HOBBY"),
							rset.getDate("enrollDate")
						);
				// 2] Member 객체를 리스트에 추가
				list.add(m);
			}
		} catch (ClassNotFoundException | SQLException e) { // 상속관계가 없을경우에는 나란히 사용 가능
			// TODO 클래스 찾지 못하는 예외사항
			e.printStackTrace();
		} finally {
			try {
				rset.close();
				stat.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	/**
	 * 요청도니 회원 정보를 DB에 추가하는 메소드
	 * @param m 사용자가 입력한 정보들이 담겨있는 Member 객체
	 * @return 추가 (INSERT) 후 처리된 행 수
	 */
	public int insertMember(Member m) {
		int result = 0;
		// DML(insert)   -> int 처리된 행 수  --> 트랜잭션(commit|rollback)
		
		String sql ="INSERT INTO MEMBER VALUES(SEQ_MNO.NEXTVAL"
				+ ", '"+m.getMemberId()+"'"
				+ ", '"+m.getMemberPw()+"'"
				+ ", '"+m.getGender()+"'"
				+ ", '"+m.getAge()+"'"
				+ ", '"+m.getEmail()+"'"
				+ ", '"+m.getAddress()+"'"
				+ ", '"+m.getPhone()+"'"
				+ ", '"+m.getHobby()+"'"
				+ ", SYSDATE)";
		System.out.println("=============================");
		System.out.println(sql);
		System.out.println("=============================");
		
		// JDBC용 객체 선언
		Connection conn = null;
		Statement stat = null;
		
		
		try {
			// 1) jdbc 드라이버 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//2) connenction 객체 생성(DB 정보로 연결)
			conn = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			conn.setAutoCommit(false);		//-> 오토커밋 해제
			
			//3) Statement 객체 생성(conn.통해 생성) stat변수에 대입
			stat= conn.createStatement();
			
			//4),5) SQL 실행과 결과 받기
			result = stat.executeUpdate(sql); // 결과를 result로 받기
			
			//6) 트랜잭션 처리
			if(result >0) {
				conn.commit();
			}else {
				conn.rollback();
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				stat.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}
