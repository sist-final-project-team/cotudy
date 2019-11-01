
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<html>--%>
<%--<head>--%>
<%--    <title>코터디</title>--%>
<%--    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>--%>
<%--    <script type="text/javascript">--%>
<%--        function goJoin() {--%>
<%--            window.opener.top.location.href="/join";--%>
<%--            self.close();--%>
<%--        }--%>
<%--        function check123() {--%>
<%--                if($.trim($("#id").val())===""){--%>
<%--                    alert("아이디를 입력하세요.");--%>
<%--                    $("#id").focus();--%>
<%--                    return false;--%>
<%--                }--%>
<%--                if($.trim($("#pwd").val())===""){--%>
<%--                    alert("비밀번호를 입력하세요.");--%>
<%--                    $("#pwd").focus();--%>
<%--                    return false;--%>
<%--                }--%>
<%--        }--%>
<%--        function pwd_find() {--%>
<%--            window.open("/findPwd", "비밀번호 찾기", "top=300, left=300, width=800, height=900, status=no, menubar=no, toolbar=no, resizable=no");--%>
<%--            self.close();--%>
<%--        }--%>
<%--        function id_find() {--%>
<%--            window.open("/findid", "아이디 찾기", "top=300, left=300, width=800, height=900, status=no, menubar=no, toolbar=no, resizable=no");--%>
<%--            self.close();--%>
<%--        }--%>
<%--    </script>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div align="center">--%>
<%--    <hr width="50%" color="orange">--%>
<%--    <h3>회원 로그인 화면</h3>--%>
<%--    <hr width="50%" color="orange">--%>
<%--    <form method="post" action="<%=request.getContextPath()%>/login_ok" onsubmit="return check123()">--%>
<%--        <table border="1" width="300" cellspacing="0">--%>
<%--            <tr>--%>
<%--                <th>아이디</th>--%>
<%--                <td><input name = "id" id="id"></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <th>비밀번호</th>--%>
<%--                <td><input type="password" name = "pwd" id="pwd"></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="2" align="center">--%>
<%--                    <input type="submit" value="로그인">&nbsp;--%>
<%--                    <input type="button" value="회원가입" onclick="goJoin()" >--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="2" align="center">--%>
<%--                    <input type="button" value="아이디찾기" onclick="id_find()">--%>
<%--                    <input type="button" value="비밀번호찾기" onclick="pwd_find()">--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--    </form>--%>
<%--</div>--%>
<%--</body>--%>
<%--</html>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap Simple Login Form</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        .login-form {
            width: 340px;
            margin: 50px auto;
        }
        .login-form form {
            margin-bottom: 15px;
            background: #f7f7f7;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            padding: 30px;
        }
        .login-form h2 {
            margin: 0 0 15px;
        }
        .form-control, .btn {
            min-height: 38px;
            border-radius: 2px;
        }
        .btn {
            font-size: 15px;
            font-weight: bold;
        }
    </style>
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

        function id_find() {
            window.open("/findid", "아이디 찾기", "top=300, left=300, width=800, height=900, status=no, menubar=no, toolbar=no, resizable=no");
            self.close();
        }
    </script>
</head>
<body>
<div class="login-form">
    <form method="post" action="<%=request.getContextPath()%>/login_ok" onsubmit="return check123()">
        <h2 class="text-center">회원 로그인</h2>
        <div class="form-group">
            <input type="text" name = "id" id="id" class="form-control" placeholder="아이디" required="required">
        </div>
        <div class="form-group">
            <input type="password" name = "pwd" id="pwd" class="form-control" placeholder="비밀번호" required="required">
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block">로그인</button>
        </div>
        <div class="clearfix">

            <a href="/findPwd" class="pull-right">비밀번호 찾기</a>
            <a href="/findid" class="pull-left">아이디 찾기</a>
        </div>
    </form>
    <p class="text-center"><a href="/join">회원가입</a></p>
</div>
</body>
</html>

