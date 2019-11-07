
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>코터디</title>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script type="text/javascript">
        function goJoin() {
            window.opener.top.location.href="/join";
            self.close();
        }
        function check123() {
                if($.trim($("#id").val())===""){
                    alert("아이디를 입력하세요.");
                    $("#id").focus();
                    return false;
                }
                if($.trim($("#pwd").val())===""){
                    alert("비밀번호를 입력하세요.");
                    $("#pwd").focus();
                    return false;
                }
        }
        function pwd_find() {
            window.open("/findPwd", "비밀번호 찾기", "top=300, left=300, width=800, height=900, status=no, menubar=no, toolbar=no, resizable=no");
            self.close();
        }
        function id_find() {
            window.open("/findid", "아이디 찾기", "top=300, left=300, width=800, height=900, status=no, menubar=no, toolbar=no, resizable=no");
            self.close();
        }
    </script>
</head>
<body>
<div align="center">
    <hr width="50%" color="orange">
    <h3>회원 로그인 화면</h3>
    <hr width="50%" color="orange">
    
    <form method="post" action="<%=request.getContextPath()%>/login_ok" onsubmit="return check123()">
        <table border="1" width="300" cellspacing="0">
            <tr>
                <th>아이디</th>
                <td><input name = "id" id="id"></td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td><input type="password" name = "pwd" id="pwd"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="로그인">&nbsp;
                    <input type="button" value="회원가입" onclick="goJoin()" >
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="button" value="아이디찾기" onclick="id_find()">
                    <input type="button" value="비밀번호찾기" onclick="pwd_find()">
                </td>
            </tr>
        </table>
    </form>
           <a href="https://kauth.kakao.com/oauth/authorize?client_id=466c43b6799bd576421ad9edd9c3944c&redirect_uri=http://localhost:9000/callback&response_type=code">
            <img src="images/kakao_account_login_btn_medium_narrow.png">
        </a>
</div>
</body>
</html>
