package com.kh.todo.user.model.vo;

import java.sql.Date;
import lombok.Data;

@Data
public class Todo {
   private String userId;
   private String userPwd;
   private String nickname;
   private String email;
   private Date enrollDate;
}
