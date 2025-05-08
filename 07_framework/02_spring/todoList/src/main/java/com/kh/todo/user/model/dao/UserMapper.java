package com.kh.todo.user.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.kh.todo.user.model.dto.UserDTO;

// UserMapper == UserDAO 같은 클래스 명 의미
@Repository
public class UserMapper {
  /*
   * class => 빈등록 : @Repository, DB연동(*SqlSession 사용)
   * interface => 빈등록 : @Mapper, DB연동(추상메소드 정의)
   *             mapper.xml 파일 namespace에 해당 인터페이스 전체 경로 설정
   */
  private final SqlSession sqlSession;
  public UserMapper(SqlSession sqlSession) {
    this.sqlSession=sqlSession;
  }
  
  // 전달된 아이디와 일치하는 개수 조회(DML, SELECT, 단일 행(COUNT))
  public int countByUserId(String userId) {
    return sqlSession.selectOne("userMapper.countByUserId",userId);
  }
  
  //전달된 회원 정보를 DB에 추가(DML, INSERT)
  public int insertUser(UserDTO userDto) {
    // TODO Auto-generated method stub
     int result =sqlSession.insert("userMapper.insertUser", userDto);
     return result;
  }

  public UserDTO selectByUserIdAndUserPwd(UserDTO userDto) {
    // TODO Auto-generated method stub
    return sqlSession.selectOne("userMapper.selectByUserIdAndUserPwd", userDto);
  }
}
