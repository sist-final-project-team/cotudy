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
		
		<form method="post" action="<%= request.getContextPath() %>/board_edit_ok.do">
			<c:set var="dto" value="${cont }"> </c:set>
			<c:if test="${!empty dto }">
		<!-- 글번호랑 db에담겨있는pwd 히든으로넘기기. -->
		<input type="hidden" value="${dto.getBoard_no() }" name="board_no">
		<input type="hidden" value="${dto.getBoard_pwd() }" name="db_pwd">
		<table border="1" width="400" cellspacing="0">
				<tr>
					<th>글번호</th>
					<td>${dto.getBoard_no() }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${dto.getBoard_writer() }</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td><input name="board_title" value="${dto.getBoard_title() }"></td>
				</tr>
				<tr>
					<th>글내용</th>
					<td><textarea rows="8" cols="30" name="board_cont">${dto.getBoard_cont()} </textarea></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="board_pwd" ></td>
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