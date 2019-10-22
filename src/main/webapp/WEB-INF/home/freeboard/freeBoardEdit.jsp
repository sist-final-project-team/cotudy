<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div align="center">
		<hr width="50%" color="purple">
			<h3>BOARD 테이블 게시글 수정 폼</h3>
		<hr width="50%" color="purple">
		
		<form method="post" action="/freeEdit">
			<c:set var="dto" value="${freeboard }"> </c:set>
			<c:if test="${!empty dto }">
		<input type="hidden" value="${dto.getFreeNum() }" name="freeNum">
		<table border="1" width="400" cellspacing="0">
				<tr>
					<th>글번호</th>
					<td>${dto.getFreeNum() }</td>
				</tr>
				<tr>
					<th>주제</th>
					<td>
					<input name="freeSubject" value=${dto.getFreeSubject() } >
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${dto.getMemId() }</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td><input name="freeTitle" value=${dto.getFreeTitle() }>
					</td>
				</tr>
				<tr>
					<th>글내용</th>
					<td><textarea rows="8" cols="30" name="freeCont">${dto.getFreeCont()} </textarea></td>
				</tr>			
				<tr>
					<th>조회수</th>
					<td>${dto.getFreeHit() }</td>
				</tr>
				<tr>
					<th>작성일</th>
					<td>${dto.getFreeCreatedDate() }</td>
				</tr>
				
				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="수정하기" >&nbsp;&nbsp;&nbsp;
						<input type="reset" value="다시작성" >
					</td>
				</tr>
				</table>
			</c:if>
		</form>
	</div>

</body>
</html>