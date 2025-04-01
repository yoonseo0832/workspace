<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyBatis World</title>
<style>
.login-area a {
	text-decoration: none;
	color: black;
	font-size: 12px;
}

.login-area a:hover {
	background: #ffb1ca;
	color: white;
	border-radius: 1em;
	padding: 5px;
}

.nav-area {
	background: #ffb1ca;
	color: white;
	height: 50px;
}

.menu {
	display: table-cell;
	width: 250px;
	height: 50px;
	vertical-align: middle;
	font-size: 20px;
	font-weight: bold;
}

.menu:hover {
	cursor: pointer;
	background: #ffe0d9;
}
/* 공통적인 부분에 대한 css */
.outer {
	width: 1000px;
	background: #ffb1ca;
	color: white;
	margin: auto;
	margin-top: 50px;
}
</style>
</head>
<body>
	<%-- alertMsg 키에 데이터가 있을 경우 alert()를 사용하여 메세지 출력 --%>
	<c:if test="${not empty alertMsg }">
		<script>
			alert("${alertMsg}");
		</script>
		
		<c:remove var="alertMsg"/>
	</c:if>
	<h1 align="center">Welcome to MyBatis World!</h1>
	<br>
	<div class="login-area" align="right">
		<c:choose>
			<c:when test="${ empty loginUser }">
				<!-- 로그인 전 표시할 부분 -->
				<form action="login.me" method="post">
				<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.4/kakao.min.js"
  integrity="sha384-DKYJZ8NLiK8MN4/C5P2dtSmLQ4KwPaoqAfyA/DfmEc1VDxu4yyC7wy6K1Hs90nka" crossorigin="anonymous"></script>
<script>
  Kakao.init('ae7a7397b6b63bb73749363477bfc190'); // 사용하려는 앱의 JavaScript 키 입력
</script>

<a id="kakao-login-btn" href="javascript:loginWithKakao()">
  <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
    alt="카카오 로그인 버튼" />
</a>
<p id="token-result"></p>

<script>
  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'https://developers.kakao.com/tool/demo/oauth',
    });
  }

  // 아래는 데모를 위한 UI 코드입니다.
  displayToken()
  function displayToken() {
    var token = getCookie('authorize-access-token');

    if(token) {
      Kakao.Auth.setAccessToken(token);
      Kakao.Auth.getStatusInfo()
        .then(function(res) {
          if (res.status === 'connected') {
            document.getElementById('token-result').innerText
              = 'login success, token: ' + Kakao.Auth.getAccessToken();
          }
        })
        .catch(function(err) {
          Kakao.Auth.setAccessToken(null);
        });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
</script>
				
					<table>
						<tr>
							<td>아이디</td>
							<td>
								<input type="text" name="userId" required>
							</td>
							<td rowspan="2">
								<button type="submit" style="height: 50px;">로그인</button>
							</td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td><input type="password" name="userPwd" required></td>
						</tr>
						<tr>
							<td colspan="3" align="center">
								<a href="enrollForm.me">회원가입</a> 
								<a href="">아이디/비번찾기</a>
							</td>
						</tr>
					</table>
				</form>
			</c:when>
			<c:otherwise>
				<!-- 로그인 후 표시할 부분 -->
				<div>
					<table>
						<tr>
							<td colspan="2">
								<h3>${loginUser.userName }님 환영합니다^^</h3>
							</td>
						</tr>
						<tr>
							<td><a href="mypage.me">마이페이지</a></td>
							<td><a href="logout.me">로그아웃</a></td>
						</tr>
					</table>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<br>

	<div class="nav-area" align="center">
		<div class="menu">HOME</div>
		<div class="menu">공지사항</div>
		<div class="menu">게시판</div>
		<div class="menu">ETC</div>
	</div>

</body>
</html>