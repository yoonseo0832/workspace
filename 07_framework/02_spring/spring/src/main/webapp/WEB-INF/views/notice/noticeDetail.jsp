<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.spring.member.model.vo.Member,
				com.kh.spring.notice.model.vo.Notice" %>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	Notice notice  = (Notice)request.getAttribute("n");
%>
<!DOCTYPE html>
<html>
<head>
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
        
        table {width:100%;}
        table * {margin:5px;}
</style>  
</head>
<body>
	<%-- header --%>
    <jsp:include page="../common/header.jsp" />

    <div class="outer">
        <br><br>
        <div class="inner-area">
            <h2>공지사항 상세보기</h2>
            <br>
            <a href="/notice/list" class="btn btn-secondary" style="float:right;">목록보기</a>
            <br><br>

            <table align="center" class="table">
           
                <tr>
                    <th width="100">제목</th>
                    <td colspan="3">
                       ${n.noticeTitle }
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>
                        ${n.noticeWriter }
                    </td>
                    <th>작성일</th>
                    <td>
                        ${n.createDate }
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <p style="height:150px;">
                            ${n.noticeContent }
                        </p>
                    </td>
                </tr>
            </table>
            <br>
			<%if(notice != null && loginUser != null && notice.getNoticeWriter().equals(loginUser.getUserId())){  %>
	
            <div align="center">
                <!-- 작성자와 로그인한 계정이 동일한 경우만 표시 -->
                <a href="/notice/updateForm?no=${n.noticeNo}" class="btn btn-primary">수정</a>
                <a href="/notice/delete?no=${n.noticeNo}" class="btn btn-danger">삭제</a>
            </div>
            <%} %>
        </div>
        <br><br>

    </div>

    <%-- footer --%>
    <jsp:include page="../common/footer.jsp" />  
    <script>
    	window.addEventListener('load', function (){
    		const  boardTr = document.querySelectorAll("#boardList tbody tr");
    		
    		for(const ele of boardTr){
    			ele.onclick= function(){
    				location.href="/board/detail?no="+ ele.children[0].innerText;
    			}
    		}
    	})
    </script>  
</body>
</html>