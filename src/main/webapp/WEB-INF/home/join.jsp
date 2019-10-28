<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cotudy: 회원가입</title>
    <link href="../resources/css/member.css" rel="stylesheet">
    <%-- jQuery 라이브러리 링크 --%>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>


    <%-- 회원 가입에 있어서 데이터를 검증하는 외부 자바스크립트 파일 링크 --%>
    <script type="text/javascript" src="/resources/js/member.js"></script>
    <script type="text/javascript">
        // 현재 웹문서가 브라우저로 로딩 될 때 문서의 본문을 읽고 현재의 제이쿼리 호출
        $(function () {
            // 회원가입 폼 중에서 아이디 중복 체크라는 버튼을 클릭했을떄
            $("#idcheck_btn").mouseover(function () {
                $("#idcheck").hide();
                var userId = $("#memId").val();
                console.log(userId);
                // 입력 길이 체크
                if ($.trim($("#memId").val()).length < 4) {
                    var warningTxt = '<span style="color: red; ">아이디는 4자 이상이어야 합니다.</span>';
                    $("#idcheck").text('');
                    $("#idcheck").show();
                    $("#idcheck").append(warningTxt);
                    $("#memId").val('').focus();
                    return false;
                };
                if ($.trim($("#memId").val()).length > 16) {
                    var warningTxt = '<span style="color: red; ">아이디는 16자 이하이어야 합니다.</span>';
                    $("#idcheck").text('');
                    $("#idcheck").show();
                    $("#idcheck").append(warningTxt);
                    $("#memId").val('').focus();
                    return false;
                };
                // 아이디 중복 여부 확인
                $.ajax({
                    type: "post", // 데이터 전송 방식
                    url: "/check", // 파일 주소와 경로
                    data: {"userId": userId},
                   // datatype: "jsp",   // 통신할 문서의 데이터 타입
                    success: function (res) {
                        console.log(res);
                        if (res === 1) {  // 아이디가 존재하는 경우(중복)
                            var warningTxt = '<span style="color: red; "/> 중복된 아이디입니다.</font>';
                            $("#idcheck").text('');
                            $("#idcheck").show();
                            $("#idcheck").append(warningTxt);
                            $("#memId").val('').focus();
                            return false;
                        } else {   // 아이디가 중복이 되지 않는 경우
                            var warningTxt = '<span style="color: blue;"/>사용가능한 아이디입니다.</font>';
                            $("#idcheck").text('');
                            $("#idcheck").show();
                            $("#idcheck").append(warningTxt);
                        }
                    },
                    error: function () { // 비동기 통신이 실패한 경우
                        alert("data error");
                    }
                });
                return false;
            });
        });
    </script>
</head>
<body>
<div align="center">
    <hr width="50%" color="violet">
    <h3>회원가입</h3>
    <hr width="50%" color="violet">
    <div id="join_wrap">
        <form name="f" method="post" action="<%=request.getContextPath()%>/join_ok" onsubmit="return mem_check()">
            <table id="join_t">
                <tr>
                    <th>아이디</th>
                    <td><input name="memId" id="memId">
                        <input type="button" value="중복체크" id="idcheck_btn">
                        <br>
                        <%-- 경고문이 출력되는 위치 --%>
                        <span id="idcheck"></span>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="password" name="memPwd" id="memPwd"></td>
                </tr>
                <tr>
                    <th>비밀번호확인</th>
                    <td><input type="password" name="memPwd1" id="memPwd1"></td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input name="memName" id="memName"></td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><input name="memEmail" id="memEmail"></td>
                </tr>
                <tr>
                    <th>거주지</th>
                    <td><input name="memArea" id="memArea"></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="가입하기">
                        <input type="reset" value="취소">
                        <input type="button" value="돌아가기" onclick="location.href='/'">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

</body>
</html>
