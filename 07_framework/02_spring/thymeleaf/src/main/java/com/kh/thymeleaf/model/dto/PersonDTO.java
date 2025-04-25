package com.kh.thymeleaf.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class PersonDTO {
  private String name;
  private int age;
  private String birth;
  private String[] hobby;

  public PersonDTO(String name, int age, String birth) {
    super();
    this.name = name;
    this.age = age;
    this.birth = birth;
  }
}


