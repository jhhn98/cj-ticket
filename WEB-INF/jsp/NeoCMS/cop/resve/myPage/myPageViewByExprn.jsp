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
<form method="post" action="./myPageUpdateByExprn.do" onsubmit="return formCheck(this);">
    <input type="hidden" name="exprnApplNo" value="<c:out value="${exprnApplVO.exprnApplNo}"/>">
    <input type="hidden" name="myPageMode" value="<c:out value="${myPageMode}"/>">
    <c:forEach var="result" items="${myPageSearchVO.paramsMap}">
        <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
    </c:forEach>
    <fieldset>
        <legend>신청 정보 수정 - 예약번호, 신청상태, 결제상태, 결제방법, 성명, 생년월일, 성별, 연락처, 이메일, 주소, 감면신청, 신청일시</legend>
        </c:if>
        <c:set var="todate" value="${exprnApplVO.today}${exprnApplVO.now}" />
        <h4>체험/견학</h4>
        <h5>프로그램 정보</h5>
        <div class="scrollWrap-table">
            <table class="table default" data-table-response>
                <caption>프로그램 정보-강좌명, 운영기관, 모집상태, 접수기간, 체험기간, 선발방식, 이용요금, 체험장소/주소</caption>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody class="textAlignLeft">
                <tr>
                    <th scope="row" class="first">체험명</th>
                    <td colspan="3"><strong><c:out value="${exprnVO.exprnNm}"/></strong></td>
                </tr>
                <tr>
                    <th scope="row" class="first">운영기관</th>
                    <td>
                        <c:set var="insttNo" value="instt${exprnVO.insttNo}"/>
                        <strong><c:out value="${expInsttMap[insttNo]}"/></strong>
                    </td>
                    <th scope="row">모집상태</th>
                    <td><c:out value="${operSttusMap[exprnVO.operSttus]}"/></td>
                </tr>
                <tr>
                    <th scope="row" class="first">접수기간</th>
                    <td>
                        <c:out value="${exprnVO.rcptBgnDe}"/> <c:out value="${exprnVO.rcptBgnHh}"/>:<c:out value="${exprnVO.rcptBgnMm}"/> ~
                        <c:out value="${exprnVO.rcptEndDe}"/> <c:out value="${exprnVO.rcptEndHh}"/>:<c:out value="${exprnVO.rcptEndMm}"/>
                    </td>
                    <th scope="row">체험기간</th>
                    <td>
                        <c:out value="${tsu:toDateFormat(exprnVO.exprnMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/> ~
                        <c:out value="${tsu:toDateFormat(exprnVO.exprnMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first">선발방식</th>
                    <td><c:out value="${slctMthdMap[exprnVO.slctMthdCd]}"/></td>
                    <th scope="row">이용요금</th>
                    <td>
                        <c:choose>
                            <c:when test="${exprnVO.exprnAmt > 0}">
                                <fmt:formatNumber value="${tsu:xssNumberFilter(exprnVO.exprnAmt)}" pattern="#,###"/> 원
                            </c:when>
                            <c:otherwise>
                                무료
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first">체험장소</th>
                    <td colspan="3">
                        <c:set var="placeNo" value="place${exprnVO.placeNo}"/>
                        <c:out value="${expPlaceMap[placeNo]}"/>
                        <c:forEach var="result" items="${expPlaceList}">
                            <c:if test="${result.placeNo == exprnVO.placeNo}">
                                ( <c:out value="${result.addr}"/> <c:out value="${result.detailAddr}"/> )
                            </c:if>
                        </c:forEach>
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
                <caption>신청 정보 <c:if test="${myPageMode == 'UPDT'}">입력</c:if><c:if test="${myPageMode == 'VIEW'}">상세보기</c:if>-예약번호, 신청상태, 결제상태, 결제방법, 성명, 생년월일, 성별, 연락처, 이메일, 주소, 강연신청, 신청일시</caption>
                <colgroup>
                    <col style="width:15%">
                    <col>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">예약번호</div></th>
                    <td><div class="innerCell"><strong><c:out value="${exprnApplVO.exprnApplId}"/></strong></div></td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">체험일자</div></th>
                    <td>
                        <div class="innerCell">
                            <c:out value="${tsu:toDateFormat(exprnApplVO.exprnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                            <c:out value="${tsu:toDateFormat(exprnApplVO.exprnBgnHm, 'HHmm', 'HH:mm')}"/> ~
                            <c:out value="${tsu:toDateFormat(exprnApplVO.exprnEndHm, 'HHmm', 'HH:mm')}"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">예약상태</div></th>
                    <td>
                        <div class="innerCell">
                            <c:out value="${rsvSttusMap[exprnApplVO.rsvSttusCd]}"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">결제상태</div></th>
                    <td>
                        <div class="innerCell">
                            <c:out value="${paySttusMap[exprnApplVO.paySttusCd]}"/>
                            <%-- 결제대기인 경우 결제기한까지 표출--%>
                            <c:if test="${exprnApplVO.paySttusCd == 'PAY_WAIT'}">
                                <p class="iconText caution point-color-green">
                                    <c:if test="${todate < exprnApplVO.payDeadlineDt}">
                                        결제기한: <c:out value="${tsu:toDateFormat(exprnApplVO.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/> 까지
                                    </c:if>
                                    <c:if test="${todate >= exprnApplVO.payDeadlineDt}">
                                        결제기한이 마감되었습니다. (<c:out value="${tsu:toDateFormat(exprnApplVO.payDeadlineDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/> 까지)
                                    </c:if>
                                </p>
                            </c:if>
                            <%-- 취소인 경우 환불처리일시 + 환불금액 + 환불계좌 필요한 경우 환불계좌 정보 표출--%>
                            <c:if test="${fn:indexOf(exprnApplVO.paySttusCd, 'RFND') > -1}">
                                <p class="iconText caution point-color-green">
                                    환불처리일시 : <c:out value="${tsu:toDateFormat(exprnApplVO.rfndCmplDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/> / 환불금액 : <fmt:formatNumber value="${exprnApplVO.rfndAmt}" pattern="#,##0"/>원 / 환불계좌정보 : <c:out value="${exprnApplVO.rfndBankNm}"/> <c:out value="${exprnApplVO.rfndAcctNo}"/> (예금주:<c:out value="${exprnApplVO.rfndDpstrNm}"/>)
                                </p>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <!-- 유료 옵션 -->
                <c:if test="${exprnApplVO.totalPayAmt > 0}">
                    <tr>
                        <th scope="row" class="first"><div class="innerCell">결제금액</div></th>
                        <td>
                            <div class="innerCell">
                                <fmt:formatNumber value="${exprnApplVO.totalPayAmt}" pattern="#,##0"/> 원
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="first"><div class="innerCell">결제방법</div></th>
                        <td>
                            <div class="innerCell">
                                <p>
                                    <c:out value="${payMthdMap[exprnApplVO.payMthdCd]}"/>
                                    <c:if test="${exprnApplVO.payMthdCd == 'ELCTRN' && !empty exprnApplVO.tossMethod}">
                                        (<c:out value="${exprnApplVO.tossMethod}"/>)
                                    </c:if>
                                    <c:if test="${exprnApplVO.payMthdCd == 'NBKRCP'}">
                                        (<c:out value="${exprnVO.bankNm}"/> <c:out value="${exprnVO.acctNo}"/> (예금주:<c:out value="${exprnVO.dpstrNm}"/>))
                                    </c:if>
                                </p>
                                <c:if test="${exprnApplVO.payMthdCd == 'ELCTRN' && exprnApplVO.paySttusCd == 'PAY_WAIT'}">
                                    <c:if test="${todate < exprnApplVO.payDeadlineDt}">
                                        <c:import url="/tosspaymentsView.do">
                                            <c:param name="insttNo" value="${exprnApplVO.insttNo}" />
                                            <c:param name="siteId" value="${siteId}" />
                                            <c:param name="applNo" value="${exprnApplVO.exprnApplNo}" />
                                            <c:param name="totalPayAmt" value="${exprnApplVO.totalPayAmt}" />
                                            <c:param name="orderId" value="EXP_${exprnApplVO.exprnApplNo}_${todate}" />
                                            <c:param name="orderName" value="${exprnVO.exprnNm}" />
                                            <c:param name="applNm" value="${exprnApplVO.applNm}" />
                                            <c:param name="prgSe" value="EXP" />
                                        </c:import>
                                    </c:if>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="first"><div class="innerCell">결제일시</div></th>
                        <td><div class="innerCell"><c:out value="${tsu:toDateFormat(exprnApplVO.payDt, 'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/></div></td>
                    </tr>
                </c:if>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">성명</div></th>
                    <td><div class="innerCell"><c:out value="${exprnApplVO.applNm}"/></div></td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">생년월일</div></th>
                    <td><div class="innerCell"><c:out value="${tsu:toDateFormat(exprnApplVO.birthDe, 'yyyyMMdd', 'yyyy. MM. dd')}"/></div></td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">성별</div></th>
                    <td>
                        <c:if test="${exprnApplVO.genderSe == 'M'}">
                            <div class="innerCell">남자</div>
                        </c:if>
                        <c:if test="${exprnApplVO.genderSe == 'F'}">
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
                                <label for="contactFirst" title="필수 입력 항목입니다.">
                                    연락처
                                    <span class="point-color-red">*</span>
                                </label>
                            </c:if>
                        </div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <c:if test="${myPageMode == 'VIEW'}">
                                <c:out value="${exprnApplVO.mobileNo1}"/> - <c:out value="${exprnApplVO.mobileNo2}"/> - <c:out value="${exprnApplVO.mobileNo3}"/>
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <div class="contactForm">
                                    <label for="contactFirst">연락처 첫번호</label>
                                    <input type="number" name="mobileNo1" maxlength="4" id="contactFirst" class="customInputDefault simple" placeholder="010" value="<c:out value="${exprnApplVO.mobileNo1}"/>">
                                    <span>-</span>
                                    <label for="contactMiddle">연락처 가운데번호</label>
                                    <input type="number" name="mobileNo2" maxlength="4" id="contactMiddle" class="customInputDefault simple" placeholder="0000" value="<c:out value="${exprnApplVO.mobileNo2}"/>">
                                    <span>-</span>
                                    <label for="contactLast">연락처 끝번호</label>
                                    <input type="number" name="mobileNo3" maxlength="4" id="contactLast" class="customInputDefault simple" placeholder="0000" value="<c:out value="${exprnApplVO.mobileNo3}"/>">
                                </div>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first">
                        <div class="innerCell">이메일</div>
                    </th>
                    <td>
                        <div class="innerCell">
                            <c:if test="${myPageMode == 'VIEW'}">
                                <c:out value="${exprnApplVO.email}"/>
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <input type="text" id="emailId" placeholder="ID" class="customInputDefault" name="email1" value="<c:out value="${exprnApplVO.email1}"/>">
                                &nbsp;@&nbsp;
                                <input type="text" id="emailDomain" placeholder="도메인" class="customInputDefault" name="email2" value="<c:out value="${exprnApplVO.email2}"/>">
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
                                (<c:out value="${exprnApplVO.zip}"/>) <c:out value="${exprnApplVO.addr}"/> <c:out value="${exprnApplVO.detailAddr}"/>
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <input type="hidden" name="zip" value="<c:out value="${exprnApplVO.zip}"/>">
                                <div class="addressForm">
                                    <label for="addressInput1">검색 주소 입력</label>
                                    <input type="text" name="addr" id="addressInput1" class="customInputDefault inputAddress simple" placeholder="도로명 또는 건물명을 입력해주세요" value="<c:out value="${exprnApplVO.addr}"/>">
                                    <%--<a href="" class="searchAddress"><span>우편번호</span></a>--%>
                                    <button type="button" class="searchAddress" onclick="openDaumZipAddress();"><span>우편번호</span></button>
                                    <label for="addressInput2">상세 주소 입력</label>
                                    <input type="text" name="detailAddr" id="addressInput2" class="customInputDefault inputAddress detail" placeholder="상세주소 입력해주세요" value="<c:out value="${exprnApplVO.detailAddr}"/>">
                                </div>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <!-- 유료 옵션 -->
                <%--<tr> TODOSDB: 감면신청 여부
                    <th scope="row" class="first"><div class="innerCell">감면신청</div></th>
                    <td><div class="innerCell">신청(국가유공자: 할인율 50%) / 아니오</div></td>
                </tr>--%>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">신청일시</div></th>
                    <td><div class="innerCell"><c:out value="${tsu:toDateFormat(exprnApplVO.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd HH:mm:ss')}"/></div></td>
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
                    <button type="submit" class="customLink bgGreen" onclick="return formCheck(this);"><span>수정</span></button>
                </c:if>
                <c:if test="${myPageMode == 'VIEW'}">
                    <a href="./myPageViewByExprn.do?exprnApplNo=<c:out value="${exprnApplVO.exprnApplNo}"/>&amp;<c:out value="${myPageSearchVO.params}"/>&amp;myPageMode=UPDT" class="customLink bgGreen"><span>수정</span></a>
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

        var regPhone = /^010-\d{4}-\d{4}$/;
        var regEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

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

        if( !confirm("수정하시겠습니까?") ) {
            return false;
        }
        return true;
    }

</script>
</body>
</html>
