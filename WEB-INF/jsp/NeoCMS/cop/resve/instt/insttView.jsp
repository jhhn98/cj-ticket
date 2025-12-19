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
    <title>${menuInfo.cntntsNm} 상세보기</title>
</head>
<body>

<div class="p-wrap">

        <table class="p-table">
            <caption>운영기관 상세보기</caption>
            <colgroup>
                <col class="w20p">
                <col />
            </colgroup>
            <tbody class="p-table--th-left">
            <tr>
                <th scope="row">구분</th>
                <td><c:out value="${prgSeMap[insttVO.prgSe]}"/></td>
            </tr>
            <tr>
                <th scope="row">운영기관명</th>
                <td><c:out value="${insttVO.insttNm}"/></td>
            </tr>
            <tr>
                <th scope="row">월 횟수 제한</th>
                <td>
                    <c:out value="${insttVO.mtCoLmtt}"/>
                    <span class="p-table__content">회</span>
                </td>
            </tr>
            <tr>
                <th scope="row">감면 횟수 제한</th>
                <td>
                    <c:out value="${insttVO.rdcxptCoLmtt}"/>
                    <span class="p-table__content">회</span>
                </td>
            </tr>
            <tr>
                <th scope="row">운영여부</th>
                <td>
                    <c:if test="${insttVO.useYn == 'Y'}">운영</c:if>
                    <c:if test="${insttVO.useYn == 'N'}">미운영</c:if>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="row margin_t_20">
            <div class="col-12">
                <a href="./selectInsttList.do?<c:out value="${insttSearchVO.params}"/>" class="p-button cancel">목록 </a>
            </div>
            <div class="col-12 right">
                <a href="./updateInsttView.do?insttNo=<c:out value="${insttVO.insttNo}"/>&amp;<c:out value="${insttSearchVO.params}"/>" class="p-button p-button--combine edit">수정</a>
                <a href="./deleteInstt.do?insttNo=<c:out value="${insttVO.insttNo}"/>&amp;<c:out value="${insttSearchVO.params}"/>" class="p-button p-button--combine delete" onclick="return fn_delete();">삭제</a>
            </div>
        </div>

</div>

<script nonce="NEOCMSSCRIPT">
    function fn_delete() {
        return confirm("삭제하시겠습니까?");
    }
</script>

</body>
</html>