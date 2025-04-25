package com.kh.api.controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.kh.api.model.dto.UserDTO;

// 서버에서 클라이언트에서 접근하는 것을 도와주는 역할
/*
 * @CrossOrigin : 스프링에서 제공하는 어노테이션으로 CORS 설정을 위해 사용
 *              => 클래스, 메소드 단위에 설정
 *     COSR (Cross - Origin Resource Sharing)
 *     : 클라이언트와 서버가 서로 다른 출처 (origin)에서 요청을 주고 받을 때 발생하는 보안 정책
 *     브라우저에서는 보안 상의 이유로 기본적으로 요청을 차단함
 *     
 *     리액트 앱 (http://localhost:3000)에서 스프링 서버(http://localhost:8080)로 요청을 하면 CORS에 의해 차단됨
 *     
 *     이 문제 해결하기 위해
 *              서버 쪽에서 @CrossOrigin을 사용해 허용할 출처 origins=을 명시
 *            origin : 프로토콜 + 도메인 + 포트
 */
// @CrossOrigin(origins="http://localhost:3000")  // WebConfig 클래스 정의하면 메소드 마다 @CrossOrigin 안해도됨
@RestController // = > @Controller + @ResponseBody
public class APIController {
  /**
   * [GET]    /server/get --> Server에 대한 데이터 조회
   * [POST]   /server/add --> Server 데이터 생성
   * [PUT]    /server/update --> Server에 대한 데이터 수정
   * [DELETE] /server/delete --> Server 데이터 삭제
   * @return
   */
  @GetMapping("/server")
  public String getServer() {
    return "My API~";
  }
  
  @GetMapping("/users")
  public List<UserDTO> getUserList() {
      // -- 비지니스 로직 다녀옴 -- //
    List<UserDTO> list = new ArrayList<>();
    list.add(new UserDTO("홍화연", 27, "010-3245-2424"));
    list.add(new UserDTO("김지은", 30, "010-4341-1222"));
    list.add(new UserDTO("이윤서", 23, "010-2322-1177"));
      
    return list;
  }
}
