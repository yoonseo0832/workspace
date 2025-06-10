package com.kh.library.book.service;

import static org.junit.jupiter.api.Assertions.*;
import java.util.List;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import com.kh.library.book.model.vo.Book;
import com.kh.library.common.model.dto.SearchParams;

class BookServiceImplTest {

  private static BookService bookService;
  
  @BeforeAll
  static void setUpBeforeClass() throws Exception {
    bookService = new BookServiceImpl();
  }

  @AfterAll
  static void tearDownAfterClass() throws Exception {}

  @Test
  @DisplayName("도서 목록 조회 테스트:: 제목 검색")
  void testGetBooks() {
    // given
    SearchParams params = new SearchParams();
    params.setFilter("title");
    params.setKeyword("혼자");
    
    // when
    List<Book> list = bookService.getBooks(params);
    
    // then
    assertTrue(list.size() == 2);
    // => 전달하 조건 true 인지 확인
  }

  @Test
  @DisplayName("도서 목록 조회 테스트:: 조건 없을 경우")
  void testGetBooksNoOption() {
    // given
    SearchParams params = new SearchParams();
    //params.setFilter("");
    //params.setKeyword("");
    // when
    List<Book> list = bookService.getBooks(params);
    
    // then
    assertEquals(list.size(), 5);
  }
  
  @Test
  @DisplayName("도서 정보 조회 기능 테스트")
  void testGetBook() {
    // given
    int no =1;
    
    // when
    Book book = bookService.getBook(no);
    
    // then
    //assertTrue(book != null);
    //assertFalse(book == null);
    assertNotNull(book);
  }

  @Test
  @DisplayName("도서 정보 조회 기능 실패")
  void testGetBookFailed() {
    // given
    int no =100;
    
    // when
    Book book = bookService.getBook(no);
    
    // then
    assertNull(book);
  }
  
  @Test
  void testAddBook() {
    fail("Not yet implemented");
  }

  @Test
  void testUpdateBook() {
    fail("Not yet implemented");
  }

  @Test
  void testDeleteBook() {
    fail("Not yet implemented");
  }

}
