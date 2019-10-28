<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>코터디-자유게시판-상세페이지</title>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<div class="container2">
    <hr width="50%" color="violet">
    <h3>자유 게시판 상세내용</h3>
    <hr width="50%" color="violet">
    <table class="board_list">
        <c:set value="${freeBoardCont}" var="dto"/>
        <c:if test="${!empty dto}">
            <tr>
                <th>글 번호</th>
                <td>${dto.getFreeNum()}</td>
                <th>글 제목</th>
                <td>${dto.getFreeTitle()}</td>
                <th>작성자</th>
                <td>${dto.getMemId()}</td>
            </tr>
            <tr>
                <th colspan="2">글 내용</th>
                <td colspan="4"><textarea rows="14" cols="50" style="resize: none; " readonly>${dto.getFreeCont()}</textarea></td>
            </tr>
            <tr>
                <th colspan="1">작성일자/수정일자</th>
                <td colspan="3">${dto.getFreeCreatedDate() }/${dto.getFreeUpdatedDate() }</td>
                <th colspan="1">조회수</th>
                <td colspan="1">${dto.getFreeHit()}</td>
            </tr>
        </c:if>
        <c:if test="${empty dto }">
            <tr>
                <td colspan="2" align="center">
                    <h3>게시물이 존재하지 않습니다.</h3>
                </td>
            </tr>
        </c:if>
        <tr>
            <td colspan="6" align="center">
                <c:if test="${sessionScope.memId eq dto.getMemId()}">
                    <input type="button" value="수정" onclick="location.href='/freeEdit?no=${dto.getFreeNum()}'">
                    <input type="button" value="삭제" onclick="location.href='/freeDelete?no=${dto.getFreeNum()}'">
                </c:if>
                <input type="button" value="목록" onclick="location.href='/freeList'">
            </td>
        </tr>
    </table>
    <form method="post" action="<%=request.getContextPath()%>/freeReplyWrite">
    <table class="board_reply">
        <% if ((String)session.getAttribute("memId")==null){ %>
        <tr>
            <td><textarea cols="70" rows="5" style="resize: none" readonly>로그인 후 작성이 가능합니다.</textarea></td>
        </tr>
        <%} else{ %>
       <tr>
           <input type="hidden" name="memId" value="${sessionScope.memId}">
           <input type="hidden" name="freeNum" value="${dto.getFreeNum()}">
           <td><textarea cols="70" rows="5" style="resize: none" name="replyCont"></textarea></td>
           <td><input type="submit" value="댓글달기"></td>
       </tr>
        <% } %>
    </table>
    </form>

    <table class="board_reply">
        <c:set var="list" value="${replyDto}"/>
        <c:if test="${!empty list}">
            <c:forEach items="${list}" var="reply">
               <tr>
                   <td>${reply.getFreeReplyNum()}</td>
                   <td>${reply.getReplyCont()}</td>
                   <td>${reply.getMemId()}</td>
               </tr>
            </c:forEach>
        </c:if>
    </table>
</div>

</body>
</html>
