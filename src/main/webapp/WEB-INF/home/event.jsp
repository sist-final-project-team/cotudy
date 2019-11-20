<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>COTUDY_EVENT</title>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>
<br><br><br><br><br>
<div align="center">
    <iframe src="https://calendar.google.com/calendar/embed?height=600&amp;wkst=1&amp;bgcolor=%23ffffff&amp;ctz=Asia%2FSeoul&amp;src=Y290dWR5MzI1QGdtYWlsLmNvbQ&amp;color=%2322AA99&amp;showTitle=0&amp;showNav=1&amp;showPrint=0&amp;showTabs=1&amp;showTz=1" style="border-width:0" width="800" height="600" frameborder="0" scrolling="no"></iframe>
</div>


<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
