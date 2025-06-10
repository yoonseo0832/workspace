package com.kh.library.book.controller;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import com.google.gson.Gson;
import com.kh.library.book.model.vo.Book;
import com.kh.library.book.service.BookService;
import lombok.extern.slf4j.Slf4j;

@Slf4j  // lombok 기능
@WebMvcTest(BookController.class)       // 테스트하는 해당 클래스명
class BookControllerTest {

  // 가짜 객체 
  @MockitoBean      // MockBean 동일하 역할임 버전이 다름 = 모의 객체 주입
  private BookService bookService;
  
  @Autowired
  private MockMvc mockMvc;      // http 시뮬레이션 용도의 객체
  
  @BeforeAll
  static void setUpBeforeClass() throws Exception {
    log.info("============ BookController Test Start ============");
  }

  @AfterAll
  static void tearDownAfterClass() throws Exception {
    log.info("============ BookController Test End ============");
  }

  @Test
  @DisplayName("도서 추가 요청 테스트")
  void testAddBook() throws Exception {
    // Given - when - when
    
    // 입력값(준비) = Given
    Book book = new Book("명탐정코난", "아오야마 고쇼", "소년선데이");
    // 테스트 수행 = when
    mockMvc.perform(
        post("/book")
        .content(new Gson().toJson(book))
        .contentType(MediaType.APPLICATION_JSON)
    )
    .andExpect(status().isOk());
    // MediaType = IMPORT import org.springframework.http.MediaType;
    // 예외 발생하면 throws 처리함
    
    // 테스트 수행 결과 = when
    
  }

  @Test
  void testGetBooks() {
    fail("Not yet implemented");
  }

  @Test
  void testGetBook() {
    fail("Not yet implemented");
  }

  @Test
  @DisplayName("도서 수정 요청 테스트")
  void testUpdateBook() throws Exception {
    Book book = new Book("최강기아", "김도영", "기아타이거즈");
    mockMvc.perform(
        put("/book")
        .content(new Gson().toJson(book))
        .contentType(MediaType.APPLICATION_JSON)
    ).andExpect(status().isOk());
  }

  @Test
  @DisplayName("도서 삭제 요청")
  void testDeleteBook() throws Exception {
    // given
    String no = "1";        // String 타입
    
    // when+then
    mockMvc.perform(
        delete("/book")
        .param("no", no)    // "키값", 벨류값
    ).andExpect(status().isOk());
  }

}
