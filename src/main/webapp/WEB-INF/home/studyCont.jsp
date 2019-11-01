<%@ page import="com.project.cotudy.model.StudyBoardDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>코터디</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="container" style="padding-top: 120px;">
    검색 : <input type="text" id="filter"><button type="button" class="btn btn-secondary" onclick="search()"></button>
</div>
<div class="container">
    <c:set var="studyBoard" value="${studyCont}"></c:set>
    <c:if test="${!empty studyBoard}">
        <div>
            제목 : ${studyBoard.getStudyTitle()}<br>
            내용 : ${studyBoard.getStudyCont()}<br>
            지역 : ${studyBoard.getStudyArea()}<br>
        </div>
    </c:if>
    <c:if test="${empty studyBoard}">
        <p>데이터가 없습니다.</p>
    </c:if>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
