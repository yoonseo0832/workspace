package com.kh.practice.chap01;

import java.util.Scanner;

public class ControlPractice {

	public static void main(String[] args) {
		// practice1();
		// practice2();
		// practice3();
		// practice4();
		// practice5();
		// practice6();
		// preatice7();
		// practice8();
		// practice9();
		practice10();
	}

	public static void practice1() {
		Scanner sc = new Scanner(System.in);
		System.out.println("1. 입력");
		System.out.println("2. 수정");
		System.out.println("3. 조회");
		System.out.println("4. 삭제");
		System.out.println("7. 종료");
		System.out.print("메뉴를 번호를 입력하세요: ");
		int n1 = sc.nextInt();
		switch (n1) {
			case 1:
				System.out.print("입력 메뉴입니다.");
				break;
			case 2:
				System.out.print("수정 메뉴입니다.");
				break;
			case 3:
				System.out.print("조회 메뉴입니다.");
				break;
			case 4:
				System.out.print("삭제 메뉴입니다.");
				break;
			case 7:
				System.out.print("종료 메뉴입니다.");
				break;
			default:
				System.out.print("잘못된 번호입니다.");
		}
		sc.close();
	}

	public static void practice2() {
		Scanner sc = new Scanner(System.in);
		System.out.print("숫자를 한개 입력하세요: ");
		int n2 = sc.nextInt();
		if (n2 <= 0) {
			System.out.print("양수만 입력해주세요.");
		} else if (n2 % 2 == 0) {
			System.out.print("짝수이다.");
		} else {
			System.out.print("홀수이다.");
		}
		sc.close();
	}

	public static void practice3() {
		Scanner sc = new Scanner(System.in);
		System.out.print("국어점수: ");
		int kor = sc.nextInt();
		System.out.print("수학점수: ");
		int math = sc.nextInt();
		System.out.print("영어점수: ");
		int eng = sc.nextInt();
		int total = kor + math + eng;
		double mid = (double) (total / 3);
		if (kor >= 40 && math >= 40 && eng >= 40 && mid >= 60) {
			System.out.println("국어: " + kor);
			System.out.println("수학: " + math);
			System.out.println("영어: " + eng);
			System.out.println("합계: " + total);
			System.out.println("평균: " + mid);
			System.out.println("축하합니다, 합격입니다.");
		} else {
			System.out.print("불합격입니다.");
		}
		sc.close();
	}

	public static void practice4() {
		Scanner sc = new Scanner(System.in);
		System.out.print("1~12 사이의 정수를 입력: ");
		int month = sc.nextInt();
		switch (month) {
			case 1:
			case 2:
			case 12:
				System.out.printf("%d월은 겨울입니다.", month);
				break;
			case 3:
			case 4:
			case 5:
				System.out.printf("%d월은 봄입니다.", month);
				break;
			case 6:
			case 7:
			case 8:
				System.out.printf("%d월은 여름입니다.", month);
				break;
			case 9:
			case 10:
			case 11:
				System.out.printf("%d월은 가을입니다.", month);
				break;
			default:
				System.out.printf("%d월은 잘못 입력된 달입니다.", month);
		}
		sc.close();
	}

	public static void practice5() {
		Scanner sc = new Scanner(System.in);
		final String ID = "myId";
		final String PASS = "myPass";

		System.out.print("아이디: ");
		String userId = sc.next();
		System.out.print("비밀번호: ");
		String userPwd = sc.next();

		// 문자열 비교 메소드: 문자열.equals("변수/문자열값")
		if (userId.equals(ID) && userPwd.equals(PASS)) {
			System.out.println("로그인 성공");
		} else if (!userId.equals(ID) && !userPwd.equals(PASS)) {
			System.out.println("가입된 정보가 없습니다.");
		} else {
			if (!userId.equals(ID)) {
				System.out.println("아이디가 틀렸습니다.");
			} else if (!userPwd.equals(PASS)) {
				System.out.println("비밀번호가 틀렸습니다.");
			}
		}
		sc.close();
	}

	public static void practice6() {
		Scanner sc = new Scanner(System.in);
		System.out.print("권한을 확인하고자 하는 회원의 등급: ");
		String member = sc.next();
		if (member.equals("관리자")) {
			System.out.print("회원관리, 게시글 관리 게시글 작성, 댓글 작성 게시글 조회");
		} else if (member.equals("회원")) {
			System.out.print("게시글 작성, 게시글 조회, 댓글 작성");
		} else if (member.equals("비회원")) {
			System.out.print("게시글 조회");
		}
		sc.close();
	}

	public static void practice7() {
		Scanner sc = new Scanner(System.in);
		System.out.print("키(m)를 입력해 주세요: ");
		double height = sc.nextDouble();
		System.out.print("몸무게(kg)를 입력해 주세요: ");
		double weight = sc.nextDouble();
		double bmi = weight / (height * height);
		if (bmi < 18.5) {
			System.out.print("저체중");
		} else if (bmi >= 18.5 && bmi < 23) {
			System.out.print("정상체중");
		} else if (bmi >= 23 && bmi < 25) {
			System.out.print("과체중");
		} else if (bmi >= 25 && bmi < 30) {
			System.out.print("비만");
		} else if (bmi >= 30) {
			System.out.print("고도비만");
		}
		sc.close();
	}

	public static void practice8() {
		Scanner sc = new Scanner(System.in);
		System.out.print("피연산자1 입력: ");
		int n1 = sc.nextInt();
		System.out.print("피연산자2 입력: ");
		int n2 = sc.nextInt();
		System.out.print("연산자를 입력(+,-,*,/,%): ");
		String s1 = sc.next();

		double r1 = (double) n1 + n2;
		double r2 = (double) n1 - n2;
		double r3 = (double) n1 * n2; // 형변환은 하나에만 입력해도 더 큰것으로 됨
		double r4 = (double) n1 / n2; // 15/(double)4=3 => 3.00000
		double r5 = (double) n1 % n2;

		if (s1.equals("+")) {
			System.out.printf("%d %s %d = %.6f", n1, s1, n2, r1);
		} else if (s1.equals("-")) {
			System.out.printf("%d %s %d = %.6f", n1, s1, n2, r2);
		} else if (s1.equals("*")) {
			System.out.printf("%d %s %d = %.6f", n1, s1, n2, r3);
		} else if (s1.equals("/")) {
			System.out.printf("%d %s %d = %.6f", n1, s1, n2, r4);
		} else if (s1.equals("%")) {
			System.out.printf("%d %s %d = %.6f", n1, s1, n2, r5);
		}
		sc.close();
	}

	public static void practice9() {
		Scanner sc = new Scanner(System.in);

		System.out.print("중간고사 점수: ");
		int mid = sc.nextInt();
		System.out.print("기말고사 점수: ");
		int last = sc.nextInt();
		System.out.print("과제 점수: ");
		int assign = sc.nextInt();
		System.out.print("출석 횟수: ");
		int attend = sc.nextInt();

		System.out.print("==========결과=========\n");

		int totalAttend = 20;
		double rMid = mid * 0.2;
		double rLast = last * 0.3;
		double rAssign = assign * 0.3;
		double rAttend = ((double) attend / totalAttend) * 20;
		double totalScore = rMid + rLast + rAssign + rAttend;

		System.out.printf("중간고사 점수(20) : %.1f\n", rMid);
		System.out.printf("기말고사 점수(30) : %.1f\n", rLast);
		System.out.printf("과제 점수(30) : %.1f\n", rAssign);
		System.out.printf("출석 점수(20) : %.1f\n", rAttend);

		if (attend < totalAttend * 0.7) {
			System.out.printf("Fail[출석 횟수 부족 (%d/%d)]\n", attend, totalAttend);
		} else if (totalScore >= 70) {
			System.out.println("PASS");
		} else {
			System.out.println("FAIL[점수 미달]");
		}
		sc.close();
	}
	public static void practice10(){
		Scanner sc = new Scanner(System.in);
		System.out.println("실행할 기능을 선택하세요");
		System.out.println("1. 메뉴 출력");
		System.out.println("2. 짝수/홀수");
		System.out.println("3. 합격/불합격");
		System.out.println("4. 계절");
		System.out.println("5. 로그인");
		System.out.println("6. 권한 확인");
		System.out.println("7. BMI");
		System.out.println("8. 계산기");
		System.out.println("9. PASS/FAIL");
		System.out.println("선택: ");
		int selected = sc.nextInt();
		switch(selected){
			case 1: 
				practice1();
				break;
			case 2: 
				practice2();
				break;
			case 3: 
				practice3();
				break;
			case 4: 
				practice4();
				break;
			case 5: 
				practice5();
				break;
			case 6: 
				practice6();
				break;
			case 7: 
				practice7();
				break;
			case 8: 
				practice8();
				break;
			case 9: 
				practice9();
				break;
		}
	}
}
