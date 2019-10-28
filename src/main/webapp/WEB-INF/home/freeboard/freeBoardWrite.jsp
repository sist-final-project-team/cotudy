<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.getSession().getAttribute("memId"); %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>코터디-자유게시판-글 쓰기</title>

</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<div class="container2">
    <hr width="50%" color="orange">
        <h3>자유 게시판 글 쓰기</h3>
    <hr width="50%" color="orange">
    <form method="post" action="<%=request.getContextPath()%>/freeWriteOk">
    <table class="board_list">
        <tr>
            <th>글 제목</th>
            <td>
                <input type="hidden" value="<%=(String)session.getAttribute("memId")%>" name="memId">
                <input name="freeTitle">
            </td>
        </tr>
        <tr>
            <th>글 내용</th>
            <td><textarea rows="8" cols="50" name="freeCont" style="resize: none"></textarea> </td>
        </tr>
        <tr>
            <th>주제</th>
            <td>
                    <select name="freeSubject">
                        <option value="잡담">잡담</option>
                        <option value="코딩">코딩</option>
                    </select>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="글 작성">&nbsp;&nbsp;&nbsp;
                <input type="reset" value="취소">
            </td>
        </tr>
    </table>
    </form>
</div>
</body>
</html>
