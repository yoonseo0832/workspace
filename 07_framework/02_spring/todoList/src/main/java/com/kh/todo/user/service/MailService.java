package com.kh.todo.user.service;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import com.kh.todo.user.model.vo.AuthData;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class MailService {
  //mail 관련 객체 추가 주입    --> Spring boot starter mail 추가
  //                            java mail API 가 포함되어 있음
  private final JavaMailSender sender;
  
  public MailService(JavaMailSender sender) {
    this.sender=sender;
    
    // 스케룰러 추가 -> 1분마다 인증 정보를 정리
    ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    scheduler.scheduleAtFixedRate(()->clearData(), 0, 1, TimeUnit.MINUTES);
    // 실행작업, 초기 지연시간, 실행주기, 시간단위 -> 1분마다 clearData 실행
  }
  
  // 이메일, 인증 정보(인증코드, 유효시간)를 관리하기 위한 Map 추가
  private Map<String, AuthData> authInfo = new HashMap<>();
  
  public void sendMail(String email) throws MessagingException {
    // 인증 정보 생성 -> AuthData
    AuthData authData = new AuthData();
    String code = authData.getCode();
    
    // 메일 내용 작성
    String subject = "[TODO MANAGER] 인증코드";
    String[] to = {email};
    String content = "<p>아래의 인증코드를 입력해주세요.</p>"
                      + "<h3>"+ code +"</h3>"
                      + "<p>인증코드는 3분간 유효합니다.</p>";
    
    // 메일 전송
    MimeMessage mm = sender.createMimeMessage();
    MimeMessageHelper helper = new MimeMessageHelper(mm);
    
    helper.setSubject(subject);
    helper.setTo(to);
    helper.setText(content, true);
    
    sender.send(mm);        // 마이메세지 객체를 전송
    
    // 이메일, 인증 정보를 Map에 추가
    authInfo.put(email, authData);
  }
  
  public boolean verifyCode(String email, String code) {
    // Map에서 email에 해당하는 인증 정보 있는지 체크
    AuthData authData = authInfo.get(email);
    
    if(authData == null) return false; // 이메일 인증정보 없는 경우
    /*
    // 인증 정보가 있다 => 코드값==전달된 코드값 비교해 동일한지 체크
    // 제한 시간 체크 (현재>제한시간== 시간 초과):: return false
    long currTime = System.currentTimeMillis();
    if(currTime > authData.getTime()) {
      authInfo.remove(email);
      return false;
    }
    
    if(code.equals(authData.getCode())) {
      authInfo.remove(email);
      return true;
    }else {
      return false;
    }*/   
    if(code.equals(authData.getCode())) {
      authInfo.remove(email);
    }
    return true;
    
  }
  
  private void clearData() {
    long currTime = System.currentTimeMillis();
    
    authInfo.entrySet().removeIf(entry->currTime > entry.getValue().getTime());
  }
}
