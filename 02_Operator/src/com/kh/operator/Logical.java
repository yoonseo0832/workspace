package com.kh.operator;
import java.util.Scanner;
public class Logical {
	/*
	 * 논리 연산자(이항 연산자)
	 * : 두 개의 논리값을 연산(true/false)
	 * :결과값도 논리값
	 * 
	 * *종류: && || (and/or)
	 * 		and - A && B: A,B 모두 true값이여야 true;
	 * 		true && true => true
	 * 		true && false => false
	 * 		false && true => false//이미 앞이 false여서 뒤에 계산 안해
	 * 		false && false => false//이미 앞이 false여서 뒤에 계산 안해
	 * 		or  - A || B: A 또는 B 둘중 하나라도 true값이면 true;
	 * 		true || true => true //이미 앞이 true여서 뒤에 계산 안해
	 * 		true || false => true //이미 앞이 true여서 뒤에 계산 안해
	 * 		false || true => true
	 * 		false || false => false
	 * 
	 * - 주의사항 .SCE (Short-Circuit Evaluation)
	 * 	- && 앞 조건이 false라면 뒤의 조건은 실행되지 않음
	 *  - || 앞 조건이 true라면 뒤의 조건은 실행되지 않음
	 */
	public static void main(String[] args) {
		//method1();
		method2();
	}
	public static void method2() {
		Scanner sc = new Scanner(System.in);
		System.out.println("문자를 입력하세요: ");
		
		String str = sc.next();
		char ch = str.charAt(0);
	//char ch = sc.next().charAt(0); 위의 두 라인과 같은것
		
		// 97 <= ch <=122 사이인 값인지 확인하는 것
		boolean result = (ch >=97 && ch<=122);
		boolean r1 = (ch >='a' && ch<='z');
		System.out.println("입력은 소문자인가? "+ result);
		System.out.println("입력은 소문자인가? "+ r1);
		
		System.out.println((int)ch);
		
		sc.close();
	}
	public static void method1() {
		Scanner sc = new Scanner(System.in);
		System.out.print("입력받은 수: ");
		int num = sc.nextInt();
		boolean result = (1<=num) && (num <=10);
		System.out.println("입력된 값은 1~10 사이의 값인가?"+ result);
		
		boolean result1 = (1>num) || (num >10);
		System.out.println("입력된 값은 1~10 범위를 벗어났는가?"+ result1);
		
		if(num>=1 && num<=10) {
			System.out.println("당신의 숫자는 1과10사이입니다");
		}else {
			System.out.println("당신의 숫자는 1과10사이가 아닙니다");
		}
		
		boolean result2 = (num%2==0);
		System.out.println("짝수인가요?"+ result2);
		
		if(num %2==0) {
			System.out.print("짝수입니다");
		}else {
			System.out.print("홀수입니다");
		}
		sc.close();
	}
}
