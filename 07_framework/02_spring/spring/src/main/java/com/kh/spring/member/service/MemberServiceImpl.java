package com.kh.spring.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.member.model.dao.MemberDao;
import com.kh.spring.member.model.vo.Member;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor	// 필드로 선언된 객체(빈)를 생성자 방식으로 주입 기능
@Service  // @Component 보다 좀 더 구체화된 객체를 의미! => Service bean 등록
public class MemberServiceImpl implements MemberService {
	private final MemberDao mDao;

	@Override
	public int insertMember(Member m) {
		
		return mDao.insertMember(m);
	}

	@Override
	public Member loginMember(Member m) {
		// TODO Auto-generated method stub
		return mDao.loginMember(m);
	}

	@Override
	public int updateMember(Member m) {
		return 0;
	}

	@Override
	public int deleteMember(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}