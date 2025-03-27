<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyBatis Project</title>
<!--부트스트랩 CDN-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!--부트스트랩 CDN-->
<style>
/* 공통적인 부분에 대한 css */
.outer {
	width: 1000px;
	background: #ffb1ca;
	color: white;
	margin: auto;
	margin-top: 50px;
}
#mypage-area table {
	margin: auto;
}
</style>
</head>
<body>
	<%-- menubar.jsp 포함/ 상위폴더로 이동은 "../" --%>
	<jsp:include page="../common/menubar.jsp" />

	<div class="outer">
		<br>
		<h2 align="center">마이페이지</h2>

		<form action="update.me" method="post" id="mypage-area">
			<table>
				<tr>
					<td>* 아이디</td>
					<td>
						<input type="text" class="form-control" name="userId" maxlength="30" readonly value="${loginUser.userId }"/>
					</td>
				</tr>
				<tr>
					<td>* 이름</td>
					<td>
						<input type="text" class="form-control" name="userName" readonly value="${loginUser.userName }" />
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;이메일</td>
					<td><input type="email" class="form-control" name="email" value="${ loginUser.email}"/>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;성별</td>
					<td>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender"
								value="M" id="genderM"  /> <label class="form-check-label"
								for="genderM" > 남자 </label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender"
								value="F" id="genderF" checked /> <label
								class="form-check-label" for="genderF"> 여자 </label>
						</div>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;생년월일</td>
					<td>
						<input type="date" class="form-control" id="birth" value="${loginUser.birthday}"/>
						<!-- yymmdd => yyyy-mm-dd  20/19 pattern TO_CHAR"yyyy-mm-dd"-->
						<input type="hidden" name="birthday" />
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;연락처</td>
					<td>
						<input type="tel" class="form-control" name="phone" placeholder="-를 포함해서 입력" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"
								value="${loginUser.phone }"/>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;주소</td>
					<td><input type="text" class="form-control" name="address"  value="${loginUser.address }"/>
					</td>
				</tr>
			</table>
			<br>
			<br>
			<div align="center">
				<button type="submit" class="btn btn-sm btn-primary">정보 수정</button>
				<button type="button" class="btn btn-sm btn-secondary">비밀번호 수정</button>
				<button type="button" class="btn btn-sm btn-danger">회원 탈퇴</button>
			</div>
		</form>
	</div>
	<script>
	// 모든 요소들이 로드 되었을때 화면에 표시
	onload = function (){
		// 성별항목을 적용
		const gender = "${loginUser.gender}"; // 로그인한 사용자의 성별정보
		console.log(gender);
		
		//성별(name=gender) 입력 요소들에 접근 {radio 태그의 경우}
		const gArr = document.querySelectorAll("input[name=gender]");
		// => [E, E] 배열형태
		for(let gEle of gArr){
			//console.log(gEle.value);
			if(gEle.value == gender){
				// 로그인 사용자의 성별 정보와 해당 요소(gender)의 value 속성값이 같은 경우
				gEle.checked = true;  // 체크되로록
				break;
			}
		}
		// 생년월일 데이터 가공
		makeBirth();
	}
		// yyyy-mm-dd ---> yymmdd
		// const makeBirth = (target) => {
		
		function makeBirth() {
			// 생년월일 readonly 인 경우
			//const data = "${loginUser.birthday}";
			
			// 생년월일 readonly 아닌 경우
			// + onchange() 이벤트 사용 가능
			const data = document.getElementById("birth").value;
			const dArr = data.split('-');
			yy = dArr[0].slice(-2);
			mm = dArr[1];
			dd = dArr[2];
	
			console.log(yy, mm, dd);
	
			document.querySelector("#mypage-area input[name=birthday]").value = yy+ mm + dd;
		}
		// 입력된 비밀번호 값과 비밀번호 확인 값이 같을 경우 true
		// 다를 경우 false;
		/*
		function pwdCheck(){
			//비밀번호 일력값 -> name=userPwd
			const pwd = document.querySelector("#mem-enroll-area input[name=userPwd]").value;
			
			const pwdCheck = document.getElementById("userPwdCheck").value;
			
			// 두 값이 다를 경우 false 리턴
			if(pwd != pwdCheck){
				alert("비밀번호가 다릅니다.");
				return false;
			}
		}
		*/
		const myemail = document.querySelector("#mypage-area input[name=email]").value;
		document.querySelector("#mypage-area ").value;
	</script>
</body>
</html>