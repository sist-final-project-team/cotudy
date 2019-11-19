function mem_check() {
    if($.trim($("#memId").val())===""){
        alert("회원아이디를 입력하세요!");
        $("#memId").val("").focus();
        return false;
    }
    if($.trim($("#memPwd").val())===""){
        alert("비밀번호를 입력하세요!");
        $("#memPwd").val("").focus();
        return false;
    }
    if($.trim($("#memPwd1").val())===""){
        alert("비밀번호를 확인하세요!");
        $("#memPwd1").val("").focus();
        return false;
    }
    if($.trim($("#memPwd").val()) !== $.trim($("#memPwd1").val())){
        alert("비밀번호가 일치하지 않습니다!.");
        $("#memPwd").val("");
        $("#memPwd1").val("");
        $("#memPwd").focus();
        return false;
    }
    
    if($.trim($("#memPwd").val()).length <4){
        alert("비밀번호는 4자 이상 입력해 주세요!.");
        $("#memPwd").val("");
        $("#memPwd1").val("");
        $("#memPwd").focus();
        return false;
    }    
    
    if($.trim($("#memPwd").val()).length >20){
        alert("비밀번호는 20자 이하로 입력해 주세요!.");
        $("#memPwd").val("");
        $("#memPwd1").val("");
        $("#memPwd").focus();
        return false;
    }   
    
    if($.trim($("#memArea").val())===""){
        alert("거주지를 입력하세요!");
        $("#memArea").val("").focus();
        return false;
    }
    if($.trim($("#memEmail").val())===""){
        alert("이메일을 입력하세요!");
        $("#memEmail").val("").focus();
        return false;
    }
    if($.trim($("#memName").val())===""){
        alert("이름을 입력하세요!");
        $("#memName").val("").focus();
        return false;
    }

    if($.trim($("#memName").val()).length > 10){
        alert("이름은 10자 이하로 입력해주세요!");
        $("#memName").val("").focus();
        return false;
    }


    if($.trim($("#idcheck").text())!=="사용 가능한 아이디입니다."){
        console.log("!");
        console.log($.trim($("#idcheck").text()));
        console.log("!");
        alert("중복아이디 확인하세요");
        $("#idcheck_btn").focus();
        return false;
    }
}