<%@ page import="com.project.cotudy.model.StudyBoardDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
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
        function cont_check() {
            if ($.trim($("#studyReplyCont1").val()) === "") {
                alert('댓글을 입력하세요');
                $("#studyReplyCont1").focus();
                return false;
            }
            $.ajax({
                type: "post",
                url: "/studyCmt", // 파일 주소와 경로
                data: $("#replyform").serialize(),
                success: function (data) {
                    if(data==="success"){
                        getCommentList();
                        $("#studyReplyCont1").val("");
                        alert("댓글입력완료");
                    }
                },
                error:function () {
                    alert("error");
                }
            })
        }
        function getCommentList(){
            var studyNum = document.getElementById("studyNum").value;
            console.log("studyNum->"+studyNum);
            $.ajax({
                type: "post",
                url: "/studyReplyList", // 파일 주소와 경로
                data: {"studyNum":studyNum},
                success: function (data) {
                    console.log(data);
                    var html = "  <tr>\n" +
                        "<th colspan=\"3\">댓글 목록</th>\n" +
                        "</tr>\n" +
                        " <tr>\n" +
                        " <th>작성자</th>\n" +
                        " <th>내용</th>\n" +
                        " <th>작성일자</th>\n" +
                        " </tr>";
                    var id = "<%=(String)session.getAttribute("memId")%>";
                    if(data.length>0){
                        for(i=0;i<data.length;i++){
                            html += "<tr><td>"+data[i].memId+"</td>";
                            html += "<td>"+data[i].studyReplyCont+"</td>";
                            html += "<td>"+data[i].studyReplyCreatedTime;
                            if(id===data[i].memId){
                                html += "<input type='button' value='수정'>";
                                html += "<input type='submit' value='삭제' >"
                            }
                            html += "</td></tr>"
                        }
                        $("#commentList").html(html);
                    }else{
                    }
                    },
                error:function () {
                    alert("error");
                }
            })
        }
        $(function(){
            getCommentList();
        });
    </script>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<div class="container" style="padding-top: 120px;">
</div>
<div class="container">
    <c:set var="studyBoard" value="${studyCont}"></c:set>
    <c:if test="${!empty studyBoard}">
        <input type="hidden" name="studyNum" value="${studyBoard.getStudyNum()}" id="studyNum">
        <div align="center">
            <table col="2" cellpadding="50" border="0">
                <tr>
                    <td colspan="2">
                        <p align="center" style="color: #533f03">${studyBoard.getStudyArea()}</p>
                        <p align="center">주제: <b>${studyBoard.getStudyKeyword()}</b></p>
                        <h1 align="center" style="padding-left: 200px;
                            padding-right: 200px;"
                        ><b>${studyBoard.getStudyTitle()}</b></h1>
                        <hr>
                    </td>
                </tr>
                <tr>
                    <th style="vertical-align: top; padding-left:10px;padding-right:10px" ><h4>스터디 소개</h4></th>
                    <td><textarea  readonly cols="100"  placeholder="Type, paste, cut text here...">${studyBoard.getStudyCont()}</textarea></td>

                </tr>
                <tr>
                    <td colspan="2"> <hr></td>
                </tr>
                <tr>
                    <th style="vertical-align: top; padding-left:10px;padding-right:10px" ><h4>상세 정보</h4></th>
                    <td>
                        <ul>
                            <li>지역 : ${studyBoard.getStudyArea()}</li>
                            <li>주제 : ${studyBoard.getStudyKeyword()}</li>
                            <li>시작일 : ${studyBoard.getStudyStartDate()}</li>
                            <li>종료일 : ${studyBoard.getStudyEndDate()}</li>
                        </ul>
                    </td>
                </tr>
            </table>
            <input type="button" id="bookMark" onclick="checkBookMark()" value="북마크">
            <table class="board_reply" id="commentList">

            </table>
            <form method="post"  id="replyform">
                <table class="board_reply">
                    <% if ((String)session.getAttribute("memId")==null){ %>
                    <tr>
                        <td><textarea cols="70" rows="5" style="resize: none" readonly>로그인 후 작성이 가능합니다.</textarea></td>
                    </tr>
                    <%} else{ %>
                    <tr>
                        <input type="hidden" name="memId" value="${sessionScope.memId}">
                        <input type="hidden" name="studyNum" value="${studyBoard.getStudyNum()}">
                        <td><textarea cols="70" rows="5" style="resize: none" name="studyReplyCont" id="studyReplyCont1"></textarea></td>
                        <td><input type="button" value="댓글달기" onclick="return cont_check();"></td>
                    </tr>
                    <% } %>
                </table>

            </form>
        </div>
    </c:if>
    <c:if test="${empty studyBoard}">
        <p>데이터가 없습니다.</p>
    </c:if>
</div>
<jsp:include page="../footer.jsp"></jsp:include>

<!--textarea 스크롤 자동 늘리기 -->
<script>
    $('textarea').each(function () {
        this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;'+'border : none;'+'resize:none;');
    }).on('input', function () {
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
    });
</script>
</body>
</html>
