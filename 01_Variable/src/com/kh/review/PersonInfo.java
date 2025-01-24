package com.kh.review;

public class PersonInfo {
	public static void main(String[] args) { // static
        String name = "홍길동"; //"홍길동을 감싸야하고"
        int age = 25; // 숫자는 25로 사용하면됨
        double height = 175.5;  // 소수점 아래를 표시하려면 .쩜으로 
		// ,콤마는 나엻하는 것임 
        char bloodType = 'O'; // '문자는 쌍따옴표가 아닌따옴표로' 

        System.out.println("이름: " + name);
        System.out.println("나이: " + age);
        System.out.println("키: " + height);
        System.out.println("혈액형: " + bloodType);
    }
}
