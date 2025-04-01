<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
    .container{
        margin: 0 auto;
        text-align: center;
    }
    .loginBox{
        height: 700px;
        width: 500px;
        background-color: #F9F9F9;
        box-shadow: 1px black;
    }
    h1{
        color:#0E6973;
    }
    input{
        display: flex;
        background-color: #0E6973;
    }
</style>
</head>
<body>
	<!-- header-->
    <div class="container">
        <!-- Content here -->
         <div class="loginBox">
            <h1>로그인</h1>
            <form action="" method="">
                <div class="input-group">
                    <label for="email">이메일</label><br>
                    <input type="email" id="email" name="email" placeholder="이메일" /><br>
                </div>
                <label for="userPwd">비밀번호</label><br>
                <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호" />

                <br>
                <div class="btn">
                    <button type="submit">로그인</button><br>
                </div><br>
                <a href="">카카오로 시작하기</a><br>
                <a href="">Google로 시작하기</a><br>
                <p>아직 회원이 아니신가요? <a href="">회원가입</a></p>
            </form>
         </div>
      </div>
    <!-- footer-->
</body>
</html>