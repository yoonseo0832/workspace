package com.kh.spring.board.controller;

import java.util.ArrayList;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.spring.board.model.vo.Board;
import com.kh.spring.board.model.vo.Reply;
import com.kh.spring.board.service.BoardService;

@RestController // @Controller + @ResponseBody
				// 모든  요청에 대한 응답을 페이지가 아닌 데이터로 응답
@RequestMapping("/api/board")
public class BaordAPIController {
	
	private final BoardService boardService;
	public BaordAPIController(BoardService boardService) {
		this.boardService = boardService;
	}
	
	@PostMapping("reply")
	// 페이지가 아닌 데이터 형식으로 응답하고자 
	public String replyInsert(Reply reply) {
		// 댓글 정보를 DB에 추가
		int result = boardService.insertReply(reply);
		if(result > 0) {
		// 댓글 추가 성공 시 "success" 응답
			return "success";
		// 댓글 추가 실패 시 "failed" 응답
		}else {
			return "failed";
		}	
	}
	
	@GetMapping("rlist")
	public ArrayList<Reply> selectReplyList(@RequestParam(required=true)int boardNo) {
		// 해당 게시글의 댓글 목록 조회
		ArrayList<Reply> list = boardService.selectReplyList(boardNo);
		
		// 조회된 결과 응답
		return list;
	}
	
	@GetMapping("top5")
	public ArrayList<Board> selectTop5BoardList(){
		return boardService.selectTop5BoardList();
	} 
}
