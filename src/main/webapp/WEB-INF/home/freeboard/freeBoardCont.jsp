<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>

	function deleteconfirm(memId)
	{
		console.log("삭제폼입성");
		var freeNum = document.getElementById("freeNum").value;
		var memId =memId;
		msg = "정말로 삭제하시겠습니까?";
		if (confirm(msg)!=0) {
			location.href = "/freeDelete?freeNum=" + freeNum+ "&memId="+memId;
			 // Yes click
		} else {
			// no click
	}
	} // deleteconfirm
	function show(i) {
		var watch = "reply"+i;
		var show = "modify"+i;
		if(document.getElementById(watch).style.display==="none"){
			document.getElementById(watch).style.display="";
			if(document.getElementById(show).style.display===""){
				document.getElementById(show).style.display="none";
			}
		}else{
			document.getElementById(watch).style.display="none";
		}
	}
	function modify(i) {
		var watch = "modify"+i;
		var show = "reply"+i;
		if(document.getElementById(watch).style.display==="none"){
			document.getElementById(watch).style.display="";
			if(document.getElementById(show).style.display===""){
				document.getElementById(show).style.display="none";
			}
		}else{
			document.getElementById(watch).style.display="none";

		}
	}
	function replyDeleteconfirm(i) {
        var watch = "freeReplyNum"+i;
        var watch2 = "replyStep"+i;
		var freeReplyNum = document.getElementById(watch).value;
		var freeNum = document.getElementById("freeNum").value;
		var replyStep = document.getElementById(watch2
		).value;
		msg = "정말로 삭제하시겠습니까?";
		if (confirm(msg)!=0) {
			location.href = "/freeReplyDelete?freeReplyNum=" + freeReplyNum+"&replyStep="+replyStep+"&freeNum="+freeNum;
			// Yes click
		} else {
			// no click
		}
	}


</script>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
	<% String memId = (String)session.getAttribute("memId"); %>
			<c:set var="memId" value="<%=memId %>"></c:set>
	<div align="center" class="container2">
		<hr width="50%" color="purple">
			<h3>BOARD 게시판 게시글 상세 내역</h3>
		<hr width="50%" color="purple">
		
		<table class="board_list">
	
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
                    	<c:if test="${ filecount >= 0}">
                    	<c:forEach var="i" begin="0" end="${filecount }">
							<c:set var="status" value="${status+1}"/>
                    	 <img alt="" width="400" height="300"
                           src="${fileDtolist.get(i).getStoredFilePath().substring(15) }">
                           <br>
                    	</c:forEach>
                    	</c:if>
                    </td> 
				</tr>			
				<tr>
					<th>조회수</th>
					<td>${dto.getFreeHit() }</td>
				</tr>
				<tr>
					<c:if test="${!empty dto.getFreeUpdatedDate()}">
					<th>작성일/수정일</th>
					<td>${dto.getFreeCreatedDate() }/${dto.getFreeUpdatedDate() }</td>
					</c:if>
					<c:if test="${empty dto.getFreeUpdatedDate()}">
					<th>작성일</th>
					<td>${dto.getFreeCreatedDate() }</td>
					</c:if>
				</tr>

				<tr>
					<th>첨부파일</th>
					<td>
					<c:forEach items="${dto.fileList}" var="list">
						<c:set var="status" value="${status+1}"/>
							<a href="/downloadBoardFile?freeNum=${list.freeNum}&idx=${list.idx}">
								${list.originalFileName } (${ (list.fileSize) }kb)
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
				
				 <c:if test="${sessionScope.memId eq dto.getMemId()}">
                    <input type="button" value="수정" onclick="location.href='/freeEditForm?freeNum=${dto.getFreeNum()}'">
		 			<input type="button" value="삭제" onclick="deleteconfirm('${dto.getMemId()}')">
                </c:if>
					<input type="button" value="전체목록" onclick="location.href='/freeList'">
				</td>
			</tr>
			
		</table>
		
    <table class="board_reply">
        <tr>
            	<th colspan="3">댓글 목록</th>
        </tr>
        <c:set var="list" value="${replyDto}"/>
		<c:set var="index" value="0"/>
        <c:if test="${!empty list}">
			 <tr>
				 <th>작성자</th>
				 <th>내용</th>
				 <th>작성일자</th>
			 </tr>
            <c:forEach items="${list}" var="reply">
				<c:set var="index" value="${index+1}"/>
				<c:set var="step" value="${reply.getReplyStep()}"/>
               <tr>
				   <td>${reply.getMemId()}</td>
				   <c:if test="${step != 0}">
				   <td>☞${reply.getReplyCont()}</td>
				   </c:if>
				   <c:if test="${step == 0}">
					   <td><a href = "#none" onclick="show(${index})">${reply.getReplyCont()}</a></td>
				   </c:if>
				   <td>${reply.getReplyCreatedDate()}
					   <c:if test="${sessionScope.memId eq reply.getMemId()}">
						   <input type="button" value="수정" onclick="modify(${index})">
						   <input type="button" value="삭제" onclick="replyDeleteconfirm(${index})">
					   </c:if>
				   </td>
				</tr>
				<form method="post"  action="<%=request.getContextPath()%>/reReply">
					<% if ((String)session.getAttribute("memId")==null){ %>
					<tr id = "reply${index}" style="display:none">
						<td colspan="2"><textarea cols="70" rows="5" style="resize: none" readonly>로그인 후 작성이 가능합니다.</textarea></td>
					</tr>
					<%} else{ %>
					<tr id = "reply${index}" style="display:none">
						<td colspan="2"><textarea cols="70" rows="5" style="resize: none" name="replyCont"></textarea></td>
						<td><input type="submit" value="댓글달기"></td>
					</tr>
					<% } %>
						<input type="hidden" name="memId" value="${sessionScope.memId}">
						<input type="hidden" name="freeNum" value="${reply.getFreeNum()}">
						<input type="hidden" name="freeReplyNum" value="${reply.getFreeReplyNum()}">
						<input type="hidden" name="replyStep" id="replyStep${index}" value="${reply.getReplyStep()}">
						<input type="hidden" name="replyIndent" value="${reply.getReplyIndent()}">
				</form>
				<form method="post" action="<%=request.getContextPath()%>/freeReplyModify">
					<tr id = "modify${index}" style="display:none">
						<td colspan="2"><textarea cols="70" rows="5" style="resize: none" name="replyCont">${reply.getReplyCont()}</textarea></td>
						<input type="hidden" name="freeReplyNum" id="freeReplyNum${index}" value="${reply.getFreeReplyNum()}">
						<input type="hidden" name="freeNum" value="${reply.getFreeNum()}">
						<td><input type="submit" value="수정하기"></td>
					</tr>
				</form>
            </c:forEach>
        </c:if>
    </table>
		 <form method="post" action="<%=request.getContextPath()%>/freeReplyWrite">
    <table class="board_reply">
        <% if ((String)session.getAttribute("memId")==null){ %>
        <tr>
            <td><textarea cols="70" rows="5" style="resize: none" readonly>로그인 후 작성이 가능합니다.</textarea></td>
        </tr>
        <%} else{ %>
       <tr>
		   <c:set var="freeNum" value="${freeNum}"/>
		   <input type="hidden" name="memId" value="${sessionScope.memId}">
		   <input type="hidden" name="freeNum" value="${freeNum}">
           <td><textarea cols="70" rows="5" style="resize: none" name="replyCont"></textarea></td>
           <td><input type="submit" value="댓글달기"></td>
       </tr>
        <% } %>
    </table>
    </form>


	
	</div>
	
</body>
</html>

