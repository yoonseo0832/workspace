package com.kh.operator;

public class InDecrease {

	public static void main(String[] args) {
		/*
		 * 증감연산자 (단항 연산자)
		 * 
		 * ++ : 값을 하나씩 증가시키는 연산자
		 * -- : 값을 하나씩 감소시키는 연산자
		 * 
		 * *처리 순서: 다른 연산자가 있을 경우
		 * - (증감연산자)변수 : 전위연산: "선증감"후처리
		 * - 변수(증감연산자) : 후위연산: "선처리"후증감
		 * i++, i--:(후위연산)
		 * ++i, --i:(전위연산) 
		 * i = 변수 --/++ (감소/증감연산자)
		 */
		//method1();
		//method2();
		method3();
	}
	public static void method3() {
		int a = 10;
		int b = 20;
		int c = 30;
		// 중괄호 안에서는 계산된 거에 맞게 하면 되서 리셋하지 않음
		int r1 = a++; //r1 = 10 // a = 11
		System.out.printf("a: %d, b: %d, c: %d, r1: %d\n", a,b,c,r1);
		int r2 = (++a)+ (b++); 
		// a = 12, b= 21, c= 30, r2=32
		System.out.printf("a: %d, b: %d, c: %d, r2: %d\n", a,b,c,r2);
		
		int r3= (a++)+ (--b)+(--c);
		// a=13 b= 20 c=29 r3= 61
		System.out.printf("a: %d, b: %d, c: %d, r3: %d\n", a,b,c,r3);
	}
	public static void method2() {
		int num1 = 20;
		int result1 = ++num1 * 3;
		System.out.printf("num1: %d, result1: %d\n", num1, result1);
		//result1 = 63; num1 = 21
		
		int num2 = 20;
		int result2 = num2++ *3;
		System.out.printf("num2: %d, result2: %d\n", num2, result2);
	}
	public static void method1() {
		int num1 =10;
		System.out.println("num1: "+ num1);
		System.out.println("전위연산 1회 수행: "+ ++num1);
		System.out.println("후위연산 1회 수행: "+ num1++);
		System.out.println("최종 num1: "+ num1);
	}
}
