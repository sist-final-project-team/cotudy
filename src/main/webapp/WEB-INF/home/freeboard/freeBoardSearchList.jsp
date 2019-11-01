<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>코터디-자유게시판</title>
    <script type="text/javascript">
        function writeOk() {
            var id = "<%=(String)session.getAttribute("memId")%>";
            console.log(id);
            if (id.length > 4) {
                location.href = "/freeWriteForm";
            } else {
                alert("로그인 후 이용 가능합니다.");
                window.open("/login", "로그인 화면", "top=300, left=300, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no");
                location.href = "/freeList"
            }
        }
    </script>

</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<div class="container2">
    <hr width="50%" color="blue">
    <h3>자유 게시판 목록</h3>
    <hr width="50%" color="blue">
    <table class="board_list">
        <tr>
            <th>글 번호</th>
            <th>주제</th>
            <th>글 제목</th>
            <th>작성자</th>
            <th>작성일자</th>
            <th>조회수</th>
        </tr>
        <c:set var="list" value="${list1}"/>
        <c:if test="${!empty list}">
            <c:forEach items="${list}" var="freeboardDto">
                <tr>
                    <td>${freeboardDto.getFreeNum()}</td>
                    <td>${freeboardDto.getFreeSubject()}</td>
                    <td>
                        <a href="/freeCont?freeNum=${freeboardDto.getFreeNum()}&page=${page}"> ${freeboardDto.getFreeTitle()}</a>
                    </td>
                    <td>${freeboardDto.getMemId()}</td>
                    <td>${freeboardDto.getFreeCreatedDate()}</td>
                    <td>${freeboardDto.getFreeHit()}</td>
                    <td><input type="hidden" name="freeSubject" value="${freeSubject}">
                        <input type="hidden" name="searchKeyword" value="${searchKeyword}">
                        <input type="hidden" name="searchType" value="${searchType}"></td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty list}">
            <tr>
                <td colspan="6" align="center">
                    <h3>게시글이 없습니다.</h3>
                </td>
            </tr>
        </c:if>

    </table>
        <td colspan="6" align="center">
<%--            <input value="${page1}++++${block1}">--%>
<%--            <input value="${endBlock1}++++${allPage1}+++startBlock = >${startBlock1}">--%>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">

                    <c:if test="${page1 > block1}">
                        <%--                        [<a href="/freeSearchList?page=1">◀◀</a>]--%>
                        <%--                        [<a href="/freeSearchList?page=${startBlock1-1 }">◀</a>]--%>
                        <li class="page-item"><a class="page-link"
                                                 href="/freeSearchList?page=${startBlock1-1 }&freeSubject=${freeSubject }&searchKeyword=${searchKeyword}&searchType=${searchType}">Previous</a>
                        </li>
                    </c:if>
                    <c:forEach begin="${startBlock1 }" end="${endBlock1 }" var="i">
                        <c:if test="${i==page1 }">
                            <%--                            <b>[${i}]</b>--%>
                            <li class="page-item active"><a class="page-link" href="/freeList?page=${i}">${i}<span
                                    class="sr-only">(current)</span></a></li>
                        </c:if>
                        <c:if test="${!(i==page1) }">
                            <%--                            <c:if test="${ freeSubject !='전체보기' && !empty searchKeyword}">--%>
                            <%--                                [<a href="freeSearchList?page=${i}&freeSubject=${freeSubject}&searchKeyword=${searchKeyword}&searchType=${searchType}">${i}</a>]--%>
                            <%--                            </c:if>--%>
                            <c:if test="${!empty freeSubject}">
                                <%--                            [<a href="freeSearchList?page=${i}&freeSubject=${freeSubject}">${i}</a>]--%>
                                <li class="page-item"><a class="page-link"
                                                         href="freeSearchList?page=${i}&freeSubject=${freeSubject}&searchKeyword=${searchKeyword}&searchType=${searchType}">${i}</a>
                                </li>
                            </c:if>
                            <%--  <c:if test="${!empty searchKeyword && freeSubject=='전체보기'}">
                                  [<a href="freeSearchList?page=${i}&searchKeyword=${searchKeyword}&searchType=${searchType}">${i}</a>]
                              </c:if>--%>
                        </c:if>
                    </c:forEach>
                    <c:if test="${endBlock1 <allPage1 }">
                        <li class="page-item"><a class="page-link"
                                                 href="/freeSearchList?page=${endBlock1+1}&freeSubject=${freeSubject }&searchKeyword=${searchKeyword}&searchType=${searchType}">Next</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
<%--            <input type="button" value="목록" onclick="location.href='/freeList'">--%>
        </td>
    <div align="center">
        <form method="get" action="/freeSearchList">
            <%--<input type="hidden" name="page" value="${page}">--%>
            <select name="freeSubject">
                <option value="전체보기" selected>전체보기</option>
                <option value="질문">질문</option>
                <option value="사담">사담</option>
                <option value="기타">기타</option>
            </select>
            <select name="searchType">
                <option value="free_title">제목</option>
                <option value="free_cont">내용</option>
                <option value="mem_id">작성자</option>
            </select>
            <input type="text" name="searchKeyword">
            <input type="submit" value="검색"  class="btn btn-outline-secondary">
            <input align="right" type="button" value="글 작성" onclick="writeOk()" class="btn btn-success">

        </form>
    </div>
</div>


</body>
</html>
