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
    <title>${menuInfo.cntntsNm} 목록</title>
</head>
<body>

<div class="p-wrap">

    <div class="row">
        <div class="col-6">
			<span class="p-total__number">
				총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><strong>${paginationInfo.totalRecordCount}</strong></em>건
				&nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em>/${paginationInfo.totalPageCount} 페이지 ]
			</span>
        </div>
        <div class="col-18 right">
            <form:form modelAttribute="placeSearchVO" name="placeSearchVO" method="get">
                <fieldset>
                    <legend>장소 검색</legend>
                    <form:hidden path="key"/>
                    <form:hidden path="pageUnit"/>
                    <form:hidden path="pageIndex"/>
                    <form:select path="searchPrgSe" class="p-input p-input--auto">
                        <form:option value="" label="구분 선택"/>
                        <form:options items="${prgSeList}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <form:select path="searchInsttNo" class="p-input p-input--auto">
                        <form:option value="0" label="운영기관 선택"/>
                        <form:options items="${eduInsttList}" itemValue="insttNo" itemLabel="insttNm" class="insttList EDU" style="display:none;"/>
                        <form:options items="${expInsttList}" itemValue="insttNo" itemLabel="insttNm" class="insttList EXP" style="display:none;"/>
                        <form:options items="${fctInsttList}" itemValue="insttNo" itemLabel="insttNm" class="insttList FCT" style="display:none;"/>
                    </form:select>
                    <form:input path="searchKrwd" class="p-input p-input--auto" placeholder="검색어 입력"/>
                    <input value="검색" type="submit" class="p-button p-button--small primary">
                </fieldset>
            </form:form>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption>장소 목록 - 번호, 운영기관, 장소명, 주소, 사용여부 등 제공</caption>
        <colgroup>
            <col style="width:100px">
            <col style="width:100px">
            <col style="width:200px">
            <col>
            <col>
            <col style="width:100px">
            <col style="width:80px">
            <col style="width:80px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">구분</th>
            <th scope="col">운영기관</th>
            <th scope="col">장소명</th>
            <th scope="col">주소</th>
            <th scope="col">사용여부</th>
            <th scope="col" colspan="2">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${placeList}">
            <tr>
                <td>${currentPageStartNo}</td>
                <td>
                    <c:out value="${prgSeMap[result.prgSe]}"/>
                </td>
                <td>
                    <c:set var="insttNo" value="instt${result.insttNo}"/>
                    <c:out value="${eduInsttMap[insttNo]}"/>
                    <c:out value="${expInsttMap[insttNo]}"/>
                    <c:out value="${fctInsttMap[insttNo]}"/>
                </td>
                <td><a href="./selectPlaceView.do?placeNo=<c:out value="${result.placeNo}"/>&amp;<c:out value="${placeSearchVO.params}"/>"><c:out value="${result.placeNm}"/></a></td>
                <td>(<c:out value="${result.zip}"/>) <c:out value="${result.addr}"/> <c:out value="${result.detailAddr}"/></td>
                <td>
                    <span class="p-switcher p-switcher--single">
                        <input id="useYn_<c:out value="${result.insttNo}"/>" type="checkbox" class="p-switcher__input"<c:if test="${result.useYn eq 'Y'}"> checked</c:if> value="<c:out value="${result.insttNo}"/>" onchange="fn_useYnCheck(<c:out value="${result.insttNo}"/>)">
                        <label for="useYn_<c:out value="${result.insttNo}"/>" class="p-switcher__label"><em class="p-switcher__text blind">사용여부</em></label>
                    </span>
                </td>
                <td><a href="./updatePlaceView.do?placeNo=<c:out value="${result.placeNo}"/>&amp;<c:out value="${placeSearchVO.params}"/>" class="p-button p-button--combine edit">수정</a></td>
                <td><a href="./deletePlace.do?placeNo=<c:out value="${result.placeNo}"/>&amp;<c:out value="${placeSearchVO.params}"/>" class="p-button p-button--combine delete" onclick="return fn_delete();">삭제</a></td>
            </tr>
            <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(placeList) eq 0}">
            <tr>
                <td colspan="8">검색된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="p-pagination">
        <div class="p-page">
            <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectPlaceList.do?${placeSearchVO.paramsExclPi}&amp;pageIndex=" />
        </div>
    </div>
    <div class="text_right">
        <a href="./addPlaceView.do?${placeSearchVO.params}" class="p-button p-button--combine write">등록</a>
    </div>
    
</div>

<script>

    $(document).ready(function() {

        <c:set var="searchPrgSe" value="${placeSearchVO.searchPrgSe}"/>
        <c:if test="${searchPrgSe == 'EDU'}">
            $('#searchInsttNo option.EDU').show();
        </c:if>
        <c:if test="${searchPrgSe == 'EXP'}">
            $('#searchInsttNo option.EXP').show();
        </c:if>
        <c:if test="${searchPrgSe == 'FCT'}">
            $('#searchInsttNo option.FCT').show();
        </c:if>

        $('select[name=searchPrgSe]').on("change", function () {
            $('#searchInsttNo').val(0);
            $('#searchInsttNo option.insttList').hide();
            $('#searchInsttNo option.' + $(this).val()).show();
        });

    })

    function fn_useYnCheck(insttNo) {
        var para = document.location.href.split("?");
        var url = './updatePlaceUseYn.do?' + para[1] + '&placeNo=' + insttNo;
        var chkAt = $('#useYn_' + insttNo).is(":checked");

        if (chkAt) {
            if (confirm("사용여부를 사용으로 변경 하시겠습니까?")) {
                window.location.href = url + "&useYn=Y";
            } else {
                $('#useYn_'+insttNo).prop('checked', false);
                return false;
            }

        } else {
            if (confirm("사용여부를 미사용으로 변경 하시겠습니까?")) {
                window.location.href = url + "&useYn=N";
            } else {
                $('#useYn_'+insttNo).prop('checked', true);
                return false;
            }
        }
    }

    function fn_delete() {
        return confirm("삭제하시겠습니까?");
    }

</script>

</body>
</html>
