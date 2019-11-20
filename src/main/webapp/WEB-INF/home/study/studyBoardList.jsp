<%@ page import="com.project.cotudy.model.StudyBoardDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>코터디</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <script src="../../../resources/lib/jquery/jquery.min.js"></script>
    <link rel="stylesheet" href="../../../resources/lib/bootstrap/css/bootstrap.css">

    <style type="text/css">
        .filter-list {
            display: inline-block;
            width: 230px;
            vertical-align: top;
        }
        .custom-checkbox {
            padding-bottom: 5px;
        }
        .filter-list-label {
            margin-left: 40px;
            font-size: 120%;
        }
    </style>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>

<div class="container" style="padding-top: 150px;">
    <form method="get" action="/studySearch" id="target">
        <div class="filter-list area">
            <p class="filter-list-label"><strong>지역</strong></p>
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" name="areas" id="seoul_gangnam"
                       value="seoul_gangnam">
                <label class="custom-control-label" for="seoul_gangnam">서울_강남</label>
            </div>
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" name="areas" id="seoul_sinchon"
                       value="seoul_sinchon">
                <label class="custom-control-label" for="seoul_sinchon">서울_신촌</label>
            </div>
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" name="areas" id="seoul_nowon"
                       value="seoul_nowon">
                <label class="custom-control-label" for="seoul_nowon">서울_노원</label>
            </div>
        </div>
        <div class="filter-list keyword">
            <p class="filter-list-label"><strong>키워드</strong></p>
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" name="keywords" id="Java"
                       value="Java">
                <label class="custom-control-label" for="Java">Java</label>
            </div>
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" name="keywords" id="python"
                       value="python">
                <label class="custom-control-label" for="python">python</label>
            </div>
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" name="keywords" id="C#"
                       value="C#">
                <label class="custom-control-label" for="C#">C#</label>
            </div>
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" name="keywords" id="JavaScript"
                       value="JavaScript">
                <label class="custom-control-label" for="JavaScript">JavaScript</label>
            </div>
        </div>
        <input type="submit" class="btn btn-primary" value="찾기">
    </form>
</div>
<div class="container">
    <c:if test="${!empty studyList}">
        <div class="row">
            <c:forEach var="studyBoard" items="${studyList}">
                <fmt:parseDate value="${studyBoard.getStudyStartDate() }" var="strPlanDate" pattern="yyyy-MM-dd"/>
                <fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
                <fmt:parseDate value="${studyBoard.getStudyEndDate() }" var="endPlanDate" pattern="yyyy-MM-dd"/>
                <fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
                <jsp:useBean id="now1" class="java.util.Date" />
                <fmt:formatDate value="${now1}" pattern="yyyy-MM-dd" var="today" />
                <fmt:parseNumber value="${now1.time / (1000*60*60*24)-1}" integerOnly="true" var="todayDate"></fmt:parseNumber>
                <c:set var="dateCal" value="${(todayDate-strDate+1)/(endDate-strDate+1)*100}"></c:set>

                <div class="col-sm-4" style="margin-bottom: 50px;">
                    <div class="card">
                        <img src="../resources/img/slide-3.jpg" height="180" width="180" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">${studyBoard.getStudyTitle()}</h5>
                            <p class="card-text">장소 : ${studyBoard.getStudyArea()}<br>키워드
                                : ${studyBoard.getStudyKeyword()}</p>
                            <c:choose>
                                <c:when test="${todayDate < strDate}">
                                    <div class="progress">
                                        <div class="progress-bar progress-bar progress-bar-striped progress-bar-animated " role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>
                                    </div>
                                </c:when>
                                <c:when test="${todayDate >= endDate}">
                                    <div class="progress">
                                        <div class="progress-bar progress-bar progress-bar-striped progress-bar-animated " role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">100%</div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="progress">
                                        <div class="progress-bar progress-bar progress-bar-striped progress-bar-animated " role="progressbar" style="width: <fmt:formatNumber value="${dateCal+(1-(dateCal%1))%1}" type="number" />%;" aria-valuenow="<fmt:formatNumber value="${dateCal+(1-(dateCal%1))%1}" type="number" />" aria-valuemin="0" aria-valuemax="100"> <fmt:formatNumber value="${dateCal+(1-(dateCal%1))%1}" type="number" />%</div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <br>
                            <a href="/studyCont?studyNum=${studyBoard.getStudyNum()}" class="btn btn-success">자세히 보기</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <c:if test="${empty studyList}">
        <p>데이터가 없습니다.</p>
    </c:if>
</div>
<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
