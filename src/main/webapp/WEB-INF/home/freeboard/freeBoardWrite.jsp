<!DOCTYPE html>

<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
  <meta charset="utf-8">
  <title>EstateAgency Bootstrap Template</title>

</head>


<body>
<% String memId = (String)session.getAttribute("login"); %>


	<div align="center">
		<hr width="50%" color="purple">
			<h3><%=memId%>님 테이블 글쓰기 폼</h3>
		<hr width="50%" color="purple">
																					
		<form method="post" action="/freeWrite" >
		<input type="hidden" value="<%=memId %>" name="memId">
			<table border="1" width="400" cellspacing="0">
				<tr>
					<th>주제</th>
					<td>
						<select name="freeSubject">
							<option value="미선택" selected>주제선택</option>
							<option value="질문">질문</option>
							<option value="사담">사담</option>
							<option value="기타">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>글제목 </th>
					<td> <input name="freeTitle"> </td>
				</tr>
				<tr>
					<th>글내용</th>
					<td> <textarea rows="8" cols="30" name="freeCont" ></textarea> </td>
				</tr>				
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="글쓰기">&nbsp;&nbsp;&nbsp;
						<input type="reset" value="다시작성">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>