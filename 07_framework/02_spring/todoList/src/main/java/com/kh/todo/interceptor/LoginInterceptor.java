package com.kh.todo.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import com.kh.todo.user.model.dto.UserDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
 * 세션에 로그인 정보가 있을 경우 , 컨트롤러를 동작
 *                  없을 경우 , 응답헤더에 401 코드를 담아서 컨트롤러를 동작X
 */
@Component
public class LoginInterceptor implements HandlerInterceptor{

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
      throws Exception {
    
    //OPTIONS 요청에 대하여 인증체크 없이 허용. CORS preflight 요청
    
    System.out.println("?----------------------");
    if (request.getMethod().equalsIgnoreCase("OPTIONS")) {
        //response.setStatus(200);
      response.setStatus(HttpServletResponse.SC_OK);
      return true;
    }
    
    // 세션에 로그인 정보가 있는지 확인
    HttpSession session = request.getSession();
    UserDTO loginUser = (UserDTO) session.getAttribute("user");
    if( loginUser == null) { // 로그인 정보가 없는 경우
      response.setStatus(401); // 또는 
      //response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
      response.getWriter().print("로그인 이후 이용 가능합니다.");
      return false;
    }else {                 // 로그인 정보가 있는 경우
      return true;
    }
  }
  
}
