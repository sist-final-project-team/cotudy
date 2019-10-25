<!DOCTYPE html>

<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta charset="utf-8">
<title>EstateAgency Bootstrap Template</title>

</head>

<body>


	<div align="center">
		<hr width="50%" color="purple">
		<h3>BOARD 게시판 전체 리스트</h3>
		<hr width="50%" color="purple">
	<% String memId = (String)session.getAttribute("login"); %>
			<c:set var="memId" value="<%=memId %>"></c:set>
		<h4><%=memId%> 님 환영합니다.</h4>
		<table border="1" width="800" cellspacing="0">

			<tr>

				<th>글번호</th>
				<th>주제</th>
				<th>글제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일자</th>
			</tr>
			<c:set var="list" value="${list }"></c:set>
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.getFreeNum() }</td>
						<td>${dto.getFreeSubject() }</td>
						<td><a href="freeCont?freeNum=${dto.getFreeNum()}">
								${dto.getFreeTitle() }</a></td>
						<td>${dto.getMemId() }</td>
						<td>${dto.getFreeHit() }</td>
						<td>${dto.getFreeCreatedDate().substring(0,16) }</td>
					</tr>
				</c:forEach>
			</c:if>


			<c:if test="${empty list }">
				<tr>
					<td colspan="6" align="center">
						<h3>검색된 레코드가 없습니다.</h3>
					</td>
				</tr>
			</c:if>

			<c:if test="${!empty memId}">
			<tr>
				<td colspan="6" align="right">
				<input type="button" value="글쓰기"
					onclick="location.href='freeWriteForm'"></td>
			</tr>
			</c:if>
			
			<c:if test="${empty memId}">
			<tr>
				<td colspan="6" align="right">
				<h5>로그인 후 글쓰기가 가능합니다.</h5>
			</tr>
			</c:if>
		</table>
		<br>

		<form method="post" action="/freeSearchList">
			<select name="freeSubject">
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
			<input type="submit" value="검색">
		</form>

	</div>
</body>
</html>