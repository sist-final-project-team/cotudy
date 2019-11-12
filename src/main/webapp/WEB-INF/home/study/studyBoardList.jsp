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
                <input type="checkbox" class="custom-control-input" name="keywords" id="c#"
                       value="c#">
                <label class="custom-control-label" for="c#">C#</label>
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
                <div class="col-sm-4" style="margin-bottom: 50px;">
                    <div class="card">
                        <img src="../resources/img/slide-3.jpg" height="180" width="180" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">${studyBoard.getStudyTitle()}</h5>
                            <p class="card-text">장소 : ${studyBoard.getStudyArea()}<br>키워드
                                : ${studyBoard.getStudyKeyword()}</p>
                            <a href="/studyCont?studyNum=${studyBoard.getStudyNum()}" class="btn btn-primary">자세히 보기</a>
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
