package com.kh.view;

import java.util.Scanner;
import com.kh.model.dao.*;
public class CafeOrderMenu {
	Scanner sc = new Scanner(System.in);
	CafeDao cd = new CafeDao();
	public void mainMenu() {
		while(true) {
			System.out.println("======KHī���Դϴ�!=======");
		    System.out.println("���Ḧ �ֹ��Ͻðڽ��ϱ�? �մ�!");
		    System.out.println("1. �ֹ��ϱ�");
		    System.out.println("2. ����ϱ�");
		    System.out.println("=========================");
		    System.out.print("��ȣ�� �������ּ���: ");
		    int menu = sc.nextInt();
		    sc.nextLine(); 
		    
		    switch(menu) {
		    case 1: 
		    	processOrder();
		    	break;
		    case 2: 
		    	System.out.println("�ֹ��� ��ҵǾ����ϴ�. �ȳ������ʽÿ�.");
                return;	
		    }
		}
	}
	public void processOrder() {
		while(true) {
			System.out.println("\n======= ī�װ� ======");
			for (int i = 0; i < cd.getCategories().size(); i++) {
	            System.out.println("    "+(i+1)+". "+cd.getCategories().get(i));
	        }
	        System.out.println("==================");
		}
	}
}
