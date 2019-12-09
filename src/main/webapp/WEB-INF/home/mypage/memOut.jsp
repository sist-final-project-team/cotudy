<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>COTUDY_MYPAGE</title>
</head>

<body>
<jsp:include page="../header.jsp"></jsp:include>
<br><br><br><br><br><br><br>

<div class="container">
    <div align="center">
        <img src="https://img.icons8.com/windows/150/000000/remove-user-male--v2.png">
    </div>
    <h1 align="center">탈퇴 안내</h1>
    회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.<br>

    1. 사용하고 계신 아이디(<c:out value="${sessionScope.memId}"/>)는 탈퇴할 경우 재사용 및 복구가 불가능합니다.<br>
    2. 탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가하오니 신중하게 선택하시기 바랍니다.<br></h1>
    <p>3. 탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.

        삭제를 원하는 게시글이 있다면 반드시 탈퇴 전 삭제하시기 바랍니다.<br>
        4. 탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없어, 게시글을 임의로 삭제해드릴 수 없습니다.
    </p>
    <p>5. 탈퇴 후에는 아이디(<c:out value="${sessionScope.memId}"/>)로 다시 가입할 수 없으며 아이디와 데이터는 복구할 수 없습니다.<br>
        6. 게시판형 서비스에 남아 있는 게시글은 탈퇴 후 삭제할 수 없습니다.<br>
    <p style="color: red;">카카오의경우 고유id가 같기떄문에 회원탈퇴 후 재가입시 기존에 사용 하던 아이디가 그대로 적용됩니다</p>
        안내 사항을 모두 확인하였으며, 이에 </p>
    <form action="/memOutOk" method="post" onsubmit="return memOutCheck()">
        <input type="checkbox" id="memOutCheck1" name="memOutCheck1" value="ok">동의합니다.
        <input type="submit" value="탈퇴하기" class="btn btn-outline-danger">
    </form>

</div>
<script>
    function memOutCheck() {
        var chk = memOutCheck1.checked;
        if (!chk) {
            alert("동의합니다에 체크 해주세요.");
            return false;
        }
    }
</script>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>