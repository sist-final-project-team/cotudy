
<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <!-- Favicons -->
  <link href="../resources/../resources/img/favicon.png" rel="icon">
  <link href="../resources/../resources/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">

  <!-- Bootstrap CSS File -->
  <link href="../resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Libraries CSS Files -->
  <link href="../resources/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="../resources/lib/animate/animate.min.css" rel="stylesheet">
  <link href="../resources/lib/ionicons/css/ionicons.min.css" rel="stylesheet">
  <link href="../resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

  <!-- Main Stylesheet File -->
  <link href="../resources/css/style.css" rel="stylesheet">
    <script type="text/javascript">
        function login() {
            window.open("/login", "로그인 화면", "top=300, left=300, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no");
        }

    </script>
</head>
<body>
<!--/ Nav Start /-->
<nav class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top">
    <div class="container">
      <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarDefault"
        aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span></span>
        <span></span>
        <span></span>
      </button>
      <a class="navbar-brand text-brand" href="/">CO<span class="color-b">TUDY</span></a>
      <button type="button" class="btn btn-link nav-search navbar-toggle-box-collapse d-md-none" data-toggle="collapse"
        data-target="#navbarTogglerDemo01" aria-expanded="false">
        <span class="fa fa-search" aria-hidden="true"></span>
      </button>
      <div class="navbar-collapse collapse justify-content-center" id="navbarDefault">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="/event">스터디 찾기</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/event">스터디 만들기</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/freeList">통합게시판</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/notice">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/event">EVENT</a>
          </li>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

          <li class="nav-item">
              <% if ((String)session.getAttribute("memId")==null){ %>
            <a class="nav-link" href="javascript:void(0);" onclick="login();">Login</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/join">회원가입</a>
          </li>
            <%
            }else{
            %>
            <li class="nav-item">
            <a class="nav-link" href="/myPage">마이페이지</a>
          </li>
            <li class="nav-item">
                <a class="nav-link" href="/logout" >로그아웃</a>
           </li>
            <% } %>
        </ul>
      </div>
      <button type="button" class="btn btn-b-n navbar-toggle-box-collapse d-none d-md-block" data-toggle="collapse"
        data-target="#navbarTogglerDemo01" aria-expanded="false">
        <span class="fa fa-search" aria-hidden="true"></span>
      </button>

    </div>
</nav>
</body>
</html>