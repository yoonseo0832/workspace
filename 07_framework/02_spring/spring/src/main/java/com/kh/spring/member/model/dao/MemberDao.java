package com.kh.spring.member.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.spring.member.model.vo.Member;

@Mapper
public interface MemberDao {
	// 회원 가입 - 데이터 추가
	int insertMember(Member member);

	// 로그인 - 데이터 조회
	Member loginMember(Member member);
	
	// 수정
	int updateMember(Member member);
}
