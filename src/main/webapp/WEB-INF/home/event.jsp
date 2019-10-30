<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>dd</title>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>
<br><br><br><br><br>
<div align="center">
<%--<iframe width="1600" height="800"frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0 src="https://meetup4u.com/"></iframe>--%>
    <iframe src="https://calendar.google.com/calendar/embed?height=600&amp;wkst=1&amp;bgcolor=%23ffffff&amp;ctz=Asia%2FSeoul&amp;src=ampkYXZpbjMyNUBnbWFpbC5jb20&amp;src=YWRkcmVzc2Jvb2sjY29udGFjdHNAZ3JvdXAudi5jYWxlbmRhci5nb29nbGUuY29t&amp;src=a28uc291dGhfa29yZWEjaG9saWRheUBncm91cC52LmNhbGVuZGFyLmdvb2dsZS5jb20&amp;color=%23039BE5&amp;color=%2333B679&amp;color=%230B8043" style="border-width:0" width="1200" height="600" frameborder="0" scrolling="no"></iframe>
</div>
<%--&lt;%&ndash;<script type="text/javascript">document.write("<i"+"fr"+"ame src='http://job.incruit.com/calendar/blogcafe.asp?ct=01&mode=m' width='1200' height='1000' border='0' frameborder='0' scrolling='no' marginheight='0' marginwidth='0'></"+"if"+"ra"+"me>");</script>&ndash;%&gt;--%>

<%--<c:set var="dto" value="${doc }"> </c:set>--%>
<%--&lt;%&ndash;<c:set var="dto2" value="${doc2 }"> </c:set>&ndash;%&gt;--%>
<%--&lt;%&ndash;${dto2}&ndash;%&gt;--%>
<%--${dto}--%>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
