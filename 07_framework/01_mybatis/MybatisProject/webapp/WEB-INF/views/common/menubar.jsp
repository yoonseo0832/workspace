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
	<h1 align="center">Welcome to MyBatis World!</h1>
	<br>
	<div class="login-area" align="right">
		<c:choose>
			<c:when test="${ empty loginUser }">
				<!-- 로그인 전 표시할 부분 -->
				<form action="" method="post">
					<table>
						<tr>
							<td>아이디</td>
							<td><input type="text" name="userId" required></td>
							<td rowspan="2"><button type="submit" style="height: 50px;">로그인</button>
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
								<h3>@@@님 환영합니다^^</h3>
							</td>
						</tr>
						<tr>
							<td><a href="">마이페이지</a></td>
							<td><a href="">로그아웃</a></td>
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