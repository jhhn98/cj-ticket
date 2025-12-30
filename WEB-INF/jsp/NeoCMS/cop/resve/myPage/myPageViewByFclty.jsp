<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
    <title>${menuInfo.cntntsNm} 상세보기</title>
</head>
<body>

<c:if test="${myPageMode == 'UPDT'}">
<form method="post" action="./myPageUpdateByFclty.do" onsubmit="return formCheck(this);">
    <input type="hidden" name="fcltyApplNo" value="<c:out value="${fcltyApplVO.fcltyApplNo}"/>">
    <input type="hidden" name="myPageMode" value="<c:out value="${myPageMode}"/>">
    <c:forEach var="result" items="${myPageSearchVO.paramsMap}">
        <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
    </c:forEach>
    <fieldset>
        <legend>신청 정보 수정 - 예약번호, 신청상태, 결제상태, 결제방법, 성명, 생년월일, 성별, 연락처, 이메일, 주소, 감면신청, 신청일시</legend>
        </c:if>
        <h4>시설/견학</h4>
        <h5>프로그램 정보</h5>
        <div class="scrollWrap-table">
            <table class="table default" data-table-response>
                <caption>프로그램 정보-강좌명, 운영기관, 모집상태, 접수기간, 시설기간, 선발방식, 이용요금, 시설장소/주소</caption>
                <colgroup>
                    <col style="width:15%">
                    <col style="width:35%">
                    <col style="width:15%">
                    <col style="width:35%">
                </colgroup>
                <tbody class="textAlignLeft">
                <tr>
                    <th scope="row" class="first">시설명</th>
                    <td colspan="3"><strong><c:out value="${fcltyVO.fcltyNm}"/></strong></td>
                </tr>
                <tr>
                    <th scope="row" class="first">운영기관</th>
                    <td>
                        <c:set var="insttNo" value="instt${fcltyVO.insttNo}"/>
                        <strong><c:out value="${fctInsttMap[insttNo]}"/></strong>
                    </td>
                    <th scope="row">모집상태</th>
                    <td><c:out value="${operSttusMap[fcltyVO.operSttus]}"/></td>
                </tr>
                <tr>
                    <th scope="row" class="first">접수기간</th>
                    <td>
                        <c:out value="${fcltyVO.rcptBgnDe}"/> <c:out value="${fcltyVO.rcptBgnHh}"/>:<c:out value="${fcltyVO.rcptBgnMm}"/> ~
                        <c:out value="${fcltyVO.rcptEndDe}"/> <c:out value="${fcltyVO.rcptEndHh}"/>:<c:out value="${fcltyVO.rcptEndMm}"/>
                    </td>
                    <th scope="row">시설기간</th>
                    <td>
                        <c:out value="${tsu:toDateFormat(fcltyVO.fcltyMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/> ~
                        <c:out value="${tsu:toDateFormat(fcltyVO.fcltyMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first">선발방식</th>
                    <td><c:out value="${slctMthdMap[fcltyVO.slctMthdCd]}"/></td>
                    <th scope="row">이용요금</th>
                    <td>
                        <c:choose>
                            <c:when test="${fcltyVO.fcltyAmt > 0}">
                                <fmt:formatNumber value="${tsu:xssNumberFilter(fcltyVO.fcltyAmt)}" pattern="#,###"/> 원
                            </c:when>
                            <c:otherwise>
                                무료
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first">시설장소</th>
                    <td colspan="3">
                        <c:set var="placeNo" value="place${fcltyVO.placeNo}"/>
                        <c:out value="${fctPlaceMap[placeNo]}"/>
                        <c:forEach var="result" items="${fctPlaceList}">
                            <c:if test="${result.placeNo == fcltyVO.placeNo}">
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
                    <td><div class="innerCell"><strong><c:out value="${fcltyApplVO.fcltyApplId}"/></strong></div></td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">시설사용일자</div></th>
                    <td>
                        <div class="innerCell">
                            <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                            <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyBgnHm, 'HHmm', 'HH:mm')}"/> ~
                            <c:out value="${tsu:toDateFormat(fcltyApplVO.fcltyEndHm, 'HHmm', 'HH:mm')}"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">예약상태</div></th>
                    <td>
                        <div class="innerCell">
                            <c:out value="${rsvSttusMap[fcltyApplVO.rsvSttusCd]}"/>
                            <%-- TODOSDB: 상태값 취소인 경우 취소일시/사유 표출 (유료는 환불 요청일시/사유)
                            사용자 취소(취소일: 2025-07-07 14:10)
                            <p class="iconText caution point-color-green">취소사유: 사용자 취소</p>--%>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">결제상태</div></th>
                    <td>
                        <div class="innerCell">
                            <c:out value="${paySttusMap[fcltyApplVO.paySttusCd]}"/>
                            <%-- TODOSDB: 결제대기인 경우 결제기한까지 / 취소인 경우 환불처리일시 + 환불계좌 필요한 경우 환불계좌 정보까지
                            <p class="iconText caution point-color-green">결제기한: 2025-07-11 00시 00분 00초</p>--%>
                        </div>
                    </td>
                </tr>
                <!-- 유료 옵션 -->
                <c:if test="${fcltyApplVO.totalPayAmt > 0}">
                    <tr>
                        <th scope="row" class="first"><div class="innerCell">결제금액</div></th>
                        <td>
                            <div class="innerCell">
                                <fmt:formatNumber value="${fcltyApplVO.totalPayAmt}" pattern="#,##0"/> 원
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="first"><div class="innerCell">결제방법</div></th>
                        <td>
                            <div class="innerCell">
                                <p><c:out value="${payMthdMap[fcltyApplVO.payMthdCd]}"/></p>
                                <c:if test="${fcltyApplVO.payMthdCd == 'ELCTRN'}">
                                    <%--<div class="editFormPayWrap">
                                        <label for="payType1" class="customRadioButton">
                                            <input type="radio" id="payType1" name="payType">
                                            <span class="customStyle">
                                                <i class="radioButton"></i>
                                                <span>신용카드</span>
                                            </span>
                                        </label>
                                        <label for="payType2" class="customRadioButton">
                                            <input type="radio" id="payType2" name="payType">
                                            <span class="customStyle">
                                                <i class="radioButton"></i>
                                                <span>가상계좌</span>
                                            </span>
                                        </label>
                                        <a href="" class="payButton"><span>전자결제(신용카드,가상계좌)</span></a>
                                    </div>--%>
                                </c:if>
                            </div>
                        </td>
                    </tr>

                    <c:if test="${fcltyApplVO.payMthdCd == 'NBKRCP'}">
                        <tr>
                            <th scope="row" class="first"><div class="innerCell">입금계좌</div></th>
                            <td>
                                <div class="innerCell">
                                    [<c:out value="${fcltyVO.bankNm}"/>] <c:out value="${fcltyVO.acctNo}"/> - <c:out value="${fcltyVO.dpstrNm}"/>
                                </div>
                            </td>
                        </tr>
                    </c:if>

                    <tr>
                        <th scope="row" class="first"><div class="innerCell">결제일시</div></th>
                        <td><%--<div class="innerCell"><c:out value="${fcltyApplVO.applNm}"/></div>--%></td>
                    </tr>
                </c:if>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">성명</div></th>
                    <td><div class="innerCell"><c:out value="${fcltyApplVO.applNm}"/></div></td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">생년월일</div></th>
                    <td><div class="innerCell"><c:out value="${tsu:toDateFormat(fcltyApplVO.birthDe, 'yyyyMMdd', 'yyyy. MM. dd')}"/></div></td>
                </tr>
                <tr>
                    <th scope="row" class="first"><div class="innerCell">성별</div></th>
                    <td>
                        <c:if test="${fcltyApplVO.genderSe == 'M'}">
                            <div class="innerCell">남자</div>
                        </c:if>
                        <c:if test="${fcltyApplVO.genderSe == 'F'}">
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
                                <c:out value="${fcltyApplVO.mobileNo1}"/> - <c:out value="${fcltyApplVO.mobileNo2}"/> - <c:out value="${fcltyApplVO.mobileNo3}"/>
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <div class="contactForm">
                                    <label for="contactFirst">연락처 첫번호</label>
                                    <input type="number" name="mobileNo1" maxlength="4" id="contactFirst" class="customInputDefault simple" placeholder="010" value="<c:out value="${fcltyApplVO.mobileNo1}"/>">
                                    <span>-</span>
                                    <label for="contactMiddle">연락처 가운데번호</label>
                                    <input type="number" name="mobileNo2" maxlength="4" id="contactMiddle" class="customInputDefault simple" placeholder="0000" value="<c:out value="${fcltyApplVO.mobileNo2}"/>">
                                    <span>-</span>
                                    <label for="contactLast">연락처 끝번호</label>
                                    <input type="number" name="mobileNo3" maxlength="4" id="contactLast" class="customInputDefault simple" placeholder="0000" value="<c:out value="${fcltyApplVO.mobileNo3}"/>">
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
                                <c:out value="${fcltyApplVO.email}"/>
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <input type="text" id="emailId" placeholder="ID" class="customInputDefault" name="email1" value="<c:out value="${fcltyApplVO.email1}"/>">
                                &nbsp;@&nbsp;
                                <input type="text" id="emailDomain" placeholder="도메인" class="customInputDefault" name="email2" value="<c:out value="${fcltyApplVO.email2}"/>">
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
                                (<c:out value="${fcltyApplVO.zip}"/>) <c:out value="${fcltyApplVO.addr}"/> <c:out value="${fcltyApplVO.detailAddr}"/>
                            </c:if>
                            <c:if test="${myPageMode == 'UPDT'}">
                                <input type="hidden" name="zip" value="<c:out value="${fcltyApplVO.zip}"/>">
                                <div class="addressForm">
                                    <label for="addressInput1">검색 주소 입력</label>
                                    <input type="text" name="addr" id="addressInput1" class="customInputDefault inputAddress simple" placeholder="도로명 또는 건물명을 입력해주세요" value="<c:out value="${fcltyApplVO.addr}"/>">
                                    <%--<a href="" class="searchAddress"><span>우편번호</span></a>--%>
                                    <button type="button" class="searchAddress" onclick="openDaumZipAddress();"><span>우편번호</span></button>
                                    <label for="addressInput2">상세 주소 입력</label>
                                    <input type="text" name="detailAddr" id="addressInput2" class="customInputDefault inputAddress detail" placeholder="상세주소 입력해주세요" value="<c:out value="${fcltyApplVO.detailAddr}"/>">
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
                    <td><div class="innerCell"><c:out value="${tsu:toDateFormat(fcltyApplVO.applDtMs, 'yyyyMMddHHmmssSSS', 'yyyy-MM-dd HH:mm:ss')}"/></div></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="flexWrap marginTop40">
            <div class="flexLeft">
                <a href="./myPageList.do?<c:out value="${myPageSearchVO.params}"/>" class="customLink lineGray"><span>목록</span></a>
            </div>
            <div class="flexRight">
                <c:if test="${(tsu:getNowDateTime('yyyyMMdd')+0) lt (fcltyApplVO.fcltyDe+0)}">
                    <c:if test="${myPageMode == 'UPDT'}">
                        <button type="submit" class="customLink bgGreen" onclick="return formCheck(this);"><span>수정</span></button>
                    </c:if>
                    <c:if test="${myPageMode == 'VIEW'}">
                        <a href="./myPageViewByFclty.do?fcltyApplNo=<c:out value="${fcltyApplVO.fcltyApplNo}"/>&amp;<c:out value="${myPageSearchVO.params}"/>&amp;myPageMode=UPDT" class="customLink bgGreen"><span>수정</span></a>
                    </c:if>
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
