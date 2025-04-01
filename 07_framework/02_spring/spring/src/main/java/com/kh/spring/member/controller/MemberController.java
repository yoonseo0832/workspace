package com.kh.spring.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.member.model.vo.Member;
import com.kh.spring.member.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller		// Controller 어노테이션 추가 시 빈 스캐닝을 통해 자동으로 빈 등록
@RequestMapping("/member")	// 공통 주소 설정 => 해당 클래스에서 받는 요청은 /member 로 시작될 것임!
public class MemberController {
	
	/*
	 * * 기존 객체 생성 방식
	 * 
	 * 	 private MemberService mService = new MemberServiceImpl();
	 * 
	 * 	 => 객체 간의 결합도가 높아짐 (-> 코드 수정 시 하나하나 모두 바꿔줘야 함)
	 *   => 동시에 많은 요청이 될 경우 그만큼 객체가 생성될 것임!
	 *   
	 * * DI (Dependency Injection) - 의존성 주입
	 * 
	 * 		@Autowired : 의존성 주입 시 사용되는 어노테이션
	 * 
	 *  	=> 클래스 내에 객체를 직접 생성하지 않고
	 *  	   spring에서 관리하는 객체를 주입받아(Bean 등록) 사용하도록 해줄 것임!
	 *  
	 *  	[주입 방식]
	 *      1) 필드 주입 방식  : 스프링 컨테이너가 객체를 생성한 후 
	 *      				  @Autowired 가 붙은 필드에 의존성을 주입하는 방식
	 *      => 간결하고 해당 필드에 대한 처리를 하지 않아도 됨. (생성자, setter)
	 *      => 테스트가 어려움 (객체 생성 시 주입되는 것이 아닌 bean에 생성된 후 주입받는 방식으로 
	 *      				테스트 진행 시 임의의 객체를 생성하기 어려움)
	 *         불변성 보장 문제 (객체 생성 시 의존성이 주입되어 고정되지 않으므로
	 *                            클래스 생성 이후 의존성이 변경될 수 있음)
	 *      
	 *      2) 생성자 주입 방식 : 스프링 컨테이너가 객체를 생성할 때 
	 *      				  @Autowired 가 붙은 생성자를 통해 필요한 의존성을 주입하는 방식
	 *      => 불변성 보장되고, 테스트가 편리함
	 *      => 순환 참조 방지
	 */
	/* 필드 주입 방식 */
	/*
	@Autowired
	private MemberService mService;
	*/
	
	/* 생성자 주입 방식 */
	private final MemberService mService;
	private final BCryptPasswordEncoder bCryptPasswordEncorder;
	@Autowired
	public MemberController(MemberService mService, BCryptPasswordEncoder bCryptPasswordEncorder) {
		this.mService = mService;
		this.bCryptPasswordEncorder = bCryptPasswordEncorder;
	}
	
	// -----------------------------------------
	/**
	 * 회원 가입 페이지 응답
	 */
	// @RequestMapping("/enrollForm")
	@GetMapping("/enrollForm")
	public String enrollFormPage() {
		// => 응답할 페이지 정보(경로)
		//	  /WEB-INF/views/member/enrollForm.jsp
		//    {prefix}member/enrollForm{suffix}
		//	  --> 설정값을 제외하고 문자열로 리턴하면 해당 파일을 찾아 응답할 것임!
		return "member/enrollForm";
	}
	/**
	 * [1] HttpServletRequest 객체 이용 (기존 서블릿 방법)
	 *     => 매개변수 위치에 HttpServletRequest 타입을 작성!
	 * @return
	 */
	/*
	@PostMapping("/regist")
	public String registMember(HttpServletRequest request) {
		// 아이디, 비밀번호 데이터를 추출하여 출력해보자!
		System.out.println("회원가입 요청이 들어옴@@@@@@");
		
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		System.out.printf("%s / %s\n", userId, userPwd);
		
		// 회원가입 페이지 응답 (임시)
		return "member/enrollForm";
	}
	*/
	
	/**
	 * [2] RequestParam 어노테이션 이용
	 * 		=> @RequestParam("키값") 자료형 변수명 --> 매개변수 위치에 작성
	 * 		   
	 *   	   @RequestParam(value="키값", defaultValue="기본값")
	 * 
	 * 	   request.getParameter("키값"):데이터 
	 * 		위의 작업을 대신해주는 어노테이션
	 */
	/*
	@PostMapping("/regist")
	public String registMember(@RequestParam("userId") String id,
								@RequestParam("userPwd") String passwd) {
		
		System.out.println("id : " + id);
		System.out.println("pwd: " + passwd);		
		
		return "member/enrollForm";
	}
	*/
	/**
	 * [3] @RequestParam 생략
	 * 		=> 주의!! 매개변수명을 요청 시 전달되는 데이터의 키값과 동일하게 작성해야 함!!
	 */
	/*
	@PostMapping("/regist")
	public String registMember(String userId, String userPwd) {
		
		System.out.println("id:: "+userId);
		System.out.println("pwd::"+userPwd);
		
		return "member/enrollForm";
	}
	*/
	
	/**
	 * [4] 커맨드 객체 방식
	 *     => 요청 시 전달되는 데이터를 vo/dto 클래스 타입으로 받고자 하는 경우
	 *     
	 *     * 매개변수 타입을 vo/dto 클래스 타입으로 작성
	 *       !!주의!! 전달되는 "데이터의 키값"을 
	 *       		 받고자하는 "클래스의 필드명"과 "일치"하도록 해야함
	 *       
	 *     * 스프링 컨테이너가 해당 클래스 객체를 "기본생성자"로 생성 후
	 *     	 "setter 메소드"를 사용하여 요청 시 전달 값을 해당 필드에 저장함
	 */
	@PostMapping("/regist")
	public String registMember(Member user, HttpSession session,Model model) {
		System.out.println(user);		
		// 처리전 : 비밀번호 평문(값 그대로)
		// => 비번 암호화처리 => BCryptPasswordEncoder
		String encPwd = bCryptPasswordEncorder.encode(user.getUserPwd());
		user.setUserPwd(encPwd);
		// 처리 후 ㅣ 암호문
		// 서비스에게 Member 객체를 전달하여 회원가입 요청
		int result = mService.insertMember(user);
		//결과에 따른 처리
		if(result >0) {//회원가입 성공
			session.setAttribute("alertMsg", "회원가입에 성공하셨습니다. 환영합니다^^");
			return "redirect:/"; // "redirect:요청할 url주소"
		}else {		// 회원가입 실패
			
			model.addAttribute("errorMsg", "회원가입에 실패했습니다");
			return "common/errorPage";
		}
	}
	
	/**
	 * 로그인 요청
	 */
	@PostMapping("/login")  //member/login 요청을 받을 것임
	public String login(Member user, HttpSession session, Model model) {  //@ModelAttribute Member user 와 같이 작성 가능
		System.out.println(user);
		
		Member loginUser = mService.loginMember(user);
		/*
		 * user: 사용자가 입력한 값 비번: 평문
		 * loginUser: DB에서 아이디 기준으로 조회한 데이터 암호문
		 */
		if(loginUser == null) {
			//아이디 해당 회원 없는 경우
			model.addAttribute("errorMsg", "아이디에 해당하는 회원 정보없습니다");
			return "common/errorPage";	// user. 평문 // loginUser. 암호문
		}else if(!bCryptPasswordEncorder.matches(user.getUserPwd(), loginUser.getUserPwd())) {
			//입력된 비번값이 저장된 비번에 해당하지 않는 경우
			model.addAttribute("errorMsg", "비밀번호가 잘못 입력되었습니다.");
			return "common/errorPage";	
		}else {
			session.setAttribute("alertMsg", "로그인 성공!");
			session.setAttribute("loginUser", loginUser);
			return "redirect:/";
		}
		/*
		if(loginUser != null) { // 로그인 성공
			session.setAttribute("alertMsg", "로그인 성공하셨습니다.");
			
			//로그인 정보를 저장
			session.setAttribute("loginUser", loginUser);
			return "redirect:/"; 
		}else { // 로그인 실패
			// 에러페이지로 url 요청 , 데이터를 저장한다면 "request" 영역에 저장
			model.addAttribute("errorMsg", "로그인 실패");
			return "common/errorPage";
		}
	*/
	}
	@GetMapping("/logout")  
	public String logout(HttpSession session) { 
		// 세션 비우기
		session.invalidate();
		
		// 메인페이지로 url 재요청 (리다이렉트)
		return "redirect:/";
	}
	@GetMapping("/mypage")
	public String mypage(Member user, HttpSession session) { 
		
		return "member/mypage";
	}
	@PostMapping("/update")
	public String updateMember(Member user, HttpSession session, Model model) { 

		String userName = user.getUserName();
		String email = user.getEmail();
		String age = user.getAge();
		String phone = user.getPhone();
		String address = user.getAddress();
		String gender = user.getGender();
		
		
		return "member/update";
	}
}