package com.kh.todo.user.controller;

import java.util.Map;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.kh.todo.user.service.MailService;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;

//@CrossOrigin(origins="http://localhost:5174")
@RestController     // @Controller + ResponseBody
@RequiredArgsConstructor        // lombok을 이용하여 생성자 주입 처리
public class UserController {
  private final MailService mailService;
  /**
   * 이메일은 전달받아 인증코드를 메일로 전송
   * @Param email
   * return "ok" : 인증코드 발송, "nok" : 인증코드 발송 실패
   */
  @PostMapping("/email/send")   //String email 지우고
  public String sendEmailCode(@RequestBody Map<String, Object> requestBody) {
    /*
     * 폼 요청 시 전송 형식과 axios(fetch) 요청 시 전송 형식이 달라
     * 요청 본문에서 전달데이터를 추출해야 함
     * 
     * @RequestBody : 요청 본문. 전송 형식이 application/json
     * @RequestParam  : 쿼리 파라미터 또는 폼 데이터. 단일 데이터 처리
     * @ModelAttribute : 쿼리 파라미터 또는 폼 데이터. 객체 바인딩 처리
     */
    String email = (String)requestBody.get("email");
    System.out.println("email::" +email);
    
    try {
      mailService.sendMail(email);
    } catch (MessagingException e) {
      return "nok";
    }
    return "ok";
  }
  
  /**
   * 이메일에 대한 인증 코드 검증
   * @param requestBody {email : '이메일 정보', code : '인증코드'}
   * @return "success": 검증 성공, 'failed': '검증 실패'
   */
  @PostMapping("/email/verify")
  public String verityEmailCode(@RequestBody Map<String, Object> requestBody) {
    String email = (String)requestBody.get("email");
    String code = (String)requestBody.get("code");
    
    System.out.println("code::" +code);
    
    boolean result = mailService.verifyCode(email, code);
    
    return result ? "success" : "failed";
    
  }
  
  /**
   * 아이디 중복 체크
   * [POST] /checkId
   * @param id 아이디
   * @return "nnnnn" 중복된 아이디 ,  "nnnny" 사용 가능한 아이디
   */
  @PostMapping("/checkId")
  public String checkIdIsSame(@RequestBody Map<String, Object> requestBody) {
    String id = (String)requestBody.get("id");
    
    // 서비스로부터 중복체크 결과 -> 사용자 테이블에서 id에 해당하는 개수를 조회하는 거임
    int result =0;
    
    return result > 0 ? "nnnnn":"nnnny";
  }
}
