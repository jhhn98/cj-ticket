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

        <form:form modelAttribute="dscnt" name="dscnt" method="post" action="addDscnt.do" onsubmit="return fn_addDscntCheck(this)">
            <fieldset>
                <legend>감면혜택 등록</legend>
                <c:forEach var="result" items="${dscntSearchVO.paramsMap}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <table class="p-table">
                    <caption>감면혜택 등록</caption>
                    <colgroup>
                        <col class="w15p">
                        <col />
                    </colgroup>
                    <tbody class="p-table--th-left">
                    <tr>
                        <th scope="row"><form:label path="insttNo">운영기관</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:select path="insttNo" class="p-input p-input--auto">
                                <c:if test="${fn:length(insttList) > 1}"><form:option value="" label="구분 선택"/></c:if>
                                <form:options items="${insttList}" itemValue="insttNo" itemLabel="insttNm"/>
                            </form:select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="dscntCd">감면혜택구분</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:select path="dscntCd" class="p-input p-input--auto">
                                <form:option value="" label="선택"/>
                                <form:options items="${dscntSeList}" itemValue="code" itemLabel="codeNm"/>
                            </form:select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="dscntCnd">감면혜택 조건</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="dscntCnd" class="p-input"/>
                            <span class="p-table__content padding_l_10">
                                <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#info-circle"></use></svg>
                                <em class="em_black">80자 이내로 입력해주세요.</em>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="dscntRate">감면율</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:select path="dscntRate" class="p-input p-input--auto">
                                <form:option value="0" label="선택"/>
                                <c:forEach var="i" begin="5" end="100" step="5">
                                    <form:option value="${i}" label="${i}"/>
                                </c:forEach>
                            </form:select>
                            <span class="p-table__content">%</span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="piscYn">비대면 사용여부</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <span class="p-form-checkbox">
                                <input type="radio" name="piscYn" id="piscYn1" class="p-form-radio__input" value="Y" checked>
                                <label for="piscYn1" class="p-form-radio__label">사용</label>
                            </span>
                            <span class="p-form-checkbox">
                                <input type="radio" name="piscYn" id="piscYn2" class="p-form-radio__input" value="N">
                                <label for="piscYn2" class="p-form-radio__label">미사용</label>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="directYn">서류직접제출 사용여부</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <span class="p-form-checkbox">
                                <input type="radio" name="directYn" id="directYn1" class="p-form-radio__input" value="Y" checked>
                                <label for="directYn1" class="p-form-radio__label">사용</label>
                            </span>
                            <span class="p-form-checkbox">
                                <input type="radio" name="useYn" id="directYn2" class="p-form-radio__input" value="N">
                                <label for="directYn1" class="p-form-radio__label">미사용</label>
                            </span>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="row margin_t_20">
                    <div class="col-12">
                        <a href="./selectDscntList.do?<c:out value="${dscntSearchVO.params}"/>" class="p-button cancel">목록 </a>
                    </div>
                    <div class="col-12 right">
                        <input type="submit" class="p-button write" value="등록">
                    </div>
                </div>
            </fieldset>
        </form:form>

</div>

<script>

    function fn_addDscntCheck(form){

        if (!form.insttNo.value) {
            alert("운영기관을 선택해주세요.");
            form.insttNo.focus();
            return false;
        }

        if (!form.dscntCd.value) {
            alert("감면혜택코드를 선택해주세요.");
            form.dscntCd.focus();
            return false;
        }

        if (!form.dscntCnd.value) {
            alert("감면혜택 조건을 입력해주세요.");
            form.dscntCnd.focus();
            return false;
        }

        if (form.dscntRate.value == 0) {
            alert("감면율을 선택해주세요.");
            form.dscntRate.focus();
            return false;
        }

        if (!form.piscYn.value) {
            alert("비대면 사용여부를 확인해주세요.");
            $('#piscYn1').focus();
            return false;
        }

        if (!form.directYn.value) {
            alert("서류직접제출 사용여부를 확인해주세요.");
            $('#directYn1').focus();
            return false;
        }

        return confirm('등록하시겠습니까?');
    }

</script>

</body>
</html>
