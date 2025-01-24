package com.kh.review;

public class BookInfo {
	public static void main(String[] args) {
        String title = "Java의 정석"; 
        String author = "남궁성"; 
        int pageCount = 1022; // 숫자는 따옴표 없이 입력
        boolean isAvailable = false; 
        //true false 값만을 출력
        // 0 => false ; 1 => true로 하면됨

        System.out.println("책 제목: " + title);
        System.out.println("저자: " + author);
        System.out.println("페이지 수: " + pageCount);
        System.out.println("대출 가능 여부: " + isAvailable);
    }
}
