package com.kh.view;

import java.util.Scanner;

import com.kh.controller.MemberController;

/*
 * * View
 *   : 사용자가 보게될 시각적인 요소(화면).
 *     출력 또는 입력
 */
public class MemberMenu {
	Scanner sc = new Scanner(System.in);
	
	private MemberController mController =  new MemberController();
	
	public void mainMenu() {
		while(true) {
			System.out.println("======= 회원 관리 프로그램 =======");
			System.out.println("1. 회원 추가");			// c (create)
			System.out.println("2. 전체 회원 조회");		// r (read)
			System.out.println("3. 회원 아이디로 검색");	// r (read)
			System.out.println("4. 회원 정보 수정");		// u (update)
			System.out.println("5. 회원 탈퇴");			// d (delete)
			System.out.println("9. 프로그램 종료");
			
			System.out.print(">> 메뉴 번호 : ");
			int menu = sc.nextInt();
			sc.nextLine();
			
			switch(menu) {
			case 1:
				addMemberMenu();
				break;
			case 2:
				// Controller 객체에게 전체 회원 조회 요청
				mController.selectAll();
				break;
			case 3:
				searchByIdMenu();
				break;
			case 4:
				updateMemberMenu();
				break;
			case 5:
				deleteMemberMenu();
				break;
			case 9:
				System.out.println("프로그램이 종료됩니다..");
				return;
			}
		}
	}
	public s
}
