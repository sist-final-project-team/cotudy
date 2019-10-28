<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    // 현재 로그인된 사용자의 세션 정보를 만료시켜야 한다.
    session.invalidate(); // 모든 세션 속성을 만료시키는 메서드
%>
<html>
<head>
    <title>Insert title here</title>
</head>
<body>
<script>
    alert("로그아웃 되었습니다.");
    location.href="/";
</script>
</body>
</html>