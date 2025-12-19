<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="decorator" content="${menuInfo.siteId}" />
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/program.js"></script>
    <title><c:out value="${menuInfo.naviList[0].menuNm}"/> &gt; ${menuInfo.cntntsNm} &gt; 접수관리 상세보기</title>
</head>
<body>

<div class="p-wrap">

    <h3>신청자 기본 정보</h3>
    <table class="p-table">
        <caption>신청자 정보 상세보기</caption>
        <colgroup>
            <col class="w15p">
            <col />
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
            <th scope="row">신청자명</th>
            <td>
                <c:out value="${fcltyApplVO.applNm}"/>
                <c:if test="${fcltyApplVO.genderSe == 'M'}"> (남)</c:if>
                <c:if test="${fcltyApplVO.genderSe == 'F'}"> (여)</c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">생년월일</th>
            <td>
                <c:out value="${tsu:toDateFormat(fcltyApplVO.birthDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">연락처</th>
            <td>
                <c:out value="${fcltyApplVO.mobileNo1}"/> - <c:out value="${fcltyApplVO.mobileNo2}"/> - <c:out value="${fcltyApplVO.mobileNo3}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">주소</th>
            <td>
                (<c:out value="${fcltyApplVO.zip}"/>) <c:out value="${fcltyApplVO.addr}"/> <c:out value="${fcltyApplVO.detailAddr}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">개인 / 단체</th>
            <td>
                <c:if test="${empty fcltyApplVO.grpNm}">개인</c:if>
                <c:if test="${!empty fcltyApplVO.grpNm}"><c:out value="${fcltyApplVO.grpNm}"/></c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">이메일</th>
            <td>
                <c:out value="${fcltyApplVO.email}"/>
            </td>
        </tr>
        <%--<tr>
            <th scope="row">감면혜택</th>
            <td>
            </td>
        </tr>--%>
        </tbody>
    </table>

    <div class="h3">예약 정보</div>
    <table class="p-table">
        <caption>예약 정보 상세보기</caption>
        <colgroup>
            <col class="w15p">
            <col />
            <col class="w15p">
            <col />
            <col class="w15p">
            <col />
            <col class="w15p">
            <col />
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
            <th scope="row">시설명</th>
            <td colspan="7">
                <c:out value="${fcltyApplVO.fcltyNm}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">예약번호</th>
            <td colspan="7">
                <c:out value="${fcltyApplVO.fcltyApplId}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">신청일시</th>
            <td colspan="7">
                <c:out value="${tsu:toDateFormat(fcltyApplVO.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd HH:mm:ss:SSS')}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">시설일자</th>
            <td colspan="3">
                <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyBgnHm, 'HHmm', 'HH:mm')}"/> ~
                <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyEndHm, 'HHmm', 'HH:mm')}"/>
            </td>
            <th scope="row">결제금액</th>
            <td>
                <fmt:formatNumber value="${fcltyApplVO.totalPayAmt}" pattern="#,##0"/> 원
            </td>
            <th scope="row">결제기한</th>
            <td>
                <c:out value="${tsu:toDateFormat(fcltyApplVO.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">예약상태</th>
            <td colspan="3">
                <c:out value="${rsvSttusMap[fcltyApplVO.rsvSttusCd]}"/>
            </td>
            <th scope="row">결제상태</th>
            <td colspan="3">
                <c:out value="${paySttusMap[fcltyApplVO.paySttusCd]}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">승인일시</th>
                <%--<c:out value="${fcltyApplVO.rsvSttusCd}"/>--%>
            <td>
            </td>
            <th scope="row">취소일시</th>
            <td>
                <%--<c:out value="${fcltyApplVO.rsvSttusCd}"/>--%>
            </td>
            <th scope="row">결제일시</th>
            <td>
                <%--<c:out value="${fcltyApplVO.rsvSttusCd}"/>--%>
            </td>
            <th scope="row">결제방법</th>
            <td>
                <%--<c:out value="${fcltyApplVO.rsvSttusCd}"/>--%>
            </td>
        </tr>
        <tr>
            <th scope="row">취소사유</th>
            <td colspan="3">
                <pre><c:out value="${fcltyApplVO.memo}"/></pre>
            </td>
            <th scope="row">환불사유</th>
            <td colspan="3">
                <%--<c:out value="${fcltyApplVO.rsvSttusCd}"/>--%>
            </td>
        </tr>
        <tr>
            <th scope="row">환불요청일시</th>
            <td colspan="3">
                <pre><c:out value="${fcltyApplVO.memo}"/></pre>
            </td>
            <th scope="row">환불처리일시</th>
            <td colspan="3">
                <%--<c:out value="${fcltyApplVO.rsvSttusCd}"/>--%>
            </td>
        </tr>
        <tr>
            <th scope="row">환불계좌</th>
            <td colspan="7">
                <pre><c:out value="${fcltyApplVO.memo}"/></pre>
            </td>
        </tr>
        <tr>
            <th scope="row">메모</th>
            <td colspan="7">
                <pre><c:out value="${fcltyApplVO.memo}"/></pre>
            </td>
        </tr>
        </tbody>
    </table>

    <div class="row margin_t_20">
        <div class="col-12">
            <c:set var="applListUrl" value="./selectFcltyApplList.do?"/>
            <c:if test="${isFcltyList == 'Y'}">
                <c:set var="applListUrl" value="./selectFcltyApplListByFclty.do?"/>
            </c:if>
            <c:set var="applListParam" value="${fcltyApplSearchVO.params}${fcltyApplSearchVO.paramsMng}"/>
            <c:if test="${isFcltyList == 'Y'}">
                <c:set var="applListParam" value="${applListParam}&${fcltySearchVO.fcltyParamsMng}&fcltyNo=${fcltyApplVO.fcltyNo}"/>
            </c:if>
            <a href="<c:out value="${applListUrl}"/><c:out value="${applListParam}"/>" class="p-button cancel">목록 </a>
        </div>
        <div class="col-12 right">
            <a href="./updateFcltyApplView.do?fcltyApplNo=<c:out value="${fcltyApplVO.fcltyApplNo}"/>&amp;<c:out value="${fcltyApplSearchVO.params}"/>&amp;<c:out value="${fcltyApplSearchVO.paramsMng}"/>" class="p-button p-button--small edit" onclick="alert('개발 진행 중입니다.'); return false;">수정</a>
        </div>
    </div>

</div>

</body>
</html>
