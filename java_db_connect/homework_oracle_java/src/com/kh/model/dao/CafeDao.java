package com.kh.model.dao;

import java.util.Arrays;
import java.util.List;

public class CafeDao {
	private List<String> category = Arrays.asList("커피", "논커피", "에이드", "스무디", "디저트");

	private List<List<String>> menuItems = 
			Arrays.asList(Arrays.asList("아메리카노", "라떼", "모카", "에스프레소"),
			Arrays.asList("티라떼", "딸기라떼", "초코라떼", "자몽허니블랙티", "버블티"), Arrays.asList("자몽에이드", "레몬에이드", "포도에이드"),
			Arrays.asList("망고스무디", "블루베리스무디", "초코스무디", "딸기쿠키프라페"), Arrays.asList("초코파이", "초코케이크", "딸기생크림케이크", "크레이프롤"));

	private List<List<Integer>> menuPrices = 
			Arrays.asList(Arrays.asList(2500, 3000, 3500, 2700),
			Arrays.asList(4000, 4500, 4300, 4700, 5200), Arrays.asList(5000, 5200, 5500),
			Arrays.asList(5000, 5000, 5200, 4800), Arrays.asList(4000, 7500, 7700, 8000));

	public List<String> getCategories() {
		return category;
	}

	public List<String> getMenuItems(int categoryIdx) {
		return menuItems.get(categoryIdx);
	}

	public int getPrice(int categoryIdx, int menuIdx) {
		return menuPrices.get(categoryIdx).get(menuIdx);
	}

	public boolean customize(int cc) { // 샷 커스텀
		return (cc == 0 || cc == 1); // 커피와 논커피만 샷 추가 가능
	}
}
