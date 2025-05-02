package com.kh.todo.user.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class UserDTO {
  private String userId;
  private String userPwd;
  private String nickname;
  private String email;
}
