<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>코터디-내가쓴글</title>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<br><br><br><br><br><br><br>

<div align="center">
    <h2>통합게시판</h2>
    <table border="1">
        <tr>
            <th>글번호</th>
            <th>주제</th>
            <th>제목</th>
            <th>아이디</th>
            <th>작성일자</th>
        </tr>
        <c:set var="free" value="${freeList}"/>
        <c:if test="${!empty free}">
            <c:forEach items="${free}" var="freeboardDto">
                <tr>
                    <td>${freeboardDto.getFreeNum()}</td>
                    <td>${freeboardDto.getFreeSubject()}</td>
                    <td><a href="/freeCont?freeNum=${freeboardDto.getFreeNum()}"> <b>${freeboardDto.getFreeTitle()}</b></a>
                    </td>
                    <td>${freeboardDto.getMemId()}</td>
                    <td>${freeboardDto.getFreeCreatedDate()}</td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty free}">
            <h2>내가쓴글이엄서요</h2>
        </c:if>
    </table>
</div>
<hr>

<div align="center">
    <h2>등록한 스터디</h2>
        <c:set var="studyList" value="${studyList}"/>
        <div class="container">
            <c:if test="${!empty studyList}">
                <div class="row">
                    <c:forEach items="${studyList}" var="studyList">
                        <%--                    <c:forEach var="studyBoard" items="${list}">--%>
                        <fmt:parseDate value="${studyList.getStudyStartDate() }" var="strPlanDate" pattern="yyyy-MM-dd"/>
                        <fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
                        <fmt:parseDate value="${studyList.getStudyEndDate() }" var="endPlanDate" pattern="yyyy-MM-dd"/>
                        <fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
                        <fmt:parseDate value="${now}" var="today" pattern="yyyy-MM-dd " />
                        <fmt:parseNumber value="${today.time / (1000*60*60*24)}" integerOnly="true" var="todayDate"></fmt:parseNumber>
                        <c:set var="dateCal" value="${(todayDate-strDate+18217)/(endDate-strDate)*100}"></c:set>


                        <div class="col-sm-4" style="margin-bottom: 50px;">
                            <div class="card">
                                <img src="../resources/img/slide-3.jpg" height="180" width="180" class="card-img-top">
                                <div class="card-body">
                                    <h5 class="card-title">${studyList.getStudyTitle()}</h5>
                                    <p class="card-text">장소 : ${studyList.getStudyArea()}<br>키워드
                                        : ${studyList.getStudyKeyword()}<br>
                                        일수:${endDate - strDate }; <br>
                                        종료날짜:${endDate-18217}
                                        시작날짜:${strDate-18217}
                                        현재날짜:${todayDate}

                                    </p>

<%--                                    <c:if test="${todayDate < strDate-18217}">--%>
<%--                                        <h3>이거는 0퍼센트</h3>--%>
<%--                                        <div class="progress">--%>
<%--                                            <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>--%>
<%--                                        </div>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${todayDate >= endDate-18217}">--%>
<%--                                        <h3>이거는 100퍼센트</h3>--%>
<%--                                    <div class="progress">--%>
<%--                                        <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>--%>
<%--                                    </div>--%>
<%--                                    </c:if>--%>
<%--                                    <c:if test="${!(todayDate >= endDate-18217)||(todayDate < strDate-18217)}">--%>
<%--                                        <h3>  ${todayDate-strDate+18217}/${endDate-strDate}*100</h3>--%>
<%--                                        <div class="progress">--%>

<%--                                            <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"> ${todayDate-strDate+18217}/${endDate-strDate}*100%</div>--%>
<%--                                        </div>--%>
<%--                                    </c:if>--%>

                                    <c:choose>
                                        <c:when test="${todayDate < strDate-18217}">
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>
                                    </div>
                                        </c:when>
                                        <c:when test="${todayDate >= endDate-18217}">
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
                                    </div>
                                        </c:when>
                                        <c:otherwise>
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" style="width: <fmt:formatNumber value="${dateCal+(1-(dateCal%1))%1}" type="number" />%;" aria-valuenow="<fmt:formatNumber value="${dateCal+(1-(dateCal%1))%1}" type="number" />" aria-valuemin="0" aria-valuemax="100"> <fmt:formatNumber value="${dateCal+(1-(dateCal%1))%1}" type="number" />%</div>
                                    </div>
                                        </c:otherwise>

                                    </c:choose>
                                    <br>
                                    <a href="/studyCont?studyNum=${studyList.getStudyNum()}" class="btn btn-primary">자세히
                                        보기</a>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
        <c:if test="${empty studyList}">
            <h2>내가쓴글이엄서요</h2>
        </c:if>
</div>
</script>
<script type="text/javascript">
    function percent() {
        var today = new Date();
        var startDate = document.getElementById("studyStartDate").value;
        var endDate = document.getElementById("studyEndDate").value;

        var dateArray = dateString.split("-");
        var dateObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);
        var betweenDay = (today - dateObj)/1000/60/60/24;
        var bd = Math.ceil(betweenDay);
        alert(bd);
    }
</script>
<script>
    window.onload= function () {
        var today = new Date();
        SimpleDateFormat
        var dateArray = dateString.split("-");
        var dateObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);
        var betweenDay = (today - dateObj)/1000/60/60/24;
        <c:forEach items="${studyList}" var="studyList">
<%--        <c:if test="${studyList.getStudyEndDate()-studyList.getStudyStartDate()}>0">--%>
        console.log("에베베벱베베베베베벱");


        </c:forEach>
    }


</script>

</body>
</html>