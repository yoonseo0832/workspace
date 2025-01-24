package com.kh.operator;

public class Arithmetic {
	/*
	 * 산술 연산자(이항연산자)
	 * + - * / % (사칙연산 관련 연산자)
	 * 우선순위 : * / % > + -
	 */
	public static void main(String[] args) {
		
		//method1(); //만든 메소드 호출 
		method2();
	}
	public static void method2() {
		int a =5;
		int b =10;
		
		int c = (++a)+ b; 
		// a=6 b=10 c=16
		int d = c /a; 
		// a=6 b=10 c=16 d=2
		int e = c % a;
		// a=6 b=10 c=16 d=2 e=4
		int f = e++;
		// a=6 b=10 c=16 d=2 e=5 f=4
		int g = (--b) + (d--);
		// a=6 b=9 c=16 d=1 e=5 f=4 g=11
		int h = 2;
		// a=6 b=9 c=16 d=1 e=5 f=4 g=11 h=2
		int i = (a++) + b/(--c/f)* (g-- - d)% (++e +h);
		// a=7 b=9 c=15 d=1 e=6 f=4 g=10 h=2 i=12
		//6+ 3*10%8=2 6+ 6 =12
		// i= (6+3)*2 = 18
		System.out.printf("a: %d, b: %d, c: %d, d: %d, e: %d, f: %d, g: %d, h: %d, i: %d\n", a,b,c,d,e,f,g,h,i);;
	}
	public static void method1() {
		int n1 = 10;
		int n2 =3;
		//int leftNum = (n1%n2);
		// 나머지 연산자 (%) -> 짝수/홀수 판별에쓰임
		//나머지 0=> 짝수/ 1=> 홀수
		System.out.printf("n1 + n2 = %d\n", (n1+n2));
		System.out.printf("n1 - n2 = %d\n", (n1-n2));
		System.out.printf("n1 * n2 = %d\n", (n1*n2));
		System.out.printf("n1 / n2 = %d\n", (n1/n2));
		System.out.printf("n1의 값은 짝수? %b\n", (n1%2==0));
		System.out.printf("n2의 값은 짝수? %b\n", (n2%2==0));
		//System.out.printf("n2 % n1 = %d\n", (n2%n1));
	}
}
