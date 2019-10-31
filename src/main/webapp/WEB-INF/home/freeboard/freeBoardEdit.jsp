<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		<table border="1" width="400" cellspacing="0">
				<tr>
					<th>글번호</th>
					<td>${dto.getFreeNum() }</td>
				</tr>
				<tr>
					<th>주제</th>
					<td>
						<select name="freeSubject">
							<option value="질문"  <c:if test=" ${dto.getFreeSubject()=='질문' }">selected</c:if> >질문</option>
							<option value="사담"  <c:if test="${dto.getFreeSubject()=='사담'}">selected</c:if> >사담</option>
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
					<th>파일첨부</th>
					
					
					
					<td> <input type="file" id="files" name="files" multiple="multiple" >
 						<%  
							List<Integer> delList = new ArrayList<Integer>();
							delList = null;
							
						%> 
						<c:forEach items="${dto.fileList}" var="list"> 
							${ list.getOriginalFileName()} 
							<input type="button" value="X" onclick = "delList.add(${ list.getIdx()} );" name="${ list.getIdx()} " >
							<%--  <% System.out.println(delList.get(0)); %> --%>
							
		<!-- List<Integer> delList = new ArrayList<Integer>();
		delList.add(4);
		delList.add(433);
		delList.add(12);
		System.out.println(delList.get(0));
		System.out.println(delList.get(1));
		System.out.println(delList.get(2)); -->
							<br>
					</c:forEach>
					</td> 
					
					
					
				</tr>	
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
			</c:if>
		</form>
	</div>

</body>
</html>

