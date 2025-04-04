package com.kh.spring.common;

import lombok.Getter;

@Getter
public class PageInfo {
	/**
	 * ===== 페이징 처리를 위한 준비 작업 =====
	 * 
	 * [필요한 데이터]
	 * + 전체 게시글 개수
	 * + 현재 페이지 번호 => 사용자로부터 전달될 값
	 * + 페이징바의 최대 개수(표시될 페이지번호의 개수)
	 * + 한 페이지 당 표시할 게시글 최대 개수
	 * 
	 * + 가장 마지막 페이지 번호(페이지 총 수)
	 * + 표시되는 페이징 바의 시작 번호
	 * + 표시되는 페이징 바의 마지막 번호
	 */
	private int listCount; //전체 게시글 수
	private int currPage; //현재 페이지 번호
	private int pageLimit; //페이징바 최대 번호
	private int boardLimit; //한 페이지 당 게시글 최대 개수
	
	//=> 4개 데이터를 가지고 아래 3개 데이터 계산
	
	private int maxPage; //가장 마지막 페이지번호
	private int startPage; //페이징바 시작 번호
	private int endPage; //페이징바 끝 번호
	
	public PageInfo(int listCount, int currPage, int pageLimit, int boardLimit) {
		this.listCount = listCount;
		this.currPage = currPage;
		this.pageLimit = pageLimit;
		this.boardLimit = boardLimit;
		
		/**
		 * 가장 마지막 페이지 번호(maxPage)
		 * 총 게시글 수(listCount)  한 페이지당 게시글 최대 개수(boardLimit)
		 * 100 						10 						=> 10
		 * 107						10						=> 11
		 * 115						10						=> 12
		 * 
		 * listCount / boardLimit --> 올림처리
		 */
		this.maxPage = (int)Math.ceil((double)listCount / boardLimit);
		
		/**
		 * 페이징 바 시작 번호(startPage)
		 * 
		 * 현재 페이지 번호 (currPage)		페이징바 개수(pageLimit)
		 * 1							10 					=> 1
		 * 5							10					=> 1
		 * 11							10					=> 11
		 * 
		 * 1~10 +>  시작번호 1  n=0
		 * 11~20 +> 시작번호 11 n=1
		 * 21~30 +> 시작번호 31 n=2
		 * 
		 * n*10 + 1  페이징 바 시작 번호
		 * ((currPage -1) / pageLimit) * pageLimit + 1
		 * 
		 */
		this.startPage = ((currPage -1) / pageLimit) * pageLimit + 1;
		
		/**
		 * 페이징 바 끝 번호(endpage)
		 * 
		 * endPage = startPage + pageLimit - 1
		 */
		this.endPage = startPage + pageLimit - 1;
		
		// 시작 번호 11 경우 20일것
		// 마지막 페이지 번호 maxPage 13 => endPage를 13으로 변경
		// 마지막 번호가  끝번호보다 작을경우 endPage==maxPage로 바꾼다
		this.endPage = endPage > maxPage ? maxPage : endPage;
	}
	
}
