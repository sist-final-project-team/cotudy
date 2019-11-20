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
		<hr width="50%" color="purple">
			<h3>회원정보 수정</h3>
		<hr width="50%" color="purple">
		
		<form method="post" action="/infoEdit" >
			<input type="hidden" name="memId" value="<%=memId%>">
		 
		<table border="1" width="400" cellspacing="0">
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
                    <input type="submit" value="수정하기">&nbsp;&nbsp;&nbsp;
                <input type="button" value="뒤로가기" onclick="location.href='/myPage'">
            </td>
        </tr>
				</table>
		</form>
	</div>		

</body>
</html>