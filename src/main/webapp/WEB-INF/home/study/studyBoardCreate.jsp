<!DOCTYPE html>

<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.getAttribute("memId"); %>

<script>

</script>


<head>
  <meta charset="utf-8">
  <title>EstateAgency Bootstrap Template</title>

</head>


<body>


<jsp:include page="../header.jsp"></jsp:include>
	<div class ="container2" align="center">
		<hr width="50%" color="purple">
			<h3>스터디 만들기 폼</h3>
		<hr width="50%" color="purple">
																					
		<form method="post" action="/freeWrite" enctype="multipart/form-data">
		<input type="hidden" value="<%=(String)session.getAttribute("memId") %>" name="memId">
			<table border="1" width="600" cellspacing="0">

				<tr>
					<th>제목 </th>
					<td> <input name="studyTitle"> </td>
				</tr>
				<tr>
					<th>내용</th>
					<td> <textarea rows="8" cols="30" name="studyCont" style="resize: none"></textarea> </td>
				</tr>
				
						
				<tr>
					<th rowspan="3">상세정보</th>
					<td> 시작일 <input type="date" name="studyStartDate"> &nbsp;&nbsp;
							종료일 <input type="date" name="studyEndDate">  </td>
				</tr>
				<tr>
					<td>지역 
						<select name="studyArea">						
							<option value="강원도" selected="selected">강원도</option>
							<option value="경기도">경기도</option>
							<option value="경상남도">경상남도</option>
							<option value="경상북도">경상북도</option>
							<option value="광주광역시">광주광역시</option>
							<option value="대구광역시">대구광역시</option>
							<option value="대전광역시">대전광역시</option>
							<option value="부산광역시">부산광역시</option>
							<option value="서울특별시">서울특별시</option>
							<option value="세종특별자치시">세종특별자치시</option>
							<option value="울산광역시">울산광역시</option>
							<option value="인천광역시">인천광역시</option>
							<option value="전라남도">전라남도</option>
							<option value="전라북도">전라북도</option>
							<option value="제주특별자치도">제주특별자치도</option>
							<option value="충청남도">충청남도</option>
							<option value="충청북도">충청북도</option>
						</select>
					</td>
				</tr>
				<tr>
 					<td> 키워드 
						  <input type='checkbox' name='studykeyword' value='Java' />Java
						  <input type='checkbox' name='studykeyword' value='C' />C
						  <input type='checkbox' name='studykeyword' value='Ruby' />Ruby
						  <input type='checkbox' name='studykeyword' value='Python' />Python
						  <input type='checkbox' name='studykeyword' value='Nodejs' />Nodejs
						  <input type='checkbox' name='studykeyword' value='PHP' />PHP
							<h6 style="color:red" align="center">※1~3개의 키워드를 선택해 주세요.</h6>
					</td> 
		
				</tr>
				<tr>
					<th>오픈채팅 링크 </th>
					<td> <textarea rows="4" cols="30" name="freeCont" style="resize: none"></textarea>  </td>
				</tr>										
				<tr>
					<th>파일첨부</th>
					<td> <input type="file" id="files" name="files" multiple="multiple"> </td>
				</tr>	
				<tr>
					<td colspan="2" style="color:red" align="center">※파일은 10MB 이하의 jpg, png, gif 파일만 업로드 가능합니다.</td>
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

<body>


