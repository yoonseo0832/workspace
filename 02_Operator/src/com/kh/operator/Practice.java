package com.kh.operator;
import java.util.Scanner;
public class Practice {

	public static void main(String[] args) {
		//example01();
		//example02();
		example03();
	}
	public static void example03() {
		/*
		 * 산술 연산자 활용 예제_
		 * 키와 몸무게 입력받아 BMI 계산 출력
		 * * BMI : 몸묵게/키 *키
		 * - 18.5 이하 저체중
		 * - 18.5<BMI <22.9 정상
		 * - 23.0 <=BMI <+24.9 과체중
		 * - 25 <= BIM 비만
		 * 출력 예시 "BMI 지수는 ㅇㅇㅇ로 ㅇㅇ입니다"
		 */
		Scanner sc = new Scanner(System.in);
		System.out.print("키 입력(cm): ");
		System.out.print("몸무게 입력(kg): ");
		double height = sc.nextDouble();
		double weight = sc.nextDouble();
		height*= 0.01;
		//double heightM = height*(0.01);// 또는 /100을 하면 됨
		//double result = kg/(heightM *heightM);
		double bmi = weight /(height*height);
		String result = (bmi <18.5 )? "저체중":
				18.5<=bmi&& bmi<=22.9?"정상":
					23.0<=bmi&&bmi<=24.9?"과체중":"비만";
						
		System.out.printf("BMI 지수는 %.1f로 %s입니다\n", bmi, result);
		
		sc.close();
	}
	/*
	 * [2] 비교 연산자, 논리 연산자
	 * 		: 결과값 참(true) 또는 거짓(false)
	 * 		: 이항 연산자
	 */
	public static void example02() {
		/*
		 * 나이를 입력 받아 초등(8~13)/중등(14~16)/고등(17~19)인지 구분 출력
		 */
		Scanner sc = new Scanner(System.in);
		
		System.out.println("나이를 입력하세요: ");
		int age = sc.nextInt();
		String result = (8 <= age && age <=13)?"초등학생":
							(14<=age && age<=16)?"중학생":
								(17<= age && age <=19)?"고등학생":"그외";
		System.out.println("결과1: "+ result);
		
		System.out.println("------------------------------");
		
		String result1 = "알수없음";
		result1 = 8<=age && age <=13 ? "초등학생": result1;
		result1 = 14<=age && age <=16 ? "중학생": result1;
		result1 = 17<=age && age <=19 ? "고등학생": result1;
		System.out.println("결과2: "+ result1);
		
		
		if(age>=8 && age<=13){
			System.out.print("초등학생입니다\n");
		}else if(age>=14 && age<=16) {
			System.out.print("중학생입니다\n");
		}else if(age>=17 && age<=19){
			System.out.print("고등학생입니다\n");
		}else{
			System.out.print("그 외 나이입니다\n");
		}
		//SCE => && || 연산자가 수행될 때 두 항을 모두 실행하지 않더라도 결과를 알수
		//			있는 경우 뒤쪽 연산을 수행 안함
		// *&& => 앞의 조건이 false일 때 뒤의 조건이 수행되지 않음
		// *|| => 앞의 조건이 true일 때 뒤의 조건이 수행되지 않음
		int num =10;
		int i =3;
		boolean r1;

		r1=((num+=15)<0&&((i*=2)>2));
		//r1 =false num=20 i=3그래로 정지
		System.out.println("r1: "+r1);
		System.out.println("num: "+ num);
		System.out.println("i: "+i);
		
		r1=((num+=15)<0||((i*=2)>2));
		//r2=true num=40 i =6
		System.out.println("r1: "+r1);
		System.out.println("num: "+ num);
		System.out.println("i: "+i);
		sc.close();
	}
	/*
	 * [1] 복합 대입 연산자
	 * 		: 대입 연산자와 다른 연산자를 조합해 하나의 연산자처럼 사용되는 연산자
	 * 
	 * 		n1 += 10  => n1 = n1 + 10;
	 */
	public static void example01() {
		/*
		 * 사용자로부터 숫자를 입력받아 그값에 7Long 타입을 더한 결과를 출력
		 * => 숫자를 입력받을 때 타입을 short 자료형 사용
		 */
		Scanner sc = new Scanner(System.in);
		System.out.println("숫자를 입력하세요: ");
		short n1 = sc.nextShort();
		
		//아래와 같이 float 또한 숫자 옆에 f를 붙임, float num = 4f;
		//long 타입의 숫자를 자료형 변수에 저장할때 숫자 옆에 l또는L을 붙여사용함
		
		// num = (short)(num + (short)7L)  //(num + (short)7L) 값의 연산 결과가 int로 바뀌여서
		// (short) 한번 더 형변환을 하는 것이다, 아래의 num+=7L과 동일한 코드이다
		System.out.print("입력의 값: "+n1+", 7L을 더한 값: "+(n1+=7l));
		
		sc.close();
	}
}
