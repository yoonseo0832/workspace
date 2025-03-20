package com.kh.controller;

import java.util.ArrayList;

import com.kh.model.dao.MemberDao;
import com.kh.model.vo.Member;
import com.kh.view.*;
/*
 * Controller : View로부터 사용자가 요청한 기능에 대해 처리하는 역할
 * 				전달받은 데이터를 가공처리 후 DAO로 전달하여 호출
 * 				=> DAO로부터 반환받은 결과에 따라 성공인지, 실패인지 판단 후 view한테 응답 
 */
public class MemberController {
	private MemberDao mDao = new MemberDao();
	/**
	 * 회원 추가 요청을 처리할 메소드(신규 회원)
	 * @param id 		아이디
	 * @param pwd 		비번
	 * @param gender 	성별
	 * @param age 		나이
	 */
	public void insertMember(String id, String pwd, char gender, int age ) {
		//View로부터 전달받은 값들을 DAO에게 바로 전달 아닌 Memeber 객체에 담아서 전달
		
		//Member 객체 생성
		// - 기본 생성자 생성 후 setter 이용해 저장
		// - 매개 변수 있는 생성자 사용해 저장
		// 매개변수 4개인 생성자 
		Member m= new Member(id, pwd, gender, age);
		
		// DAO에게 신규회원정보를 전달하여 추가 요청
		int result = mDao.insertMember(m);
		
		if(result >0) {
			//출력 성공 (View이용)
			new MemberMenu().displaySuccess("회원 추가 성공");
		}else {
			// 출력 실패 (View이용)
			new MemberMenu().displayFailed("회원 추가 실패");
		}
	}
	/**
	 * 전체 회원 정보들을 조회하는 메소드
	 */
	public void selectAll() {
		ArrayList<Member>list = mDao.selectAllList();
		
		// * 조회된 결과에 따라 사용자에게 표시(출력_)
		//if(list.size() == 0))
		if(list.isEmpty()) {
			new MemberMenu().displayNoData();
		}else {
			new MemberMenu().displayAllMembers(list);
		}
	}
}
