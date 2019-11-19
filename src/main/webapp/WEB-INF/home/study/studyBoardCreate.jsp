<!DOCTYPE html>

<%@ page session="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.getAttribute("memId"); %>

<head>
    <link rel="stylesheet"
          href="http://code.jquery.com/ui/1.10.4/themes/redmond/jquery-ui.min.css" />
    <link href="../resources/css/fSelect.css" rel="stylesheet" type="text/css">
    <script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<jsp:include page="../header.jsp"></jsp:include>
<div class ="container2" align="center">
    <hr width="50%" color="purple">
    <h3>테이블 글쓰기 폼</h3>
    <hr width="50%" color="purple">

    <form method="post" action="/studyCreateOk"  onsubmit="return checkForm()" name="studyForm">
        <input type="hidden" value="<%=(String)session.getAttribute("memId") %>" name="memId">
        <table border="1" width="600" cellspacing="0">

            <tr>
                <th>글제목 </th>
                <td> <input id="studyTitle" name="studyTitle" required="required"> </td>
            </tr>
            <tr>
                <th>글내용</th>
                <td> <textarea rows="8" cols="60" name="studyCont" style="resize: none" required="required"></textarea> </td>
            </tr>

            <tr>
                <th>날짜선택</th>
                <td > <input type="text" class="date1" id ="studyStartDate" name="studyStartDate" placeholder="시작날짜 선택" autocomplete="off" required="required" readonly>
                    <input type="text" class="date2"  id="studyEndDate" name="studyEndDate" placeholder="종료날짜 선택" autocomplete="off" required="required" readonly></td>
            </tr>
            <tr>
                <th>지역</th>
                <td>
                <select name="studyArea" required="required" >
                    <option value="">지역선택</option>
                    <option value="강남">강남</option>
                    <option value="신촌">신촌</option>
                    <option value="홍대">홍대</option>
                    <option value="부평">부평</option>
                    <option value="수원">수원</option>
                    <option value="제주">제주</option>
                </select>
                </td>
            </tr>

            <tr>
                <th>키워드</th>
                <td>
                    <select  class="demo" multiple="multiple" name="studyKeyword" >
                        <optgroup label="Languages">
                            <option value="C++">C++</option>
                            <option value="C#">C#</option>
                            <option value="Java">Java</option>
                            <option value="C언어">C언어</option>
                        </optgroup>
                        <optgroup label="Scripts">
                            <option value="JavaScript">JavaScript</option>
                            <option value="PHP">PHP</option>
                            <option value="ASP">ASP</option>
                            <option value="JSP">JSP</option>
                        </optgroup>
                    </select>
                </td>
            </tr>
            <tr>
                <th>카카오 오픈채팅 주소</th>
                <td><input type="text" name="studyOpenchat"> </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="글쓰기" onclick="percent()">&nbsp;&nbsp;&nbsp;
                    <input type="reset" value="다시작성">
                </td>
            </tr>
        </table>
    </form>


        <script src="../resources/js/fSelect.js"></script>

        <script>
            $(function() {
                $('.demo').fSelect();
            });
        </script>

</div>

<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/i18n/jquery-ui-i18n.min.js"></script>
<script>
    $(function() {
        $.datepicker.setDefaults($.datepicker.regional['ko']);
        $('.date1').datepicker({
            minDate: 0,
            onClose:function (selectedDate) {
                $('.date2').datepicker("option","minDate",selectedDate);
            }
        });
        $('.date2').datepicker({
        });
    });
</script>
<script type="text/javascript">
    jQuery.fn.trilemma = function(options) {
        var options = options || {};
        var cbfs = this; // establish checkbox container
        var cbs = this.find('input:checkbox');
        var maxnum = options.max ? options.max : 2;


        cbs.each(function () {
            $(this).bind('click', function () {
                    if ($(this).is(':checked')) {
                        if (cbs.filter(':checked').length == maxnum) {
                            cbs.not(':checked').each(function () {
                                $(this).attr('disabled', 'true');
                                if (options.disablelabels) {
                                    var thisid = $(this).attr('id');
                                    $('label[for="' + thisid + '"]').addClass('disabled');
                                }

                            });
                        }
                    } else {
                        cbs.removeAttr('disabled');
                        if (options.disablelabels) {
                            cbfs.find('label.disabled').removeClass('disabled');
                        }
                    }
                }
            );
        });
        return this;
    };
    $(function(){
        jQuery('.hondas').trilemma({max:3,disablelabels:true});//max3=3개체크하면 나머지는 비활성
    });
</script>
<script type="text/javascript">
    $(document).ready(function() {
        var last_valid_selection = null;
        $('#userRequest_activity').change(function(event) {
            if ($(this).val().length > 3) {
                $(this).val(last_valid_selection);
            } else {
                last_valid_selection = $(this).val();
            }
        });
    });
</script>
<!-- FORM 유효성체크-->
<script>
    function checkForm() {
        var theForm = document.studyForm;

        if(theForm.studyStartDate.value===''||theForm.studyEndDate.value===''){
            window.alert("날짜를 선택해 주세요");
            return false;
        } else if(theForm.studyKeyword.value===''){
            window.alert("키워드를 선택해 주세요");
            return false;
        }
        return true;
    }

</body>



