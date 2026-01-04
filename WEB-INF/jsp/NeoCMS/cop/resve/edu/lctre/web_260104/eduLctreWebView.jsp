<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
    <title>${menuInfo.cntntsNm} 상세</title>
    <script>
        function fn_goApply() {
            var operSttus = "${eduLctreVO.operSttus}";
            if ( operSttus == 'RCPT_ING' || operSttus == 'WAIT_ING' || operSttus == 'RCPT_ADD' ) {
                return true;
            }
            alert("접수가 마감되었습니다.");
            return false;
        }
    </script>
</head>
<body>
<h3>교육 상세보기 - <c:out value="${eduLctreVO.lctreNm}"/> </h3>
<input type="hidden" name="key" value="${key}"/>

<div class="viewProgram simpleInformation">
    <div class="simpleTextArea">
        <div class="title">
            <%-- [운영상태]
                OPER_CNCL 폐강 | OPER_END 종료 | OPER_ING 운영중
                RCPT_ADD 추가모집 | RCPT_END 접수마감 | RCPT_ING 접수중
                RCPT_WAIT 접수예정 | WAIT_ING 대기자접수
            --%>
                <c:set var="stateTypeClass" value="type1"/>
                <c:if test="${eduLctreVO.operSttus eq 'RCPT_ING'
                                                    or eduLctreVO.operSttus eq 'RCPT_ADD'
                                                    or eduLctreVO.operSttus eq 'WAIT_ING'}">
                    <c:set var="stateTypeClass" value="type2"/>
                </c:if>
                <c:if test="${eduLctreVO.operSttus eq 'OPER_CNCL'
                                                    or eduLctreVO.operSttus eq 'OPER_END'
                                                    or eduLctreVO.operSttus eq 'RCPT_END'
                                                    or eduLctreVO.operSttus eq 'OPER_ING'}">
                    <c:set var="stateTypeClass" value="type3"/>
                </c:if>
                <span class="stateType ${stateTypeClass}"><c:out value="${operSttusMap[eduLctreVO.operSttus]}"/></span>
            <strong><c:out value="${eduLctreVO.lctreNm}"/></strong>
        </div>
        <div class="linkGroup">
            <c:if test="${(eduLctreVO.operSttus eq 'RCPT_ING'
                            or eduLctreVO.operSttus eq 'RCPT_ADD'
                            or eduLctreVO.operSttus eq 'WAIT_ING')
                            and fn:contains(eduLctreVO.rcptMthdCd, 'ONLIN')
                            }">
                <a href="./eduAplctAgreWebView.do?lctreNo=${eduLctreVO.lctreNo}&amp;<c:out value="${eduLctreVO.params}"/>" class="anchorButton wide line-color-green" onclick="return fn_goApply();">신청하기</a>
            </c:if>
            <a href="./myPageList.do?key=59" class="anchorButton wide line-color-green">예약확인</a>
            <a href="./selectEduLctreWebList.do?<c:out value="${eduLctreVO.params}"/>" class="anchorButton">목록</a>
            <a href="./selectBbsNttList.do?bbsNo=1&key=70" class="anchorButton">공지사항</a>
        </div>
    </div>
    <div class="simpleImage">
        <div class="imageSlide">
            <div class="slideList">
                <%--
                <div class="slideItem">
                    <img src="/site/www/images/search/testImage.png" alt="대체텍스트">
                </div>
                <div class="slideItem no-image">
                    <img src="/site/www/images/program/no-image-grey.png" alt="대체텍스트">
                </div>
                --%>
                <c:choose>
                    <c:when test="${not empty cmmnAtchImgList}">
                        <c:forEach var="cmmnAtchmnfl" items="${cmmnAtchImgList}" varStatus="idx">
                            <div class="slideItem">
                                <img src="/<c:out value="${cmmnAtchmnfl.storePath}"/>/thumb/p_<c:out value="${cmmnAtchmnfl.storeFileNm}"/>" alt="<c:out value="${eduLctreVO.lctreNm}"/> 이미지">
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="slideItem">
                            <img src="/site/www/images/program/no-image-grey.png" alt="<c:out value="${eduLctreVO.lctreNm}"/> 이미지 없음">
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
            <div class="controller">
                <div class="count">
                    <span class="current">0</span>/<span class="total">0</span>
                </div>
                <button type="button" class="prev"><span>이전</span></button>
                <button type="button" class="next"><span>다음</span></button>
            </div>
        </div>
    </div>
</div>
<div class="viewProgram detailInformation">
    <div class="infoTab">
        <div class="tabButton">
            <a href="#tab1" type="button" data-content-key="tab1" class="current"><span>교육정보</span></a>
            <a href="#tab2" data-content-key="tab2"><span>상세내용</span></a>
            <a href="#tab3" data-content-key="tab3"><span>위치안내</span></a>
            <a href="#tab4" data-content-key="tab4"><span>유의사항</span></a>
            <a href="#tab5" data-content-key="tab5"><span>환불정책</span></a>
        </div>
        <div class="tabContent">
            <div class="tabContentIㄱtem" data-content-key="tab1" id="tab1">
                <h4 class="noLine">교육정보</h4>
                <div class="itemWrap">
                    <table class="table default" data-table-response>
                        <caption>상세내용 - 운영기관, 기수(회차), 대상, 장소, 주소, 접수기간, 운영기간, 모집인원, 이용요금, 선별방법, 예약방법, 문의전화, 강의계획서</caption>
                        <colgroup>
                            <col style="width:200px">
                            <col>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th scope="row" class="first">운영기관</th>
                            <td><c:out value="${eduLctreVO.insttNm}"/></td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">강좌명</th>
                            <td><c:out value="${eduLctreVO.lctreNm}"/></td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">대상</th>
                            <td>
                                <c:set var="isAllTargets" value="${not empty trgetList}"/>
                                <%-- 대상 코드가 전부 있으면 '제한없음' 표시 --%>
                                <c:forEach var="cd" items="${trgetList}">
                                    <c:if test="${isAllTargets and !eduLctreVO.trgetList.contains(cd.code)}">
                                        <c:set var="isAllTargets" value="false"/>
                                    </c:if>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${isAllTargets}">
                                        제한없음
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="targetCd" items="${eduLctreVO.trgetList}" varStatus="status">
                                            <c:out value="${targetMap[targetCd]}"/>
                                            <c:if test="${!status.last}"> , </c:if>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">장소</th>
                            <td>
                                <c:set var="placeNo" value="place${eduLctreVO.placeNo}"/>
                                <c:out value="${eduPlaceMap[placeNo]}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">주소</th>
                            <td>
                                <c:forEach var="place" items="${eduPlaceList}">
                                    <c:if test="${place.placeNo eq eduLctreVO.placeNo}">
                                        <c:out value="${place.addr}"/>
                                        <c:if test="${not empty place.detailAddr}">
                                            <c:out value=" ${place.detailAddr}"/>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">접수기간</th>
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
                        <c:if test="${!empty eduLctreVO.addRcptBgnDt}">
                            <tr>
                                <th scope="row" class="first">추가모집기간</th>
                                <td>
                                    <c:if test="${not empty eduLctreVO.addRcptBgnDt && fn:length(eduLctreVO.addRcptBgnDt) >= 12}">
                                        <c:set var="rcptBgnDe" value="${fn:substring(eduLctreVO.addRcptBgnDt, 0, 8)}"/>
                                        <c:set var="rcptBgnHm" value="${fn:substring(eduLctreVO.addRcptBgnDt, 8, 12)}"/>
                                        ${fn:substring(rcptBgnDe, 0, 4)}.${fn:substring(rcptBgnDe, 4, 6)}.${fn:substring(rcptBgnDe, 6, 8)}
                                        ${fn:substring(rcptBgnHm, 0, 2)}시
                                    </c:if>
                                    ~
                                    <c:if test="${not empty eduLctreVO.addRcptEndDt && fn:length(eduLctreVO.addRcptEndDt) >= 12}">
                                        <c:set var="rcptEndDe" value="${fn:substring(eduLctreVO.addRcptEndDt, 0, 8)}"/>
                                        <c:set var="rcptEndHm" value="${fn:substring(eduLctreVO.addRcptEndDt, 8, 12)}"/>
                                        ${fn:substring(rcptEndDe, 0, 4)}.${fn:substring(rcptEndDe, 4, 6)}.${fn:substring(rcptEndDe, 6, 8)}
                                        ${fn:substring(rcptEndHm, 0, 2)}시
                                    </c:if>
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <th scope="row" class="first">운영기간</th>
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
                        </tr>
                        <tr>
                            <th scope="row" class="first">운영시간</th>
                            <td>
                                <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 12}">
                                    <c:set var="lctBgnHm" value="${fn:substring(eduLctreVO.lctBgnDt, 8, 12)}"/>
                                    ${fn:substring(lctBgnHm, 0, 2)}시
                                </c:if>
                                ~
                                <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 12}">
                                    <c:set var="lctEndHm" value="${fn:substring(eduLctreVO.lctEndDt, 8, 12)}"/>
                                    ${fn:substring(lctEndHm, 0, 2)}시
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">운영요일</th>
                            <td>
                                <c:if test="${not empty eduLctreVO.lctWeekNm}">
                                    <c:out value="${eduLctreVO.lctWeekNm}"/>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">모집인원</th>
                            <td>모집인원: <c:out value="${eduLctreVO.onlineCnt}"/> 명 / 신청인원: <c:out value="${eduLctreVO.rsvCmplCnt != null ? eduLctreVO.rsvCmplCnt : 0}"/> 명</td>
                        </tr>
                    <c:if test="${slctMthdMap[eduLctreVO.slctMthdCd] eq '선착순'}">
                        <tr>
                            <th scope="row" class="first">대기모집</th>
                            <td><c:out value="${eduLctreVO.waitCnt}"/> 명 / 대기신청인원: <c:out value="${eduLctreVO.waitLstCnt != null ? eduLctreVO.waitLstCnt : 0}"/> 명</td>
                        </tr>
                    </c:if>
                        <tr>
                            <th scope="row" class="first">이용요금</th>
                            <td>
                                <c:choose>
                                    <c:when test="${!empty eduLctreVO.eduAmt and eduLctreVO.eduAmt > 0}">
                                        유료 ( <fmt:formatNumber value="${eduLctreVO.eduAmt}" pattern="#,###"/>원 )
                                        <c:if test="${fn:contains(eduLctreVO.payMthdCd, 'NBKRCP')}">
                                            <br/>- 은행명 : <c:out value="${eduLctreVO.bankNm}"/>
                                            <br/>- 계좌번호 : <c:out value="${eduLctreVO.acctNo}"/>
                                            <br/>- 예금주명 : <c:out value="${eduLctreVO.dpstrNm}"/>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>무료</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">선별방법</th>
                            <td><c:out value="${slctMthdMap[eduLctreVO.slctMthdCd]}"/></td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">예약방법</th>
                            <td>
                                <c:forEach var="selectedCode" items="${eduLctreVO.rcptMthdCdList}" varStatus="status">
                                    <c:forEach var="item" items="${rcptMthdList}">
                                        <c:if test="${item.code eq selectedCode}">
                                            <c:if test="${!status.first}">, </c:if>
                                            <c:out value="${item.codeNm}"/>
                                        </c:if>
                                    </c:forEach>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">문의전화</th>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty eduLctreVO.formattedTelNo}">
                                        <c:out value="${eduLctreVO.formattedTelNo}"/>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">강의계획서</th>
                            <td>
                                <c:forEach var="cmmnAtchFile" items="${cmmnAtchFileList}" varStatus="idx">
                                    <a href="./downloadLctreFileWeb.do?key=<c:out value="${param.key}"/>&amp;lctreNo=<c:out value="${eduLctreVO.lctreNo}"/>&amp;fileNo=<c:out value="${cmmnAtchFile.fileNo}"/>" class="link download">
                                        <span><c:out value="${cmmnAtchFile.fileNm}"/></span>
                                    </a>
                                </c:forEach>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="linkGroup marginTop30">
                    <c:if test="${(eduLctreVO.operSttus eq 'RCPT_ING'
                                or eduLctreVO.operSttus eq 'RCPT_ADD'
                                or eduLctreVO.operSttus eq 'WAIT_ING')
                                and fn:contains(eduLctreVO.rcptMthdCd, 'ONLIN')
                                }">
                        <a href="./eduAplctAgreWebView.do?lctreNo=${eduLctreVO.lctreNo}&amp;<c:out value="${eduLctreVO.params}"/>" class="anchorButton wide line-color-green" onclick="return fn_goApply();">신청하기</a>
                    </c:if>
                    <a href="./myPageList.do?key=59" class="anchorButton wide line-color-green">예약확인</a>
                    <a href="./selectEduLctreWebList.do?<c:out value="${eduLctreVO.params}"/>" class="anchorButton">목록</a>
                    <a href="./selectBbsNttList.do?bbsNo=1&key=70" class="anchorButton">공지사항</a>
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab2" id="tab2">
                <h4>상세내용</h4>
                <div class="itemWrap" style="white-space: pre-line;">
                    <c:out value="${eduLctreVO.detailCn}" escapeXml="false"/>
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab3" id="tab3">
                <h4>위치안내</h4>
                <div class="itemWrap">
                    <%-- 장소 좌표 정보 추출 --%>
                    <c:set var="placeLat" value=""/>
                    <c:set var="placeLon" value=""/>
                    <c:set var="placeNm" value=""/>
                    <c:forEach var="place" items="${eduPlaceList}">
                        <c:if test="${place.placeNo eq eduLctreVO.placeNo}">
                            <c:set var="placeLat" value="${place.lat}"/>
                            <c:set var="placeLon" value="${place.lon}"/>
                            <c:set var="placeNm" value="${place.placeNm}"/>
                        </c:if>
                    </c:forEach>

                    <strong class="locationTitle">
                        <c:out value="${placeNm}"/>
                    </strong>
                    <div class="locationInformation">
                        <ul>
                            <li>
                                <span class="locationInformationTitle">주소</span>
                                <p class="locationInformationText">
                                    <c:forEach var="place" items="${eduPlaceList}">
                                        <c:if test="${place.placeNo eq eduLctreVO.placeNo}">
                                            <c:out value="${place.addr}"/>
                                            <c:if test="${not empty place.detailAddr}">
                                                <c:out value=" ${place.detailAddr}"/>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </p>
                            </li>
                            <li>
                                <span class="locationInformationTitle">전화번호</span>
                                <p class="locationInformationText">
                                    <c:choose>
                                        <c:when test="${not empty eduLctreVO.formattedTelNo}">
                                            <c:out value="${eduLctreVO.formattedTelNo}"/>
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </p>
                            </li>
                        </ul>
                        <c:choose>
                            <c:when test="${not empty placeLat and not empty placeLon}">
                                <a href="https://map.kakao.com/link/to/<c:out value='${placeNm}'/>,<c:out value='${placeLat}'/>,<c:out value='${placeLon}'/>" class="mapLink" target="_blank" title="새창열림">길찾기</a>
                            </c:when>
                            <c:otherwise>
                                <a href="#none" class="mapLink" onclick="alert('위치 정보가 없습니다.'); return false;">길찾기</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="locationMap">
                        <div id="map"></div>
                    </div>
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab4" id="tab4">
                <h4>유의사항</h4>
                <div class="itemWrap" style="white-space: pre-line;">
                    <c:out value="${eduLctreVO.noticeCn}" escapeXml="false"/>
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab5" id="tab5">
                <h4>환불정책</h4>
                <div class="itemWrap" style="white-space: pre-line;">
                    <c:out value="${eduLctreVO.refundPlcyCn}" escapeXml="false"/>
                </div>
            </div>
        </div>
    </div>
    <div class="infoState">
        <div class="programCalendar">
            <jsp:include page="./eduCalendar.jsp"/>
        </div>
        <div class="shortLink">
            <%-- [운영상태]
                OPER_CNCL 폐강 | OPER_END 종료 | OPER_ING 운영중
                RCPT_ADD 추가모집 | RCPT_END 접수마감 | RCPT_ING 접수중
                RCPT_WAIT 접수예정 | WAIT_ING 대기자접수
            --%>
                <c:set var="stateTypeClass" value="type1"/>
                <c:if test="${eduLctreVO.operSttus eq 'RCPT_ING'
                                                    or eduLctreVO.operSttus eq 'RCPT_ADD'
                                                    or eduLctreVO.operSttus eq 'WAIT_ING'}">
                    <c:set var="stateTypeClass" value="type2"/>
                </c:if>
                <c:if test="${eduLctreVO.operSttus eq 'OPER_CNCL'
                                                    or eduLctreVO.operSttus eq 'OPER_END'
                                                    or eduLctreVO.operSttus eq 'RCPT_END'
                                                    or eduLctreVO.operSttus eq 'OPER_ING'}">
                    <c:set var="stateTypeClass" value="type3"/>
                </c:if>
                <span class="stateType ${stateTypeClass}"><c:out value="${operSttusMap[eduLctreVO.operSttus]}"/></span>
            <strong><c:out value="${eduLctreVO.lctreNm}"/></strong>
            <div class="linkGroup">
                <c:if test="${(eduLctreVO.operSttus eq 'RCPT_ING'
                            or eduLctreVO.operSttus eq 'RCPT_ADD'
                            or eduLctreVO.operSttus eq 'WAIT_ING')
                            and fn:contains(eduLctreVO.rcptMthdCd, 'ONLIN')
                            }">
                    <a href="./eduAplctAgreWebView.do?lctreNo=${eduLctreVO.lctreNo}&amp;<c:out value="${eduLctreVO.params}"/>" class="anchorButton wide line-color-green" onclick="return fn_goApply();">신청하기</a>
                </c:if>

                <a href="./myPageList.do?key=59" class="anchorButton wide line-color-green">예약확인</a>
                <a href="./selectEduLctreWebList.do?<c:out value="${eduLctreVO.params}"/>" class="anchorButton">목록</a>
                <a href="./selectBbsNttList.do?bbsNo=1&key=70" class="anchorButton">공지사항</a>
            </div>
        </div>
    </div>
</div>

<%-- 로컬 appkey : 5d520cb928ac962ed6acc665ac464c83 --%>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=21afdca76805d74b4e167d981b8fe3e3&libraries=services"></script>
<script>
    if (document.getElementById('map')) {
        kakao.maps.load(function () {
            const container = document.getElementById('map');
            if (!container) return;

            // 좌표 파싱 (값이 없거나 유효하지 않으면 NaN)
            const lat = parseFloat('<c:out value="${placeLat}"/>');
            const lon = parseFloat('<c:out value="${placeLon}"/>');

            // 좌표가 유효하지 않으면(NaN 등) 기본값(서울시청) 사용
            const position = new kakao.maps.LatLng(
                lat || 37.5665,
                lon || 126.9780
            );

            // 지도 생성
            const map = new kakao.maps.Map(container, {
                center: position,
                level: 3
            });

            // 마커 생성 및 지도에 표시 (map 옵션 사용)
            new kakao.maps.Marker({
                position: position,
                map: map
            });
        });
    }
</script>
</body>
</html>
