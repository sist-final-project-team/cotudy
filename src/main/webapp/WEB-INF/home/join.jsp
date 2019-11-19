<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Roboto|Courgette|Pacifico:400,700" rel="stylesheet">
    <title>Bootstrap Start Free Trail Sign up Form</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        body{
            color: #999;
            background: #e2e2e2;
            font-family: 'Roboto', sans-serif;
        }
        .form-control{
            min-height: 41px;
            box-shadow: none;
            border-color: #e1e1e1;
            width:77%;
            display : inline

        }
        .form-control:focus{
            border-color: #00cb82;
        }
        .form-control, .btn{
            border-radius: 3px;
        }
        .form-header{
            margin: -30px -30px 20px;
            padding: 30px 30px 10px;
            text-align: center;
            background: #00cb82;
            border-bottom: 1px solid #eee;
            color: #fff;
        }
        .form-header h2{
            font-size: 34px;
            font-weight: bold;
            margin: 0 0 10px;
            font-family: 'Pacifico', sans-serif;
        }
        .form-header p{
            margin: 20px 0 15px;
            font-size: 17px;
            line-height: normal;
            font-family: 'Courgette', sans-serif;
        }
        .signup-form{
            width: 390px;
            margin: 0 auto;
            padding: 30px 0;
        }
        .signup-form form{
            color: #999;
            border-radius: 3px;
            margin-bottom: 15px;
            background: #f0f0f0;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            padding: 30px;
        }
        .signup-form .form-group{
            margin-bottom: 20px;
        }
        .signup-form label{
            font-weight: normal;
            font-size: 13px;
            display:block;

        }
        .signup-form input[type="checkbox"]{
            margin-top: 2px;
        }
        .signup-form .btn{
            font-size: 16px;
            font-weight: bold;
            background: #00cb82;
            border: none;
            min-width: 200px;
        }
        .signup-form .btn:hover, .signup-form .btn:focus{
            background: #00b073 !important;
            outline: none;
        }
        .signup-form a{
            color: #00cb82;
        }
        .signup-form a:hover{
            text-decoration: underline;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>


    <%-- 회원 가입에 있어서 데이터를 검증하는 외부 자바스크립트 파일 링크 --%>
    <script type="text/javascript" src="/resources/js/member.js"></script>
    <script type="text/javascript">
        // 현재 웹문서가 브라우저로 로딩 될 때 문서의 본문을 읽고 현재의 제이쿼리 호출

        var engnum = /^[a-zA-Z0-9]+$/;

        $(function () {
            // 회원가입 폼 중에서 아이디 중복 체크라는 버튼을 클릭했을떄
            $("#idcheck_btn").mousedown(function () {
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

                            var warningTxt = '<span style="color: red; ">중복된 아이디입니다.</span>';
                            $("#idcheck").text('');
                            $("#idcheck").show();
                            $("#idcheck").append(warningTxt);
                            $("#memId").val('').focus();
                            return false;
                        } else {   // 아이디가 중복이 되지 않는 경우
                            console.log($("#memId").val());
                            if(engnum.test($("#memId").val())){ //아이디 제대로(알파벳,숫자로만) 입력했을 경우

                                var warningTxt = '<span style="color: blue; ">사용 가능한 아이디입니다.</span>';
                                $("#idcheck").text('');
                                $("#idcheck").show();
                                $("#idcheck").append(warningTxt);
                                memId.readOnly = true;
                                console.log("warningText===" + $("#idcheck").text());
                            }
                            else{
                                var warningTxt = '<span style="color: red; ">아이디는 알파벳과 숫자만 입력 가능합니다.</span>';
                                $("#idcheck").text('');
                                $("#idcheck").show();
                                $("#idcheck").append(warningTxt);
                                $("#memId").val('').focus();
                                return false;
                            }

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
<div class="signup-form" id="join_wrap">
    <form name="f" method="post" action="<%=request.getContextPath()%>/join_ok" onsubmit="return mem_check()">
        <div class="form-header">
            <h2>Sign Up</h2>
            <p>Fill out this form to start your free trial!</p>
        </div>
        <div class="form-group">
            <label>아이디</label>
            <input type="text" class="form-control" name="memId" id="memId" placeholder="알파벳, 숫자만 사용 가능" required="required">

            <input  style="alignment :right" type="button" value="중복체크" id="idcheck_btn">
            <span id="idcheck"></span>

        </div>

        <div class="form-group">
            <label>비밀번호</label>
            <input type="password" class="form-control"  name="memPwd" id="memPwd" placeholder="4~20자 사이" required="required">
        </div>
        <div class="form-group">
            <label>비밀번호 확인</label>
            <input type="password" class="form-control" name="memPwd1" id="memPwd1" required="required">
        </div>
        <div class="form-group">
            <label>이름</label>
            <input type="text" class="form-control" name="memName" id="memName" required="required">
        </div>
        <div class="form-group">
            <label>이메일</label>
            <input type="email" class="form-control" name="memEmail" placeholder="exam@cotudy.com" id="memEmail" required="required">
        </div>


        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block btn-lg">Sign Up</button>
        </div>
    </form>
    <div class="text-center small">Already have an account? <a href="#" onclick="login()">Login here</a></div>
</div>

<script type="text/javascript">
    function login() {
        var popupX = (window.screen.width / 2) - (500 / 2);
        // 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
        var popupY= (window.screen.height / 2) - (600 / 2);
        // 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
        self.close();
        window.open("/login", "로그인 화면", 'top='+popupY+', left='+ popupX + ', width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no');
    }

</script>
</body>
</html>