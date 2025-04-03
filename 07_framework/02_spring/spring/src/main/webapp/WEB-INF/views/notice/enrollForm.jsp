<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성하기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
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
        
        #enrollForm>table {width:100%;}
        #enrollForm>table * {margin:5px;}
        #enrollForm>table td {padding-right: 1.2rem;}
    </style>
</head>
<body>
	<%-- header --%>
    <jsp:include page="../common/header.jsp" />

    <div class="outer">
        <br><br>
        <div class="inner-area">
            <h2>공지사항 작성하기</h2>
            <br>

            <form action="/notice/write" enctype="" id="enrollForm" method="post">

                <table align="center" class="table">
                    <tr>
                        <th>제목</th>
                        <td>
                            <input type="text" name="noticeTitle" id="title" class="form-control" required>
                        </td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td>
                        	<%--value="" 안에는 공백있으면 안됌 --%>
                            <input type="text" name="noticeWriter" id="writer" value="${loginUser.userId}" class="form-control" readonly>
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2">내용</th>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <textarea name="noticeContent" id="content" cols="30" rows="10" class="form-control" style="resize: none;" required></textarea>
                        </td>
                    </tr>
                </table>
                <div class="btns" align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="button" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>

        <br><br>

    </div>

    <%-- footer --%>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>