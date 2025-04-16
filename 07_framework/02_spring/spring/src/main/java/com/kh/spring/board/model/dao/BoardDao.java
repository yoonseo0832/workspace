package com.kh.spring.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.board.model.dto.SearchDto;
import com.kh.spring.board.model.vo.Board;
import com.kh.spring.board.model.vo.Reply;

@Mapper
public interface BoardDao {
	/* 게시글 목록 조회 */
	ArrayList<Board> selectBoardList(RowBounds rb, SearchDto searchDto);

	int selectBoardCount();

	// 게시글 상세페이지
	Board selectBoardDetail(int boardNo);
	
	/* 게시글 작성 */
	int insertBoard(Board board);

	// 게시글 댓글 조회
	ArrayList<Reply> selectReplyList(int boardNo);

	// 게시글 조회수 증가
	int increaseCount(int boardNo);

	// 게시글 삭제
	int deleteBoard(int boardNo);

	// 게시글 수정
	int updateBoard(Board board);
	
	// 댓글 추가
	int insertReply(Reply reply);

	// 게시글 top5 조회
	ArrayList<Board> selectTop5BoardList();

}





