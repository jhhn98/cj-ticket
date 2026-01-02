<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<ol class="programFlow">
    <li class="selected"><i>1</i>일정선택/개인정보동의</li>
    <li class="selected"><i>2</i>신청자 정보입력</li>
    <li><i>3</i>예약신청완료</li>
</ol>
<div class="programTitle">
    <c:set var="operSttus" value="${exprnVO.operSttus}"/>
    <c:set var="sttusType" value=""/>
    <c:if test="${operSttus == 'RCPT_WAIT'}">
        <c:set var="sttusType" value="type1"/>
    </c:if>
    <c:if test="${operSttus == 'RCPT_ING'}">
        <c:set var="sttusType" value="type2"/>
    </c:if>
    <c:if test="${operSttus == 'RCPT_END'}">
        <c:set var="sttusType" value="type3"/>
    </c:if>
    <c:if test="${operSttus == 'OPER_ING'}">
        <c:set var="sttusType" value="type2"/>
    </c:if>
    <c:if test="${operSttus == 'OPER_END'}">
        <c:set var="sttusType" value="type3"/>
    </c:if>
    <span class="stateType <c:out value="${sttusType}"/>"><c:out value="${operSttusMap[exprnVO.operSttus]}"/></span>
    <strong><c:out value="${exprnVO.exprnNm}"/></strong>
</div>
<h4>체험예약 정보</h4>
<div class="programInformation">
    <ul>
        <li>
            <span class="infoTitle">체험일자</span>
            <p><span><c:out value="${tsu:toDateFormat(exprnSchdWebVO.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd (EE)')}"/></span></p>
        </li>
        <li>
            <span class="infoTitle">시간</span>
            <p><c:out value="${tsu:toDateFormat(exprnSchdWebVO.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~ <c:out value="${tsu:toDateFormat(exprnSchdWebVO.exprnEndHm, 'HHmm', 'HH:mm')}"/></p>
        </li>
        <li>
            <span class="infoTitle">요일</span>
            <p><c:out value="${tsu:toDateFormat(exprnSchdWebVO.exprnDe, 'yyyyMMdd', 'EE요일')}"/></p>
        </li>
    </ul>
</div>
<h4>신청자 정보 입력</h4>
<form method="post" name="exprnApplVO" action="./addExprnApplWeb.do" onsubmit="return formCheck(this);">
    <fieldset>
        <legend>신청자 정보</legend>
        <p class="iconText comment"><span class="point-color-red">*</span> 표시는 필수 입력 항목 입니다.</p>
        <table class="table program formTable" data-table-response>
            <caption>신청자 정보 입력 - 인원구분(개인/단체), 이름, 생년월일, 연락처, 성별, 주소, 신청인원, 이메일 등</caption>
            <tbody>
            <input type="hidden" name="key" value="<c:out value="${key}"/>" />
            <input type="hidden" name="exprnNo" value="<c:out value="${exprnSchdWebVO.exprnNo}"/>" />
            <input type="hidden" name="exprnSchdNo" value="<c:out value="${exprnSchdWebVO.exprnSchdNo}"/>" />
            <input type="hidden" name="insttNo" value="<c:out value="${exprnVO.insttNo}"/>" />
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">
                        <label for="" title="필수 입력 항목입니다.">
                            인원구분
                            <span class="point-color-red">*</span>
                        </label>
                    </div>
                </th>
                <td>
                    <div class="innerCell">
                        <%-- 인원구분 공통코드 - IND : 개인 / GRP : 단체 --%>
                        <c:forEach var="result" items="${exprnVO.nmprSeCdArr}" varStatus="status">
                            <label for="nmprSeCd_<c:out value="${result}"/>" class="customRadioButton">
                                <input type="radio" id="nmprSeCd_<c:out value="${result}"/>" name="nmprSeCd" value="<c:out value="${result}"/>"<c:if test="${fn:length(exprnVO.nmprSeCdArr) == 1}"> checked</c:if> />
                                <span class="customStyle">
                                    <i class="radioButton"></i>
                                    <span><c:out value="${nmprSeMap[result]}"/></span>
                                </span>
                            </label>
                        </c:forEach>
                    </div>
                </td>
            </tr>
            <c:if test="${fn:contains(exprnVO.nmprSeCd, 'GRP')}">
                <tr id="grpNmInput"<c:if test="${fn:length(exprnVO.nmprSeCdArr) > 1}"> style="display: none;"</c:if>>
                    <th scope="row" class="first">
                        <div class="innerCell">
                            <label for="grpNm" title="필수 입력 항목입니다.">
                                단체명
                                <span class="point-color-red">*</span>
                            </label>
                        </div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <input type="text" id="grpNm" placeholder="단체명을 입력해주세요." class="customInputDefault" name="grpNm" value="<c:out value="${exprnApplVO.grpNm}"/>">
                        </div>
                    </td>
                </tr>
            </c:if>
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">신청자명</div>
                </th>
                <td>
                    <div class="innerCell"><c:out value="${exprnApplVO.applNm}"/></div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">생년월일</div>
                </th>
                <td>
                    <div class="innerCell">
                        <c:out value="${tsu:toDateFormat(exprnApplVO.birthDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    </div>
                </td>
            </tr>
            <tr>
                <c:if test="${empty exprnApplVO.mobileNo}">
                    <th scope="row" class="first">
                        <div class="innerCell">
                            <label for="codePrefix" title="필수 입력 항목입니다.">
                                연락처
                                <span class="point-color-red">*</span>
                            </label>
                        </div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <div class="phoneCode">
                                <label for="codePrefix">휴대전화 앞자리</label>
                                <input type="text" id="codePrefix" placeholder="010" maxlength="3" class="customInputDefault onlyNumber" name="mobileNo1" value="<c:out value="${exprnApplVO.mobileNo1}"/>" autocomplete="off">
                                -
                                <label for="codeExchange">휴대전화 중간자리</label>
                                <input type="text" id="codeExchange" placeholder="0000" maxlength="4" class="customInputDefault onlyNumber" name="mobileNo2" value="<c:out value="${exprnApplVO.mobileNo2}"/>" autocomplete="off">
                                -
                                <label for="codeLine">휴대전화 마지막자리</label>
                                <input type="text" id="codeLine" placeholder="0000" maxlength="4" class="customInputDefault onlyNumber" name="mobileNo3" value="<c:out value="${exprnApplVO.mobileNo3}"/>" autocomplete="off">
                            </div>
                        </div>
                    </td>
                </c:if>
                <c:if test="${!empty exprnApplVO.mobileNo}">
                    <th scope="row" class="first">
                        <div class="innerCell">연락처</div>
                    </th>
                    <td>
                        <div class="innerCell"><c:out value="${fn:substring(exprnApplVO.mobileNo, 0, 3)}"/>-<c:out value="${fn:substring(exprnApplVO.mobileNo, 3, 7)}"/>-<c:out value="${fn:substring(exprnApplVO.mobileNo, 7, 11)}"/></div>
                    </td>
                </c:if>
            </tr>
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">성별</div>
                </th>
                <td>
                    <div class="innerCell">
                        <label for="genderSeM" class="customRadioButton">
                            <input type="radio" id="genderSeM" name="genderSe" value="M"<c:if test="${exprnApplVO.genderSe == 'M'}"> checked</c:if> disabled />
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>남</span>
                            </span>
                        </label>
                        <label for="genderSeW" class="customRadioButton">
                            <input type="radio" id="genderSeW" name="genderSe" value="F"<c:if test="${exprnApplVO.genderSe == 'F'}"> checked</c:if> disabled />
                            <span class="customStyle">
                                <i class="radioButton"></i>
                                <span>여</span>
                            </span>
                        </label>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">
                        <label for="addressSearch" title="필수 입력 항목입니다.">
                            주소
                            <span class="point-color-red">*</span>
                        </label>
                    </div>
                </th>
                <td>
                    <div class="innerCell">
                        <div class="address">
                            <label for="addressSearch">주소 검색</label>
                            <input type="hidden" name="zip" id="zip" value="<c:out value="${exprnApplVO.zip}"/>" readonly autocomplete="off" />
                            <input type="text" id="addressSearch" placeholder="주소(도로명/지번/건물명)를 입력해주세요." class="customInputDefault addressSearch" name="addr" value="<c:out value="${exprnApplVO.addr}"/>" readonly autocomplete="off">
                            <button type="button" class="addressSearchButton" onclick="openDaumZipAddress();"><span>주소검색</span></button>
                            <label for="addressDetail">상세주소</label>
                            <input type="text" id="addressDetail" placeholder="상세주소를 입력해주세요." class="customInputDefault addressDetail" name="detailAddr" value="<c:out value="${exprnApplVO.detailAddr}"/>" autocomplete="off">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="first">
                    <div class="innerCell">
                        <label for="totalCnt" title="필수 입력 항목입니다.">
                            신청인원
                            <span class="point-color-red">*</span>
                        </label>
                    </div>
                </th>
                <td>
                    <c:set var="nmprMinCnt" value="1"/>
                    <c:set var="nmprMaxCnt" value="${exprnVO.rcritCnt}"/>
                    <c:if test="${exprnVO.nmprMinCnt > 0}">
                        <c:set var="nmprMinCnt" value="${exprnVO.nmprMinCnt}"/>
                    </c:if>
                    <c:if test="${exprnVO.nmprMaxCnt > 0}">
                        <c:set var="nmprMaxCnt" value="${exprnVO.nmprMaxCnt}"/>
                    </c:if>
                    <div class="innerCell">
                        총  
                        <div class="customSelect inlineBlock">
                            <select id="totalCnt" name="totalCnt">
                                <option value="0">선택</option>
                                <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                    <option value="<c:out value="${i}"/>"<c:if test="${i == exprnApplVO.totalCnt}"> selected</c:if>><c:out value="${i}"/>명</option>
                                </c:forEach>
                            </select>
                        </div>
                        <c:if test="${exprnVO.detailNmprUseYn == 'Y'}">
                              ( 성인
                            <div class="customSelect inlineBlock">
                                <select id="adltCnt" name="adltCnt">
                                    <option value="0">선택</option>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <option value="<c:out value="${i}"/>"<c:if test="${i == exprnApplVO.adltCnt}"> selected</c:if>><c:out value="${i}"/>명</option>
                                    </c:forEach>
                                </select>
                            </div>
                            ,   청소년
                            <div class="customSelect inlineBlock">
                                <select id="teenCnt" name="teenCnt">
                                    <option value="0">선택</option>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <option value="<c:out value="${i}"/>"<c:if test="${i == exprnApplVO.teenCnt}"> selected</c:if>><c:out value="${i}"/>명</option>
                                    </c:forEach>
                                </select>
                            </div>
                            ,   초등학생
                            <div class="customSelect inlineBlock">
                                <select id="elmntCnt" name="elmntCnt">
                                    <option value="0">선택</option>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <option value="<c:out value="${i}"/>"<c:if test="${i == exprnApplVO.elmntCnt}"> selected</c:if>><c:out value="${i}"/>명</option>
                                    </c:forEach>
                                </select>
                            </div>
                            ,   아동
                            <div class="customSelect inlineBlock">
                                <select id="childCnt" name="childCnt">
                                    <option value="0">선택</option>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <option value="<c:out value="${i}"/>"<c:if test="${i == exprnApplVO.childCnt}"> selected</c:if>><c:out value="${i}"/>명</option>
                                    </c:forEach>
                                </select>
                            </div>
                            ,   영유아
                            <div class="customSelect inlineBlock">
                                <select id="infantCnt" name="infantCnt">
                                    <option value="0">선택</option>
                                    <c:forEach var="i" begin="${nmprMinCnt}" end="${nmprMaxCnt}" varStatus="status">
                                        <option value="<c:out value="${i}"/>"<c:if test="${i == exprnApplVO.infantCnt}"> selected</c:if>><c:out value="${i}"/>명</option>
                                    </c:forEach>
                                </select>
                            </div>  )
                        </c:if>
                    </div>
                    <c:if test="${exprnVO.nmprMinCnt > 0 || exprnVO.nmprMaxCnt > 0}">
                        <p class="iconText caution">
                            <c:if test="${exprnVO.nmprMinCnt > 0}">
                                최소 신청인원 : <c:out value="${exprnVO.nmprMinCnt}"/> 명
                            </c:if>
                            <c:if test="${exprnVO.nmprMinCnt > 0 && exprnVO.nmprMaxCnt > 0}"> / </c:if>
                            <c:if test="${exprnVO.nmprMaxCnt > 0}">
                                최대 신청인원 : <c:out value="${exprnVO.nmprMaxCnt}"/> 명
                            </c:if>
                        </p>
                    </c:if>
                </td>
            </tr>
            <tr>
                <th scope="row" class="first"><div class="innerCell">이메일</div></th>
                <td>
                    <div class="innerCell">
                        <div class="email">
                            <label for="emailId">E-mail ID</label>
                            <input type="text" id="emailId" class="customInputDefault textAlignCenter" name="email1" value="<c:out value="${exprnApplVO.email1}"/>" autocomplete="off">
                            &nbsp;@&nbsp;
                            <label for="emailDomain">E-mail Domain name</label>
                            <input type="text" id="emailDomain" class="customInputDefault textAlignCenter" name="email2" value="<c:out value="${exprnApplVO.email2}"/>" autocomplete="off">
                            <label for="emailDomainSelect">E-mail Domain Select</label>
                            <div class="customSelect inlineBlock">
                                <select id="emailDomainSelect" name="">
                                    <option value="direct">직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="nate.com">nate.com</option>
                                    <option value="kakao.com">kakao.com</option>
                                    <option value="daum.net">daum.net</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <c:if test="${!empty exprnVO.aditIem1}">
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell"><label for="aditIem1"><c:out value="${exprnVO.aditIem1}"/></label></div>
                    </th>
                    <td><div class="innerCell"><input type="text" id="aditIem1" name="aditIem1" placeholder="" class="customInputDefault w100per" value="<c:out value="${exprnApplVO.aditIem1}"/>" autocomplete="off"></div></td>
                </tr>
            </c:if>
            <c:if test="${!empty exprnVO.aditIem2}">
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell"><label for="aditIem2"><c:out value="${exprnVO.aditIem2}"/></label></div>
                    </th>
                    <td><div class="innerCell"><input type="text" id="aditIem2" name="aditIem2" placeholder="" class="customInputDefault w100per" value="<c:out value="${exprnApplVO.aditIem2}"/>" autocomplete="off"></div></td>
                </tr>
            </c:if>
            <c:if test="${exprnVO.resInqUseYn == 'Y'}">
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell">
                            <label for="totalCnt" title="필수 입력 항목입니다.">
                                거주지 조회
                                <span class="point-color-red">*</span>
                            </label>
                        </div>
                    </th>
                    <td>
                        <input type="hidden" name="resInqTxId" value="">
                        <input type="hidden" name="resInqResult" value="">
                        <div class="innerCell">
                            <div class="juminNo" id="juminNoInput">
                                <label for="resJuminNoPre">주민번호 앞자리</label>
                                <input type="text" id="resJuminNoPre" placeholder="주민번호 앞자리" class="customInputDefault textAlignCenter onlyNumber" maxlength="6" value="<c:out value="${tsu:toDateFormat(exprnApplVO.birthDe, 'yyyyMMdd', 'yyMMdd')}"/>" autocomplete="off" disabled>
                                &nbsp;-&nbsp;
                                <label for="resJuminNoPost">주민번호 뒷자리</label>
                                <input type="password" id="resJuminNoPost" placeholder="주민번호 뒷자리" class="customInputDefault textAlignCenter onlyNumber" maxlength="7" name="resJuminNoPost" autocomplete="off">
                                <button type="button" class="customLink bgBlack bigHeight marginLeft10" onclick="fn_ResideInsttCnfirmCheck();"><span>조회</span></button>
                                <span id="resInqResultText" class="resIngResultText"></span>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:if>
            <c:if test="${exprnVO.exprnAmt > 0}">
                <c:if test="${exprnVO.dscntUseYn == 'Y'}">
                    <tr>
                        <th scope="row" class="first">
                            <div class="innerCell"><label for="dscntCd">감면혜택</label></div>
                        </th>
                        <td>
                            <div class="innerCell">
                                <div class="customSelect inlineBlock">
                                    <select id="dscntCd" name="dscntCd">
                                        <option value="DSCNT_NONE">감면없음</option>
                                        <c:forEach var="result" items="${dscntList}">
                                            <c:if test="${result.piscYn == 'Y'}">
                                                <option value="PISC_${result.dscntCd}" data-confirm-mthd="pisc"><c:out value="${dscntSeMap[result.dscntCd]}"/>(비대면)</option>
                                            </c:if>
                                            <c:if test="${result.directYn == 'Y'}">
                                                <option value="DIRECT_${result.dscntCd}" data-confirm-mthd="direct"><c:out value="${dscntSeMap[result.dscntCd]}"/>(서류직접제출)</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <table class="table default">
                                    <caption>감면항목</caption>
                                    <thead>
                                    <tr>
                                        <th scope="col" class="first">감면항목</th>
                                        <th scope="col">감면혜택조건</th>
                                        <th scope="col">자격확인방법</th>
                                        <th scope="col">감면율</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="result" items="${dscntList}">
                                    <tr>
                                        <td class="first"><c:out value="${dscntSeMap[result.dscntCd]}"/></td>
                                        <td><c:out value="${result.dscntCnd}"/></td>
                                        <td>
                                            <c:if test="${result.piscYn == 'Y'}">
                                                비대면
                                            </c:if>
                                            <c:if test="${result.piscYn == 'Y' && result.directYn == 'Y'}">
                                                ,
                                            </c:if>
                                            <c:if test="${result.directYn == 'Y'}">
                                                서류직접제출
                                            </c:if>
                                        </td>
                                        <td><c:out value="${result.dscntRate}"/>%</td>
                                    </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                </c:if>
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell">
                            <label for="payMthdCd" title="필수 입력 항목입니다.">
                                결제방법
                                <span class="point-color-red">*</span>
                            </label>
                        </div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <div class="customSelect inlineBlock">
                                <%-- 결제방식 공통코드 - ELCTRN : 전자결제 / NBKRCP : 무통장입금 / DIRECT : 현장결제 --%>
                                <select id="payMthdCd" name="payMthdCd">
                                    <c:if test="${fn:length(exprnVO.payMthdCdArr) > 1}"><option value="">선택해주세요.</option></c:if>
                                    <c:forEach var="result" items="${exprnVO.payMthdCdArr}" varStatus="status">
                                        <option value="<c:out value="${result}"/>"<c:if test="${result == exprnApplVO.payMthdCd}"> selected</c:if>><c:out value="${payMthdMap[result]}"/></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
        <div class="programAmount">
            <div class="innerWrap">
                <ul>
                    <li>
                        <strong>이용요금</strong>
                        <span><fmt:formatNumber value="${exprnVO.exprnAmt}" pattern="#,###"/>원</span>
                    </li>
                    <c:if test="${exprnVO.dscntUseYn == 'Y'}">
                        <li>
                            <strong>감면할인</strong>
                            <span>0원</span>
                        </li>
                    </c:if>
                </ul>
                <p class="sumAmount">
                    <strong>총 결제금액</strong>
                    <span><fmt:formatNumber value="${exprnVO.exprnAmt}" pattern="#,###"/>원</span>
                </p>
            </div>
        </div>
        <div class="formButtonGroup">
            <a href="javascript:window.history.back();" class="button previous"><span>이전</span></a>
            <button type="submit" class="button next"><span>다음</span></button>
            <%--<button type="button" class="button next" data-modal-button="modal1-1"><span>다음</span></button><!--예약신청 승인 Modal-->
            <div class="programModal" data-modal-layer="modal1-1">
                <div class="modalHeader">
                    <strong>예약신청</strong>
                </div>
                <div class="modalBody alignCenter">
                    <i class="iconModal confirm"></i>
                    <p class="confirmText">신청정보가 <span class="point-color-green">확인되었습니다.</span></p>
                </div>
                <div class="modalFooter">
                    <p class="iconText caution"><span class="point-color-green">확인버튼</span>을 눌러야 신청이 완료됩니다.</p>
                    <div class="formButtonGroup">
                        <button type="submit" class="button bgFill">확인</button>
                        <button class="modalCloseButton"><span>닫기</span></button>
                    </div>
                </div>
            </div>--%>
        </div>
    </fieldset>
</form>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

    $(document).ready(function () {

    <c:if test="${fn:contains(exprnVO.nmprSeCd, 'GRP')}">
        $('input[type=radio][name=nmprSeCd]').change(function () {
            if ($(this).val() == 'GRP') {
                $('#grpNmInput').show();
            } else {
                $('#grpNmInput').hide();
                $('#grpNm').val('');
            }
        });
    </c:if>

        $('.onlyNumber').on('input',function() {
            this.value = this.value.replace(/[^0-9]/g, '');
        });

        $('#emailDomainSelect').change(function () {
            if ($('#emailDomainSelect').val() == 'direct') {
                $('input[name=email2]').prop('readonly', false);
                $('input[name=email2]').val('');
            } else {
                $('input[name=email2]').prop('readonly', true);
                $('input[name=email2]').val($('#emailDomainSelect').val());
            }
        });
    });

    function openDaumZipAddress() {
        new daum.Postcode({
            oncomplete:function(data) {
                $("#zip").val(data.zonecode);
                $("input[name=addr]").val(data.address);
                $("input[name=detailAddr]").focus();
            }
        }).open();
    }

    function fn_juminNoCheck(juminNoPost) {

        if(juminNoPost == "") {
            alert("주민등록번호를 입력해주세요.");
            return false;
        }

        if(juminNoPost.length != 7) {
            alert("주민등록번호 뒷자리는 숫자 7자리로 입력해주세요.");
            return false;
        }

        if(!$.isNumeric(juminNoPost)) {
            alert("주민등록번호는 숫자만 입력해주세요.");
            return false;
        }

        return true;
    }

    function fn_ResideInsttCnfirmCheck() {

        $('#ResideInsttCnfirm').text('');

        var juminNoPost = $('#resJuminNoPost').val();
        if(!fn_juminNoCheck(juminNoPost)) {
            $('#resJuminNoPost').focus();
            return false;
        }

        var insttNo = $('input[name=insttNo]').val();
        var prgNo = $('input[name=exprnNo]').val();

        $.ajax({
            cache: false,
            url: '/piscResInqAjax.do',
            type: 'POST',
            data: {
                prgSe: 'EXP',
                juminNoPost: juminNoPost,
                prgNo: prgNo,
                insttNo: insttNo,
            },
            success: function (res) {
                var resInqTxId = res['resInqTxId'];
                var resInqResult = '';
                var resInqResultText = '';
                var RESULT = res['RESULT'];

                if (RESULT == 'JUMIN_NO_FAILR') {
                    alert("주민번호 뒷자리를 확인해주세요.");
                    $('#resJuminNoPost').focus();
                    return false;
                }

                if (RESULT == 'Y') {
                    alert("거주지 조회가 완료되었습니다.");

                    var hangkikCd = res['hangkikCd'];
                    resInqResult = hangkikCd;

                    var admDong = res['admDong'];
                    resInqResultText += '청주시민(' + admDong + ')';
                } else {
                    var msg = '거주지 조회 오류입니다. 관리자에게 문의해주세요.';

                    if(RESULT == 'PISC_FAIL_02') {
                        msg = '주민등록번호 오류입니다. 입력하신 주민등록번호를 다시 확인해주세요.';
                        resInqResult = 2;
                    } else if(RESULT == 'PISC_FAIL_03') {
                        msg = '성명 오류입니다. 입력하신 성명을 다시 확인해주세요.';
                        resInqResult = 3;
                    } else if(RESULT == 'PISC_FAIL_04') {
                        msg = '청주시 거주자가 아닙니다.';
                        resInqResult = 4;
                    } else if(RESULT == 'PISC_FAIL_09') {
                        msg = '시스템 오류입니다. 관리자에게 문의해주세요.';
                        resInqResult = 9;
                    } else if(RESULT == 'PISC_FAIL_99') {
                        msg = '등록된 이용기관이 아닙니다. 관리자에게 문의해주세요.';
                        resInqResult = 99;
                    } else if(RESULT == 'PISC_FAIL_ELSE') {
                        msg = '잘못된 접근입니다.';
                        resInqResult = 999;
                    }

                    alert(msg);
                    resInqResultText += msg;
                }

                $('input[name=resInqTxId]').val(resInqTxId);
                $('input[name=resInqResult]').val(resInqResult);
                $('#resInqResultText').text(resInqResultText);
            }, // success
            error: function (request,xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                console.log("code:",request.status);
                console.log("message:",request.responseText);
                console.log("error:"+error)
            }
        });
    }

    function formCheck(form) {

        <c:if test="${fn:length(exprnVO.nmprSeCdArr) > 1}">
        if (!form.nmprSeCd.value) {
            alert("인원구분을 선택해주세요.");
            $('#nmprSeCd_IND').focus();
            return false;
        }
        </c:if>

        <c:if test="${fn:contains(exprnVO.nmprSeCd, 'GRP')}">
        if (form.nmprSeCd.value == 'GRP') {
            if (!form.grpNm.value) {
                alert("인원구분 단체인 경우 단체명을 입력해주세요.");
                form.grpNm.focus();
                return false;
            }
        }
        </c:if>

        var regPhone = /^01[016789]-?\d{3,4}-?\d{4}$/;
        var regEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

        <c:if test="${empty loginVO.mbtlnum}">
        if (!form.mobileNo1.value || !form.mobileNo2.value || !form.mobileNo3.value) {
            alert("연락처를 입력해주세요.");
            if (!form.mobileNo1.value) {
                form.mobileNo1.focus();
            } else if (!form.mobileNo2.value) {
                form.mobileNo2.focus();
            } else {
                form.mobileNo3.focus();
            }
            return false;
        } else {
            var mobileNo = form.mobileNo1.value + '-' + form.mobileNo2.value + '-' + form.mobileNo3.value;
            if (!regPhone.test(mobileNo)) {
                alert("연락처는 010-0000-0000 형식으로 입력해주세요.");
                form.mobileNo1.focus();
                return false;
            }
        }
        </c:if>

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
        }

        if (!form.totalCnt.value) {
            alert("신청인원을 입력해주세요.");
            form.totalCnt.focus();
            return false;
        }

        if (form.totalCnt.value <= 0) {
            alert("신청인원을 확인해주세요.");
            form.totalCnt.focus();
            return false;
        }

        var minCnt =
        <c:out value="${exprnVO.nmprMinCnt}"/>
        var maxCnt =
        <c:out value="${exprnVO.nmprMaxCnt}"/>

        if (minCnt > 0) {
            if (form.totalCnt.value < minCnt) {
                alert("최소 신청인원을 확인해주세요.");
                form.totalCnt.focus();
                return false;
            }
        }

        if (maxCnt > 0) {
            if (form.totalCnt.value > maxCnt) {
                alert("최대 신청인원을 확인해주세요.");
                form.totalCnt.focus();
                return false;
            }
        }

        <c:if test="${exprnVO.detailNmprUseYn == 'Y'}">
        // 총 인원
        let totalCnt = parseInt($("#totalCnt").val() || 0);

        // 세부 인원
        let adltCnt = parseInt($("#adltCnt").val() || 0);
        let teenCnt = parseInt($("#teenCnt").val() || 0);
        let elmntCnt = parseInt($("#elmntCnt").val() || 0);
        let childCnt = parseInt($("#childCnt").val() || 0);
        let infantCnt = parseInt($("#infantCnt").val() || 0);

        let detailSum = adltCnt + teenCnt + elmntCnt + childCnt + infantCnt;
        if (totalCnt !== detailSum) {
            form.adltCnt.focus();
            alert("세부 인원이 총 신청인원과 일치하지 않습니다. 다시 확인해주세요.");
            return false;
        }
        </c:if>

        <c:if test="${exprnVO.resInqUseYn == 'Y'}">
        if (!form.resInqTxId.value) {
            form.resJuminNoPost.focus();
            alert("거주지 조회가 필요한 서비스입니다.");
            return false;
        }
        </c:if>

        <c:if test="${exprnVO.exprnAmt > 0}">
        if (!form.payMthdCd.value) {
            alert("결제방식을 선택해주세요.");
            form.payMthdCd.focus();
            return false;
        }
        </c:if>

        if (!confirm("신청하시겠습니까?")) {
            return false;
        }
        return true;
    }

</script>

<div class="programModal" data-modal-layer="modal1-1">
    <div class="modalHeader">
        <strong>예약신청</strong>
    </div>
    <div class="modalBody alignCenter">
        <i class="iconModal confirm"></i>
        <p class="confirmText">신청정보가 <span class="point-color-green">확인되었습니다.</span></p>
    </div>
    <div class="modalFooter">
        <p class="iconText caution"><span class="point-color-green">확인버튼</span>을 눌러야 신청이 완료됩니다.</p>
        <div class="formButtonGroup">
            <button type="submit" class="button bgFill">확인</button>
            <button class="modalCloseButton"><span>닫기</span></button>
        </div>
    </div>
</div>

<spring:hasBindErrors name="exprnApplVO">
    <script nonce="NEOCMSSCRIPT">
        <c:forEach items="${errors.allErrors}" var="error" varStatus="status">
        <c:if test="${status.first}">
        <c:set var="errMsg"><spring:message code="${error.code}" arguments="${error.arguments}" /></c:set>
        alert("<c:out value="${errMsg}"/>");
        </c:if>
        </c:forEach>
    </script>
</spring:hasBindErrors>

<c:if test="${!empty message}">
    <script nonce="NEOCMSSCRIPT">
        function fn_check_message() {
            alert("<c:out value='${message}'/>");
            <c:if test="${!empty fieldName}">
            $("#<c:out value="${fieldName}"/>").focus();
            </c:if>
        }
        $(window).load(function() {
            fn_check_message();
        });
    </script>
</c:if>

</body>

</html>
