package com.kh;

public class Cast {
	/*
	 * 형변환 : 값의 자료형을 바꾸는 것
	 * - 컴퓨터에서 값을 처리하는 규칙(형변환이 필요한 시점/상황)
	 * 1) 대입 연산자: 왼쪽과 오른쪽이 같은 자료형이여야 함
	 * 		=> 다른 자료형 값을 대입하고자 할때 형변환이 필수적 
	 * 		자료형 변수명 = (자료형) 값;
	 * 2) 같은 자료형끼리만 연산 가능함
	 * 		결과값 = 값1 + 값2; 
	 *		=> 값1, 값2, 결과값도 모두 같은 자료형이야함 
	 *		
	 */
	public static void main(String[] args) {
		//autoCasting();
		forceCasting();
	}
	public static void forceCasting() {
		/*
		 * 강제 형변환
		 * : 자동 형변환 되지 않는 경우, 직접하는 방법
		 * 큰 범위의 자료형 => 작은 범위의 자료형으로 변환할 때 사용
		 * 
		 * (변환할 자료형)변환할 대상
		 * => 변환대상: 값, 변수...
		 */  
		//실수형 d1 변수에 4.0이라는 값 저장
		double d1 = 4.0;
		//정수형 i1 변수에 50이라는 값 저장
		int i1 = 50;
		System.out.println("before add di: "+d1);
		//d1 변수와 i1 변수의 합을 정수형 result 변수에 저장
		int result = i1+ (int)d1;
		System.out.println((int)d1);
		System.out.println("result: "+"i1"+"("+i1+")" + "+"+"(int)di"+"("+(int)d1+")" + " = "+result);
		
		int i2 = 290;
		byte i3 = (byte)i2;
		System.out.print("i3: "+i3); // 데이터 손실
	}
	public static void autoCasting() {
		/*
		 * 자동 형변환
		 * 값의 범위가 작은 자료형=>큰자료형으로 자동 형변환
		 * byte(1B) - short(2B) - int(4B) - long(8B) - float(4B) - double(8B)
		 * 			  char (2B)						   부동소수점
		 */
		// 정수형 변수 i1애 12라는 값 저장
		int  i1 = 12;
		System.out.println("i1: "+i1);
		// 실수형 변수 d1에 i1의 값을 저장
		double d1 = i1;
		// i1(int) => (double) 12 => 12.0자동형변환
		System.out.println("d1: "+d1);
		
		int i2 = 15;
		double d2 = 3.3;
		double result = i2 + d2;
		// i2 + d2  => (int) + (double) => double
		System.out.println("result: "+result);
	}
}
