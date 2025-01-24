package com.kh.practice1.func;
import java.util.Scanner;
public class VariablePractice4 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		System.out.print("문자열을 입력하세요: ");
		String noun =sc.nextLine();
		char noun1 = noun.charAt(0);
		char noun2 = noun.charAt(1);
		char noun3 = noun.charAt(2);

		System.out.printf("첫 번째 문자: %c\n", noun1);
		System.out.printf("첫 번째 문자: %c\n", noun2);
		System.out.printf("첫 번째 문자: %c\n", noun3);
		sc.close();
	}
}
