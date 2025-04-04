package com.kh.spring.notice.service;

import java.util.ArrayList;

import com.kh.spring.common.PageInfo;
import com.kh.spring.notice.model.vo.Notice;

public interface NoticeService {
	// 공지사항 목록 조회
	ArrayList<Notice> selectNoticeList(PageInfo pi);
	
	// 공지사항 상세 조회(기본키를 가지고 삭제와 상세 조회를 함)
	Notice selectNoticeDetail(int noticeNo);
	
	// 공지사항 제목 검색
	ArrayList<Notice> searchNoticeByTitle(String keyword, PageInfo pi);
	
	// 공지사항 검색 시 게시글 수 조회
	int selectNoticeByTitleCount(String keyword);
	
	// 공지사항 전체 게시글 수 조회
	int selectNoticeCount();
	
	// 공지사항 추가
	int insertNotice(Notice notice);
	
	// 공지사항 수정
	int updateNotice(Notice notice);
	
	// 공지사항 삭제
	int deleteNotice(int noticeNo);
}
