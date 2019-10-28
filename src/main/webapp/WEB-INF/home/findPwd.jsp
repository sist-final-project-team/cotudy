
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>코터디</title>
    <script type="text/javascript">
        function goJoin() {
            window.opener.top.location.href="/join";
            self.close();
        }
        function goMain() {
            window.opener.top.location.href="/";
            self.close();
        }

    </script>
</head>
<body>
<div align="center">
    <hr width="50%" color="orange">
    <h3>비밀번호 찾기</h3>
    <hr width="50%" color="orange">
    <form method="post" action="<%=request.getContextPath()%>/findPwd_ok">
        <table border="1" width="300" cellspacing="0">
            <tr>
                <th>아이디</th>
                <td><input name="memId" id="memId"></td>
            </tr>
            <tr>
                <th>이름</th>
                <td><input name = "memName" id="memName"></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><input name = "memEmail" id="memEmail"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="비밀번호찾기">&nbsp;
                    <input type="button" value="회원가입" onclick="goJoin()" >
                    <input type="button" value="취소" onclick="goMain()">
            </tr>
        </table>
    </form>
</div>
</body>
</html>
