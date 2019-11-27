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
	<br><br><br><br><br><br><br>
		
	<div align="center">

		
	<form method="post" action="/pwdEdit" >
		<table border="1" width="400" cellspacing="0">
			<img src="https://img.icons8.com/wired/64/000000/re-enter-pincode.png">
			<h1>비밀번호 변경</h1>
				<tr>
					<th>현재 비밀번호</th>
					<td><input name="nowpwd" type="password">
					</td>
				</tr>
				
				<tr>
					<th>변경할 비밀번호</th>
					<td><input name="editpwd" type="password" >
					</td>
				</tr>
						
				<tr>
            <td colspan="6" align="center">
                    <input type="submit" value="변경하기"class="btn btn-success">&nbsp;&nbsp;&nbsp;
                <input type="button" value="뒤로가기" onclick="location.href='/myPage'"class="btn btn-dark">
            </td>
        </tr>
				</table>
		</form>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>