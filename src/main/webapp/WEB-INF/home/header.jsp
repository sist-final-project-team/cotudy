<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
        <button type="button" class="btn btn-link nav-search navbar-toggle-box-collapse d-md-none"
                data-toggle="collapse"
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
                    <a class="nav-link" href="/event">통합게시판</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/notice">공지사항</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/event">EVENT</a>
                </li>
                <%--          <li class="nav-item dropdown">--%>
                <%--            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"--%>
                <%--              aria-haspopup="true" aria-expanded="false">--%>
                <%--              Pages--%>
                <%--            </a>--%>
                <%--            <div class="dropdown-menu" aria-labelledby="navbarDropdown">--%>
                <%--              <a class="dropdown-item" href="property-single.html">Property Single</a>--%>
                <%--              <a class="dropdown-item" href="blog-single.html">Blog Single</a>--%>
                <%--              <a class="dropdown-item" href="agents-grid.html">Agents Grid</a>--%>
                <%--              <a class="dropdown-item" href="agent-single.html">Agent Single</a>--%>
                <%--            </div>--%>
                <%--          </li>--%>
                <li class="nav-item">
                    <a class="nav-link" href="contact.html">Contact</a>
                </li>
            </ul>
        </div>
        <button type="button" class="btn btn-b-n navbar-toggle-box-collapse d-none d-md-block" data-toggle="collapse"
                data-target="#navbarTogglerDemo01" aria-expanded="false">
            <span class="fa fa-search" aria-hidden="true"></span>
        </button>

        <button type="button" class="btn btn-b-n navbar-toggle-box-collapse d-none d-md-block" data-toggle="collapse"
                data-target="#navbarTogglerDemo01" aria-expanded="false">
            <span class="fa fa-search" aria-hidden="true"></span>
        </button>
    </div>
</nav>
</body>
</html>