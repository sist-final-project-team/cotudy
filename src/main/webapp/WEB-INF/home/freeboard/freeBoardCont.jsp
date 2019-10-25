<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function deleteconfirm()
{
	var freeNum = document.getElementById("freeNum").value;
    msg = "정말로 삭제하시겠습니까?";
    if (confirm(msg)!=0) {
        location.href = "/freeDelete?freeNum=" + freeNum;
         // Yes click
        
        
    } else {
        // no click
}
} // deleteconfirm

</script>
</head>
<body>
	<% String memId = (String)session.getAttribute("login"); %>
			<c:set var="memId" value="<%=memId %>"></c:set>
	<div align="center">
		<hr width="50%" color="purple">
			<h3>BOARD 게시판 게시글 상세 내역</h3>
		<hr width="50%" color="purple">
		
		<table border="1" width="800" cellspacing="0">
	
			<c:set var="dto" value="${freeboard }"> </c:set>
			<c:set var="fileDtolist" value="${fileDtolist }"> </c:set>
			<c:set var="filecount" value="${filecount }"> </c:set>
			<c:if test="${!empty dto }">
				<input type="hidden" value="${dto.getFreeNum() }" id="freeNum">
	
				<tr>
					<th>글번호</th>
					<td>${dto.getFreeNum() }</td>
				</tr>
				<tr>
					<th>주제</th>
					<td>${dto.getFreeSubject()}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${dto.getMemId() }</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td>${dto.getFreeTitle() }</td>
				</tr>
				<tr>
					<th>글내용</th>
                    <td>${dto.getFreeCont()}
                    	<br>
                    	
                    	<c:forEach var="i" begin="0" end="${filecount }">
                    	 <img alt="" width="400" height="300"
                           src="${fileDtolist.get(i).getStoredFilePath().substring(15) }"> 
                           <br>
                    	</c:forEach>
                    </td> 
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
					<th>최종수정일</th>
					<td>
						${dto.getFreeUpdatedDate() }
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
						<td>
					<c:forEach items="${dto.fileList}" var="list"> 
							<a href="/downloadBoardFile?freeNum=${list.freeNum}&idx=${list.idx}" >
								${list.originalFileName } (${ list.fileSize }kb)
							</a>
							<br>
					</c:forEach>
						</td>
				</tr>
				
			</c:if>
			
			
			
			<c:if test="${empty dto}">
				<tr>
					<td colspan="2" align="center">
						<h3>검색된 레코드가 없습니다.</h3>
					</td>
				</tr>
			</c:if>
			
			<tr>
				
				<td colspan="2" align="center">
			<c:if test="${!empty memId}">	
					<input type="button" value="수정" onclick="location.href='/freeEditForm?freeNum=${dto.getFreeNum()}'">
		 			<input type="button" value="삭제" onclick="deleteconfirm()"> 
			</c:if>
		 	
					<input type="button" value="전체목록" onclick="location.href='/freeList'">
				</td>
			</tr>
			
		</table>
	
	</div>
	
</body>
</html>