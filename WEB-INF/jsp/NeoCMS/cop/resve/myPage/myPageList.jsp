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
    <meta name="decorator" content="${menuInfo.siteId}" />
    <title>${menuInfo.cntntsNm} 목록</title>
</head>
<body>

<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyyMMddHHmmss" var="nowDateTime"/>

<c:set var="prgSe" value="${myPageSearchVO.prgSe}"/>

<ul class="tabButtons">
    <li><a href="./myPageList.do?key=<c:out value="${key}"/>"<c:if test="${empty prgSe}"> class="current"</c:if>>전체</a></li>
    <c:forEach var="result" items="${prgSeList}">
        <li><a href="./myPageList.do?key=<c:out value="${key}"/>&amp;prgSe=<c:out value="${result.code}"/>"<c:if test="${prgSe == result.code}"> class="current"</c:if>><c:out value="${result.codeNm}"/></a></li>
    </c:forEach>
</ul>

<c:if test="${empty prgSe || prgSe == 'EDU'}">
<div class="flexWrap marginTop40">
    <div class="flexLeft">
        <h4>교육/강좌</h4>
    </div>
    <c:if test="${empty prgSe}">
        <div class="flexRight">
            <a href="./myPageList.do?key=<c:out value="${key}"/>&amp;prgSe=EDU" class="customLink isIcon afterIcon plus"><span>더보기</span></a>
        </div>
    </c:if>
</div>
    <table class="table boardList">
        <caption>교육/강좌-예약번호, 프로그램명, 운영기관, 운영기간, 운영시간/요일, 이수여부, 결제상태, 예약상태, 예약취소</caption>
        <thead>
        <tr>
            <th scope="col" class="first">예약번호</th>
            <th scope="col">프로그램명</th>
            <th scope="col">운영기관</th>
            <th scope="col">운영기간</th>
            <th scope="col">운영시간/요일</th>
            <th scope="col">이수여부</th>
            <th scope="col">결제상태</th>
            <th scope="col">예약상태</th>
            <th scope="col">예약취소</th>
        </tr>
        </thead>
        <tbody class="textAlignCenter">
        <c:set var="eduRowCnt" value="9"/>
        <c:if test="${empty prgSe}">
            <c:set var="eduRowCnt" value="2"/>
        </c:if>
        <c:forEach var="result" items="${eduAplctList}" end="${eduRowCnt}">
            <tr>
                <td class="first">
                    <span class="mobile-th">예약번호</span>
                    <a href="./myPageViewByEdu.do?key=<c:out value="${key}"/>&amp;eduAplyNo=<c:out value="${result.eduAplyNo}"/>&amp;myPageMode=VIEW"><span><c:out value="${result.eduRsvtNo}"/></span></a>
                </td>
                <td class="textAlignLeft"><span class="mobile-th">프로그램명</span><c:out value="${result.lctreNm}"/></td>
                <td><span class="mobile-th">운영기관</span><c:out value="${result.insttNm}"/></td>
                <td>
                    <span class="mobile-th">운영기간</span>
                    <c:if test="${not empty result.lctBgnDt}">
                        <c:out value="${tsu:toDateFormat(result.lctBgnDt, 'yyyyMMddHHmm', 'yyyy-MM-dd')}"/>
                    </c:if>
                    ~
                    <c:if test="${not empty result.lctEndDt}">
                        <c:out value="${tsu:toDateFormat(result.lctEndDt, 'yyyyMMddHHmm', 'yyyy-MM-dd')}"/>
                    </c:if>
                </td>
                <td>
                    <span class="mobile-th">운영시간/요일</span>
                    <c:if test="${not empty result.lctBgnDt}">
                        <c:out value="${tsu:toDateFormat(result.lctBgnDt, 'yyyyMMddHHmm', 'HH:mm')}"/>
                    </c:if>
                    ~
                    <c:if test="${not empty result.lctEndDt}">
                        <c:out value="${tsu:toDateFormat(result.lctEndDt, 'yyyyMMddHHmm', 'HH:mm')}"/>
                    </c:if>
                    <c:if test="${not empty result.lctWeek}">
                        /
                        <c:set var="weekDays" value="일,월,화,수,목,금,토"/>
                        <c:set var="weekArray" value="${fn:split(weekDays, ',')}"/>
                        <c:set var="lctWeekArray" value="${fn:split(result.lctWeek, ',')}"/>
                        <c:forEach var="weekIdx" items="${lctWeekArray}" varStatus="status">
                            <c:set var="idx" value="${fn:trim(weekIdx)}"/>
                            <c:if test="${idx >= 1 && idx <= 7}">
                                <c:out value="${weekArray[idx - 1]}"/>
                            </c:if>
                            <c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty result.lctBgnDt && empty result.lctEndDt && empty result.lctWeek}">
                        -
                    </c:if>
                </td>
                <td>
                    <span class="mobile-th">이수여부</span>
                    <c:choose>
                        <c:when test="${result.fnshYn == 'Y'}">
                            <a href="" class="customLink"><span>수료</span></a>
                        </c:when>
                        <c:otherwise>
                            미수료
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <span class="mobile-th">결제상태</span>
                    <c:choose>
                        <c:when test="${!fn:contains(result.resveSttusCd, 'CNCL') && result.payMthdCd == 'ELCTRN' && result.paySttusCd == 'PAY_WAIT' && empty result.tossMethod}">
                            <a href="./myPageViewByEdu.do?key=<c:out value="${key}"/>&amp;eduAplyNo=<c:out value="${result.eduAplyNo}"/>&amp;myPageMode=VIEW" class="customLink bgBlack"><span>결제하기</span></a>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${eduPayMap[result.paySttusCd]}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><span class="mobile-th">예약상태</span>
                    <c:choose>
                        <c:when test="${!empty result.drwtWinYn}">
                            추첨완료<br/>
                            <c:if test="${result.drwtWinYn eq 'Y'}">
                                <span class="em_blue">(당첨)</span>
                            </c:if>
                            <c:if test="${result.drwtWinYn eq 'N'}">
                                <span class="em_gray">(미당첨)</span>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${eduRsvMap[result.resveSttusCd]}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <span class="mobile-th">예약취소</span>
                        <%--
                            취소/환불 가능 조건:
                            - 폐강이 아니고 (closeYn != 'Y')
                            - 접수마감일이 지나지 않았을 때
                              (추가접수마감일이 있으면 추가접수마감일, 없으면 일반접수마감일 기준)
                        --%>
                    <c:set var="canCancel" value="false"/>
                    <c:if test="${result.closeYn != 'Y'}">
                        <%-- 접수마감일 확인: 추가접수마감일이 있으면 우선, 없으면 일반접수마감일 --%>
                        <c:set var="deadlineDt" value="${not empty result.addRcptEndDt ? result.addRcptEndDt : result.rcptEndDt}"/>
                        <c:if test="${not empty deadlineDt and nowDateTime <= deadlineDt}">
                            <c:set var="canCancel" value="true"/>
                        </c:if>
                    </c:if>

                    <c:if test="${canCancel}">
                        <%--
                            취소 요청 버튼 활성화 조건:
                            - 예약상태 : 사용자취소(USR_CNCL) or 관리자취소(MNG_CNCL) 아닌 상태
                            - 결제상태 : 무료(PAY_FREE) or 결제대기(PAY_WAIT)+전자결제(가상계좌)X
                        --%>
                        <c:if test="${!fn:contains(result.resveSttusCd, 'CNCL') && (result.paySttusCd == 'PAY_FREE' || (result.paySttusCd == 'PAY_WAIT' && result.tossMethod != '가상계좌'))}">
                            <button type="button" class="customLink" onclick="fn_eduAplctCnclAjax(<c:out value="${result.eduAplyNo}"/>)"><span>취소</span></button>
                        </c:if>
                        <%--
                            환불 요청 버튼 활성화 조건:
                            - 예약상태 : 사용자취소(USR_CNCL) or 관리자취소(MNG_CNCL) 아닌 상태
                            - 결제상태 : 결제완료(PAY_CMPL) or 결제대기(PAY_WAIT)+전자결제(가상계좌)O
                        --%>
                        <c:if test="${!fn:contains(result.resveSttusCd, 'CNCL') && (result.paySttusCd == 'PAY_CMPL' || (result.paySttusCd == 'PAY_WAIT' && result.tossMethod == '가상계좌'))}">
                            <button type="button" class="customLink" data-modal-button="modal3" data-appl-no="<c:out value="${result.eduAplyNo}"/>" data-prg-se="EDU"><span>환불요청</span></button>
                        </c:if>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(eduAplctList) == 0}">
            <tr>
                <td class="first" colspan="9">
                    <div>
                        <img src="/site/www/images/search/img-noImage.png" alt="데이터가 없습니다">
                        <p class="textAlignCenter marginTop20">예약한 프로그램이 없습니다</p>
                    </div>
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</c:if>

<c:if test="${empty prgSe || prgSe == 'EXP'}">
<div class="flexWrap marginTop40">
    <div class="flexLeft">
        <h4>체험/견학</h4>
    </div>
    <c:if test="${empty prgSe}">
        <div class="flexRight">
            <a href="./myPageList.do?key=<c:out value="${key}"/>&amp;prgSe=EXP" class="customLink isIcon afterIcon plus"><span>더보기</span></a>
        </div>
    </c:if>
</div>

    <table class="table boardList">
        <caption>체험/견학-예약번호, 프로그램명, 운영기관, 신청일자, 체험일자, 체험시간, 결제상태, 예약상태, 예약취소</caption>
        <thead>
        <tr>
            <th scope="col" class="first">예약번호</th>
            <th scope="col">프로그램명</th>
            <th scope="col">운영기관</th>
            <th scope="col">신청일자</th>
            <th scope="col">체험일자</th>
            <th scope="col">체험시간</th>
            <th scope="col">결제상태</th>
            <th scope="col">예약상태</th>
            <th scope="col">예약취소</th>
        </tr>
        </thead>
        <tbody class="textAlignCenter">
        <c:set var="expRowCnt" value="9"/>
        <c:if test="${empty prgSe}">
            <c:set var="expRowCnt" value="2"/>
        </c:if>
        <c:forEach var="result" items="${exprnApplList}" end="${expRowCnt}">
            <c:set var="todate" value="${result.today}${result.now}" />
            <tr>
                <td class="first"><span class="mobile-th">예약번호</span><a href="./myPageViewByExprn.do?exprnApplNo=<c:out value="${result.exprnApplNo}"/>&amp;<c:out value="${myPageSearchVO.params}"/>&amp;myPageMode=VIEW"><span><c:out value="${result.exprnApplId}"/></span></a></td>
                <td class="textAlignLeft"><span class="mobile-th">프로그램명</span><c:out value="${result.exprnNm}"/></td>
                <td>
                    <span class="mobile-th">운영기관</span>
                    <c:set var="insttNo" value="instt${result.insttNo}"/>
                    <c:out value="${expInsttMap[insttNo]}"/>
                </td>
                <td>
                    <span class="mobile-th">신청일자</span>
                    <c:out value="${tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd(EE)')}"/>
                    <c:out value="${tsu:toDateFormat(fn:substring(result.applDtMs, 8, 14), 'HHmmss', 'HH:mm:ss')}"/>
                </td>
                <td><span class="mobile-th">체험일자</span><c:out value="${tsu:toDateFormat(result.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd(EE)')}"/></td>
                <td><span class="mobile-th">체험시간</span><c:out value="${tsu:toDateFormat(result.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(result.exprnEndHm, 'HHmm', 'HH:mm')}"/></td>
                <td><span class="mobile-th">결제상태</span>
                    <c:set var="todate" value="${result.today}${result.now}" />
                    <c:choose>
                        <c:when test="${result.payMthdCd == 'ELCTRN' && result.rsvSttusCd == 'APPL_CMPL' && result.paySttusCd == 'PAY_WAIT' && empty result.tossMethod && todate <= result.payDeadlineDt}">
                            <a href="./myPageViewByExprn.do?key=<c:out value="${key}"/>&amp;exprnApplNo=<c:out value="${result.exprnApplNo}"/>&amp;myPageMode=VIEW" class="customLink bgBlack"><span>결제하기</span></a>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${expPayMap[result.paySttusCd]}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><span class="mobile-th">예약상태</span>
                    <c:choose>
                        <c:when test="${!empty result.drwtWinYn}">
                            추첨완료<br/>
                            <c:if test="${result.drwtWinYn eq 'Y'}">
                                <span class="em_blue">(당첨)</span>
                            </c:if>
                            <c:if test="${result.drwtWinYn eq 'N'}">
                                <span class="em_gray">(미당첨)</span>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${expRsvMap[result.rsvSttusCd]}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <span class="mobile-th">예약취소</span>
                    <%--
                        취소가능일자 또는 체험일자가 지나지 않고
                        예약상태 : 사용자취소(USR_CNCL) or 관리자취소(MNG_CNCL) 아닌 상태
                        경우에만 취소 or 환불 요청 가능
                    --%>
                    <c:set var="exprnDt" value="${result.exprnDe}${result.exprnBgnHm}" />
                    <c:if test="${(todate <= result.canclClosDt || todate < exprnDt) && !fn:contains(result.rsvSttusCd, 'CNCL')}">
                        <%--
                            결제상태 paySttusCd, 결제방법 payMthdCd 에 따라 취소/환불 버튼 활성화
                            무료(PAY_FREE) : 취소 가능
                            결제대기(PAY_WAIT)
                              - 전자결제 ELCTRN + 토스미결제 : 취소 가능
                              - 전자결제 ELCTRN + 토스결제(가상계좌 신청만 한 상태) : 환불 가능
                              - 무통장입금 NBKRCP, 현장결제 DIRECT : 취소 가능
                            결제완료(PAY_CMPL)
                              - 전자결제 ELCTRN (카드, 계좌이체, 간편결제) : 환불 가능
                              - 전자결제 ELCTRN (가상계좌) : 환불 가능(환불계좌 정보 입력 필요)
                              - 무통장입금 NBKRCP, 현장결제 DIRECT : 환불 가능(환불계좌 정보 입력 필요)
                        --%>
                        <c:choose>
                            <c:when test="${result.paySttusCd == 'PAY_FREE'}">
                                <button type="button" class="customLink" onclick="fn_applCnclAjax('EXP', <c:out value="${result.exprnApplNo}"/>)"><span>취소</span></button>
                            </c:when>
                            <c:when test="${result.paySttusCd == 'PAY_WAIT'}">
                                <c:choose>
                                    <c:when test="${result.payMthdCd == 'ELCTRN' && result.tossMethod == '가상계좌'}">
                                        <button type="button" class="customLink" onclick="fn_applRfndAjax('EXP', <c:out value="${result.exprnApplNo}"/>, null, null, null, null)"><span>환불요청</span></button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="customLink" onclick="fn_applCnclAjax('EXP', <c:out value="${result.exprnApplNo}"/>)"><span>취소</span></button>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:when test="${result.paySttusCd == 'PAY_CMPL'}">
                                <c:choose>
                                    <c:when test="${result.payMthdCd == 'ELCTRN' && (result.tossMethod == '카드' || result.tossMethod == '계좌이체' || result.tossMethod == '간편결제')}">
                                        <button type="button" class="customLink" onclick="fn_applRfndAjax('EXP', <c:out value="${result.exprnApplNo}"/>, null, null, null, null)"><span>환불요청</span></button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" class="customLink" data-modal-button="modal3" data-appl-no="<c:out value="${result.exprnApplNo}"/>" data-prg-se="EXP"><span>환불요청</span></button>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                        </c:choose>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(exprnApplList) == 0}">
            <td class="first" colspan="9">
                <div>
                    <img src="/site/www/images/search/img-noImage.png" alt="데이터가 없습니다">
                    <p class="textAlignCenter marginTop20">예약한 프로그램이 없습니다</p>
                </div>
            </td>
        </c:if>
        </tbody>
    </table>
</c:if>
<c:if test="${prgSe == 'EXP'}">
    <div class="p-pagination">
        <div class="p-page">
            <ui:pagination paginationInfo="${expPaginationInfo}" type="board" jsFunction="./myPageList.do?${myPageSearchVO.paramsExclPi}&amp;pageIndex=" />
        </div>
    </div>
</c:if>

<c:if test="${empty prgSe || prgSe == 'FCT'}">
<div class="flexWrap marginTop40">
    <div class="flexLeft">
        <h4>시설</h4>
    </div>
    <c:if test="${empty prgSe}">
        <div class="flexRight">
            <a href="./myPageList.do?key=<c:out value="${key}"/>&amp;prgSe=FCT" class="customLink isIcon afterIcon plus"><span>더보기</span></a>
        </div>
    </c:if>
</div>
    <table class="table boardList">
        <caption>시설-예약번호, 시설명, 운영기관, 신청일자, 예약일자, 예약시간, 결제상태, 예약상태, 예약취소</caption>
        <thead>
        <tr>
            <th scope="col" class="first">예약번호</th>
            <th scope="col">시설명</th>
            <th scope="col">운영기관</th>
            <th scope="col">신청일자</th>
            <th scope="col">예약일자</th>
            <th scope="col">예약시간</th>
            <th scope="col">결제상태</th>
            <th scope="col">예약상태</th>
            <th scope="col">예약취소</th>
        </tr>
        </thead>
        <tbody class="textAlignCenter">
        <c:forEach var="result" items="${fcltyApplList}">
            <tr>
                <td class="first"><span class="mobile-th">예약번호</span><a href="./myPageViewByFclty.do?key=<c:out value="${key}"/>&amp;fcltyApplNo=<c:out value="${result.fcltyApplNo}"/>&amp;myPageMode=VIEW"><span><c:out value="${result.fcltyApplId}"/></span></a></td>
                <td class="textAlignLeft"><span class="mobile-th">시설명</span><c:out value="${result.fcltyNm}"/></td>
                <td><span class="mobile-th">운영기관</span>
                    <c:set var="insttNo" value="instt${result.insttNo}"/>
                    <c:out value="${fctInsttMap[insttNo]}"/>
                </td>
                <td><span class="mobile-th">신청일자</span>
                    <c:out value="${tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd(EE)')}"/>
                    <c:out value="${tsu:toDateFormat(result.applDtMs, 'yyyyMMddHHmmssSSS', 'HH:mm:ss')}"/>
                </td>
                <td><span class="mobile-th">예약일자</span><c:out value="${tsu:toDateFormat(result.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd(EE)')}"/></td>
                <td><span class="mobile-th">예약시간</span><c:out value="${tsu:toDateFormat(result.fcltyBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(result.fcltyEndHm, 'HHmm', 'HH:mm')}"/></td>
                <td><span class="mobile-th">결제상태</span><c:out value="${fctPayMap[result.paySttusCd]}"/></td>
                <td><span class="mobile-th">예약상태</span>
                    <c:choose>
                        <c:when test="${!empty result.drwtWinYn}">
                            추첨완료<br/>
                            <c:if test="${result.drwtWinYn eq 'Y'}">
                                <span class="em_blue">(당첨)</span>
                            </c:if>
                            <c:if test="${result.drwtWinYn eq 'N'}">
                                <span class="em_gray">(미당첨)</span>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${fctRsvMap[result.rsvSttusCd]}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><span class="mobile-th">예약취소</span>
                    <%-- 시설 취소가능일자가 지나지 않은 경우에만 취소(환불)요청 가능 --%>
                    <c:if test="${empty result.canclClosDt or ((tsu:getNowDateTime('yyyyMMddHHmmss')+0) lt (result.canclClosDt+0))}">
                        <%--
                            시설 아래 상태값에 해당하는 경우에만 취소 요청 버튼 활성화
                            - 예약상태 : 사용자취소(USR_CNCL) or 관리자취소(MNG_CNCL) 아닌 상태
                            - 결제상태 : 무료(PAY_FREE) or 결제대기(PAY_WAIT)+전자결제(가상계좌)X / 결제대기의 경우 전자결제(가상계좌)는 가상계좌 발급했기 때문에 환불요청을 해야한다.
                        --%>
                        <c:if test="${!fn:contains(result.rsvSttusCd, 'CNCL') && (result.paySttusCd eq 'PAY_FREE' || (result.paySttusCd eq 'PAY_WAIT' && result.tossMethod ne '가상계좌'))}">
                            <button type="button" class="customLink" onclick="fn_fcltyApplCnclAjax('<c:out value="${result.fcltyApplNo}"/>')"><span>취소</span></button>
                        </c:if>

                        <%--
                            시설 아래 상태값에 해당하는 경우에만 환불 요청 버튼 활성화
                            - 예약상태 : 사용자취소(USR_CNCL) or 관리자취소(MNG_CNCL) 아닌 상태
                            - 결제상태 : 결제완료(PAY_CMPL) or 결제대기(PAY_WAIT)+전자결제(가상계좌)O / 결제대기의 경우 전자결제(가상계좌)는 가상계좌 발급했기 때문에 환불요청을 해야한다.
                        --%>
                        <c:if test="${!fn:contains(result.rsvSttusCd, 'CNCL') && (result.paySttusCd eq 'PAY_CMPL' || (result.paySttusCd eq 'PAY_WAIT' && result.tossMethod eq '가상계좌'))}">
                            <c:choose>
                                <c:when test="${result.tossMethod eq '카드' || result.tossMethod eq '간편결제'}">
                                    <button type="button" class="customLink" data-modal-button="modal3" onclick="fn_fcltyApplRfndAjax(<c:out value="${result.fcltyApplNo}"/>)"><span>환불요청</span></button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="customLink" data-modal-button="modal3" data-appl-no="<c:out value="${result.fcltyApplNo}"/>" data-prg-se="FCT"><span>환불요청</span></button>
                                </c:otherwise>
                            </c:choose>
                        </c:if>

                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(fcltyApplList) == 0}">
            <td class="first" colspan="9">
                <div>
                    <img src="/site/www/images/search/img-noImage.png" alt="데이터가 없습니다">
                    <p class="textAlignCenter marginTop20">예약한 시설 정보가 없습니다</p>
                </div>
            </td>
        </c:if>
        </tbody>
    </table>
</c:if>

<script>

    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('[data-modal-button="modal3"]').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const target = e.currentTarget;
                const prgSe = target.dataset.prgSe;
                const applNo = target.dataset.applNo;

                document.querySelector('#prgSe').value = prgSe;
                document.querySelector('#rfndApplNo').value = applNo;
            });
        });

        document.querySelectorAll('.modalCloseButton, [data-modal-close]').forEach( button => {
            button.addEventListener('click', () => {
                document.querySelector('#prgSe').value = '';
                document.querySelector('#rfndApplNo').value = '';
                document.querySelector('#rfndBankNm').value = '';
                document.querySelector('#rfndAcctNo').value = '';
                document.querySelector('#rfndDpstrNm').value = '';
                document.querySelector('#rfndReason').value = '';
            });
        });
    });

    function fn_applCnclAjax(prgSe, cancelApplNo) {
        if (!confirm('취소하시겠습니까?')) {
            return false;
        }

        var ajaxUrl = '';
        var ajaxData = {};

        if (prgSe != '') {
            if (prgSe == 'EXP') {
                ajaxUrl = './updateExprnApplCnclAjax.do';
                ajaxData = {
                    exprnApplNo: cancelApplNo,
                };
            }

            $.ajax({
                cache: false,
                url: ajaxUrl,
                type: 'POST',
                data: ajaxData,
                success: function (res) {
                    if (res == 1) {
                        alert("취소 처리되었습니다.");
                        location.reload();
                    } else if (res == -1) {
                        alert("신청 정보를 확인할 수 없습니다.");
                    } else if (res == -2) {
                        alert("이미 취소된 건입니다. 다시 확인해주시기 바랍니다.");
                    } else if (res == -3) {
                        alert("결제가 완료되었거나 환불 요청이 필요한 상태입니다. 다시 확인해주시기 바랍니다.");
                    } else if (res == -4) {
                        alert("취소가능일자가 지나 취소가 불가합니다.");
                    } else {
                        alert("처리된 내역이 없습니다.");
                    }
                }, // success
                error: function (request, xhr, status) {
                    //alert(request.responseText);
                    alert("에러가 발생하였습니다.");
                    console.log("code:", request.status);
                    console.log("message:", request.responseText);
                    console.log("error:" + error)
                }
            });
        }
    }

    function fn_applRfnd() {

        var prgSe = $('input[name=prgSe]');
        var rfndApplNo = $('input[name=rfndApplNo]');
        var rfndBankNm = $('select[name=rfndBankNm]');
        var rfndAcctNo = $('input[name=rfndAcctNo]');
        var rfndDpstrNm = $('input[name=rfndDpstrNm]');
        var rfndReason = $('input[name=rfndReason]');

        if (!rfndBankNm.val()) {
            alert('은행명을 입력해주세요.');
            rfndBankNm.focus();
            return false;
        }
        if (!rfndAcctNo.val()) {
            alert('계좌번호를 입력해주세요.');
            rfndAcctNo.focus();
            return false;
        }

        if (!rfndDpstrNm.val()) {
            alert('예금주를 입력해주세요.');
            rfndDpstrNm.focus();
            return false;
        }
        if (!rfndReason.val()) {
            alert('취소(환불요청)사유를 입력해주세요.');
            rfndReason.focus();
            return false;
        }

        fn_applRfndAjax(prgSe.val(), rfndApplNo.val(), rfndBankNm.val(), rfndAcctNo.val(), rfndDpstrNm.val(), rfndReason.val());
    }

    function fn_applRfndAjax(prgSe, rfndApplNo, rfndBankNm, rfndAcctNo, rfndDpstrNm, rfndReason) {
        if (!confirm('취소(환불요청)하시겠습니까?')) {
            return false;
        }

        var ajaxUrl = '';
        var ajaxData = {};

        if (prgSe != '') {
            if (prgSe == 'EXP') {
                ajaxUrl = './updateExprnApplRfndAjax.do';
                ajaxData = {
                    exprnApplNo: rfndApplNo,
                    rfndBankNm: rfndBankNm,
                    rfndAcctNo: rfndAcctNo,
                    rfndDpstrNm: rfndDpstrNm,
                    rfndReason: rfndReason
                };
            } else if (prgSe == 'EDU') {
                ajaxUrl = './updateEduAplctRfndAjax.do?key='+<c:out value="${key}"/>;
                ajaxData = {
                    eduAplyNo: rfndApplNo,
                    rfndBankNm: rfndBankNm,
                    rfndAcctNo: rfndAcctNo,
                    rfndDpstrNm: rfndDpstrNm,
                    rfndReason: rfndReason
                };
            } else {
                alert("처리할 수 없는 프로그램 유형입니다.");
                return false;
            }

            $.ajax({
                cache: false,
                url: ajaxUrl,
                type: 'POST',
                data: ajaxData,
                success: function (res) {
                    if (res == 1) {
                        alert("환불요청이 접수되었습니다.");
                        location.reload();
                    } else if (res == -1) {
                        alert("신청 정보를 확인할 수 없습니다.");
                    } else if (res == -2) {
                        alert("취소가능일자가 지나 취소가 불가합니다.");
                    } else if (res == -3) {
                        alert("이미 취소된 건입니다. 다시 확인해주시기 바랍니다.");
                    } else if (res == -4) {
                        alert("환불 요청이 불가능한 상태입니다.");
                    } else if (res == -5) {
                        alert("결제대기 중입니다. 결제가 완료된 건에 한하여 환불 요청이 가능합니다.");
                    } else if (res == -6) {
                        alert("환불요청 관련 입력 정보(계좌정보, 환불사유 등)를 다시 확인해주시기 바랍니다.");
                    } else {
                        alert("처리된 내역이 없습니다.");
                    }
                }, // success
                error: function (request, xhr, status) {
                    //alert(request.responseText);
                    alert("에러가 발생하였습니다.");
                    console.log("code:", request.status);
                    console.log("message:", request.responseText);
                    console.log("error:" + status)
                }
            });
        }
    }

    /* 교육 취소 처리 */
    function fn_eduAplctCnclAjax(eduAplyNo) {
        if (!confirm('취소하시겠습니까?')) {
            return false;
        }

        $.ajax({
            url: './updateEduAplctCnclAjax.do?key='+${key},
            type: 'POST',
            data: {
                eduAplyNo: eduAplyNo
            },
            success: function (res) {
                if (res == 1) {
                    alert("취소 처리되었습니다.");
                    location.reload();
                } else if (res == -1) {
                    alert("신청 정보를 확인할 수 없습니다.");
                } else if (res == -2) {
                    alert("이미 취소된 건입니다. 다시 확인해주시기 바랍니다.");
                } else if (res == -3) {
                    alert("결제가 완료되었거나 환불 요청이 필요한 상태입니다. 다시 확인해주시기 바랍니다.");
                } else if (res == -4) {
                    alert("취소가능일자가 지나 취소가 불가합니다.");
                } else {
                    alert("처리된 내역이 없습니다.");
                }
            },
            error: function (request, xhr, status) {
                alert("에러가 발생하였습니다.");
                console.log("code:", request.status);
                console.log("message:", request.responseText);
                console.log("error:" + status)
            }
        });
    }

    function fn_fcltyApplCnclAjax(cancelApplNo) {
        if (!confirm('취소하시겠습니까?')) {
            return false;
        }

        // console.log(cancelApplNo)

        $.ajax({
            cache: false,
            url: './updateFcltyApplCnclAjax.do',
            type: 'POST',
            data: {fcltyApplNo: cancelApplNo},
            success: function (res) {
                if (res == 1) {
                    alert("취소 처리되었습니다.");
                    location.reload();
                } else if (res == -1) {
                    alert("신청 정보를 확인할 수 없습니다.");
                } else if (res == -2) {
                    alert("이미 취소된 건입니다. 다시 확인해주시기 바랍니다.");
                } else if (res == -3) {
                    alert("결제가 완료되었거나 환불 요청이 필요한 상태입니다. 다시 확인해주시기 바랍니다.");
                } else if (res == -4) {
                    alert("취소가능일자가 지나 취소가 불가합니다.");
                } else {
                    alert("처리된 내역이 없습니다.");
                }
            }, // success
            error: function (request, xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                console.log("code:", request.status);
                console.log("message:", request.responseText);
                console.log("error:" + error)
            }
        });
    }
</script>
</body>
</html>
