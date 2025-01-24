package com.kh.operator.practice.func;
import java.util.Scanner;
public class OperatorPractice {

	public static void main(String[] args) {
		//practice1();
		//practice2();
		//practice3();
		//practice4();
		//practice5();
		//practice6();
		//practice7();
		//practice8();
		//practice9();
		//practice10();
		practice11();
	}
	public static void practice1() {
		Scanner sc = new Scanner(System.in);
		System.out.println("정수: ");
		int n1 = sc.nextInt();
		String r1 = n1>=0 ? "양수다":"양수가 아니다";
		System.out.println(r1);
		sc.close();
	}
	public static void practice2() {
		Scanner sc = new Scanner(System.in);
		System.out.println("정수: ");
		int n2 = sc.nextInt();
		String r2 = n2>0 ? "양수다":(n2==0)? "0이다":"음수다";
		System.out.println(r2);
		sc.close();
	}
	public static void practice3() {
		Scanner sc = new Scanner(System.in);
		System.out.println("정수: ");
		int n3 = sc.nextInt();
		String r3 = n3%2==0?"짝수다":"홀수다";
		System.out.println(r3);
		sc.close();
	}
	public static void practice4() {
		Scanner sc = new Scanner(System.in);
		System.out.print("인원 수: ");
		int human = sc.nextInt();
		
		System.out.print("사탕 개수: ");
		int candy = sc.nextInt();
		int forEach = candy/human;
		int forLeave = candy%human;
		System.out.println("1인당 사탕 개수: "+ forEach);
		System.out.println("남은 사탕 개수: "+ forLeave);
		sc.close();
	}
	public static void practice5() {
		Scanner sc = new Scanner(System.in);
		System.out.print("이름: ");
		String name = sc.next();
		System.out.print("학년(숫자만): ");
		int year = sc.nextInt();
		System.out.print("반(숫자만): ");
		int group = sc.nextInt();
		System.out.print("번호(숫자만): ");
		int num = sc.nextInt();
		
		System.out.print("성별(M/F): ");
		String gender = sc.next();
		char gen = gender.charAt(0);
		if(gen =='F') {
			gen = '여';
		}else {
			gen ='남';
		}
		System.out.print("성적(소수점 아래 둘째자리까지): ");
		double grade = sc.nextDouble();
		
		System.out.printf("%d학년 %d반 %d번호 %s %c학생의 성적은 %.2f이다", year, group, num, name, gen, grade);
		sc.close();
	}
	public static void practice6() {
		Scanner sc = new Scanner(System.in);
		System.out.print("나이: ");
		int age = sc.nextInt();
		String yourAge =age<8? "미취약 아동":age>=8&& age<=13? "어린이":age>13 &&age<=19?"청소년":"성인";
		System.out.print(yourAge);
		
		sc.close();
	}
	public static void practice7() {
		Scanner sc= new Scanner(System.in);
		System.out.print("국어: ");
		int kor = sc.nextInt();
		System.out.print("영어: ");
		int eng = sc.nextInt();
		System.out.print("수학: ");
		int math = sc.nextInt();
		int total = kor+ eng+ math;
		double mid = (double)total/3.0;
		System.out.println("합계: "+ total);
		System.out.printf("평균: %.1f\n", mid);
		String pass = (kor>=40&&eng>=40&&math>=40&&mid>=60)?"합격": "불합격"; 
		System.out.print(pass);
		
		sc.close();
	}
	public static void practice8() {
		Scanner sc= new Scanner(System.in);
		System.out.print("주민번호를 입력하세요(- 포함): ");
		String numId = sc.next();
		char forGender = numId.charAt(7);
		String gen="";
		if(forGender=='4'|| forGender=='2') {
			gen="여자";
		}else if(forGender=='3'||forGender=='1'){
			gen="남자";
		}else {
			System.out.print("잘못입력했습니다.");
		}
		System.out.print(gen);
		
		sc.close();
	}
	public static void practice9() {
		Scanner sc= new Scanner(System.in);
		System.out.print("정수1: ");
		int num1 = sc.nextInt();
		System.out.print("정수2: ");
		int num2 = sc.nextInt();
		System.out.print("입력: ");
		int input = sc.nextInt();
		boolean result = input<=num1 ||input>num2?true:false;
		System.out.print(result);
		
		sc.close();
	}
	public static void practice10() {
		Scanner sc= new Scanner(System.in);
		System.out.print("입력1: ");
		int n1 = sc.nextInt();
		System.out.print("입력2: ");
		int n2 = sc.nextInt();
		System.out.print("입력3: ");
		int n3 = sc.nextInt();
		boolean result = (n1==n2 &&n1==n3)?true:false;
		System.out.println(result);
		
		sc.close();
	}
	public static void practice11() {
		Scanner sc= new Scanner(System.in);
		System.out.print("A사원의 연봉: ");
		double salery1= sc.nextDouble();
		System.out.print("B사원의 연봉: ");
		double salery2= sc.nextDouble();
		System.out.print("C사원의 연봉: ");
		double salery3= sc.nextDouble();
		
		double r1 = salery1;
		double r3 = salery3;
		r1=(r1+ r1*0.4);
		r3=(r3*1.15); // r3*(1 + 0.15) => r3 + r3*0.15
		
		String total1 = (r1)>=3000?"3000 이상":"3000 미만";
		String total2 = salery2>=3000?"3000 이상":"3000 미만";
		String total3 = (r3)>=3000?"3000 이상":"3000 미만";
		
		System.out.printf("A사원 연봉/연봉+a: %.0f/%.1f\n",salery1, r1);
		System.out.print(total1+"\n");
		System.out.printf("B사원 연봉/연봉+a: %.0f/%.1f\n",salery2, salery2 );
		System.out.print(total2+"\n");
		System.out.printf("C사원 연봉/연봉+a: %.0f/%.13f\n",salery3, r3);
		System.out.print(total3);
		
		sc.close();
	}
}
