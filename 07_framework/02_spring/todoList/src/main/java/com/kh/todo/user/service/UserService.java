package com.kh.todo.user.service;

import org.springframework.stereotype.Service;
import com.kh.todo.user.model.dao.UserMapper;
import com.kh.todo.user.model.dto.UserDTO;

//interface 만들고 class 구현하기(프로젝트 진행 시)

@Service
public class UserService{
  private final UserMapper userMapper;
  public UserService(UserMapper userMapper) {
    this.userMapper=userMapper;
  }
  /**
   * 아이디 중복 체크
   * @param userId 사용자 아이디
   * @return true : 사용 가능, false : 사용 불가능
   */
  public boolean checkId(String userId) {
    //boolean result = true;
    // DB에서 아이디와 일치하는 개수를 조회하여 0 인 경우 true리턴, 0보다 큰경우 fasle 리턴
    //return result;
    int count = userMapper.countByUserId(userId);
    return count == 0;
  }
  /**
   * 회원가입
   * @param userDto 아이디,비번, 닉네임, 이메일
   * @return 처리 결과 행수
   */
  public int userRegister(UserDTO userDto) {
     return userMapper.insertUser(userDto);
  }
}
