<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="decorator" content="${menuInfo.siteId}" />
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/program.js"></script>
    <title>${menuInfo.cntntsNm} 등록</title>
</head>
<body>

<div class="p-wrap">

        <div>
            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
            <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
        </div>

        <form:form modelAttribute="insttVO" name="insttVO" method="post" action="addInstt.do" onsubmit="return fn_addInsttCheck(this)">
            <fieldset>
                <legend>운영기관 등록</legend>
                <c:forEach var="result" items="${insttSearchVO.paramsMap}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <table class="p-table">
                    <caption>운영기관 등록</caption>
                    <colgroup>
                        <col class="w10p">
                        <col />
                    </colgroup>
                    <tbody class="p-table--th-left">
                    <tr>
                        <th scope="row"><form:label path="prgSe">구분</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:select path="prgSe" class="p-input p-input--auto">
                                <form:option value="" label="구분 선택"/>
                                <form:options items="${prgSeList}" itemValue="code" itemLabel="codeNm"/>
                            </form:select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="insttNm">운영기관명</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="insttNm" style="width:200px" class="p-input"/>
                            <button type="button" class="p-button primary" onclick="fn_insttNmCheck()">중복확인</button>
                            <input type="hidden" name="insttNmCheckAt" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="mtCoLmtt">월 횟수 제한</form:label></th>
                        <td>
                            <form:input path="mtCoLmtt" style="width:100px" class="p-input" type="number"/>
                            <span class="p-table__content">회</span>
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">'0'을 입력하시면 횟수 제한 없습니다.</em>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="rdcxptCoLmtt">감면 횟수 제한</form:label></th>
                        <td>
                            <form:input path="rdcxptCoLmtt" style="width:100px" class="p-input" type="number"/>
                            <span class="p-table__content">회</span>
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">'0'을 입력하시면 횟수 제한 없습니다. 예시) 제한기간 : 9월1일 ~ 9월30일 (한달 적용)</em>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="useYn">운영여부</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <span class="p-form-checkbox">
                                <input type="radio" name="useYn" id="useYn1" class="p-form-radio__input" value="Y" checked>
                                <label for="useYn1" class="p-form-radio__label">운영</label>
                            </span>
                                <span class="p-form-checkbox">
                                <input type="radio" name="useYn" id="useYn2" class="p-form-radio__input" value="N">
                                <label for="useYn2" class="p-form-radio__label">미운영</label>
                            </span>
                            </td>
                    </tr>
                    </tbody>
                </table>
                <div class="row margin_t_20">
                    <div class="col-12">
                        <a href="./selectInsttList.do?<c:out value="${insttSearchVO.params}"/>" class="p-button cancel">목록 </a>
                    </div>
                    <div class="col-12 right">
                        <input type="submit" class="p-button write" value="등록">
                    </div>
                </div>
            </fieldset>
        </form:form>

</div>

<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="insttVO" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="insttVO">
    <script nonce="NEOCMSSCRIPT">
        <c:forEach items="${errors.allErrors}" var="error" varStatus="status">
        <c:if test="${status.first}">
        <c:set var="errMsg"><spring:message code="${error.code}" arguments="${error.arguments}" /></c:set>
        alert("<c:out value="${errMsg}"/>");
        </c:if>
        </c:forEach>
    </script>
</spring:hasBindErrors>
<c:if test="${!empty message}">
    <script nonce="NEOCMSSCRIPT">
        function fn_check_message() {
            alert("<c:out value='${message}'/>");
            <c:if test="${!empty fieldName}">
            $("#<c:out value="${fieldName}"/>").focus();
            </c:if>
        }
        $(window).load(function() {
            fn_check_message();
        });
    </script>
</c:if>

<script>

    $(document).ready(function(){
        var originVal = $("input[name=insttNm]").val();
        $("input[name=insttNm]").on("change", function() {
            if ($("input[name=insttNmCheckAt]").val() == "Y") {
                if (originVal != $("input[name=insttNm]").val()) {
                    $("input[name=insttNmCheckAt]").val("");
                }
            }
        });
    })

    function fn_insttNmCheck() {

        var insttNm = $("input[name=insttNm]");
        var insttNmVal = insttNm.val();
        var insttNmCheckAt = $("input[name=insttNmCheckAt]");

        if (insttNmVal != "") {
            $.ajax({
                cache    : false,
                type     : "GET",
                url      : "./insttNmCheckAjax.do",
                data     : { insttNm: insttNmVal },
                error    : function( request, status, error ) {
                    if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                        alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                        location.href = "/neo/index.do";
                    }else{
                        alert("에러가 발생하였습니다. 다시확인하여주세요\n"+
                            "code:"+request.status+"\n"+
                            "message:"+request.responseText+"\n"+
                            "error:"+error
                        );
                        insttNmCheckAt.val("N");
                    }
                },
                success  : function (result) {
                    if (result == 0) {
                        alert("사용 가능한 이름입니다.");
                        insttNmCheckAt.val("Y");
                    } else if (result == 999) {
                        alert("운영기관명을 입력해주세요.");
                        insttNmCheckAt.val("N");
                        insttNm.focus();
                    } else {
                        alert("사용할 수 없습니다. 같은 이름이 존재합니다.");
                        insttNmCheckAt.val("N");
                        insttNm.focus();
                    }
                }
            });
        } else {
            alert("운영기관명을 입력해주세요.");
            insttNmCheckAt.val("N");
            insttNm.focus();
        }
    }

    function fn_addInsttCheck(form){

        if (!form.prgSe.value) {
            alert("구분을 선택해주세요.");
            form.prgSe.focus();
            return false;
        }

        if (!form.insttNm.value) {
            alert("운영기관명을 입력해주세요.");
            form.insttNm.focus();
            return false;
        }

        if (!form.insttNmCheckAt.value) {
            alert("운영기관명 중복확인이 필요합니다.");
            form.insttNm.focus();
            return false;
        }
        else if (form.insttNmCheckAt.value == "N") {
            alert("운영기관명 중복확인이 필요합니다.");
            form.insttNm.focus();
            return false;
        }

        if (!form.useYn.value) {
            alert("운영여부를 확인해주세요.");
            $('#useYn1').focus();
            return false;
        }

        return true;
    }

</script>

</body>
</html>
