package com.kh.spring.board.service;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.board.model.dao.BoardDao;
import com.kh.spring.board.model.dto.SearchDto;
import com.kh.spring.board.model.vo.Board;
import com.kh.spring.board.model.vo.Reply;
import com.kh.spring.common.PageInfo;

@Service
public class BoardServiceImpl implements BoardService {
	
	// 필드 주입 방식
	/*
	@Autowired
	private BoardDao boardDao;
	*/
	
	// 생성자 주입 방식
	private final BoardDao boardDao;
	@Autowired
	public BoardServiceImpl(BoardDao boardDao) {
		this.boardDao = boardDao;
	}

	/**
	 * 게시글 목록 조회
	 */
	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi, SearchDto searchDto) {
		int offset = (pi.getCurrPage() -1)*pi.getBoardLimit();
		RowBounds rb = new RowBounds(offset, pi.getBoardLimit());
		return boardDao.selectBoardList(rb, searchDto);
	}

	@Override
	public Board selectBoardDetail(int boardNo) {
		return boardDao.selectBoardDetail(boardNo);
	}

	@Override
	public int insertBoard(Board board) {
		// TODO Auto-generated method stub
		return boardDao.insertBoard(board);
	}

	@Override
	public int updateBoard(Board board) {
		// TODO Auto-generated method stub
		return boardDao.updateBoard(board);
	}

	@Override
	public int deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		return boardDao.deleteBoard(boardNo);
	}

	@Override
	public int insertReply(Reply reply) {
		// TODO Auto-generated method stub
		return boardDao.insertReply(reply);
	}

	@Override
	public ArrayList<Reply> selectReplyList(int boardNo) {
		// TODO Auto-generated method stub
		return boardDao.selectReplyList(boardNo);
	}

	@Override
	public int increaseCount(int boardNo) {
		// TODO Auto-generated method stub
		return boardDao.increaseCount(boardNo);
	}

	@Override
	public int selectBoardCount(SearchDto searchDto) {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCount();
	}

	@Override
	public ArrayList<Board> selectTop5BoardList() {
		// TODO Auto-generated method stub
		// RowBounds 객체 사용 => 페이징 처리 활용, RowBounds (시작, 개수)
		RowBounds rb = new RowBounds(0, 5);
		
		SearchDto searchDto = new SearchDto();
		searchDto.setOrderby(null);		
		
		return boardDao.selectBoardList(rb, searchDto);
	}

	
}
