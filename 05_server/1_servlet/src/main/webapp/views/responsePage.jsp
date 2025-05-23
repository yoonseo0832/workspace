<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>응답용 페이지</title>
</head>
<body>
	<!-- html 주석 -->
	<%-- jsp 주석 --%>
	<h1>@@@응답완료###</h1>
	
	<%-- 자바 코드 작성하기 --%>
	<%
		//System.out.println("hi, jsp!?");
		// 스크립틀릿(Scriptlet) : HTML문서 내에서 자바코드를 작성할 수 있는 영역
		
		// 서블릿을 통해 전달된 데이터를 추출해보기
		String name = (String)request.getAttribute("name");
		String gender = (String)request.getAttribute("gender");
		String age = (String)request.getAttribute("age");
		String address = (String)request.getAttribute("address");
		String height = (String)request.getAttribute("height");
		String[] foods = (String[])request.getAttribute("foods");
	%>
	<%-- 변수의 값을 화면상에 출력하고자 할때 <%= %> 처럼 %뒤에 =를 붙임 --%>
	이름: <span><%= name %></span><br>
	성별: <%if(gender ==null){ %>
			성별을 선택하지 않음
		<%}else {%>
			<span><%= gender %></span>
		<%} %>
		<br>
	나이: <%if(age.isEmpty()){ %>
			나이를 입력하지 않음
		<%}else{ %>
			<span><%= age %></span>
		<%} %>
		<br>
	주소: <span><%= address %></span><br>
	 키: <span><%= height %></span><br>
	음식: <% if(foods ==null){ %>
			선택된 음식이 없습니다
		<%} else{ %>
			<span><%=String.join("/", foods) %></span>
			<ol>
			<%for(String f : foods){ %>
				<li><%= f %></li>
			<%} %>
			</ol>
		<%} %>
</body>
</html>