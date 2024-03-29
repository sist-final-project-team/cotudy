
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>COTUDY_LOGIN</title>
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
            <button type="submit" class="btn btn-primary btn-block" style="width: 279px; height: 49px">로그인</button>
            <br>
            <a href="https://kauth.kakao.com/oauth/authorize?client_id=b5403f20bcc35ced05caf41f3b74b6da&redirect_uri=http://54.180.48.102:9000/main&response_type=code">
                <img style="width: 279px; height: 49px" src="images/kakao_account_login_btn_medium_wide.png"> </a>
        </div>
        



        
        <div class="clearfix">

            <a href="/findPwd" class="pull-right">비밀번호 찾기</a>
            <a href="/findid" class="pull-left">아이디 찾기</a>
        </div>
    </form>

    <p class="text-center"><a href="javascript:void(0);" onclick="join();">회원가입</a></p>


</div>
<script type="text/javascript">
    function join() {
        self.close();
        window.opener.location.href = "/join";
    }
</script>
</body>
</html>

