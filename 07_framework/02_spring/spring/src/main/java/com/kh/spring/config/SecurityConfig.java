package com.kh.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration   // 설정 클래스 정의 시 사용되는 어노테이션
@EnableWebSecurity  // spring security 활성화 어노테이션
public class SecurityConfig {
	/*
	 * BCryptPasswordEncoder 객체의 경우 외부 라이브러리 객체이므로 직접 클래스 구현부에 @Component 등 어노테이션으로 빈으로 등록 불가
	 * 
	 * 따라서 해당 객체를 만들어서 리턴하는 메소드를 정의
	 * 헤당 메소드를 빈에 등록 후 객체를 사용
	 */
	@Bean   // 메소드를 빈으로 등록하거나 외부 라이브러리 객체를 등록할 때 사용
	public BCryptPasswordEncoder bCryptPasswordEncorder() {
		return new BCryptPasswordEncoder();
		
	}
	/*
	 * spring security 에서 기본적으로 제공하는 기능 비활성화
	 */
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		 http.formLogin(AbstractHttpConfigurer::disable)  // 로그인폼 비활성화
		 						.csrf(AbstractHttpConfigurer::disable);   // Cross-site request forgery
		 return http.build();
	}
}
