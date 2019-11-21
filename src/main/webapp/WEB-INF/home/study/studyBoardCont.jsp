<%@ page import="com.project.cotudy.model.StudyBoardDto" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<html>
<head>
    <title>COTUDY_FIND_STUDY</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <c:set var="contBookmark" value="${contBookmark}"></c:set>
    <script>
        var studyReplyNum;
        var studyReplyStep;
        var studyReplyCont;
        var studyReplyIndent;
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
                            $("#bookMark").removeClass("btn btn-outline-info");
                            $("#bookMark").addClass("btn btn-success");


                        }else{
                            $("#bookMark").removeClass("btn btn-success");
                            $("#bookMark").addClass("btn btn-outline-info");
                            // document.getElementById("bookMark").style.backgroundColor = '#FFFFFF'; // 기본색상
                        }
                    },
                    error : function () {
                        alert("비동기화 실패");
                    }
                });
            }else{
                alert("로그인 후 이용 가능합니다.");
            }
        }
        function cont_check() {
            if ($.trim($("#studyReplyConta").val()) === "") {
                alert('댓글을 입력하세요');
                $("#studyReplyConta").focus();
                return false;
            }
            $.ajax({
                type: "post",
                url: "/studyCmt", // 파일 주소와 경로
                data: $("#replyform").serialize(),
                success: function (data) {
                    if(data==="success"){
                        getCommentList();
                        $("#studyReplyConta").val("");
                        alert("댓글 입력이 완료되었습니다.");
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
                        for(var i=0;i<data.length;i++){
                            html += "<tr><td>"+data[i].memId+"</td>";
                            if(data[i].studyReplyStep!==0){
                                html += "<td  style='text-align: left'>☞"+data[i].studyReplyCont+"</td>";
                            }else{
                                html += "<td style='text-align: left'><a href='#none' onclick='show("+i+")'>"+data[i].studyReplyCont+"</a></td>";
                            }
                            html += "<td>"+data[i].studyReplyCreatedTime;
                            if(id===data[i].memId){

                                 studyReplyNum = data[i].studyReplyNum;
                                 studyReplyStep = data[i].studyReplyStep;
                                 studyReplyIndent = data[i].studyReplyIndent;
                                html += "<input type='button' value='수정' onclick='replyModify("+i+")'>";
                                html += "<input type='button' value='삭제' onclick='replyDeleteconfirm("+i+")'>";

                            }
                            html += "</td></tr>";
                            html += "<tr id='modify"+i+"' style='display: none'>";
                            html += "<td colspan='2'><textarea cols='70' rows='5' style='text-align: left resize: none' name='studyReplyCont' id='modifyCont"+i+"'>"+data[i].studyReplyCont+"</textarea></td>";
                            html += "<input type='hidden' name='studyReplyNum' id='studyReplyNum"+i+"' value='"+studyReplyNum+"'>";
                            html += "<td><input type='button' value='수정하기' onclick='replyModifyOk("+i+")'></td>";
                            html += "</tr>";
                            if(id!=="null"){
                                html += "<form method='post' id='reReplyOk'>";
                                html += "<tr id='show"+i+"' style='display: none'>";
                                html += "<input type='hidden' name='studyReplyStep' value='"+studyReplyStep+"' id='studyReplyStep"+i+"'>";
                                html += "<input type='hidden' name='studyReplyIndent' value='"+studyReplyIndent+"' id='studyReplyIndent"+i+"'>";
                                html += "<input type='hidden' name='studyReplyNum' value='"+studyReplyNum+"' id='studyReplyNum"+i+"'>";
                                html += "<input type='hidden' name='memId' id='memId' value='"+id+"'>";
                                html += "<td colspan='2'><textarea cols='70' rows='5' style='resize: none' name='studyReplyCont' id='reReplyCont"+i+"'></textarea></td>";
                                html += "<td><input type='button' value='댓글달기' onclick='reReplyOk("+i+")'></td>";
                                html += "</tr>";
                            }
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
        function replyDeleteconfirm(i) {
            var studyNum = document.getElementById("studyNum").value;
            studyReplyNum = document.getElementById("studyReplyNum"+i).value;
            studyReplyStep = document.getElementById("studyReplyStep"+i).value;
            msg = "정말로 삭제하시겠습니까?";
            if (confirm(msg)!=0) {
                location.href = "/studyReplyDelete?studyReplyNum=" + studyReplyNum+"&studyReplyStep="+studyReplyStep+"&studyNum="+studyNum;
                // Yes click
            } else {
                // no click
            }
        }
        function replyModifyOk(i) {
            var studyReplyNum = document.getElementById("studyReplyNum"+i).value;
            studyReplyCont = $("#modifyCont"+i).val();
            console.log("studyReplyCont =>"+studyReplyCont);
            $.ajax({
                type: "post",
                url: "/studyReplyModify", // 파일 주소와 경로
                data:{"studyReplyNum":studyReplyNum,"studyReplyCont":studyReplyCont},
                success: function () {
                    getCommentList();
                },
                error:function () {
                    alert("error");
                }
            });
        }
        function replyModify(i) {
            var show = "modify"+i;
            if(document.getElementById(show).style.display==="none"){
                document.getElementById(show).style.display="";
            }else{
                document.getElementById(show).style.display="none";
            }
        }
        function show(i){
            var show = "show"+i;
            if(document.getElementById(show).style.display==="none"){
                document.getElementById(show).style.display="";
            }else{
                document.getElementById(show).style.display="none";
            }
        }
        function reReplyOk(i){
            memId = "<%=(String)session.getAttribute("memId")%>";
            studyNum = document.getElementById("studyNum").value;;
            studyReplyNum = document.getElementById("studyReplyNum"+i).value;
            studyReplyCont = $("#reReplyCont"+i).val();
            studyReplyStep =document.getElementById("studyReplyStep"+i).value;
            studyReplyIndent =document.getElementById("studyReplyIndent"+i).value;
            if ($.trim($("#reReplyCont"+i).val()) === "") {
                alert('댓글을 입력하세요');
                $("#studyReplyCont"+i).focus();
                return false;
            }
            $.ajax({
                type: "post",
                url: "/studyReCmt", // 파일 주소와 경로
                data: {"studyNum":studyNum,"memId":memId,"studyReplyNum":studyReplyNum,
                    "studyReplyCont":studyReplyCont,"studyReplyStep":studyReplyStep,"studyReplyIndent":studyReplyIndent},
                success: function (data) {
                    if(data==="success"){
                        getCommentList();
                        $("#studyReplyCont"+i).val("");
                        alert("댓글 입력이 완료되었습니다.");
                    }
                },
                error:function () {
                    alert("error");
                }
            })
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
        <input type="hidden" name="studyNum" value="${studyBoard.getStudyNum()}" id="studyNum">
        <div align="center">
            <table col="2" cellpadding="50" border="0">
                <tr>
                    <td colspan="2">
                        <p align="center" style="color: #533f03">${studyBoard.getStudyArea()}</p>
                        <p align="center">주제: <b>${studyBoard.getStudyKeyword()}</b></p>
                        <h1 align="center" style="padding-left: 200px;
                            padding-right: 200px;"><b>${studyBoard.getStudyTitle()}</b></h1>
                        <div align="left"  style="float: left; width: 30%;">
                            <span style="display: inline-block"><img src="https://img.icons8.com/material-sharp/24/000000/user.png">${studyBoard.getMemId()}</span>
                        </div>
<div align="right">


    <p><span><img src="https://img.icons8.com/metro/26/000000/date-to.png">  ${studyBoard.getStudyCreated()}</span></p>
</div>
                        <hr>
                    </td>
                </tr>
                <tr>
                    <th style="vertical-align: top; padding-left:10px;padding-right:10px" ><h4>스터디 소개</h4></th>
<%--                    <td><textarea  readonly cols="100"  placeholder="Type, paste, cut text here...">${studyBoard.getStudyCont()}</textarea></td>--%>
                 <td style="white-space:pre;">${studyBoard.getStudyCont()}</td>
<%--                    <td><pre>${studyBoard.getStudyCont()}</pre></td>--%>

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
                            <li>카카오 오픈챗 : <a href="${studyBoard.getStudyOpenchat()}">${studyBoard.getStudyOpenchat()}</a></li>
                        </ul>
                    </td>
                </tr>
            </table>

            <c:set var="memId" value="${studyBoard.getMemId()}"></c:set>
            <c:if test="${sessionScope.memId eq memId}">
                <input type="hidden" id="studyNum" value="${studyBoard.getStudyNum()}">
                <input type="button" class="btn btn-warning" id="studyEdit"  value="글 수정" onclick = "location.href = '/studyEditForm?studyNum=${studyBoard.getStudyNum()}'">
                <input type="button" class="btn btn-danger" id="studyEdit" onclick="deleteConfirm('${memId}')" value="글 삭제">
            </c:if>
            <c:if test="${contBookmark eq 1}">
                <input type="button" class="btn btn-success" id="bookMark" onclick="checkBookMark()" value="북마크">
            </c:if>
            <c:if test="${contBookmark eq 0}">
                <input type="button" class="btn btn-outline-info" id="bookMark" onclick="checkBookMark()" value="북마크">
            </c:if>


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
                        <td><textarea cols="70" rows="5" style="resize: none" name="studyReplyCont" id="studyReplyConta"></textarea></td>
                        <td><input type="button" value="댓글달기" onclick="return cont_check()"></td>
                    </tr>
                    <% } %>
                </table>

            </form>
        </div>
    </c:if>
    <c:if test="${empty studyBoard}">s
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
<!--삭제 스크립트 -->
<script>
    function deleteConfirm(memId) {
        console.log("삭제폼입성");
        var studyNum = document.getElementById("studyNum").value;
        var memId = memId;
        msg = "정말로 삭제하시겠습니까?";
        if (confirm(msg) != 0) {
            location.href = "/studyDelete?studyNum=" + studyNum + "&memId=" + memId;
            // Yes click
        } else {
            // no click
        }
    }
</script>
</body>
</html>
