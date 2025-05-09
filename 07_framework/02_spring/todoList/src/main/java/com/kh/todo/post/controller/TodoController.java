package com.kh.todo.post.controller;

import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.kh.todo.post.model.dto.TodoDTO;
import com.kh.todo.post.model.vo.Todo;
import com.kh.todo.post.service.TodoService;
import com.kh.todo.user.model.dto.UserDTO;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("todo")
public class TodoController {
  private final TodoService todoServcie;
  public TodoController(TodoService todoServcie) {
    this.todoServcie=todoServcie;
  }
  
  /**
   * 할일 목록 조회
   * @return 
   */
  @GetMapping("")   // [GET]/todo
  public List<Todo> getTodoList(HttpSession session){
    UserDTO user = (UserDTO) session.getAttribute("user");
    
    System.out.println(user);
    
    List<Todo> list = todoServcie.getTodoList(user.getUserId());
    
    System.out.println(list);
    return list;
  }
  
  /**
   * 할일 추가
   * [post] /todo
   * @param {content : 할일 내용}
   * @return Todo추가된 할일 정보
   */
  @PostMapping("")  // [POST]/todo
  public ResponseEntity<Object> addTodo(@RequestBody TodoDTO todoDto, HttpSession session) {
    UserDTO user = (UserDTO)session.getAttribute("user");
    todoDto.setUserId(user.getUserId());
    Todo todo = todoServcie.addTodo(todoDto);
    if(todo != null) {
      // 추가 성공 시 추가된 할일 정보 (Todo)
      return ResponseEntity.status(HttpStatus.OK).body(todo);
    }
    // 추가 실패 기 메세지 (String)
    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("할일 추가에 실패했습니다");
  }
}
