<!DOCTYPE html>

<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.getAttribute("memId"); %>

<head>
    <meta charset="utf-8">
    <title>EstateAgency Bootstrap Template</title>
    <link rel="stylesheet"
          href="http://code.jquery.com/ui/1.10.4/themes/redmond/jquery-ui.min.css" />
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<div class ="container2" align="center">
    <hr width="50%" color="purple">
    <h3>테이블 글쓰기 폼</h3>
    <hr width="50%" color="purple">

    <form method="post" action="/studyCreateOk" >
        <input type="hidden" value="<%=(String)session.getAttribute("memId") %>" name="memId">
        <table border="1" width="600" cellspacing="0">

            <tr>
                <th>글제목 </th>
                <td> <input name="studyTitle"> </td>
            </tr>
            <tr>
                <th>글내용</th>
                <td> <textarea rows="8" cols="30" name="studyCont" style="resize: none"></textarea> </td>
            </tr>

            <tr>
                <th>날짜선택</th>
                <td> <input type="text" class="date1" name="studyStartDate" placeholder="시작날짜 선택" autocomplete="off">
                    <input type="text" class="date2"  name="studyEndDate" placeholder="종료날짜 선택" autocomplete="off"></td>
            </tr>

            <tr><th>지역</th>
                <td>
                <select name="studyArea">
                    <option value="">지역선택</option>
                    <option value="강남">강남</option>
                    <option value="신촌">신촌</option>
                    <option value="홍대">홍대</option>
                    <option value="부평">부평</option>
                    <option value="수원">수원</option>
                    <option value="제주">제주</option>
                </select></td>
            </tr>
            <tr>
                <th>키워드</th>
                <td> <input name="studyKeyword1" size="10">
                <input type="button" onclick="button1_click()" value="키워드 추가">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="글쓰기">&nbsp;&nbsp;&nbsp;
                    <input type="reset" value="다시작성">
                </td>
            </tr>
        </table>
    </form>
</div>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/i18n/jquery-ui-i18n.min.js"></script>
<script>
    $(function() {
        $.datepicker.setDefaults($.datepicker.regional['ko']);
        $('.date1').datepicker({
            minDate: 0,
            onClose:function (selectedDate) {
                $('.date2').datepicker("option","minDate",selectedDate);
            }
        });
        $('.date2').datepicker({
        });
    });
</script>
<script>
    function button1_click() {
        alert("키워드 추가 어떻게해요");
    }
</script>
</body>

<body>


