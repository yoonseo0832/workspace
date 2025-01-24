package com.kh.operator;
import java.util.Scanner;
public class Triple {
	/*
	 * 삼항 연산자(항이 3개인 연산자)
	 * 조건식 ? (조건식 true 결과값) : (조건식 false 결과값)
	 * 	-조건문과 유사하게 동작
	 * 
	 */
	public static void main(String[] args) {
		
		//method1();
		method2();
	}
	public static void method2() {
		/*
		 * 사용자에게 두개의 정수와 + 또는 - 값을 입력받아 연산 결과 출력
		 * 입력 예시: 10 20 + 
		 * 단, + 또는 - 외의 문자 입력시 "잘못된 입력입니다" 출력
		 */
		Scanner sc = new Scanner(System.in);
		System.out.println("아래와 같이 입력 시 연산 결과를 확인할 수 있습니다");
		System.out.println("예) 10 20 + => 10+20=30의 결과 확인");
		System.out.println("---------------------------------------");
		System.out.printf("숫자 두개와 산술연산자(+/-)중 하나를 입력하세요: ");
		//입력: 10 20 +  버퍼: 10 20 +\n num1 =10; num2=20 
		// 공백을 기준으로 next()가 뺴감
		int num1 = sc.nextInt();
		int num2 = sc.nextInt();
		char ch1 = sc.next().charAt(0);
		
		String result = ""+(ch1 == '+'? num1 + num2 : (ch1 =='-'? num1 - num2 : "잘못된 입력입니다."));
		System.out.printf("%d%c%d= %s\n", num1, ch1, num2, result);
			
		if(ch1=='+') {
			System.out.print(num1+"+"+num2+"= "+(num1+num2));
		}else if(ch1!='-' && ch1!='+') {
			System.out.print("연산자를 잘못 입력했습니다.");
		}else {
			System.out.print(num1+"-"+num2+"= "+(num1-num2));
		}
		
		sc.close();
	}
	public static void method1() {
		//입력한 값 x인 경우 "종료합니다" 아니면 "계속됩니다" 출력
		Scanner sc = new Scanner(System.in);
		System.out.print("종료를 원한다면 'x'또는 'X'를 입력하세요: ");
		
		String str = sc.next();
		char ch = str.charAt(0);
		
		// char ch = sc.next().charAt(0);
		String result = (ch=='x' || ch=='X') ? "종료됩니다" : "계속됩니다";
		System.out.println(result);
		
		System.out.println("-------------------------");
		
		System.out.print((ch=='x' || ch=='X') ? "종료됩니다" : "계속됩니다");
		sc.close();
	}
}
