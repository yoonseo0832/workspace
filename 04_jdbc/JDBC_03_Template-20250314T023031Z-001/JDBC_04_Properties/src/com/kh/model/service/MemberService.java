package com.kh.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.common.JDBCTemplate;
import com.kh.model.dao.MemberDao;
import com.kh.model.vo.Member;

public class MemberService {
	/*
	 * [1] Connection 객체 생성
	 * 		- jdbc driver 등록
	 * 		- Connection 객체 생성
	 * [2] DML문 실행했을 경우 트랜잭션 처리
	 * 		- commit
	 * 		- rollback
	 * [3] Connection 객체 반납
	 * 		- close
	 */
	
	/**
	 * 회원 추가 기능에 대한 메소드
	 * @param m 추가할 회원 정보
	 * @return 처리 결과
	 */
	public int insertMember(Member m) {
		// 1) Connection 객체 생성
		Connection conn = JDBCTemplate.getConnection();
		
		// 2) DAO 객체에게 전달받은 데이터(Member m)와 
		//				생성한 Connection 객체를 전달하여 결과 받기
		int result = new MemberDao().insertMember(conn, m);
		
		// 3) 실행한 SQL문 확인 => DML, insert
		//		- DML 이므로 트랜잭션 처리
		if (result > 0) {
			// 커밋처리
			JDBCTemplate.commit(conn);
		} else {
			// 롤백처리
			JDBCTemplate.rollback(conn);
		}
		
		// 4) Connection 객체 반납
		JDBCTemplate.close(conn);
		
		// 5) 결과 반환
		return result;
	}

	/**
	 * 전체 회원 목록을 조회 메소드
	 * @return 전체 회원 목록 정보
	 */
	public ArrayList<Member> selectAllList() {
		// 1) Connection 객체 생성
		Connection conn = JDBCTemplate.getConnection();
		
		// 2) DAO에게 전체회원 목록 요청 --> 생성된 Connection 객체 전달
		ArrayList<Member> list = new MemberDao().selectAll(conn);
		
		// 3) Connection 객체 반납
		JDBCTemplate.close(conn);
		
		// 4) 조회 결과 반환
		return list;
	}

	/**
	 * 전달된 아이디가 포함된 회원 목록을 조회
	 * @param searchId 검색할 회원 아이디
	 * @return 조회 결과
	 */
	public ArrayList<Member> searchById(String searchId) {
		// 1) Connection 객체 생성
		Connection conn = JDBCTemplate.getConnection();
		
		// 2) DAO에게 검색 요청
		ArrayList<Member> list = new MemberDao().searchById(conn, searchId);
		
		// 3) Connection 객체 반납
		JDBCTemplate.close(conn);
		
		// 4) 결과를 반환
		return list;
	}

	/**
	 * 수정할 회원 정보를 받아 수정 요청
	 * @param m 수정 정보 ( 회원아이디 기준, 비밀번호/성별/주소/취미 정보 변경 )
	 * @return  처리 결과
	 */
	public int updateMember(Member m) {
		// * Connection 객체 생성
		Connection conn = JDBCTemplate.getConnection();
		
		// * DAO 수정 요청 (DML)
		int result = new MemberDao().updateMember(conn, m);
		
		// * 트랜잭션 처리
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		
		// * Connection 객체 반납
		JDBCTemplate.close(conn);
		
		return result;
	}

	/**
	 * 삭제할 회원 아이디를 전달받아 회원 탈퇴 처리
	 * @param id	삭제할 회원 아이디
	 * @return		처리 결과
	 */
	public int deleteMember(String id) {
		// * Connection 객체 생성
		Connection conn = JDBCTemplate.getConnection();
		
		// * DAO 에게 삭제 요청 (=> 실제 DB에서 해당 회원 정보 삭제)
		int result = new MemberDao().deleteMember(conn, id);
		
		// * 트랜잭션 처리
		if (result > 0) {
			// 삭제 성공 -> DB에 적용 (commit)
			JDBCTemplate.commit(conn);
		} else {
			// 삭제 실패 -> 변경사항 취소 (rollback)
			JDBCTemplate.rollback(conn);
		}
		
		// * Connection 객체 반납 (close)
		JDBCTemplate.close(conn);
		
		return result;
	}
}







