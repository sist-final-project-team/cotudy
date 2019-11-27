<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<%String memId = (String)session.getAttribute("memId"); %>
    <title>COTUDY_MYPAGE</title>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<c:set var="meminfodto" value="${meminfodto }"> </c:set>
	<br><br><br><br><br><br><br>
		
	<div align="center">

		
		<form method="post" action="/infoEdit" >
			<input type="hidden" name="memId" value="<%=memId%>">
		 
		<table border="1" width="400" cellspacing="0">
			<img src="https://img.icons8.com/wired/64/000000/edit-user-female.png">
			<h1>회원정보 변경</h1>
				<tr>
					<th>ID</th>
					<td><%=memId %></td>
				</tr>

				<tr>
					<th>이름</th>
					<td><input name="memName" value="${meminfodto.getMemName()}">
					</td>
				</tr>
				
				<tr>
					<th>이메일</th>
					<td><input name="memEmail" value="${meminfodto.getMemEmail()}">
					</td>
				</tr>
						
				<tr>
            <td colspan="6" align="center">
                    <input type="submit" value="수정하기" class="btn btn-success">&nbsp;&nbsp;&nbsp;
                <input type="button" value="뒤로가기" onclick="location.href='/myPage'" class="btn btn-dark">
            </td>
        </tr>
				</table>
		</form>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>