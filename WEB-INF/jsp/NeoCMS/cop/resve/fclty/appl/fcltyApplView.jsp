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
    <title><c:out value="${menuInfo.naviList[0].menuNm}"/> &gt; ${menuInfo.cntntsNm} &gt; 신청자 상세보기</title>
</head>
<body>

<div class="p-wrap">

    <jsp:include page="../incFcltyInfo.jsp" />

    <h3>신청자 기본 정보</h3>
    <table class="p-table p-table--hover">
        <caption>신청자 정보 상세보기</caption>
        <colgroup>
            <col class="w20p">
            <col />
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
            <th scope="row">신청자명 (성별)</th>
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
            <th scope="row">(우편번호) 주소</th>
            <td>
                (<c:out value="${fcltyApplVO.zip}"/>) <c:out value="${fcltyApplVO.addr}"/> <c:out value="${fcltyApplVO.detailAddr}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">개인 / 단체</th>
            <td>
                <c:if test="${empty fcltyApplVO.grpNm}">개인</c:if>
                <c:if test="${!empty fcltyApplVO.grpNm}">[단체] <c:out value="${fcltyApplVO.grpNm}"/></c:if>
            </td>
        </tr>

        <c:if test="${!empty fcltyApplVO.grpNm}">
        <tr>
            <th scope="row">사용인원</th>
            <td>
                <c:out value="${fcltyApplVO.useCnt}"/> 명
            </td>
        </tr>
        </c:if>

        <tr>
            <th scope="row">이메일</th>
            <td>
                <c:out value="${fcltyApplVO.email}"/>
            </td>
        </tr>

        <c:if test="${fcltyVO.resInqUseYn eq 'Y'}">
            <tr>
                <th scope="row">거주지 조회 결과</th>
                <td><c:out value="${lgldongMap[fcltyApplVO.resInqCd]}"/></td>
            </tr>
        </c:if>

        <c:if test="${not empty fcltyVO.aditIem1}">
            <tr>
                <th scope="row"><c:out value="${fcltyVO.aditIem1}"/></th>
                <td><c:out value="${fcltyVO.aditIem1}"/></td>
            </tr>
        </c:if>

        <c:if test="${not empty fcltyVO.aditIem2}">
            <tr>
                <th scope="row"><c:out value="${fcltyVO.aditIem2}"/></th>
                <td><c:out value="${fcltyVO.aditIem2}"/></td>
            </tr>
        </c:if>

        <tr>
            <th scope="row">관리자 직권 입력 여부</th>
            <td><c:out value="${(fcltyApplVO.mngrAt eq 'N') ? '아니오' : '예'}"/></td>
        </tr>
        <tr>
            <th scope="row">생성자 ID / 생성일</th>
            <td><c:out value="${fcltyApplVO.frstRegisterId}"/> / <c:out value="${tsu:toDateFormat(fcltyApplVO.frstRegisterPnttm, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/></td>
        </tr>

        <c:if test="${not empty fcltyApplVO.lastUpdusrId}">
        <tr>
            <th scope="row">마지막 수정자 ID / 마지막 수정일</th>
            <td><c:out value="${fcltyApplVO.lastUpdusrId}"/> / <c:out value="${tsu:toDateFormat(fcltyApplVO.lastUpdusrPnttm, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/></td>
        </tr>
        </c:if>
        </tbody>
    </table>

    <%--    // todo 감면코드, 감면금액 --%>

    <div class="h3">예약 정보</div>
    <table class="p-table p-table--hover">
        <caption>예약 정보 상세보기</caption>
        <colgroup>
            <col class="w20p">
            <col />
            <col class="w20p">
            <col />
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
            <th scope="row">예약번호</th>
            <td>
                <!-- [예약고유번호] <c:out value="${fcltyApplVO.fcltyApplNo}"/> -->
                <c:out value="${fcltyApplVO.fcltyApplId}"/>
            </td>
            <th scope="row">신청일시 (밀리초)</th>
            <td>
                <c:out value="${tsu:toDateFormat(fcltyApplVO.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd HH:mm:ss (SSS)')}"/>
            </td>
        </tr>

        <tr>
            <th scope="row">시설사용 예약일 (사용시간 - 분단위)</th>
            <td>
                <!-- [스케줄 고유번호] <c:out value="${fcltyApplVO.fcltySchdNo}"/> -->
                <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyBgnHm, 'HHmm', 'HH:mm')}"/> ~
                <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyEndHm, 'HHmm', 'HH:mm')}"/>
                (${fcltyApplVO.tmInterval}분)
            </td>
            <th scope="row">예약상태</th>
            <td>
                <c:out value="${rsvSttusMap[fcltyApplVO.rsvSttusCd]}"/>
            </td>
        </tr>

        <c:if test="${fcltyVO.slctMthdCd eq 'DRWLT'}">
            <tr>
                <th scope="row">추첨상태</th>
                <td>
                    <c:choose>
                        <c:when test="${!empty fcltyApplVO.drwtWinYn}">
                            추첨완료
                            <c:if test="${fcltyApplVO.drwtWinYn eq 'Y'}">
                                <span class="em_blue">(당첨)</span>
                            </c:if>
                            <c:if test="${fcltyApplVO.drwtWinYn eq 'N'}">
                                <span class="em_gray">(미당첨)</span>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            미추첨
                        </c:otherwise>
                    </c:choose>
                </td>
                <th scope="row">추첨일시</th>
                <td>
                    <c:out value="${tsu:toDateFormat(fcltyApplVO.applCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                </td>
            </tr>
        </c:if>

        <c:if test="${fcltyVO.slctMthdCd eq 'CONFM'}">
        <tr>
            <th scope="row">승인상태</th>
            <td>
                <c:choose>
                    <c:when test="${fcltyApplVO.rsvSttusCd eq 'APPL_CMPL'}">승인</c:when>
                    <c:otherwise>미승인</c:otherwise>
                </c:choose>
            </td>
            <th scope="row">승인일시</th>
            <td>
                <c:out value="${tsu:toDateFormat(fcltyApplVO.applCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
        </tr>
        </c:if>

        <c:if test="${fcltyVO.fcltyAmt > 0}">
            <tr>
                <th scope="row">결제상태</th>
                <td>
                    <c:out value="${paySttusMap[fcltyApplVO.paySttusCd]}"/>
                </td>
                <th scope="row">결제금액</th>
                <td>
                    <fmt:formatNumber value="${fcltyApplVO.totalPayAmt}" pattern="#,##0"/> 원
                </td>
            </tr>

            <tr>
                <th scope="row">결제기한</th>
                <td>
                    <c:out value="${tsu:toDateFormat(fcltyApplVO.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                </td>
                <th scope="row">결제방법</th>
                <td>
                    <c:out value="${payMthdMap[fcltyApplVO.payMthdCd]}"/>
                    <c:if test="${fcltyApplVO.payMthdCd == 'ELCTRN' && !empty fcltyApplVO.tossMethod}">
                        (<c:out value="${fcltyApplVO.tossMethod}"/>)
                    </c:if>
                </td>
            </tr>

            <tr>
                <th scope="row">결제일시</th>
                <td colspan="3">
                    <c:out value="${tsu:toDateFormat(fcltyApplVO.payDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                </td>
            </tr>
        </c:if>

        <tr>
            <th scope="row">취소가능일시</th>
            <td>
                <c:out value="${tsu:toDateFormat(fcltyApplVO.canclClosDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
            <th scope="row">취소일시</th>
            <td>
                <c:out value="${tsu:toDateFormat(fcltyApplVO.cancelDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
            </td>
        </tr>

        <tr>
            <th scope="row">취소사유</th>
            <td colspan="3">
                <c:out value="${fcltyApplVO.cancelReason}"/>
            </td>
        </tr>

        <c:if test="${fcltyVO.fcltyAmt > 0}">
            <tr>
                <th scope="row">환불요청일시</th>
                <td>
                    <c:out value="${tsu:toDateFormat(fcltyApplVO.rfndReqDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                </td>
                <th scope="row">환불사유</th>
                <td>
                    <c:out value="${fcltyApplVO.rfndReason}"/>
                </td>
            </tr>

            <tr>
                <th scope="row">환불계좌</th>
                <td>
                    <c:if test="${not empty fcltyApplVO.rfndAcctNo}">
                        <c:out value="${bankMap[fcltyApplVO.rfndBankNm]}"/> <c:out value="${fcltyApplVO.rfndAcctNo}"/> (예금주:<c:out value="${fcltyApplVO.rfndDpstrNm}"/>)
                    </c:if>
                </td>
                <th scope="row">환불처리일시</th>
                <td>
                    <c:out value="${tsu:toDateFormat(fcltyApplVO.rfndCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/>
                </td>
            </tr>

            <tr>
                <th scope="row">환불금액</th>
                <td colspan="3">
                    <c:if test="${fcltyApplVO.rfndAmt > 0}">
                        <fmt:formatNumber value="${fcltyApplVO.rfndAmt}" pattern="#,##0"/> 원
                    </c:if>
                </td>
            </tr>
        </c:if>

        <tr>
            <th scope="row">메모</th>
            <td colspan="3">
                <c:out value="${fcltyApplVO.memo}"/>
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
            <a href="./updateFcltyApplView.do?fcltyApplNo=<c:out value="${fcltyApplVO.fcltyApplNo}"/>&key=<c:out value="${key}"/>" class="p-button p-button--small edit">수정</a>
        </div>
    </div>

</div>

</body>
</html>
