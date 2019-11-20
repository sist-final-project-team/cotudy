<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>COTUDY_ERROR</title>
<link href="../resources/css/error.css" rel="stylesheet">
  <link href="../resource/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<h1>ERROR!</h1>
<!-- 예외 메시지 출력 -->
<h3>아래는 에러 내용입니다.</h3>
<h4 style="color: red;">사이트 이용 중 에러가 발생했을 시, 에러가 발생하게 된 경위와 아래 내용을 복사하여 cotudy325@gmail.com 으로 보내주시길 바랍니다.</h4>
<h4>${exception.getMessage()}</h4>
	
<ul>
	<!-- 예외발생 당시의 호출스택(Call Stack)에 있었던 메서드의 정보와 예외 메시지를 화면에 출력 -->
	<c:forEach items="${exception.getStackTrace()}" var="stack">
		<li>${stack.toString()}</li>
	</c:forEach>
</ul>	
	
</body>
</html>
