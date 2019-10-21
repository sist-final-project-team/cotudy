<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
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
            <a class="nav-link" href="/freeboard/freeList">통합게시판</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/notice">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/event">EVENT</a>
          </li>
          <li class="nav-item">
          </li>
          <%
            if ((String)session.getAttribute("login") == null) {
          %>
          <li class="nav-item">
            <a class="nav-link" href="/login">로그인</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/join">회원가입</a>
          </li>
          <%
            } else {
          %>
          <li class="nav-item">
            <a class="nav-link" href="/logout">로그아웃</a>
          </li>
          <%
          }
          %>
        </ul>
      </div>
    </div>
  </nav>
</body>
</html>