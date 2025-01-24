package com.kh.condition;
import java.util.Scanner;
public class Switch {

	public static void main(String[] args) {
		//method2();
		//method1();
		method3();
	}
	public static void method3() {
		Scanner sc = new Scanner(System.in);
		System.out.print("월을 입력하세요: ");
		int month = sc.nextInt();
		switch(month) {
		case 1:case 3: case 5: case 7: case 8: case 10: case 12:
			System.out.printf("%d월은 31일까지 입니다.", month);
			break;
		case 4: case 6: case 9: case 11:
			System.out.printf("%d월은 30일까지 입니다.", month);
			break;
		case 2:
			System.out.printf("%d월은 28일까지 입니다.",month);
			break;
		default: 
			System.out.print("월을 잘못입력했습니다.");
		}
		sc.close();
	}
	public static void method2() {
		/*
		 * * 과일을 구매하는 프로그램 *
		 * 사용자가 구매하고자 하는 과일을 입력하면, 해당 가격을 출력
		 * 
		 * 출력 => {과일이름}의 가격은 {과일가격}원입니다.
		 * 
		 * ------------------------
		 * 사과  :  15000
		 * 포도  :  30000
		 * 귤   :   8000
		 * ------------------------
		 */
		Scanner sc = new Scanner(System.in);
		System.out.print("구매할 과일 이름: ");
		String fruit =sc.next();
		
		switch(fruit) {
		case "사과":
			System.out.print("사과의 가격은 15000원입니다.");
			break;
		case "포도":
			System.out.print("포도의 가격은 30000원입니다.");
			break;
		case "귤":
			System.out.print("귤의 가격은 8000원입니다.");
			break;
		default:
			System.out.print("원하는 과일이 없습니다");
		}
		sc.close();
	}
	public static void method1() {
		/* 
		 * 정수를 입력받아, 아래 조건에 따라 출력.
		 * * 1 : "빨간색"
		 * * 2 : "파란색"
		 * * 3 : "초록색"
		 * * 그외 : "잘못입력하셨습니다"
		 */
		Scanner sc = new Scanner(System.in);
		System.out.print("1 ~ 3 사이의 정수 입력: ");
		int n1 = sc.nextInt();
		switch(n1) {
			case 1: 
				System.out.print("빨간색");
				break;
			case 2: 
				System.out.print("파란색");
				break;
			case 3: 
				System.out.print("초록색");
				break;
			default: 
				System.out.print("잘못입력하셨습니다");
				
		}
		sc.close();
	}
}
