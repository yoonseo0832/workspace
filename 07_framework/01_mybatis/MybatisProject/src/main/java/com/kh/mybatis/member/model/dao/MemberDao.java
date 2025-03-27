package com.kh.mybatis.member.model.dao;

import java.sql.ResultSet;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import com.kh.mybatis.member.model.vo.Member;

public class MemberDao {

	public int insertMember(SqlSession sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	// 리턴 타입을 확인 ResultSet -> Member
	public Member selectMember(SqlSession sqlSession, Member m) {
		// select ==> selectOne: 하나만 조회(조건이 unique 제약조건이 있어서)
		// 		  ==> selectList : 여러 행을 조회
		
		// 데이터 조회 시 결과가 없을 경우 null을 반환
		return sqlSession.selectOne("memberMapper.selectMember", m);
	}
	public int updateMember(SqlSession sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}
	public int deleteMember(SqlSession sqlSession, Member m) {
		return sqlSession.update("memberMapper.deleteMember", m);
	}
	
	public int updatePassword(SqlSession sqlSession, HashMap data) {
		return sqlSession.update("memberMapper.updatePassword", data);
	}
}
