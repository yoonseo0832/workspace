package com.kh.spring.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * * Lombok (롬복) => 라이브러리. pom.xml 에 dependency 추가.
 * 
 * 1) 라이브러리 다운 후 적용
 * 2) 다운로드된 jar 파일을 찾아 설치 작업 진행 (작업할 IDE 선택-등록)
 * 3) IDE(개발도구) 재시작
 * 
 */
@NoArgsConstructor			// 기본생성자
@AllArgsConstructor			// 모든 필드를 매개변수로 가지는 생성자				
// getter 메소드
//@Setter						// setter 메소드
@ToString					// toString 메소드
public class Member {
	
	private String userId;
	private String userPwd;
	private String userName;
	private String email;
	private String gender;
	private String age;
	private String phone;
	private String address;
	private Date enrollDate;
	private Date modifyDate;
	private String status;
	public String getUserId() {
		return userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public String getEmail() {
		return email;
	}
	public String getGender() {
		return gender;
	}
	public String getAge() {
		return age;
	}
	public String getPhone() {
		return phone;
	}
	public String getAddress() {
		return address;
	}
	public Date getEnrollDate() {
		return enrollDate;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public String getStatus() {
		return status;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public void setStatus(String status) {
		this.status = status;
	}	
	
	
}
