package com.kh.todo.user.model.vo;

import lombok.Data;

@Data
public class AuthData {
  private String code;  // 인증코드
  private long time;    // 인증코드 유효기간
  
  private final long LIMIT_TIME = 3 * 60 *1000; //제한 시간 : 3분
  //기본생성자   => 인증코드 생성, 유효시간 저장
  public AuthData() {
    this.code=makeRandomCode("");   // 랜덤값 6자리
    this.time= System.currentTimeMillis() + LIMIT_TIME;
    // 현재 시간 + 제한 시간 의미
  }
  
  private String makeRandomCode(String code) {
    // 램덤값 6자리 생성
    // => 재귀 함수로써 사용하여 생성
    
    if(code.length()==6)return code;
    else {
      // 0~9사이의 랜덤값
      int random = (int)(Math.random() * 10);
      
      if(random%2== 0) {
        // 짝수인 경우 => 소문자로 변경
        int chRandom = (int)(Math.random() * ('z' - 'a' + 1) +'a');
        code += (char)chRandom;
      }else {
        // 홀수인 경우 => 숫자 그래도 사용
        code += random;
      }
      return makeRandomCode(code);
    }
  }
}
