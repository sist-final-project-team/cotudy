
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>코터디-자유게시판</title>
    <script type="text/javascript">
        function writeOk() {
            var id = "<%=(String)session.getAttribute("memId")%>";
            console.log(id.valueOf());
            if(id.valueOf()=='null'){ // = 붙여야 함 -최다빈- , null이면 못쓰게 하도록 수정 - 최다빈-
                alert("로그인 후 이용 가능합니다.");
                window.open("/login", "로그인 화면", "top=300, left=300, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no");
                location.href="/freeList";
            }else{

                location.href="/freeWriteForm";
            }
        }
    </script>

</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<div class="container2">	<!--container2 : 탑마진 내려놓음 -->
    <hr width="50%" color="blue">
        <h3>자유 게시판 목록</h3>
    <hr width="50%" color="blue">
              

<div class="btn-group" role="group" aria-label="Basic example">
  <button type="button" class="btn btn-secondary" onclick="location.href='/freeList' " >전체보기</button>
  <button type="button" class="btn btn-secondary" value="질문" onclick="location.href='/freeSearchList?freeSubject=<%="질문"%>'" >질문</button>
  <button type="button" class="btn btn-secondary" value="사담" onclick="location.href='/freeSearchList?freeSubject=<%="사담"%>'" >사담</button>
  <button type="button" class="btn btn-secondary" value="기타" onclick="location.href='/freeSearchList?freeSubject=<%="기타"%>'" >기타</button>
</div>

        
        <table class="board_list">
            <tr>
                <th>글 번호</th><th>주제</th><th>글 제목</th><th>작성자</th><th>작성일자</th><th>조회수</th>
            </tr>
            <c:set var="list" value="${list}"/>
            <c:if test="${!empty list}">
                <c:forEach items="${list}" var="freeboardDto">
                    <tr>
                        <td>${freeboardDto.getFreeNum()}</td>
                        <td>${freeboardDto.getFreeSubject()}</td>
                        <td><a href="/freeCont?freeNum=${freeboardDto.getFreeNum()}&page=${page}"> ${freeboardDto.getFreeTitle()}<c:if test="${freeboardDto.getFreeReplyCnt() >0}">
                            (${freeboardDto.getFreeReplyCnt()})
                            </c:if> </a></td>
                        <td>${freeboardDto.getMemId()}</td>
                        <td>${freeboardDto.getFreeCreatedDate()}</td>
                        <td>${freeboardDto.getFreeHit()}</td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="6" align="center">
                        <h3>게시글이 없습니다.</h3>
                    </td>
                </tr>
            </c:if>

        </table>
    <tr>
        <td colspan="6" align="center">
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <c:if test="${page > block}">
                        <li class="page-item"><a class="page-link" href="/freeList?page=${startBlock-1 }">Previous</a></li>
                        <%--                        [<a href="/freeList?page=1">◀◀</a>]--%>
                        <%--                        [<a href="/freeList?page=${startBlock-1 }">◀</a>]--%>
                    </c:if>
                    <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
                        <c:if test="${i==page }">
                            <%--                            <b>[${i}]</b>--%>
                            <li class="page-item disabled"><a class="page-link" href="/freeList?page=${i}" tabindex="-1">${i}<span class="sr-only">(current)</span></a></li>
                        </c:if>
                        <c:if test="${!(i==page) }">
                            <%--                            [<a href="/freeList?page=${i}">${i}</a>]--%>
                            <li class="page-item"><a class="page-link" href="/freeList?page=${i}">${i}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${endBlock <allPage }">
                        <%--                        [<a href="/freeList?page=${endBlock+1 }">▶</a>]--%>
                        <%--                        [<a href="/freeList?page=${allPage }">▶▶</a>]--%>
                        <li class="page-item"><a class="page-link" href="/freeList?page=${endBlock+1 }">Next</a></li>
                    </c:if>
                </ul>
            </nav>
        </td>
    </tr>
    <div align="center">
        <form method="get" action="/freeSearchList">
            <%--<input type="hidden" name="page" value="${page}">--%>
			<select name="freeSubject"  >
				<option value="전체보기" selected>전체보기</option>
				<option value="질문">질문</option>
				<option value="사담">사담</option>
				<option value="기타">기타</option>
			</select>
			<select name="searchType">
				<option value="free_title">제목</option>
				<option value="free_cont">내용</option>
				<option value="mem_id">작성자</option>
			</select> 
			<input type="text" name="searchKeyword"> 
			<input type="submit" value="검색" class="btn btn-outline-secondary">
                <input align="right" type="button" value="글 작성" onclick="writeOk()" class="btn btn-success">
		</form>
    </div>
</div>

</body>
</html>
