<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>코터디-내가쓴글</title>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<br><br><br><br><br><br><br>

<div align="center">
	<h2>자유게시판</h2>
    <table border="1">
        <tr>
            <th>주제</th>
            <th>제목</th>
			<th>아이디</th>
            <th>작성일자</th>
        </tr>
		<c:set var="list" value="${list}"/>
		<c:if test="${!empty list}">
			<c:forEach items="${list}" var="freeboardDto">
				<tr>
<%--					<td>${freeboardDto.getFreeNum()}</td>--%>
					<td>${freeboardDto.getFreeSubject()}</td>
					<td><a href="/freeCont?freeNum=${freeboardDto.getFreeNum()}"> ${freeboardDto.getFreeTitle()}</a></td>
					<td>${freeboardDto.getMemId()}</td>
					<td>${freeboardDto.getFreeCreatedDate()}</td>
<%--					<td>${freeboardDto.getFreeHit()}</td>--%>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty list}">
			<h2>내가쓴글이엄서요</h2>
		</c:if>




    </table>

</div>

</body>
</html>