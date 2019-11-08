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
    <c:if test="${!empty studyList}">
        <div class="row">
        <c:forEach var="studyBoard" items="${studyList}">
                <div class="col-sm-4" style="margin-bottom: 50px;">
                    <div class="card">
                        <img src="../resources/img/slide-3.jpg" height="180" width="180" class="card-img-top">
                         <div class="card-body">
                            <h5 class="card-title">${studyBoard.getStudyTitle()}</h5>
                            <p class="card-text">장소 : ${studyBoard.getStudyArea()}<br>키워드
                                :   ${studyBoard.getStudyKeyword()}</p>
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
<jsp:include page="footer.jsp"></jsp:include>
<script src="../../resources/lib/jquery/jquery.min.js"></script>
<script type="text/javascript">
    /*
    $(function() {
        $('#filter').keyup(function(event) {
            var val = $(this).val();
            if (val == "") {
                $('.card').show();
            } else {
                $('.card').hide();
                $(".card:contains('" + val + "')").show();
            }
        });
    });
     */
    var search = function() {

    }
</script>


</body>
</html>
