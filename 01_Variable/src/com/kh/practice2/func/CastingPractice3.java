package com.kh.practice2.func;

public class CastingPractice3 {

	public static void main(String[] args) {
		
			int iNum1 = 10;
			int iNum2 = 4;

			float fNum = 3.0f;

			double dNum = 2.5;

			char ch = 'A';
			
			System.out.println( iNum1 -(iNum2)*2 ); // 2
			System.out.println( (int)dNum ); // 2

			System.out.println( ((dNum)*16) /(double)iNum2 ); // 10.0
			System.out.println( (double)iNum1 ); // 10.0

			System.out.println( (double)iNum1 -((double)iNum2*2)+ 0.5 ); // 2.5
			System.out.println( dNum ); // 2.5

			System.out.println( (int)fNum ); // 3
			System.out.println( iNum1+(int)fNum -iNum1); // 3
			System.out.println( (float)iNum1 + fNum -iNum1 + 0.3333333);// 3.3333333
			System.out.println( (float)iNum1 + fNum -iNum1 + 0.3333333333333335 ); // 3.3333333333333335

			System.out.println( ch ); // 'A'
			System.out.println( (int)ch ); // 65
			System.out.println( (int)ch+iNum1 ); // 75
			
			int word = iNum1+(int)ch;
			System.out.println( (char)word  ); // 'K'
			System.out.println( (char)(iNum1+(int)ch)  ); // 'K'
			
			
			float a =10, b=20, c1,c2,c3;
			c1=a*b;
			c2=a/b;
			c3=a%b;
			System.out.println(c1);
			System.out.println(c2);
			System.out.println(c3);
			
			int result = ((25*5)+(36-4)-72)/5;
			System.out.print(result);

	}

}
