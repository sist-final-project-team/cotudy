
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>코터디</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<p>login 페이지</p>
<form method="post" action="loginCheck">
    <input type="text" name="id"><br>
    <input type="password" name="pwd">
    <br>
    <input type="submit" value="로그인">
</form>
<jsp:include page="footer.jsp"></jsp:include>


</body>
</html>
