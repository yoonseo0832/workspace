package com.kh.operator;

import java.util.Scanner;

public class Comparison {
	/*
	 * 비교 연산자 (이항연산자)
	 * : 두 값을 비교하는 연산자
	 * : 조건을 만족하면 결과가 true, 그렇지 않으면 false
	 * *종류(기준은 왼쪽의 조건을 [a<=b] a를 기준으로 크거나 같은지)
	 * - 대소 비교 연산자: <, >, <=, >=
	 * - 동등 비교 연산자: ==, !=
	 */
	public static void main(String[] args) {
		//입력받은 두 정수의 값을 비교
		Scanner sc = new Scanner(System.in);
		//Scanner 자료형, sc 변수명
		System.out.println("정수1: ");
		int n1 = sc.nextInt();
		
		System.out.println("정수2: ");
		int n2 = sc.nextInt();
		
		System.out.println("첫번째 숫자와 두번째 숫자는 같은 값인가? "+ (n1==n2));
		System.out.println("첫번째 숫자가 두번째 숫자보다 큰가? "+ (n1>=n2));
		System.out.println("두번째 숫자는 짝수인가? "+ (n2%2==0));
		System.out.println("두번째 값은 'A'의 유니코드인가? "+ (n2 == 'A'));
		System.out.println("'A'의 유니코드는? "+ (int)('A'));
		
		sc.close();
	}

}
