<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.kh.spring.board.model.vo.Board" %>
<% Board board = (Board)request.getAttribute("board"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 수정하기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
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

#updateForm>table {
	width: 100%;
}

#updateForm>table * {
	margin: 5px;
}
</style>
</head>
<body>
	<%-- header --%>
    <jsp:include page="../common/header.jsp" />

    <div class="outer">
        <br><br>
        <div class="inner-area">
            <h2>게시글 수정하기</h2>
            <br><br>

            <form id="updateForm" method="post" action="/board/update" enctype="multipart/form-data">
                <input type="hidden" name="boardNo" value="${board.boardNo}">
                <table align="center" class="table">
                    <tr>
                        <th width="100"><label for="title">제목</label></th>
                        <td>
                            <input type="text" name="boardTitle" id="title" class="form-control" value="${board.boardTitle}" required />
                        </td>
                    </tr>
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td>
                            <input type="text" name="boardWriter" id="writer" class="form-control" value="${board.boardWriter }" readonly />
                        </td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td>
                            <input type="file" name="upfile" id="upfile" class="form-control-file border"><br>
                            첨부 파일 :
                            <%--첨부파일이 있는 경우 getOriginName 또는 getChangeName 둘중 하나로 필드가 null 인지 아닌지 체크--%> 
                            <%if(board.getOriginName() != null){ %>
                            	<%--href= 요청 주소, ${board.originName}원래파일 이름--%>
                            	<a href="${board.changeName }" download>${board.originName}</a>
                            	<input type="hidden" name="originName" value="${board.originName}">
                            	<input type="hidden" name="changeName" value="${board.changeName}">
                            <%} %>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2"><label for="content">내용</label></th>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <textarea name="boardContent" id="content" class="form-control" rows="10" style="resize:none;" required>${board.boardContent}</textarea>
                        </td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <!-- 작성자와 로그인한 계정이 동일한 경우만 표시 -->
                    <button type="submit" class="btn btn-primary">수정</button>
                    <button type="button" class="btn btn-danger" onclick="history.go(-1);">이전</button>
                </div>
                <br><br>
            </form>
        </div>


    </div>

    <%-- footer --%>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>