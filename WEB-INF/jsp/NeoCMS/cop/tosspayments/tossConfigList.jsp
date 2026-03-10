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
    </div>

    <table class="p-table p-table--bordered">
        <caption>토스페이먼츠 설정 목록 - 번호, 구분, 가맹점 ID, 운영기관, 클라이언트key, 시크릿key, 결제수단 등 제공</caption>
        <colgroup>
            <col style="width:100px">
            <col style="width:120px">
            <col style="width:200px">
            <col>
            <col style="width:300px">
            <col style="width:300px">
            <col style="width:100px">
            <col style="width:200px">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">구분</th>
            <th scope="col">운영기관</th>
            <th scope="col">가맹점 ID</th>
            <th scope="col">클라이언트키</th>
            <th scope="col">시크릿키</th>
            <th scope="col">결제수단</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${tossConfigList}">
            <tr>
                <td>${currentPageStartNo}</td>
                <td><c:out value="${prgSeMap[result.prgSe]}"/></td>
                <td>
                    <c:set var="insttNo" value="instt${result.insttNo}"/>
                    <c:out value="${eduInsttMap[insttNo]}"/>
                    <c:out value="${expInsttMap[insttNo]}"/>
                    <c:out value="${fctInsttMap[insttNo]}"/>
                </td>
                <td><c:out value="${result.mId}"/></td>
                <td><c:out value="${result.clientKey}"/></td>
                <td><c:out value="${result.secretKey}"/></td>
                <td><c:out value="${result.payMethod}"/></td>
                <td>
                    <a href="./updateTossConfigView.do?key=<c:out value="${key}"/>&amp;tossConfigNo=<c:out value="${result.tossConfigNo}"/>&amp;<c:out value="${tossConfig.params}"/>" class="p-button p-button--combine edit">수정</a>
                    <a href="./deleteTossConfig.do?key=<c:out value="${key}"/>&amp;tossConfigNo=<c:out value="${result.tossConfigNo}"/>&amp;<c:out value="${tossConfig.params}"/>" class="p-button p-button--combine delete" onclick="return fn_delete();">삭제</a>
                </td>
            </tr>
            <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(tossConfigList) eq 0}">
            <tr>
                <td colspan="8">등록된 내용이 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="p-pagination">
        <div class="p-page">
            <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectTossConfigList.do?${tossConfig.paramsExclPi}&amp;pageIndex=" />
        </div>
    </div>
    <div class="text_right">
        <a href="./addTossConfigView.do?key=<c:out value="${key}"/>&amp;<c:out value="${tossConfig.params}"/>" class="p-button p-button--combine write">등록</a>
    </div>

    </div>

<script>

    function fn_delete() {
        return confirm("삭제하시겠습니까?");
    }

</script>
</body>
</html>
