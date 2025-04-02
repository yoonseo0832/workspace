<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.kh.spring.notice.model.vo.Notice" %>
<% 
	ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("list");
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

        #noticeList {text-align: center;}
        #noticeList>tbody>tr:hover{cursor:pointer;}

        #pagingArea {width:fit-content; margin:auto;}

        #searchForm {width:80%; margin: auto;}
        #searchForm>* {float:left; margin:5px;}
        
        .text {width:75%;}
        .searchBtn{width:20%;}
</style>
</head>
<body>
	 <%-- header --%>
    <jsp:include page="../common/header.jsp" />

    <div class="outer">
        <br><br>
        <div class="innerOuter" style="padding: 5% 10%">
            <h2>공지사항</h2>
            <br>

            <%-- admin 계정일때만 글쓰기 버튼 표시 --%>
            <a href="" class="btn btn-secondary" style="float:right">글쓰기</a>
            <br>
            
            <br>
            <table id="noticeList" class="table table-hover" align="center">
                <thead>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </thead>

                <tbody>
                 <%--DB에 조회된 목록이 표시되도록 처리 --%>  
                 <% for(Notice n :list){%>
                  <tr >
                        <td><%= n.getNoticeNo()%></td>
                        <%-- <td><a href="/notice/detail?no=<%= n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>--%>
                        <td><%=n.getNoticeTitle()%></td>
                        <td><%=n.getNoticeWriter()%></td>
                        <td><%=n.getCreateDate()%></td>
                    </tr>
                 <%} %>                         
                </tbody>
            </table>
            <br>

            <div id="pagingArea">
                <ul class="pagination">
                    <li class="page-item"><a href="" class="page-link">Prev</a></li>
                    <li class="page-item"><a href="" class="page-link">1</a></li>
                    <li class="page-item"><a href="" class="page-link">2</a></li>
                    <li class="page-item"><a href="" class="page-link">3</a></li>
                    <li class="page-item"><a href="" class="page-link">4</a></li>
                    <li class="page-item"><a href="" class="page-link">5</a></li>
                    <li class="page-item"><a href="" class="page-link">Next</a></li>
                </ul>
            </div>

            <br clear="both">

            <form action="" id="searchForm">
                <div class="text">
                    <input type="text" class="form-control" name="keyword" placeholder="검색할 제목을 입력하세요.">
                </div>
                <button class="searchBtn btn btn-secondary">검색</button>
            </form>
        </div>
        <br><br>
    </div>

    <%-- footer --%>
    <jsp:include page="../common/footer.jsp" />
    <!-- Ele, Ele.. -->
    <script>
    	onload = function (){
    		const noticeTr = document.querySelectorAll("#noticeList tbody tr");
    		
    		for(const ele of noticeTr){
    			ele.onclick= function(){
    				location.href="/notice/detail?no="+ ele.children[0].innerText;
    			}
    		}
    	}
    </script>
</body>
</html>