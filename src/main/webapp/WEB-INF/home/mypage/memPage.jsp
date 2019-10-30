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
<title>코터디-마이페이지</title>
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
  				거주지 : ${meminfodto.getMemArea()}
  			</li>
		</ul><br><br><br>
		
			<button type="button"  class="btn btn-success btn-lg btn-block" onclick="location.href='/myWrite'">내가 쓴 글</button><br><br>
			<button type="button"  class="btn btn-success btn-lg btn-block" onclick="location.href='/bookMark'">북마크</button><br><br>
			<button type="button"  class="btn btn-success btn-lg btn-block" onclick="location.href='/infoEdit'">회원정보 수정</button><br><br>
			<button type="button"  class="btn btn-success btn-lg btn-block" onclick="location.href='/out'">회원 탈퇴</button><br><br>
		
		</div>
	</div>
<%-- 
<div class="col-md-4">
          <div class="card-box-d">
            <div class="card-img-d">
              <img src="../resources/img/agent-4.jpg" alt="" class="img-d img-fluid">
            </div>
            <div class="card-overlay card-overlay-hover">
              <div class="card-header-d">
                <div class="card-title-d align-self-center">
                  <div class="title-d">
                  	<div align="center"><br>
                      <h2 class="link-two">ID : <%=memId %> </h2>
                      <h4 class="link-two">이름 : ${meminfodto.getMemName()} </h4>
                      <h4 class="link-two">이메일 : ${meminfodto.getMemEmail()} </h4>
                      <h4 class="link-two">지역 : ${meminfodto.getMemArea()} </h4>
                  	</div>
                  </div>
                </div>
              </div>
             </div></div></div>
 --%>
</body>
</html>
