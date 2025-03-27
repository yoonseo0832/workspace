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
<!--  jQuery CDN -->
<script
  src="https://code.jquery.com/jquery-3.7.1.min.js"
  integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
  crossorigin="anonymous"></script>
<!--  jQuery CDN -->
<style>
/* 공통적인 부분에 대한 css */
.outer {
	width: 1000px;
	background: #ffb1ca;
	color: white;
	margin: auto;
	margin-top: 50px;
}

#btn-marign {
	margin-left: 10px;
}

#mem-enroll-area table {
	margin: auto;
}
</style>
</head>

<body>
	<%-- menubar.jsp 포함/ 상위폴더로 이동은 "../" --%>
	<jsp:include page="../common/menubar.jsp" />

	<div class="outer">
		<br>
		<h2 align="center">회원가입</h2>

		<form action="insert.me" method="post" id="mem-enroll-area">
			<table>
				<tr>
					<td>* 아이디</td>
					<td><input type="text" class="form-control" name="userId"
						maxlength="30" required /></td>
					<td><input type="button" class="btn btn-sm btn-outline-dark"
						value="중복체크" id="btn-marign" onclick="idCheck();"/></td>
				</tr>
				<tr>
					<td>* 비밀번호</td>
					<td><input type="password" class="form-control" name="userPwd"
						required /></td>
				</tr>
				<tr>
					<td>* 비밀번호 확인</td>
					<td>
						<input type="password" class="form-control" id="userPwdCheck" required />
					</td>
				</tr>
				<tr>
					<td>* 이름</td>
					<td><input type="text" class="form-control" name="userName"
						required /></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;이메일</td>
					<td><input type="email" class="form-control" name="email" />
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;성별</td>
					<td>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender"
								value="M" id="genderM" /> <label class="form-check-label"
								for="genderM"> 남자 </label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="gender"
								value="F" id="genderF" /> <label
								class="form-check-label" for="genderF"> 여자 </label>
						</div>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;생년월일</td>
					<td>
						<input type="date" class="form-control" onchange="makeBirth(this);" />
						<input type="hidden" name="birthday" />
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;연락처</td>
					<td>
						<input type="tel" class="form-control" name="phone" placeholder="-를 포함해서 입력" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"/>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;주소</td>
					<td><input type="text" class="form-control" name="address" />
					</td>
				</tr>
			</table>
			<br>
			<br>
			<div align="center">
				<button class="btn btn-primary" type="submit" onclick="return pwCheck();">회원가입</button>
				<button class="btn btn-danger" type="reset">초기화</button>
			</div>
		</form>
	</div>
	<script>
		// 아이디 중복 체크 (비동기통신, ajax)
		function idCheck(){
			//[중복체크] 클릭 시 사용자가 입력한 아이디값을 전달하여 조회
			// => 존재하는지 아닌지 여부를 확인 => 응답 데이터를 받는 것
			
			// 입력된 아이디 값 추출(jQuery)
			const $userId = $("#mem-enroll-area input[name=userId]");
			//console.log($userId, $userId.val());
			//console.log("*** ajax 요청 전 ***");
			
			//$.ajax(요청정보);
			// 요청 정보 : 객체 json 형태로  key/value 형태로 작성
			/*
				- url  : 요청 주소 
				- type | method : 요청 방식(get, post..)
				- data : 전달할 데이터 (json) {key:value, key:value, ..}
				- success : 요청(통신) 성공 시 처리할 내용(함수)
				- error : 요청(통신) 실패 시 처리할 내용(함수)
				------------------
				- async : 서버와의 비동기 통신 처리 여부(기본값: true)
				- contentType: 요청 시 데이터 인코딩 방식
				- dataType: 서버에서 응답 시 전달되는 데이터 형식 설정
							(설정하지 않을 경우 자동으로 판단)
					+ xml  : 트리 형태 데이터
					+ json : 객체 (맵 형식) -> 일반적인 데이터 구조
					+ html : html 형식 태그
					+ text : 문자열 데이터 
					...
			*/
			$.ajax({
				url: 'idCheck',
				data: {
					userId: $userId.val()
					},
				type: 'get', //생략 가능
				
				success: function(){
					//요청 성공 시
					
				},
				error: function(){
					//요청 실패 시
				},
				
			})
		}
		// yyyy-mm-dd ---> yymmdd
		// const makeBirth = (target) => {
		function makeBirth(target) {
			
			const data = target.value;
			// document.querySelector("#mem-enroll-area input[type=date]") --> target
			
			const birth = new Date(data);
			
			console.log(birth);
			let yy = birth.getFullYear() % 100;
			let mm = ("0"+ (birth.getMonth() + 1)).slice(-2); // '0' + 3 --> '03', '0' + 11 --> '011'
			let dd = ("0"+ birth.getDate()).slice(-2);
			
			console.log(yy, mm, dd);
			
			const dArr = data.split('-');
			yy = dArr[0].slice(-2);
			mm = dArr[1];
			dd = dArr[2];
	
			console.log(yy, mm, dd);
	
			document.querySelector("#mem-enroll-area input[name=birthday]").value = yy+ mm + dd;
		}
		// 입력된 비밀번호 값과 비밀번호 확인 값이 같을 경우 true
		// 다를 경우 false;
		
		function pwCheck(){
			//비밀번호 일력값 -> name=userPwd
			const pwd = document.querySelector("#mem-enroll-area input[name=userPwd]").value;
			 //=> $("#mem-enroll-area input[name=userPwd]").val();
			//$('#userId').html();
			const pwdCheck = document.getElementById("userPwdCheck").value;
			
			// 두 값이 다를 경우 false 리턴
			if(pwd != pwdCheck){
				alert("비밀번호가 다릅니다.");
				return false;
			}
		}
	</script>
</body>
</html>