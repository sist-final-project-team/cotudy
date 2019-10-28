<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>코터디-자유게시판-수정페이지</title>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<div class="container2">
    <hr width="50%" color="violet">
    <h3>자유 게시판 상세내용</h3>
    <hr width="50%" color="violet">
    <form method="post" action="<%=request.getContextPath()%>/freeEditOk">
    <table class="board_list">
        <c:set value="${freeBoardCont}" var="dto"/>
        <c:if test="${!empty dto}">
            <tr>
                <th>글 번호</th>
                <td>${dto.getFreeNum()}</td>
                <input type="hidden" value="${dto.getFreeNum()}" name="freeNum">
                <th>글 제목</th>
                <td><input value="${dto.getFreeTitle()}" name = "freeTitle"></td>
                <th>작성자</th>
                <td>${dto.getMemId()}</td>
            </tr>
            <tr>
                <th colspan="2">글 내용</th>
                <td colspan="4"><textarea rows="14" cols="50" style="resize: none" name = "freeCont">${dto.getFreeCont()}</textarea></td>
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
                    <input type="submit" value="수정하기">&nbsp;&nbsp;&nbsp;
                    <input type="reset" value="취소">
                </c:if>
                <input type="button" value="목록" onclick="location.href='/freeList'">
            </td>
        </tr>
    </table>
    </form>
</div>

</body>
</html>
