package com.kh.practice1.func;
import java.util.Scanner;
public class VariablePractice3 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
			
		System.out.print("가로: ");
		double row = sc.nextDouble();
		
		System.out.print("세로: ");
		double column = sc.nextDouble();
		
		System.out.println("면적: " +(row*column));
		System.out.println("둘레: " +((row+column)*2));
		
		sc.close();
	}
}
