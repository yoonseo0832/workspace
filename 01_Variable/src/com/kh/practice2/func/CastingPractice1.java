package com.kh.practice2.func;
	import java.util.Scanner;
public class CastingPractice1 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		System.out.println("문자: ");
		String word = sc.next();
		char uni = word.charAt(0);
		
		System.out.print(word + "unicode: "+ (int)uni);
		// 대문자 A : 65 소문자 a : 97
		
		sc.close();
	}
}
