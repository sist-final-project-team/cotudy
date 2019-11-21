<!DOCTYPE html>

<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.getAttribute("memId"); %>

<head>
  <meta charset="utf-8">
    <title>COTUDY_COMMUNITY</title>
</head>


<body>


<jsp:include page="../header.jsp"></jsp:include>
	<div class ="container2" align="center">
																					
		<form method="post" action="/freeWrite" enctype="multipart/form-data">
		<input type="hidden" value="<%=(String)session.getAttribute("memId") %>" name="memId">
			<table border="1" width="600" cellspacing="0">
				<tr>
					<th>주제</th>
					<td>
						<select name="freeSubject">
							<option value="기타" selected>주제선택</option>
							<option value="자유">자유</option>
							<option value="질문">질문</option>
							<option value="정보">정보</option>
							<option value="기타">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>글제목 </th>
					<td> <input name="freeTitle"  required="required"> </td>
				</tr>
				<tr>
					<th>글내용</th>
					<td> <textarea rows="8" cols="30" name="freeCont" style="resize: none"  required="required"></textarea> </td>
				</tr>		
				<tr>
					<th>파일첨부</th>
					<td> <input type="file" id="files" name="files" multiple="multiple" > </td>
				</tr>
				<tr>
					<td colspan="2" style="color:red" align="center">※파일은 10MB 이하의 jpg, png, gif 파일만 업로드 가능합니다.</td>
				</tr>											
				<tr>
					<td colspan="2" align="center">
						<input type="submit" class="btn btn-success" value="글쓰기">&nbsp;&nbsp;&nbsp;
						<input type="reset" class="btn btn-dark" value="다시작성">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>

<body>


