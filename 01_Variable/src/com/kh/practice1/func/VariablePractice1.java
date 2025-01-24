package com.kh.practice1.func;
import java.util.Scanner;
public class VariablePractice1 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
			
		System.out.print("이름을 입력해: ");
		String name = sc.nextLine();
		
		//sc.nextLine();s
		
		System.out.print("성별을 입력해(남/여): ");
		String gender = sc.nextLine();
		// 문자 타입으로  한글자씩 꺼내옴
		char gen = gender.charAt(0);
		
		
		System.out.print("나이를 입력해: ");
		int age = sc.nextInt();

		System.out.print("키를 입력해(cm): ");
		double height = sc.nextDouble();
		
		System.out.printf("키 %.1fcm인 %d살 gender: %s자이고 gen: %c자 %s님 반갑습니다^^", height, age, gender,gen, name);
		// 줄바꿈 없이 출력하려면 print() 줄바꿈 있이 출력 println() 
		// next() nextLine() 둘다 String 자료형 입력받음
		
		//sc.nextLine(); 계속 쓰면 sc.nextLine(); 필요없으나 sc.nextInt(); 또는 sc.nextFloat();처럼
		// 다른 next를 사용한 경우 위에 사용한 sc.nextLine();의 버퍼에 \n이 남아있어서 입력을 못하고 바로 종료됨
		// 이유는 이미 \n값이 들어가 있기 때문이다, 이름 방지하려면 sc.nextLine(); 사용하면 됨
		/*
		 * System.out.print("이름을 입력해: ");
		String name = sc.nextLine();

		System.out.print("나이를 입력해: ");
		int age = sc.nextInt();

		System.out.print("키를 입력해(cm): ");
		float height = sc.nextFloat();
		
		sc.nextLine();
		
		System.out.print("성별을 입력해(남/여): ");
		String gender = sc.nextLine();
		 * 
		 * 이렇게 하면 성별 부분의 입력을 할수 있게 된다/. 
		 */
		sc.close();
	}
}
