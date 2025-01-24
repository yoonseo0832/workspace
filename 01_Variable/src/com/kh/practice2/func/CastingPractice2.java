package com.kh.practice2.func;
import java.util.Scanner;
public class CastingPractice2 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.print("국어: ");
		double kor = sc.nextDouble();
		// 입력을 하면 enter를 쳐서 다음줄에 작성되니 print 써도됨
		System.out.print("영어: ");
		double eng = sc.nextDouble();
		System.out.print("수학: ");
		double math = sc.nextDouble();
		int total = (int)(kor+eng+math);
		int mid = total/3;
		System.out.println("총점: "+ total);
		System.out.print("평균: "+ mid);
		sc.close();
	}
}
