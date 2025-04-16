<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.kh.spring.board.model.vo.Board
				,com.kh.spring.member.model.vo.Member
				,java.util.ArrayList
				,com.kh.spring.board.model.vo.Reply " %>
<%
	Board board = (Board)request.getAttribute("board");
	Member loginUser = (Member)session.getAttribute("loginUser");
	ArrayList<Reply> rlist= (ArrayList<Reply>)request.getAttribute("rlist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 상세보기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous">
</script>
<script src="https://code.jquery.com/jquery-3.7.1.slim.js"
	integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc="
	crossorigin="anonymous"></script>
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

table {
	width: 100%;
}

table * {
	margin: 5px;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<div class="outer">
		<br>
		<br>
		<div class="inner-area">
			<h2>게시글 상세보기</h2>
			<br> <a href="/board/list" class="btn btn-secondary" style="float: right;">목록보기</a>
			<br>
			<br>

			<table align="center" class="table">
				<tr>
					<th width="100">제목</th>
					<td colspan="3">${board.boardTitle}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${board.boardWriter}</td>
					<th>작성일</th>
					<td>${board.createDate}</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<a href="resources/upfile/${board.changeName}" download>
							${board.originName}
						</a>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td colspan="4">
						<p style="height: 150px;">${board.boardContent}</p>
					</td>
				</tr>
			</table>
			<br>

			 <!-- 작성자(board.boardWriter)와 
              	 로그인한 계정(loginUser.userId)이 동일한 경우만 표시 -->
			<% if (board != null && loginUser != null
					&& board.getBoardWriter().equals(loginUser.getUserId())) { %>
	            <div align="center">
	                <a href="/board/updateForm?bno=${ board.boardNo }" class="btn btn-primary">수정</a>
	                <a href="/board/delete?bno=<%= board.getBoardNo() %>" class="btn btn-danger">삭제</a>
	            </div>
            <% } %>
            <br><br>

			<table id="replyArea" class="table" align="center">
				<thead>
					<tr>
						<th colspan="2"><textarea name="" id="content" cols="55"
								rows="2" class="form-control" style="resize: none;"></textarea>
						</th>
						<th style="vertical-align: middle;">
							<button class="btn btn-secondary">등록</button>
						</th>
					</tr>
					<tr>
						<td colspan="3">댓글 (<span id="rcount"><%=rlist.size() %></span>)
						</td>
					</tr>
				</thead>
				<tbody>
				<% for(Reply r : rlist){ %>
					<tr>
						<th><%=r.getReplyWriter() %></th>
						<td><%=r.getReplyContent() %></td>
						<td><%=r.getCreateDate() %></td>
					</tr>
				<%} %>
				</tbody>
			</table>
			<br>
			<br>
		</div>


	</div>

	<%-- footer --%>
	<jsp:include page="../common/footer.jsp" />
	<script>
		window.addEventListener('load', function(){
			// [등록] 버튼 클릭 이벤트
			$("#replyArea button .btn").click(function(){
				// 입력된 댓글 내용을 추가 요청 -> 비동기 처리
				addRelpy();
			});
		});
		
		// 댓글 추가 기능
		function addRelpy(){
			if($("#replyArea #content").val() == ""){
				alert("댓글 작성 후 등록 가능합니다");
				return;
			}
			
			// 비동기 통신 => ajax
			$.ajax({
				//url:'/board/rinsert',
				url: '/api/board/reply',
				method: 'post',	// type:
				data: {
					replyContent: ${"#replyArea #content"}.val(),
					replyWriter: ${loginUser.userId},
					refBno: ${board.boardNo}
				},	// {키-데이터..}
				success: function(result){
					// result => 응답 데이터(결과)
					console.log("댓글 작성 성공!");
					console.log(result);
					if(result == "success"){
						selectReplyList();
						
						//댓글 입력 창 초기화
						$("#replyArea #content").val("");
					}
				},
				error: function(){
					// err => 오류 내용
					console.log("댓글 작성 실패");
					console.log(result);
				}
			});
		}
		
		function selectReplyList(){
			$.ajax({
				url: '/board/rlist',
				method: 'get',
				data: {boardNO: ${board.boardNo}},
				success: function(list){
					console.log("댓글 목록 조회 성공");
					console.log(list);
					
					// 댓글 개수 업데이트
					$("#replyArea #rcount").text(list.length);
					
					// 댓글 목록 업데이트
					let replyData = "";
					for(const reply of list){
						replyData += "<tr>"
									+"<th>" + reply.replyWriter + "</th>"
									+ <td>" + reply.replyContent + "</td>"
									+ <td>" + reply.createDate + "</td>"
									+"</th>";
					}
					
					$("#replyArea tbody").html(replyData);
				},
				error: function(err){
					console.log("댓글 목록 조회 실패");
					console.log(err);
				}
			});
		}
	</script>
</body>
</html>