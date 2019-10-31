
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>코터디</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <title>코터디</title>
    <style>
        h2 {
            font-family: Arial, Verdana;
            font-weight: 800;
            font-size: 2.5rem;
            color: #091f2f;
            text-transform: uppercase;
        }
        .accordion-section .panel-default > .panel-heading {
            border: 0;
            background: #f4f4f4;
            padding: 0;
        }
        .accordion-section .panel-default .panel-title a {
            display: block;
            font-style: italic;
            font-size: 1.5rem;
        }
        .accordion-section .panel-default .panel-title a:after {
            font-family: 'FontAwesome';
            font-style: normal;
            font-size: 3rem;
            content: "\f106";
            color: #1f7de2;
            float: right;
            margin-top: -12px;
        }
        .accordion-section .panel-default .panel-title a.collapsed:after {
            content: "\f107";
        }
        .accordion-section .panel-default .panel-body {
            font-size: 1.2rem;
        }</style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<br><br><br><br><br>
<section class="accordion-section clearfix mt-3" aria-label="Question Accordions">
    <div class="container">
        ​
        <h2><b>자주 묻는 질문</b> </h2>
        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            <div class="panel panel-default">
                <div class="panel-heading p-3 mb-3" role="tab" id="heading0">
                    <h3 class="panel-title">
                        <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse0" aria-expanded="true" aria-controls="collapse0">
                            코터디가 무엇인가요?
                        </a>
                    </h3>
                </div>
                <div id="collapse0" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading0">
                    <div class="panel-body px-3 mb-4">
                        <p> 코터디가 무엇인가요?</p>
                        <ul>
                            <li> 코터디가 무엇인가요?</li>
                            <li> 코터디가 무엇인가요?</li>
                            <li> 코터디가 무엇인가요?</li>
                            <li> 코터디가 무엇인가요?</li>
                        </ul>
                    </div>
                </div>
            </div>
            ​
            <div class="panel panel-default">
                <div class="panel-heading p-3 mb-3" role="tab" id="heading1">
                    <h3 class="panel-title">
                        <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse1" aria-expanded="true" aria-controls="collapse1">
                            서지훈은 보세요
                        </a>
                    </h3>
                </div>
                <div id="collapse1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading1">
                    <div class="panel-body px-3 mb-4">
                        <p>끄지셈</p>
                    </div>
                </div>
            </div>
            ​
            <div class="panel panel-default">
                <div class="panel-heading p-3 mb-3" role="tab" id="heading2">
                    <h3 class="panel-title">
                        <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2">
                            안녕하세요
                        </a>
                    </h3>
                </div>
                <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
                    <div class="panel-body px-3 mb-4">
                        <p>안녕히가세요</p>
                    </div>
                </div>
            </div>
            ​
            <div class="panel panel-default">
                <div class="panel-heading p-3 mb-3" role="tab" id="heading3">
                    <h3 class="panel-title">
                        <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse3" aria-expanded="true" aria-controls="collapse3">
                            질문있어요?>
                        </a>
                    </h3>
                </div>
                <div id="collapse3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading3">
                    <div class="panel-body px-3 mb-4">
                        <p>탈퇴하세요.</p>
                    </div>
                </div>
            </div>
        </div>
        ​
    </div>
</section>
</body>
​
​
</html>

<jsp:include page="footer.jsp"></jsp:include>


</body>
</html>
