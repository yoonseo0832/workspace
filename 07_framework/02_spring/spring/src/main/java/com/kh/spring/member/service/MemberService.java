package com.kh.spring.member.service;

import com.kh.spring.member.model.vo.Member;

public interface MemberService {
	/* 회원 가입 서비스 (C) */
	int insertMember(Member member);
	
	/* 로그인 서비스 (R) */
	Member loginMember(Member member);
	
	/* 회원 정보 수정 서비스 (U) */
	int updateMember(Member member);
	
	/* 회원 탈퇴 서비스 (D) */
	int deleteMember(String id);
}
