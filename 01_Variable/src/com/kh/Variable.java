package com.kh;

public class Variable {
	//자바 실행 main 메소드
	public static void main(String[] args) {
		// printVariable(); // 호출
		declareVariable();
		printVariable();
	}
	public static void declareVariable() {
		/*
		 * 변수 선언: 값을 기록하기 위한 변수를 메모리 공간에 할당 및 확보
		 * [표현식]
		 * 			자료형 변수명;
		 *		- 자료형: 변수의 크기 및 모양을 지정하는 부분
		 *		- 변수명: 변수의 이름을 부여하는 부분(의미부여)
		 *
		 *명명규칙
		 *	[1] 커멜케이스 적용: 소문자 시작, 다른 단어는 대문자로 시작ex) gameChange
		 *		=> 클래스명의 경우 대문자로 시작
		 *	[2] 영문 대소문자 구분
		 *	[3] 숫자 시작 안됨, 오류 발생
		 *	[4] 예약어(키워드) 사용 불가
		 *	[5] 특수문자 $와 _(언더바)만 사용 가능
		 *
		 *	주의사항
		 *	- 같은 영역 안 {}를 의미, 동일한 변수명 선언 불가(중복 선언 불가)
		 *	- 해당 영역 안 선언된 변수는 영역 안에서만 사용 가능
		 */
		//정수형 
		//
		// 중복 선언 불가 int num = 20;
		// 
		//-----------------------------
		//1. 논리값 boolean : 논리값 (true/false) 1by
		 boolean isTrue = true;
		 boolean isFalse = false;
		 System.out.println("isTrue 변수 값: "+ isTrue);
		 System.out.println("isFalse 변수 값: "+ isFalse);
		 isTrue = 1 + 3 > 1; 
		 System.out.println("isTrue 변수 값: "+ isTrue);
		 isFalse = 2+ 3 <=5;
		 System.out.println("isFalse 변수 값: "+ isFalse);
		 // 2. 정수형 : 딱 떨어지는 수, 소수점 없음
		 //byte < short < int(기본자료형) 4바이트 < long
		 byte bNum; // btye : -128 ~127까지 
		 bNum = -128;
		 //bNum = 1000; // 범위를 벗어남 => byte형 =(int형) 
		 // 3. 실수형 : 소수점 0
		 //		float 4바이트
		 //     double(기본자료형) 8바이트
		 float fNum = 0.0f;// 소수점 7자리까지 표현 가능
		 				   // 값 자체(리터럴) 저장할 때 값 뒤에 f 붙임
		 double dNum = 0; // 소수점 15자리까지 표현 가능
		 System.out.println(dNum); //
		 
		 //4. 문자형 char / String
		 // char 2바이트
		 char ch ='a';
		 char kim = '김';
		 
		 // String 참조자료형
		 String str;
		 str="문이 열리네요 그대가 들어오죠";
		 System.out.println("문자열 길이: "+str.length());
		 
		 // 상수 변하지 않는 값 저장 공간 final
		 // [표현식] final 자료형 변수명;
		 final int AGE;
		 AGE=23;
		 System.out.println(AGE + "살, 양띠입니다");
		 //대표적 상수 : Math.PI
		 System.out.println("Math.PI: "+ Math.PI);
	}
	public static void printVariable() {
		// 다른 영역에 있는 변수 사용 불가 System.out.println(num);
		/*
		 * 변수의 목적 
		 * - 데이터(값)을 저장하기 위한 공간
		 * - 가독성 증가 (변수명: 의미 중시)
		 * - 재사용성 증가(한번 값 저장하면 필요에 따라 변수명으로 가져다 씀)
		 * - 유지보수 용이(한번 저장하면 해당 위치의 값을 변경)
		*/
		//월급 계산 = 시급 * 근무시간 * 근무일수
		// 최저시급 10050
		
		int lowPay =10050; //변수에 값 10050 대입 및 저장
		int time = 8;
		int days = 14;
		
		System.out.println("-------------------------");
		System.out.println("강호동: "+ lowPay*time*days + "원");
		System.out.println("김동준: "+ lowPay*6*days+ "원");
		System.out.println("카리마: "+ lowPay*time*days + "원");
		System.out.println("설윤도: "+ lowPay*10*days+ "원");
		System.out.println("윈터린: "+ 10050*2*days+ "원");
		
		System.out.println("-------------------------");
		System.out.println("김동준: "+ 10050*6*14+ "원");
		System.out.println("카리마: "+ 10050*8*14+ "원");
		System.out.println("설윤도: "+ 10050*10*14+ "원");
		System.out.println("윈터린: "+ 10050*2*14+ "원");
	}
}
