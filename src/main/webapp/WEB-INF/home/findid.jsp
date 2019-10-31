
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>코터디</title>
    <script type="text/javascript">
        function pwd_find() {
            window.open("/findPwd", "비밀번호 찾기", "top=300, left=300, width=800, height=900, status=no, menubar=no, toolbar=no, resizable=no");
            window.close();
        }
    </script>
</head>
<body>
<div align="center">
    <hr width="50%" color="orange">
    <h3>아이디 찾기</h3>
    <hr width="50%" color="orange">
    <form method="post" action="<%=request.getContextPath()%>/findid_ok">
        <table border="1" width="300" cellspacing="0">
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
                    <input type="submit" value="아이디찾기">&nbsp;
                    <input type="button" value="비밀번호찾기" onclick="pwd_find()">
            </tr>
        </table>
    </form>
</div>
</body>
</html>
