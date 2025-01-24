package com.kh.condition;
import java.util.Scanner;
public class If {

	public static void main(String[] args) {
		//method1();
		//method2();
		method3();
	}
	public static void method1() {
		/* 
		 * 사용자의 입력 값이 1 ~ 10 사이의 값인지 확인하여
		 * * 범위를 벗어난 경우 "범위를 벗어났습니다." 출력
		 * * 범위 내에 있는 경우 입력값을 출력
		 */
		Scanner sc = new Scanner(System.in);
		System.out.print("숫자를 입력하세요: ");
		int n1 = sc.nextInt();
		if(n1>=1&&n1<=10) {
			System.out.print(n1);
		}else {
			System.out.print("범위를 벗어났습니다.");
		}
		sc.close();
	}
	public static void method2() {
		/* 
		 * 문자를 입력받아 소문자인 경우 "{입력받은값}은 소문자입니다." 출력
		 * 대문자인 경우 "{입력받은값}은 대문자입니다." 출력
		 * 그렇지 않으면 "알파벳이 아닙니다." 출력
		 */
		Scanner sc = new Scanner(System.in);
		System.out.print("문자: ");
		char ch = sc.next().charAt(0);
		
		if(ch >='a' && ch<='z') {
			System.out.printf("%c은 소문자입니다.", ch);
			
		}else if((ch >='A' && ch<='Z')){
			System.out.printf("%c은 대문자입니다.", ch);
		}else {
			System.out.println("알파벳이 아닙니다.");
		}
		sc.close();
	}
	public static void method3() {
		/* TODO:
		 * 주민번호 입력받아서 남자인지, 여자인지 출력
		 * (단, - 포함해서 입력받은 값의 길이가 14가 아닌 경우 "잘못 입력되었습니다" 출력)
		 * * 문자열 길이 확인 메소드: 문자열.length()
		 */
		Scanner sc = new Scanner(System.in);
		System.out.print("주민번호를 입력하세요: ");
		String numId = sc.next();
		char ch = numId.charAt(7);
		
		if(numId.length() != 14) {
			System.out.print("잘못 입력되었습니다");
		}else if(ch =='4'||ch=='2') {
			System.out.print("여자입니다.");
		}else if(ch =='3'|| ch =='1') { //조건식은 무조건(if문) 필요, else는 안됨
			System.out.print("남자입니다.");
		}
		sc.close();
	}
}
