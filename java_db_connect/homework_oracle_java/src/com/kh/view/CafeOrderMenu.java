package com.kh.view;

import java.util.Scanner;
import com.kh.model.dao.*;
public class CafeOrderMenu {
	Scanner sc = new Scanner(System.in);
	CafeDao cd = new CafeDao();
	public void mainMenu() {
		while(true) {
			System.out.println("======KH카페입니다!=======");
		    System.out.println("음료를 주문하시겠습니까? 손님!");
		    System.out.println("1. 주문하기");
		    System.out.println("2. 취소하기");
		    System.out.println("=========================");
		    System.out.print("번호를 선택해주세요: ");
		    int menu = sc.nextInt();
		    sc.nextLine(); 
		    
		    switch(menu) {
		    case 1: 
		    	processOrder();
		    	break;
		    case 2: 
		    	System.out.println("주문이 취소되었습니다. 안녕히가십시오.");
                return;	
		    }
		}
	}
	public void processOrder() {
		while(true) {
			System.out.println("\n======= 카테고리 ======");
			for (int i = 0; i < cd.getCategories().size(); i++) {
	            System.out.println("    "+(i+1)+". "+cd.getCategories().get(i));
	        }
	        System.out.println("==================");
		}
	}
}
