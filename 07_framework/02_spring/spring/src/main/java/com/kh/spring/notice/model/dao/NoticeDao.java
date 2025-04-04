package com.kh.spring.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.spring.common.PageInfo;
import com.kh.spring.notice.model.vo.Notice;

@Repository // @Component 보다 구체화된 객체를 의미
			// 데이터베이스와 직접 연결되는 클래스 지정
public class NoticeDao {
	// SqlSession 객체 DI 처리(생성자 주입방식)
	private final SqlSession sqlSession;
	
	 @Autowired
	public NoticeDao(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	/**
	 * 공지사항 목록 조회
	 * @return
	 */
	public List<Notice> selectNoticeList(PageInfo pi){
		// 공지사항 목록 조회하는 쿼리문을 실행하여 결과를 반환
		// selectList (조회 결과 여러 행)| selectOne (조회 결과 한 행)
		
		// RowBounds 객체 생성
		// 마이바티스 제공 객체, 시작과 끝값 전달하여 조회 목록 쪼개서 조회 도움(범위 지정)
		int offset = (pi.getCurrPage() -1) * pi.getBoardLimit();
		RowBounds rb = new RowBounds(offset, pi.getBoardLimit());
		
		return sqlSession.selectList("noticeMapper.selectNoticeList", null, rb);
	}
	/**
	 * 공지사항 상세 조회
	 * @param noticeNo 공지사항 번호
	 * @return
	 */
	public Notice selectNoticeDetail(int noticeNo) {
		return sqlSession.selectOne("noticeMapper.selectNoticeDetail", noticeNo);
	}
	/**
	 * 공지사항 추가/등록
	 * @param notice  추가될 공지사항 정보
	 * @return
	 */
	public int insertNotice(Notice notice) {
		return sqlSession.insert("noticeMapper.insertNotice", notice);
	}
	public int updateNotice(Notice notice) {
		return sqlSession.update("noticeMapper.updateNotice", notice);
	}
	/**
	 * 공지사항 삭제
	 * @param noticeNo
	 * @return
	 */
	public int deleteNotice(int noticeNo) {
		return sqlSession.delete("noticeMapper.deleteNotice", noticeNo);
	}
	public int selectNoticeCount() {
		return sqlSession.selectOne("noticeMapper.selectNoticeCount");
	}
	/**
	 * 공지사항 제목 키워드 검색
	 * @param keyword  검색어
	 * @param pi  페이징 처리
	 * @return
	 */
	public List<Notice> findByNoticeTitleLike(String keyword, PageInfo pi) {
		int offset = (pi.getCurrPage() -1) * pi.getBoardLimit();
		RowBounds rb = new RowBounds(offset, pi.getBoardLimit());
		
		return sqlSession.selectList("noticeMapper.selectNoticeList", keyword, rb);
	}
	
	/**
	 * 공지사항 검색 시 개수 조회
	 * 
	 */
	public int selectByNoticeTitleCount(String keyword) {
		return sqlSession.selectOne("noticeMapper.selectNoticeCount",keyword);
	}
}
