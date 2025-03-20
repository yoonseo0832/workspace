package com.kh.model.vo;

public class CafeMenu {
	private int order_no;
	private String category; 
	private String menu_name;
	private int price;
	private int total_price;
	private char shot;
	private String iceyn;
	
	public CafeMenu() {}
	
	// 주문 정보 내역 조회시 사용하는 생성자
	public CafeMenu(int order_no, String category, String menu_name, int price) {
		super();
		this.category=category;
		this.order_no =order_no;
		this.menu_name=menu_name;
		this.price=price;
	}
	
	// 메뉴 전체 조회시 사용 생성자
	
}
