<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
<style>
.outer {
	background-color: #e7e7e7;
	width: 80%;
	margin: auto;
}

.inner-area {
	border: 1px solid #000025;
	width: 80%;
	margin: auto;
	padding: 5% 15%;
	background: #e7ecf7;
}
main {
	height: 600px;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="common/header.jsp" />

	<main class="outer">
		<br>
		<br>
		<div class="inner-area">
			<h4>게시글 Top 5</h4>
			<br>
			<table id="top5-board-list" class="table table-hover" align="center">
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>첨부파일</th>
					</tr>
				</thead>
				<tbody align="center">
					<tr>
						<td colspan="6" rowspan="4" align="center">
							<div class="spinner-border text-primary"></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</main>

	<jsp:include page="common/footer.jsp" />
	<script>
		window.addEventListener('load', function(){
			selectBoardTop5();	
		});
		
		function selectBoardTop5(){
			$.ajax({
				url: '/api/board/top5',
				method: 'get',
				success: function(list){
					console.log("---  자유게시판 TOP5 조회 성공 ----");
					let top5List = "";
					for(const board of list){
						top5List += "<tr>"
								+ 		"<td>"+ board.boardNo	+ "</td>"
								+ 		"<td>"+ board.baordTitle	+ "</td>"
								+ 		"<td>"+ board.boardWriter	+ "</td>"
								+ 		"<td>"+ board.count	+ "</td>"
								+ 		"<td>"+ board.createDate	+ "</td>";
						if(board.originName != null){
							top5List += "<td>■</td>";
						}else{
							top5List += "<td></td>";
						}
						
						top5List += "</tr>"
					}
					$("#top5-board-list tbody").html(top5List);
				},
				error: function(err){
					console.log("---  자유게시판 TOP5 조회 실패 ----");
					console.log(err);
				}
			});
		}
	</script>
</body>
</html>