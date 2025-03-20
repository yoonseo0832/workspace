package com.kh.model.dao;

import java.util.Arrays;
import java.util.List;

public class CafeDao {
	private List<String> category = Arrays.asList("Ŀ��", "��Ŀ��", "���̵�", "������", "����Ʈ");

	private List<List<String>> menuItems = 
			Arrays.asList(Arrays.asList("�Ƹ޸�ī��", "��", "��ī", "����������"),
			Arrays.asList("Ƽ��", "�����", "���ڶ�", "�ڸ���Ϻ�Ƽ", "����Ƽ"), Arrays.asList("�ڸ����̵�", "�����̵�", "�������̵�"),
			Arrays.asList("��������", "��纣��������", "���ڽ�����", "������Ű������"), Arrays.asList("��������", "��������ũ", "�����ũ������ũ", "ũ��������"));

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

	public boolean customize(int cc) { // �� Ŀ����
		return (cc == 0 || cc == 1); // Ŀ�ǿ� ��Ŀ�Ǹ� �� �߰� ����
	}
}
