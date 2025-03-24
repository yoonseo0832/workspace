<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - Format Library</title>
</head>
<body>
	<h1>* 숫자 관련 ㅣ formatNumber</h1>
	<p>
		숫자 데이터의 형식(포맷) 지정<br>
		- 표현하고자하는 숫자 데이터의 형식을 통화기호, % 등으로 원하는 방식에 맞게 지정하는 태그
		<br>
		fmt:formatNumber value="출력할 값"
					groupingUsed="true|false"
					type="percent|currency" currencySymbol="문자"
	</p>
	
	<c:set var="n1" value="123456789" />
	<c:set var="n2" value="0.65" />
	<c:set var="n3" value="50000" />
	
	n1 : ${ n1 }
	<br>
	구분자 : <fmt:formatNumber value="${n1 }" />
	<br>
	groupingUsed: <fmt:formatNumber value="${n1 }" groupingUsed="false"/>
	<br>
	percent : <fmt:formatNumber value="${n2 }" type="percent"/>
	<br>
	currency: <fmt:formatNumber value="${n3 }" type="currency" currencySymbol="$"/>
	<br><br>
	
	<h3>* formatDate</h3>
	<p>
		날짜 및 시간 데이터의 포맷(형식) 지정하여 출력
	</p>
	<i>단, java.util.Date 객체 사용</i><br>
	<%--import 하지 않고 앞에 경로를 붙이면 사용 가능 --%>
	<c:set var="now" value="<%= new java.util.Date() %>" />
	- now : ${now }
	<br>
	<ul>
	<%--date : 날짜 | time : 시간 --%>
		<li>날짜: <fmt:formatDate value="${now }" type="date" /></li>
		<li>시간: <fmt:formatDate value="${now }" type="time" /></li>
		<li>
			- 날짜+시간: <fmt:formatDate value="${now }" type="both" />
			<ul>
				<li>
					medium : <fmt:formatDate value="${now }" type="both" dataStyle="medium" timeStyle="medium" />
				</li>
				<li>
				<%--더 자세한 형식 --%>
					long : <fmt:formatDate value="${now }" type="both" dataStyle="long" timeStyle="long" />
				</li>
				<li>
				<%--더 짧은 형식 --%>
					short : <fmt:formatDate value="${now }" type="both" dataStyle="short" timeStyle="short" />
				</li>
				<li>
				<%--더 짧은 형식 --%>
					full : <fmt:formatDate value="${now }" type="both" dataStyle="full" timeStyle="full" />
				</li>
				<li>
				<%--더 짧은 형식 --%>
					pattern : <fmt:formatDate value="${now }" type="both" pattern="yyyy-MM-dd(E) HH:mm:ss" />
				</li>
			</ul>
		</li>
	</ul>
	
</body>
</html>