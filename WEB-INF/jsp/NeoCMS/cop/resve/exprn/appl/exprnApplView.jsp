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
    <title>${menuInfo.cntntsNm} 상세보기</title>
</head>
<body>

<div class="p-wrap">

    <div class="card card--line margin_b_30">
        <h3>체험 정보</h3>
        <table class="p-table margin_b_20">
            <caption>체험 정보 - 제목, 기관명, 접수기간, 체험기간, 내용, 첨부파일 정보 제공</caption>
            <colgroup>
                <col class="w15p" />
                <col />
                <col class="w15p" />
                <col />
            </colgroup>
            <tbody class="p-table--th-left">
            <tr class="p-table__subject">
                <th scope="row">체험명</th>
                <td colspan="3">
                    <span class="p-table__subject_text"><c:out value="${exprnVO.exprnNm}"/></span>
                </td>
            </tr>
            <tr>
                <th scope="row">운영기관</th>
                <td colspan="3">
                    <c:set var="insttNo" value="instt${exprnVO.insttNo}"/>
                    <c:out value="${expInsttMap[insttNo]}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">모집상태</th>
                <td><c:out value="${operSttusMap[exprnVO.operSttus]}"/></td>
                <th scope="row">신청/모집정원</th>
                <td colspan="3">
                    <c:out value="${exprnVO.totResveCnt}/${exprnVO.totRcritCnt}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">접수기간</th>
                <td><c:out value="${exprnVO.rcptBgnDe}"/> <c:out value="${exprnVO.rcptBgnHh}"/>:<c:out value="${exprnVO.rcptBgnMm}"/>
                    ~
                    <c:out value="${exprnVO.rcptEndDe}"/> <c:out value="${exprnVO.rcptEndHh}"/>:<c:out value="${exprnVO.rcptEndMm}"/>
                </td>
                <th scope="row">체험기간</th>
                <td>
                    <c:out value="${tsu:toDateFormat(exprnVO.exprnMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    ~
                    <c:out value="${tsu:toDateFormat(exprnVO.exprnMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                </td>
            </tr>
            <tr>
                <th scope="row">선발방식</th>
                <td><c:out value="${slctMthdMap[exprnVO.slctMthdCd]}"/></td>
                <th scope="row">체험료 / 결제방식</th>
                <td>
                    <c:choose>
                        <c:when test="${exprnVO.exprnAmt > 0}">
                            <fmt:formatNumber value="${tsu:xssNumberFilter(exprnVO.exprnAmt)}" pattern="#,###"/> 원
                        </c:when>
                        <c:otherwise>
                            무료
                        </c:otherwise>
                    </c:choose>
                    /
                    <c:forEach var="result" items="${exprnVO.payMthdCdArr}" varStatus="status">
                        <c:out value="${payMthdMap[result]}"/>
                        <c:if test="${result == 'NBKRCP'}">
                            [<c:out value="${exprnVO.bankNm}"/> <c:out value="${exprnVO.acctNo}"/> (예금주:<c:out value="${exprnVO.dpstrNm}"/>)]
                        </c:if>
                        <c:if test="${!status.last}">, </c:if>
                    </c:forEach>
                </td>
            </tr>
            <tr>
            </tr>
            </tbody>
        </table>
    </div>

    <h3>신청자 정보</h3>
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
                <c:out value="${exprnApplVO.applNm}"/>
                <c:if test="${exprnApplVO.genderSe == 'M'}"> (남)</c:if>
                <c:if test="${exprnApplVO.genderSe == 'F'}"> (여)</c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">생년월일</th>
            <td>
                <c:out value="${tsu:toDateFormat(exprnApplVO.birthDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">연락처</th>
            <td>
                <c:out value="${exprnApplVO.mobileNo1}"/> - <c:out value="${exprnApplVO.mobileNo2}"/> - <c:out value="${exprnApplVO.mobileNo3}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">주소</th>
            <td>
                (<c:out value="${exprnApplVO.zip}"/>) <c:out value="${exprnApplVO.addr}"/> <c:out value="${exprnApplVO.detailAddr}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">개인 / 단체</th>
            <td>
                <c:if test="${exprnApplVO.nmprSeCd == 'IND'}">개인</c:if>
                <c:if test="${exprnApplVO.nmprSeCd == 'GRP'}">단체(<c:out value="${exprnApplVO.grpNm}"/>)</c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">신청인원</th>
            <td>
                <c:out value="${exprnApplVO.totalCnt}"/> 명
                <c:if test="${exprnVO.detailNmprUseYn == 'Y'}">
                    ( 세부인원 :
                    성인 <c:out value="${exprnApplVO.adltCnt}"/>명,
                    청소년 <c:out value="${exprnApplVO.teenCnt}"/>명,
                    초등학생 <c:out value="${exprnApplVO.elmntCnt}"/>명,
                    아동 <c:out value="${exprnApplVO.childCnt}"/>명,
                    영유아 <c:out value="${exprnApplVO.infantCnt}"/>명
                    )
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">이메일</th>
            <td>
                <c:out value="${exprnApplVO.email}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">거주지 조회</th>
            <td><c:out value="${lgldongMap[exprnApplVO.resInqCd]}"/></td>
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
            <th scope="row">예약번호</th>
            <td colspan="7">
                <c:out value="${exprnApplVO.exprnApplId}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">신청일시</th>
            <td colspan="7">
                <c:out value="${tsu:toDateFormat(exprnApplVO.applDtMs, 'yyyyMMddHHmmssSS', 'yyyy-MM-dd HH:mm:ss:SS')}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">체험일자</th>
            <td colspan="7">
                <c:out value="${tsu:toDateFormat(exprnApplVO.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                <c:out value="${tsu:toDateFormat(exprnApplVO.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~
                <c:out value="${tsu:toDateFormat(exprnApplVO.exprnEndHm, 'HHmm', 'HH:mm')}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">예약상태</th>
            <td colspan="3">
                <c:out value="${rsvSttusMap[exprnApplVO.rsvSttusCd]}"/>
            </td>
            <th scope="row">결제상태</th>
            <td colspan="3">
                <c:out value="${paySttusMap[exprnApplVO.paySttusCd]}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">신청완료(승인)일시</th>
            <td colspan="3">
                <c:out value="${tsu:toDateFormat(exprnApplVO.applCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
            <th scope="row">총결제금액</th>
            <td>
                <fmt:formatNumber value="${exprnApplVO.totalPayAmt}" pattern="#,##0"/> 원
            </td>
            <th scope="row">결제방법</th>
            <td>
                <c:out value="${payMthdMap[exprnApplVO.payMthdCd]}"/>
                <c:if test="${exprnApplVO.payMthdCd == 'ELCTRN' && !empty exprnApplVO.tossMethod}">(<c:out value="${exprnApplVO.tossMethod}"/>)</c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">취소일시</th>
            <td colspan="3">
                <c:out value="${tsu:toDateFormat(exprnApplVO.cancelDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
            <th scope="row">감면금액</th>
            <td>
                <%--TODOSDB: 감면코드 같이 표출--%>
                <fmt:formatNumber value="${exprnApplVO.dscntAmt}" pattern="#,##0"/> 원
            </td>
            <th scope="row">체험료</th>
            <td>
                <fmt:formatNumber value="${exprnVO.exprnAmt}" pattern="#,##0"/> 원
            </td>
        </tr>
        <tr>
            <th scope="row">취소사유</th>
            <td colspan="3">
                <pre><c:out value="${exprnApplVO.cancelReason}"/></pre>
            </td>
            <th scope="row">결제기한</th>
            <td colspan="3">
                <c:out value="${tsu:toDateFormat(exprnApplVO.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">환불요청일시</th>
            <td colspan="3">
                <c:out value="${tsu:toDateFormat(exprnApplVO.rfndReqDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
            <th scope="row">결제일시</th>
            <td colspan="3">
                <c:out value="${tsu:toDateFormat(exprnApplVO.payDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">환불계좌</th>
            <td colspan="3">
                <c:out value="${bankMap[exprnApplVO.rfndBankNm]}"/> <c:out value="${exprnApplVO.rfndAcctNo}"/> (예금주:<c:out value="${exprnApplVO.rfndDpstrNm}"/>)
            </td>
            <th scope="row" rowspan="3">메모</th>
            <td colspan="3" rowspan="3">
                <pre><c:out value="${exprnApplVO.memo}"/></pre>
            </td>
        </tr>
        <tr>
            <th scope="row">환불사유</th>
            <td colspan="3">
                <pre><c:out value="${exprnApplVO.rfndReason}"/></pre>
            </td>
        </tr>
        <tr>
            <th scope="row">환불처리일시</th>
            <td colspan="3">
                <c:out value="${tsu:toDateFormat(exprnApplVO.rfndCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
        </tr>
        </tbody>
    </table>

    <div class="row margin_t_20">
        <div class="col-12">
            <c:set var="applListUrl" value="./selectExprnApplList.do?"/>
            <c:if test="${isExprnList == 'Y'}">
                <c:set var="applListUrl" value="./selectExprnApplListByExprn.do?"/>
            </c:if>
            <c:set var="applListParam" value="${exprnApplSearchVO.params}${exprnApplSearchVO.paramsMng}"/>
            <c:if test="${isExprnList == 'Y'}">
                <c:set var="applListParam" value="${applListParam}&${exprnSearchVO.exprnParamsMng}&exprnNo=${exprnApplVO.exprnNo}"/>
            </c:if>
            <a href="<c:out value="${applListUrl}"/><c:out value="${applListParam}"/>" class="p-button cancel">목록 </a>
        </div>
        <div class="col-12 right">
            <a href="./updateExprnApplView.do?exprnApplNo=<c:out value="${exprnApplVO.exprnApplNo}"/>&amp;<c:out value="${exprnApplSearchVO.params}"/>&amp;<c:out value="${exprnApplSearchVO.paramsMng}"/>" class="p-button p-button--small edit"">수정</a>
        </div>
    </div>

</div>

</body>
</html>
