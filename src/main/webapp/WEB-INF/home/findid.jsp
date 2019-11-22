<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>COTUDY</title>
    <script type="text/javascript">
        function pwd_find() {
            window.open("/findPwd", "비밀번호 찾기", "top=300, left=300, width=800, height=900, status=no, menubar=no, toolbar=no, resizable=no");
            window.close();
        }
    </script>
</head>
<body>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<div class="container forget-password">
    <div class="row">
        <div class="col-md-12 col-md-offset-4">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="text-center">
                        <img src="images/user.png" alt="유저">
                        <h2 class="text-center">Forgot ID?</h2>
                        <p>You can find your id here.</p>
                        <form id="register-form" role="form" autocomplete="off" class="form" method="post" action="<%=request.getContextPath()%>/findid_ok"">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                                    <input  name="memName" placeholder="이름을 입력하세요" class="form-control"  type="text" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope color-blue"></i></span>
                                    <input  name="memEmail" placeholder="이메일을 입력하세요" class="form-control"  type="email" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <input name="btnForget" class="btn btn-lg btn-primary btn-block btnForget" value="아이디 찾기" type="submit">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

