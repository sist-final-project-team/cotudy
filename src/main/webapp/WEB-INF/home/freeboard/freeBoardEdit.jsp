<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>COTUDY_COMMUNITY</title>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script>
		function dFile(i){
			var pId = "pId"+i;
			var put = "put"+i;
            document.getElementById(put).value="1";
			document.getElementById(pId).style.display="none";
            //document.getElementById(pId).remove();

		}
	</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include><br><br><br><br><br><br>
	<div align="center">
		<hr width="50%" color="purple">
			<h3>BOARD 테이블 게시글 수정 폼</h3>
		<hr width="50%" color="purple">
		
		<form method="post" action="/freeEdit" enctype="multipart/form-data">
			<c:set var="dto" value="${freeboard }"> </c:set>
			<c:if test="${!empty dto }">
		<input type="hidden" value="${dto.getFreeNum() }" name="freeNum">


		<table border="1" width="600" cellspacing="0">
				<tr>
					<th>글번호</th>
					<td>${dto.getFreeNum() }</td>
				</tr>
				<tr>
					<th>주제</th>
					<td>
						<select name="freeSubject">
							<option value="자유"  <c:if test=" ${dto.getFreeSubject()=='질문' }">selected</c:if> >자유</option>
							<option value="질문"  <c:if test=" ${dto.getFreeSubject()=='질문' }">selected</c:if> >질문</option>
							<option value="정보"  <c:if test="${dto.getFreeSubject()=='사담'}">selected</c:if> >정보</option>
							<option value="기타"  <c:if test="${dto.getFreeSubject()=='기타' }">selected</c:if> >기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${dto.getMemId() }</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td><input name="freeTitle" value="${dto.getFreeTitle() }">
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
					<td colspan="2" style="color:red" align="center">※파일은 10MB 이하의 jpg, png, gif 파일만 업로드 가능합니다.</td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td> <input type="file" id="files" name="files" multiple="multiple">
						<input type="hidden" name="put" value="">
						<input type="hidden" name="fileList1" value="">
						<input type="hidden" name="filePath" value="">
						<c:forEach items="${dto.fileList}" var="list">
							<c:set value="${status+1}" var="status"/>
							<p id ="pId${status}">
							${ list.getOriginalFileName()}
							<input type="hidden" id="put${status}" value="" name="put">
								<input type="hidden" value="${dto.getFileList().get(status-1).getIdx()}" name="fileList1">
								<input type="hidden" value="${dto.getFileList().get(status-1).getStoredFilePath()}" name="filePath">

							<input type="button" value="X" onclick = "dFile(${status})">
							</p>
					</c:forEach>

					</td>
				</tr>	
				<tr>
            <td colspan="6" align="center">
                <c:if test="${sessionScope.memId eq dto.getMemId()}">
                    <input type="submit" value="수정하기" >&nbsp;&nbsp;&nbsp;
                </c:if>
                <input type="button" value="목록" onclick="location.href='/freeList'">
            </td>
        </tr>
				</table>
			</c:if>
		</form>
	</div>

</body>
</html>

