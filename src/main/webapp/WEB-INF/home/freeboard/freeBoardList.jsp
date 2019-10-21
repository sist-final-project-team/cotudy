<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
  <meta charset="utf-8">
  <title>EstateAgency Bootstrap Template</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">

  <!-- Favicons -->
  <link href="../resources/../resources/img/favicon.png" rel="icon">
  <link href="../resources/../resources/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">

  <!-- Bootstrap CSS File -->
  <link href="../resources/../resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Libraries CSS Files -->
  <link href="../resources/../resources/lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="../resources/../resources/lib/animate/animate.min.css" rel="stylesheet">
  <link href="../resources/../resources/lib/ionicons/css/ionicons.min.css" rel="stylesheet">
  <link href="../resources/../resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

  <!-- Main Stylesheet File -->
  <link href="../resources/css/style.css" rel="stylesheet">

  <!-- =======================================================
    Theme Name: EstateAgency
    Theme URL: https://bootstrapmade.com/real-estate-agency-bootstrap-template/
    Author: BootstrapMade.com
    License: https://bootstrapmade.com/license/
  ======================================================= -->
</head>

<body>
  <div class="click-closed"></div>
<div class="hhheader">
<jsp:include page="header.jsp"></jsp:include>
</div>

    <div class="container">
    	<h2>게시글 목록</h2>
    	<table class="board_list">
	        <colgroup>
	            <col width="15%"/>
	            <col width="*"/>
	            <col width="15%"/>
	            <col width="20%"/>
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col">글번호</th>
	                <th scope="col">제목</th>
	                <th scope="col">조회수</th>
	                <th scope="col">작성일</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<tr th:if="${#lists.size(list)} > 0" th:each="list : ${list}">
	        		<td th:text="${list.boardIdx}"></td>
	        		<td class="title"><a href="/board/openBoardDetail.do?boardIdx=" th:attrappend="href=${list.boardIdx}" th:text="${list.title}"></a></td>
	        		<td th:text="${list.hitCnt}"></td>
	        		<td th:text="${list.createdDatetime}"></td>
	        	</tr> 
	        	<tr th:unless="${#lists.size(list)} > 0">
	        		<td colspan="4">조회된 결과가 없습니다.</td>
	        	</tr>
	        </tbody>
	    </table>
	    <a href="/freeWrite" class="btn">글 쓰기</a>
    </div>
</body>
</html>