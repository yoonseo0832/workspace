package com.kh;

import java.util.Scanner; // Scanner import 연결

public class VariablePractice0 {
	public static void main(String[] args) {
		/*
		 * (1) 아래 코드 변수 사용해 실행
		 * 
		 */
		int year;
		int age;
		year = 2025;
		age = 20;
		System.out.println("현재 "+year+ "년이고 올해 "+ age + "살입니다.");
		System.out.printf("현재 %d년이고 올해 %d살입니다.\n", year, age);
		
		final int WEIGHT;
		WEIGHT=80;
		System.out.println("몸무게가 "+WEIGHT+"kg 이상인 경우 탑승하지 못합니다.");
		System.out.printf("몸무게가 %dkg 이상인 경우 탑승하지 못합니다.\n", WEIGHT);
		
		/*
		 * 입력을 받기 위한 기능을 포함 클래스: Scanner
		 * 	1) 연결: import 전체클래스명; //패키지경로.클래스명
		 * 			import java.util.Scanner;
		 * 	2) 생성: new 생성자;
		 * 			new Scanner(System.in); 
		 */
		Scanner sc = new Scanner(System.in);
		// 생성 및 할당
		System.out.println("이름: ");
		String name = sc.nextLine();
		//System.out.println("환영합니다, " +name+ " 고객님!");
		System.out.println("나이: ");
		int age1 = sc.nextInt();
		System.out.println("당신의 이름은 "+ name+" 나이는 "+age1+"살입니다.");
		sc.nextLine();
		// sc.nextline(); 계속 쓰려면 사이에 버퍼 지우기 \n 남아있어서
		// 사용하지 않으면 그냥 \n값이 있다고 판단되서 종료시킨다!
		System.out.print("하고 싶은 말: ");
		String temp = sc.nextLine();
		System.out.println(temp);
		
		sc.close();
	}
}
