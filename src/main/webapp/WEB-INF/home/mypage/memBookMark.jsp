<%@ page import="com.project.cotudy.model.StudyBoardDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>COTUDY_MYPAGE</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	<meta content="" name="keywords">
	<meta content="" name="description">
	<script src="../../resources/lib/jquery/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
	<br><br><br><br><br><br><br>
<div class="container">
<h1 align="center">북마크</h1>
	<c:if test="${!empty list}">
		<div class="row">
			<c:forEach var="studyBoard" items="${list}">


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
							<h5 class="card-title"><c:out value="${studyBoard.getStudyTitle()}"/></h5>
							<p class="card-text">지역 : <c:out value="${studyBoard.getStudyArea()}"/><br>키워드
								: <c:out value="${studyBoard.getStudyKeyword()}"/></p>
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
	<c:if test="${empty list}">
		<p>데이터가 없습니다.</p>
	</c:if>
</div>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
