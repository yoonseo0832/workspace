package com.kh.spring.notice.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.notice.model.vo.Notice;
import com.kh.spring.notice.service.NoticeService;

@Controller		
@RequestMapping("/notice")

public class NoticeController {
	// NoticeService 객체를 생성자 주입 방식을 사용해 적용
	private final NoticeService noticeService;
	// 생성자 추가해 초기화
	@Autowired  // 필수 아니
	public NoticeController(NoticeService noticeService) {
		this.noticeService = noticeService;
	}
	/**
	 * 요청받는 주소 : /notice/list
	 * @return
	 */
	@GetMapping("/list") //반환 타입 String X => ModelAndView
	public ModelAndView noticeList(ModelAndView mv) {
		//System.out.println("요청중");
		//return "redirect:/"; // 임시
		
		// 응답 전 데이터베이스에서 공지사항 목록 페이지 조회
		ArrayList<Notice>list = noticeService.selectNoticeList();
		
		// request 영역에 조회된 목록을 저장 => Model
		
		// ModelAndView : 스프링에서 제공해주는 객체
			// -Model : 데이터 => key-value 형태로 저장할 공간 제공(단독 사용)
			// -View  : 응답 페이지에 대한 정보를 저장할 공간 (단독 사용 불가 => ModelAndView 사용)
		mv.addObject("list", list); // 키값-밸류값
		
		//  공지사항 목록 페이지 응답
		//return "notice/noticeList";
		
		// 동일하게 포워딩해줌
		mv.setViewName("notice/noticeList");
		
		return mv;
	}
	
	@RequestMapping("/detail")
	public String noticeDetail(@RequestParam(value="no", defaultValue="0") int no, Model model) {
		// 글 번호에 해당하는 공지사항 정보(글번호, 제목, 작성자, 내용, 작성일)
		
		Notice notice = noticeService.selectNoticeDetail(no);
		
		model.addAttribute("n", notice);
		
		return "notice/noticeDetail";		
	}
}
