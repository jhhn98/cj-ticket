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
    <title>${menuInfo.cntntsNm} </title>
</head>
<body>

<div class="p-wrap">

        <div>
            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
            <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
        </div>

        <form:form modelAttribute="tossConfig" name="tossConfig" method="post" action="addTossConfig.do" onsubmit="return fn_addTossConfigCheck(this)">
            <fieldset>
                <legend>토스페이먼츠 설정 등록</legend>
                <input type="hidden" name="key" value="<c:out value="${key}"/>"/>
                <c:forEach var="result" items="${tossConfig.paramsMap}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <table class="p-table">
                    <caption>토스페이먼츠 설정 등록</caption>
                    <colgroup>
                        <col class="w10p">
                        <col />
                    </colgroup>
                    <tbody class="p-table--th-left">
                    <tr>
                        <th scope="row"><form:label path="prgSe">운영기관</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:select path="prgSe" class="p-input p-input--auto">
                                <form:option value="" label="구분 선택"/>
                                <form:options items="${prgSeList}" itemValue="code" itemLabel="codeNm"/>
                            </form:select>
                            <form:select path="insttNo" class="p-input p-input--auto">
                                <form:option value="" label="운영기관 선택"/>
                                <form:options items="${eduInsttList}" itemValue="insttNo" itemLabel="insttNm" class="insttList EDU" style="display:none;"/>
                                <form:options items="${expInsttList}" itemValue="insttNo" itemLabel="insttNm" class="insttList EXP" style="display:none;"/>
                                <form:options items="${fctInsttList}" itemValue="insttNo" itemLabel="insttNm" class="insttList FCT" style="display:none;"/>
                            </form:select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="mId">가맹점 ID</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="mId" class="p-input w30p" type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="clientKey">클라이언트키</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="clientKey" class="p-input w30p" type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="secretKey">시크릿키</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="secretKey" class="p-input w30p" type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="payMethod">결제수단</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="payMethod" class="p-input w30p" type="text"/>
                            <br/>
                            <span class="p-table__content  padding_t_5">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">신용카드( C ), 가상계좌( V ), 계좌이체( T ), 구분자( | )</em>
                            </span>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="row margin_t_20">
                    <div class="col-12">
                        <a href="./selectTossConfigList.do?key=<c:out value="${key}"/>&amp;<c:out value="${tossConfig.params}"/>" class="p-button cancel">목록 </a>
                    </div>
                    <div class="col-12 right">
                        <input type="submit" class="p-button write" value="등록">
                    </div>
                </div>
            </fieldset>
        </form:form>

</div>

<script>

    $('select[name=prgSe]').on("change",function(){
        $('#insttNo').val('');
        $('#insttNo option.insttList').hide();
        $('#insttNo option.' + $(this).val()).show();
    });

    function fn_addTossConfigCheck(form){

        if (!form.prgSe.value) {
            alert("구분을 선택해주세요.");
            form.prgSe.focus();
            return false;
        }

        if (!form.insttNo.value) {
            alert("운영기관명을 선택해주세요.");
            form.insttNo.focus();
            return false;
        }

        if (!form.mId.value) {
            alert("가맹점 ID를 입력해주세요.");
            form.insttNo.focus();
            return false;
        }

        if (!form.clientKey.value) {
            alert("클라이언트키를 입력해주세요.");
            form.insttNo.focus();
            return false;
        }

        if (!form.secretKey.value) {
            alert("시크릿키를 입력해주세요.");
            form.insttNo.focus();
            return false;
        }

        if (!form.payMethod.value) {
            alert("결제수단을 입력해주세요.");
            form.insttNo.focus();
            return false;
        }

        return true;
    }

</script>

</body>
</html>
