package com.kh.spring.board.model.dto;

import lombok.Data;
import lombok.Setter;
/**
 * DTO 통신/흐름 간에 저장되어야 할 데이터
 */
@Data
public class SearchDto {
	private String condition; // 검색 조건
 	private String keyword;   // 검색어
 	
 	private String orderby; // 정렬기준
}
