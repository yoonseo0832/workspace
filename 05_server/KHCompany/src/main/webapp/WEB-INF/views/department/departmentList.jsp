<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KH Company</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- ------- -->
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	
	<main class="container-lg">
		<table class="table">
			<thead>
				<tr>
					<th>사원명</th>
					<th>부서코드</th>
					<th>부서명</th>
					<th>지역코드</th>
					<th>국가명</th>
				</tr>
			</thead>
			<tbody>
				<%-- 조회 결과가 있을 경우 한 행씩 출력 --%>
				<c:choose>
					<c:when test="${not empty dList}">
						<c:forEach var="d" items="${dList}">
							<tr>
								<td>${d.empName }</td>
								<td>${d.deptId }</td>
								<td>${d.deptTitle }</td>
								<td>${d.locationId }</td>
								<td>${d.nationalName }</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="5">조회된 사원이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				<%-- 조회 결과 없을 경우 "조회된 사원이 없습니다." 출력 --%>
			</tbody>
		</table>
	</main>
	
	<jsp:include page="../common/footer.jsp" />
</body>
</html>