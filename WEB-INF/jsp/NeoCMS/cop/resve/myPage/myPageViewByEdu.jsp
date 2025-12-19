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
    <title>${menuInfo.cntntsNm} 상세보기</title>
</head>
<body>

<c:if test="${myPageMode == 'UPDT'}">
<form method="post" action="./myPageUpdateByEdu.do" onsubmit="return formCheck(this);">
    <input type="hidden" name="eduAplyNo" value="<c:out value="${eduAplctVO.eduAplyNo}"/>">
    <input type="hidden" name="myPageMode" value="<c:out value="${myPageMode}"/>">
    <input type="hidden" name="telNo" value="<c:out value="${eduAplctVO.telNo}"/>">
    <input type="hidden" name="email" value="<c:out value="${eduAplctVO.email}"/>">
    <c:forEach var="result" items="${myPageSearchVO.paramsMap}">
        <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
    </c:forEach>
    <fieldset>
        <legend>신청 정보 수정-예약번호, 신청상태, 결제상태, 성명, 생년월일, 성별, 연락처, 이메일, 주소, 신청일시</legend>
</c:if>
        <c:set var="todate" value="${eduLctreVO.nowDateTime}" />
        <h4>교육/강좌</h4>
        <h5>프로그램 정보</h5>
        <div class="scrollWrap-table">
            <table class="table default" data-table-response>
                <caption>프로그램 정보-강좌명, 운영기관, 접수기간, 교육기간, 교육시간/요일</caption>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody class="textAlignLeft">
                <tr>
                    <th scope="row" class="first">강좌명</th>
                    <td colspan="3"><strong><c:out value="${eduLctreVO.lctreNm}"/></strong></td>
                </tr>
                <tr>
                    <th scope="row" class="first">운영기관</th>
                    <td>
                        <strong><c:out value="${eduLctreVO.insttNm}"/></strong>
                    </td>
                    <th scope="row">접수기간</th>
                    <td>
                        <c:if test="${not empty eduLctreVO.rcptBgnDt && fn:length(eduLctreVO.rcptBgnDt) >= 12}">
                            <c:set var="rcptBgnDe" value="${fn:substring(eduLctreVO.rcptBgnDt, 0, 8)}"/>
                            <c:set var="rcptBgnHm" value="${fn:substring(eduLctreVO.rcptBgnDt, 8, 12)}"/>
                            ${fn:substring(rcptBgnDe, 0, 4)}.${fn:substring(rcptBgnDe, 4, 6)}.${fn:substring(rcptBgnDe, 6, 8)}
                            ${fn:substring(rcptBgnHm, 0, 2)}시
                        </c:if>
                        ~
                        <c:if test="${not empty eduLctreVO.rcptEndDt && fn:length(eduLctreVO.rcptEndDt) >= 12}">
                            <c:set var="rcptEndDe" value="${fn:substring(eduLctreVO.rcptEndDt, 0, 8)}"/>
                            <c:set var="rcptEndHm" value="${fn:substring(eduLctreVO.rcptEndDt, 8, 12)}"/>
                            ${fn:substring(rcptEndDe, 0, 4)}.${fn:substring(rcptEndDe, 4, 6)}.${fn:substring(rcptEndDe, 6, 8)}
                            ${fn:substring(rcptEndHm, 0, 2)}시
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first">교육기간</th>
                    <td>
                        <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 8}">
                            <c:set var="lctBgnDe" value="${fn:substring(eduLctreVO.lctBgnDt, 0, 8)}"/>
                            ${fn:substring(lctBgnDe, 0, 4)}-${fn:substring(lctBgnDe, 4, 6)}-${fn:substring(lctBgnDe, 6, 8)}
                        </c:if>
                        ~
                        <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 8}">
                            <c:set var="lctEndDe" value="${fn:substring(eduLctreVO.lctEndDt, 0, 8)}"/>
                            ${fn:substring(lctEndDe, 0, 4)}-${fn:substring(lctEndDe, 4, 6)}-${fn:substring(lctEndDe, 6, 8)}
                        </c:if>
                    </td>
                    <th scope="row">교육시간/요일</th>
                    <td>
                        <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 12}">
                            <c:set var="lctBgnHm" value="${fn:substring(eduLctreVO.lctBgnDt, 8, 12)}"/>
                            ${fn:substring(lctBgnHm, 0, 2)}:${fn:substring(lctBgnHm, 2, 4)}
                        </c:if>
                        ~
                        <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 12}">
                            <c:set var="lctEndHm" value="${fn:substring(eduLctreVO.lctEndDt, 8, 12)}"/>
                            ${fn:substring(lctEndHm, 0, 2)}:${fn:substring(lctEndHm, 2, 4)}
                        </c:if>
                        <c:if test="${not empty eduLctreVO.lctWeekNm}">
                            / <c:out value="${eduLctreVO.lctWeekNm}"/>
                            </c:if>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first">선발방식</th>
                    <td>
                        <c:out value="${slctMthdMap[eduLctreVO.slctMthdCd]}"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <h4>신청 정보 <c:if test="${myPageMode == 'UPDT'}">입력</c:if></h4>
        <c:if test="${myPageMode == 'UPDT'}">
            <p class="iconText comment"><span class="point-color-red">*</span>표시는 필수 입력 항목입니다.</p>
        </c:if>
        <div class="scrollWrap-table">
            <table class="table program formTable" data-table-response>
                <caption>신청 정보-예약번호, 교육기간/시간, 예약상태, 결제상태, 성명, 생년월일, 성별, 연락처, 이메일, 주소, 신청일시</caption>
                <colgroup>
                    <col style="width:15%">
                    <col>
                </colgroup>
                <tbody>
                <!-- 목록 데이터 없을때 공통으로 사용해주세요. td에 colspan 속성 thead의 th갯수에 맞춰주세요 -->
                <tr>
                    <th scope="row" class="first"><div class="innerCell">예약번호</div></th>
                    <td><div class="innerCell"><strong><c:out value="${eduAplctVO.eduRsvtNo}"/></strong></div></td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">교육기간</div></th>
                    <td>
                        <div class="innerCell">
                            <c:if test="${not empty eduAplctVO.lctBgnDt && fn:length(eduAplctVO.lctBgnDt) >= 8}">
                                <c:set var="applLctBgnDe" value="${fn:substring(eduAplctVO.lctBgnDt, 0, 8)}"/>
                                <c:out value="${fn:substring(applLctBgnDe, 0, 4)}-${fn:substring(applLctBgnDe, 4, 6)}-${fn:substring(applLctBgnDe, 6, 8)}"/>
                            </c:if>
                            <c:if test="${not empty eduAplctVO.lctBgnDt && not empty eduAplctVO.lctEndDt}">
                                ~
                            </c:if>
                            <c:if test="${not empty eduAplctVO.lctEndDt && fn:length(eduAplctVO.lctEndDt) >= 8}">
                                <c:set var="applLctEndDe" value="${fn:substring(eduAplctVO.lctEndDt, 0, 8)}"/>
                                <c:out value="${fn:substring(applLctEndDe, 0, 4)}-${fn:substring(applLctEndDe, 4, 6)}-${fn:substring(applLctEndDe, 6, 8)}"/>
                            </c:if>
                            <br/>
                            <c:if test="${not empty eduAplctVO.lctBgnDt && fn:length(eduAplctVO.lctBgnDt) >= 12}">
                                <c:set var="applLctBgnHm" value="${fn:substring(eduAplctVO.lctBgnDt, 8, 12)}"/>
                                <c:out value="${fn:substring(applLctBgnHm, 0, 2)}:${fn:substring(applLctBgnHm, 2, 4)}"/>
                            </c:if>
                            <c:if test="${not empty eduAplctVO.lctBgnDt && not empty eduAplctVO.lctEndDt}">
                                ~
                            </c:if>
                            <c:if test="${not empty eduAplctVO.lctEndDt && fn:length(eduAplctVO.lctEndDt) >= 12}">
                                <c:set var="applLctEndHm" value="${fn:substring(eduAplctVO.lctEndDt, 8, 12)}"/>
                                <c:out value="${fn:substring(applLctEndHm, 0, 2)}:${fn:substring(applLctEndHm, 2, 4)}"/>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">예약상태</div></th>
                    <td>
                        <div class="innerCell">
                            <c:out value="${resveSttusCdMap[eduAplctVO.resveSttusCd]}"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">결제상태</div></th>
                    <td>
                        <div class="innerCell">
                            <c:out value="${paySttusCdMap[eduAplctVO.paySttusCd]}"/>
                            <%-- 결제대기인 경우 결제기한까지 표출--%>
                            <c:if test="${eduAplctVO.paySttusCd == 'PAY_WAIT'}">
                                <p class="iconText caution point-color-green">
                                    <c:if test="${todate < eduAplctVO.payDeadlineDtHm}">
                                        결제기한: <c:out value="${tsu:toDateFormat(eduAplctVO.payDeadlineDtHm, 'yyyyMMddHHmm', 'yyyy-MM-dd HH:mm')}"/> 까지
                                    </c:if>
                                    <c:if test="${todate >= eduAplctVO.payDeadlineDtHm}">
                                        결제기한이 마감되었습니다. (<c:out value="${tsu:toDateFormat(eduAplctVO.payDeadlineDtHm, 'yyyyMMddHHmm', 'yyyy-MM-dd HH:mm')}"/> 까지)
                                    </c:if>
                                </p>
                            </c:if>
                            <%-- 취소인 경우 환불처리일시 + 환불금액 + 환불계좌 필요한 경우 환불계좌 정보 표출--%>
                            <c:if test="${fn:indexOf(eduAplctVO.paySttusCd, 'RFND') > -1}">
                                <p class="iconText caution point-color-green">
                                    환불금액 : <fmt:formatNumber value="${eduAplctVO.payAmt}" pattern="#,##0"/>원
                                    <c:if test="${not empty eduAplctVO.rfndBankNm}">
                                        / 환불계좌정보 : <c:out value="${eduAplctVO.rfndBankNm}"/> <c:out value="${eduAplctVO.rfndAcctNo}"/> (예금주:<c:out value="${eduAplctVO.rfndDpstrNm}"/>)
                                    </c:if>
                                </p>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <!-- 유료 옵션 -->
                <c:if test="${eduAplctVO.payAmt != null && eduAplctVO.payAmt > 0}">
                <tr>
                    <th scope="row" class="first"><div class="innerCell">결제금액</div></th>
                    <td>
                        <div class="innerCell">
                            <fmt:formatNumber value="${eduAplctVO.payAmt}" pattern="#,##0"/> 원
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">결제방법</div></th>
                    <td>
                        <div class="innerCell">
                            <p>
                                <c:if test="${not empty eduAplctVO.payMthdCd}">
                                    <c:out value="${payMthdMap[eduAplctVO.payMthdCd]}"/>
                                    <c:if test="${eduAplctVO.payMthdCd == 'ELCTRN' && !empty eduAplctVO.tossMethod}">
                                        (<c:out value="${eduAplctVO.tossMethod}"/>)
                                    </c:if>
                                </c:if>
                                <c:if test="${empty eduAplctVO.payMthdCd && not empty eduLctreVO.payMthdCd}">
                                    <c:out value="${payMthdMap[eduLctreVO.payMthdCd]}"/>
                                </c:if>
                                <c:if test="${eduAplctVO.payMthdCd eq 'NBKRCP'}">
                                    <br/>( <c:out value="${eduLctreVO.bankNm}"/>
                                    <c:out value="${eduLctreVO.acctNo}"/>,
                                    예금주 : <c:out value="${eduLctreVO.dpstrNm}"/> )
                                </c:if>
                            </p>
                            <c:if test="${(not empty eduAplctVO.payMthdCd && eduAplctVO.payMthdCd == 'ELCTRN') || (empty eduAplctVO.payMthdCd && not empty eduLctreVO.payMthdCd && eduLctreVO.payMthdCd == 'ELCTRN')}">
                                <c:set var="currentPayMthdCd" value="${not empty eduAplctVO.payMthdCd ? eduAplctVO.payMthdCd : eduLctreVO.payMthdCd}" />
                                <c:if test="${currentPayMthdCd == 'ELCTRN' && eduAplctVO.paySttusCd == 'PAY_WAIT'}">
                                    <c:if test="${todate < eduAplctVO.payDeadlineDtHm}">
                                        <c:import url="/tosspaymentsView.do">
                                            <%-- 추후 상점ID 추가 시 해당값으로 설정.
                                            <c:param name="insttNo" value="${eduLctreVO.insttNo}" />
                                            --%>
                                            <c:param name="insttNo" value="10" />
                                            <c:param name="siteId" value="${siteId}" />
                                            <c:param name="applNo" value="${eduAplctVO.eduAplyNo}" />
                                            <c:param name="totalPayAmt" value="${eduAplctVO.payAmt}" />
                                            <c:param name="orderId" value="EDU_${eduAplctVO.eduAplyNo}_${todate}" />
                                            <c:param name="orderName" value="${eduLctreVO.lctreNm}" />
                                            <c:param name="applNm" value="${eduAplctVO.applNm}" />
                                            <c:param name="prgSe" value="EDU" />
                                        </c:import>
                                    </c:if>
                                </c:if>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">결제일시</div></th>
                    <td><div class="innerCell"><c:out value="${tsu:toDateFormat(eduAplctVO.payDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/></div></td>
                </tr>
                </c:if>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">성명</div></th>
                    <td><div class="innerCell"><c:out value="${eduAplctVO.applNm}"/></div></td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">생년월일</div></th>
                    <td><div class="innerCell"><c:out value="${tsu:toDateFormat(eduAplctVO.birthDe, 'yyyyMMdd', 'yyyy. MM. dd')}"/></div></td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">성별</div></th>
                    <td>
                        <c:if test="${eduAplctVO.genderSe == 'M'}">
                            <div class="innerCell">남자</div>
                        </c:if>
                        <c:if test="${eduAplctVO.genderSe == 'F'}">
                            <div class="innerCell">여자</div>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell">
                            <c:if test="${myPageMode == 'VIEW'}">
                                연락처
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <label for="telNo1" title="필수 입력 항목입니다.">
                                    연락처
                                    <span class="point-color-red">*</span>
                                </label>
                            </c:if>
                        </div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <c:if test="${myPageMode == 'VIEW'}">
                                <c:if test="${not empty eduAplctVO.telNo && fn:length(eduAplctVO.telNo) == 11}">
                                    <c:out value="${fn:substring(eduAplctVO.telNo, 0, 3)}"/>-
                                    <c:out value="${fn:substring(eduAplctVO.telNo, 3, 7)}"/>-
                                    <c:out value="${fn:substring(eduAplctVO.telNo, 7, 11)}"/>
                                </c:if>
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <div class="contactForm">
                                    <c:set var="telNoArr" value="${fn:length(eduAplctVO.telNo) == 11 ? [fn:substring(eduAplctVO.telNo, 0, 3), fn:substring(eduAplctVO.telNo, 3, 7), fn:substring(eduAplctVO.telNo, 7, 11)] : ['010','','']}"/>
                                    <label for="telNo1">연락처 첫번호</label>
                                    <div class="customSelect simple">
                                        <select id="telNo1" name="telNo1" title="연락처 앞자리">
                                            <option value="010"${telNoArr[0] eq '010' ? ' selected="true"':''}>010</option>
                                            <option value="011"${telNoArr[0] eq '011' ? ' selected="true"':''}>011</option>
                                            <option value="016"${telNoArr[0] eq '016' ? ' selected="true"':''}>016</option>
                                            <option value="017"${telNoArr[0] eq '017' ? ' selected="true"':''}>017</option>
                                            <option value="018"${telNoArr[0] eq '018' ? ' selected="true"':''}>018</option>
                                            <option value="019"${telNoArr[0] eq '019' ? ' selected="true"':''}>019</option>
                                        </select>
                                    </div>
                                    <span>-</span>
                                    <label for="telNo2">연락처 가운데번호</label>
                                    <input type="text" name="telNo2" maxlength="4" id="telNo2" class="customInputDefault simple" placeholder="0000" value="<c:out value="${telNoArr[1]}"/>">
                                    <span>-</span>
                                    <label for="telNo3">연락처 끝번호</label>
                                    <input type="text" name="telNo3" maxlength="4" id="telNo3" class="customInputDefault simple" placeholder="0000" value="<c:out value="${telNoArr[2]}"/>">
                                </div>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">이메일<%--<label for="email">이메일</label>--%></div></th>
                    <td>
                        <div class="innerCell">
                            <c:if test="${myPageMode == 'VIEW'}">
                                <c:out value="${eduAplctVO.email}"/>
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <c:set var="emailParts" value="${fn:split(eduAplctVO.email, '@')}"/>
                                <input type="text" id="emailId" placeholder="ID" class="customInputDefault" name="email1" value="<c:out value="${emailParts[0]}"/>">
                                &nbsp;@&nbsp;
                                <input type="text" id="emailDomain" placeholder="도메인" class="customInputDefault" name="email2" value="<c:out value="${emailParts[1]}"/>">
                                <div class="customSelect inlineBlock">
                                    <select id="emailDomainSelect" name="">
                                        <option value="direct">직접입력</option>
                                        <option value="naver.com">naver.com</option>
                                        <option value="gmail.com">gmail.com</option>
                                        <option value="nate.com">nate.com</option>
                                        <option value="kakao.com">kakao.com</option>
                                    </select>
                                </div>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell">
                            <c:if test="${myPageMode == 'VIEW'}">
                                주소
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <label for="addressInput1" title="필수 입력 항목입니다.">
                                    주소
                                    <span class="point-color-red">*</span>
                                </label>
                            </c:if>
                        </div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <c:if test="${myPageMode == 'VIEW'}">
                                (<c:out value="${eduAplctVO.zip}"/>) <c:out value="${eduAplctVO.addr}"/> <c:out value="${eduAplctVO.detailAddr}"/>
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <input type="hidden" name="zip" value="<c:out value="${eduAplctVO.zip}"/>">
                                <div class="addressForm">
                                    <label for="addressInput1">검색 주소 입력</label>
                                    <input type="text" name="addr" id="addressInput1" class="customInputDefault inputAddress simple" placeholder="도로명 또는 건물명을 입력해주세요" value="<c:out value="${eduAplctVO.addr}"/>">
                                    <button type="button" class="searchAddress" onclick="openDaumZipAddress();"><span>우편번호</span></button>
                                    <label for="addressInput2">상세 주소 입력</label>
                                    <input type="text" name="detailAddr" id="addressInput2" class="customInputDefault inputAddress detail" placeholder="상세주소 입력해주세요" value="<c:out value="${eduAplctVO.detailAddr}"/>">
                                </div>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">신청일시</div></th>
                    <td>
                        <div class="innerCell">
                            <c:if test="${not empty eduAplctVO.applDtMs && fn:length(eduAplctVO.applDtMs) >= 14}">
                                <c:set var="dt" value="${eduAplctVO.applDtMs}" />
                                ${fn:substring(dt, 0, 4)}-${fn:substring(dt, 4, 6)}-${fn:substring(dt, 6, 8)}
                                ${fn:substring(dt, 8, 10)}:${fn:substring(dt, 10, 12)}:${fn:substring(dt, 12, 14)}
                            </c:if>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="flexWrap marginTop40">
            <div class="flexLeft">
                <a href="./myPageList.do?<c:out value="${myPageSearchVO.params}"/>" class="customLink lineGray"><span>목록</span></a>
            </div>
            <div class="flexRight">
                <c:if test="${myPageMode == 'UPDT'}">
                    <button type="submit" class="customLink bgGreen"><span>수정</span></button>
                </c:if>
                <c:if test="${myPageMode == 'VIEW'}">
                    <a href="./myPageViewByEdu.do?eduAplyNo=${eduAplctVO.eduAplyNo}&amp;<c:out value="${myPageSearchVO.params}"/>&amp;myPageMode=UPDT" class="customLink bgGreen"><span>수정</span></a>
                </c:if>
            </div>
        </div>
<c:if test="${myPageMode == 'UPDT'}">
    </fieldset>
</form>
</c:if>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

    $(document).ready(function () {

        $('#emailDomainSelect').change(function () {
            if ($('#emailDomainSelect').val() == 'direct') {
                $('input[name=email2]').prop('readonly', false);
                $('input[name=email2]').val('');
            } else {
                $('input[name=email2]').prop('readonly', true);
                $('input[name=email2]').val($('#emailDomainSelect').val());
            }
        });
        
        // 숫자만 입력 (연락처)
		$('#telNo2, #telNo3').on('keyup', function() {
			$(this).val($(this).val().replace(/[^0-9]/g, ""));
		});
    });

    function openDaumZipAddress() {
        new daum.Postcode({
            oncomplete:function(data) {
                $("input[name=zip]").val(data.zonecode);
                $("input[name=addr]").val(data.address);
                $("input[name=detailAddr]").focus();
            }
        }).open();
    }


    function formCheck(form) {

        var regPhone = /^\d{3}-\d{3,4}-\d{4}$/;
        var regEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

        if (!form.telNo1.value || !form.telNo2.value || !form.telNo3.value) {
            alert("연락처를 입력해주세요.");
            if (!form.telNo1.value) {
                form.telNo1.focus();
            } else if (!form.telNo2.value) {
                form.telNo2.focus();
            } else {
                form.telNo3.focus();
            }
            return false;
        } 
        
        // 연락처 조합
        var telNo = form.telNo1.value + form.telNo2.value + form.telNo3.value;
        form.telNo.value = telNo;

        if (!form.zip.value || !form.addr.value) {
            alert("주소를 검색해주세요.");
            $('.addressSearchButton').focus();
            return false;
        }

        if (!form.detailAddr.value) {
            alert("상세주소를 입력해주세요.");
            form.detailAddr.focus();
            return false;
        }

        if ((form.email1.value && !form.email2.value) || (!form.email1.value && form.email2.value)) {
            alert("올바른 형식의 이메일을 입력해주세요.");
            form.email1.focus();
            return false;
        } else if (form.email1.value && form.email2.value) {
            var email = form.email1.value + '@' + form.email2.value;
            if (!regEmail.test(email)) {
                alert("올바른 형식의 이메일을 입력해주세요.");
                form.email1.focus();
                return false;
            }
            // 이메일 조합
            form.email.value = email;
        }

        if( !confirm("수정하시겠습니까?") ) {
            return false;
        }
        return true;
    }

</script>

</body>
</html>
