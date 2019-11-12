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
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script>
        function checkBookMark() {
            var id = "<%=(String)session.getAttribute("memId")%>";
            console.log(id);
            var studyNum = document.getElementById("studyNum").value;
            if (id.valueOf()!='null'){
                $.ajax({
                    type: "post", // 데이터 전송 방식
                    url: "/bookmark", // 파일 주소와 경로
                    data: {"id": id ,"studyNum":studyNum},
                    success : function (res) {
                        console.log(res);
                        if(res === 1){
                            document.getElementById("bookMark").style.backgroundColor = 'aqua'; // 즐찾했을떄 색상
                        }else{
                            document.getElementById("bookMark").style.backgroundColor = '#FFFFFF'; // 기본색상
                        }
                    },
                    error : function () {
                        alert("비동기화 실패");
                    }
                });
            }else{
                alert("로그인 먼저 하세요");
            }
        }
    </script>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>

<div class="container" style="padding-top: 120px;">

</div>
<div class="container">
    <c:set var="studyBoard" value="${studyCont}"></c:set>
    <c:if test="${!empty studyBoard}">
        <div align="center">
            <table border="1">
                <tr>
                    <input type="hidden" name="studyNum" value="${studyBoard.getStudyNum()}" id="studyNum">
                    <td><h1>${studyBoard.getStudyTitle()}</h1></td>

                </tr>
                <tr>
                    <td> <textarea  readonly  rows="28" cols="100" name="freeCont" style="resize: none">${studyBoard.getStudyCont()}</textarea></td>
                </tr>
            </table>

            내용 : ${studyBoard.getStudyCont()}<br>
            지역 : ${studyBoard.getStudyArea()}<br>
            <input type="button" id="bookMark" onclick="checkBookMark()" value="북마크" >
        </div>
    </c:if>
    <c:if test="${empty studyBoard}">
        <p>데이터가 없습니다.</p>
    </c:if>
</div>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
