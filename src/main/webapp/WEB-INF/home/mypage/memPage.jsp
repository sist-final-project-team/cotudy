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
				<div class="well center-block" style="max-width: 400px;">
		<ul class="list-group">
  			<li class="list-group-item" style="font-weight:bold;" ><%=memId %></li>
  			<li class="list-group-item">
  				이름 : ${meminfodto.getMemName()}<br>
  				이메일 : ${meminfodto.getMemEmail()}<br>
  				${meminfodto.getMemSalt()}
  			</li>
		</ul><br><br>
		
			<button type="button"  class="btn btn-success btn-lg btn-block" onclick="location.href='/myWrite'">내가 쓴 글</button><br>
			<button type="button"  class="btn btn-success btn-lg btn-block" onclick="location.href='/myBookMark'">북마크</button><br>

			<c:if test= "${ !empty meminfodto.getMemSalt()}">
			<button type="button"  class="btn btn-success btn-lg btn-block" onclick="location.href='/infoEditForm'">회원정보 수정</button><br>
			<button type="button"  class="btn btn-success btn-lg btn-block" onclick="location.href='/pwdEditForm'">비밀번호 변경</button><br>
			</c:if>
			
			<button type="button"  class="btn btn-success btn-lg btn-block" onclick="location.href='/out'">회원 탈퇴</button><br>
		
		</div>
	</div>

</body>
</html>
