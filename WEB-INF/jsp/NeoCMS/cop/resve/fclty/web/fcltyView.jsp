<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% pageContext.setAttribute("newLineChar", "\n"); %>

<!DOCTYPE html>
<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
    <title>${menuInfo.cntntsNm} 상세보기</title>
</head>
<body>

<h3>시설 상세보기 - "<c:out value="${fcltyVO.fcltyNm}"/>"</h3>
<div class="viewProgram simpleInformation">
    <div class="simpleTextArea">
        <div class="title">
            <c:set var="operSttus" value="${fcltyVO.operSttus}"/>
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
            <span class="stateType <c:out value="${sttusType}"/>"><c:out value="${operSttusMap[fcltyVO.operSttus]}"/></span>
            <strong><c:out value="${fcltyVO.fcltyNm}"/></strong>
        </div>
        <div class="linkGroup">
            <c:if test="${fcltyVO.operSttus == 'RCPT_ING'}">
                <a href="./fcltyApplCalendarWebView.do?fcltyNo=<c:out value="${fcltyVO.fcltyNo}"/>&amp;<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsWeb}"/>" class="anchorButton wide line-color-green">신청하기</a>
            </c:if>
            <a href="./myPageList.do?key=59" class="anchorButton wide line-color-green">예약확인</a>
            <a href="./selectFcltyWebList.do?<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsWeb}"/>" class="anchorButton">목록</a>
            <a href="./selectBbsNttList.do?bbsNo=1&key=70" class="anchorButton">공지사항</a>
        </div>
    </div>
    <div class="simpleImage">
        <div class="imageSlide">
            <div class="slideList">
                <c:choose>
                    <c:when test="${fn:length(cmmnAtchImgList) gt 0}">
                        <c:forEach var="result" items="${cmmnAtchImgList}">
                            <div class="slideItem aaa">
                                <img src="/<c:out value="${result.storePath}"/>/thumb/p_<c:out value="${result.storeFileNm}"/>" alt="<c:out value="${fcltyVO.fcltyNm}"/> 이미지">
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:when test="${fn:length(cmmnAtchImgList) eq 0 and not empty fcltyVO.svcTyCd}">
                        <div class="slideItem bbb">
                            <img src="/DATA/fct/no_img/<c:out value="${fcltyVO.svcTyCd}"/>.jpg" alt="<c:out value="${svcTyMap[fcltyVO.svcTyCd]}"/><c:out value="${fn:contains(svcTyMap[fcltyVO.svcTyCd],'장')?'':'장'}"/> 이미지">
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="slideItem ccc">
                            <img src="/site/www/images/program/no-image-grey.png" alt="<c:out value="${fcltyVO.fcltyNm}"/> 이미지 없음">
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
            <a href="#tab1" data-content-key="tab1" class="current"><span>시설정보</span></a>
            <a href="#tab2" data-content-key="tab2"><span>상세내용</span></a>
            <a href="#tab3" data-content-key="tab3"><span>위치안내</span></a>
            <a href="#tab4" data-content-key="tab4"><span>유의사항</span></a>
            <a href="#tab5" data-content-key="tab5"><span>환불정책</span></a>
        </div>
        <div class="tabContent">
            <div class="tabContentItem" data-content-key="tab1" id="tab1">
                <h4 class="noLine">시설정보</h4>
                <div class="itemWrap">
                    <table class="table default">
                        <caption>시설정보 - 운영기관, 대상, 장소, 주소, 접수기간, 시설예약기간, 사용료, 선별방법, 예약방법, 문의전화, 첨부파일</caption>
                        <tbody>
                        <tr>
                            <th scope="row" class="first">운영기관</th>
                            <td>
                                <c:set var="insttNo" value="instt${fcltyVO.insttNo}"/>
                                <c:out value="${fctInsttMap[insttNo]}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">대상</th>
                            <td>
                                <c:choose>
                                    <c:when test="${fn:length(targetList) == fn:length(fcltyVO.targetCdArr)}">
                                        제한없음
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="result" items="${fcltyVO.targetCdArr}" varStatus="status">
                                            <c:out value="${targetMap[result]}"/>
                                            <c:if test="${!status.last}">, </c:if>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">장소</th>
                            <td>
                                <c:set var="placeNo" value="place${fcltyVO.placeNo}"/>
                                <c:out value="${fctPlaceMap[placeNo]}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">주소</th>
                            <td>
                                <c:set var="placeLat" value=""/>
                                <c:set var="placeLon" value=""/>
                                <c:set var="placeNm" value=""/>

                                <c:forEach var="result" items="${fctPlaceList}">
                                    <c:if test="${result.placeNo == fcltyVO.placeNo}">
                                        <c:out value="${result.addr}"/> <c:out value="${result.detailAddr}"/>
                                        <c:set var="placeLat" value="${result.lat}"/>
                                        <c:set var="placeLon" value="${result.lon}"/>
                                        <c:set var="placeNm" value="${result.placeNm}"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">접수기간</th>
                            <td>
                                <c:out value="${fcltyVO.rcptBgnDe}"/> <c:out value="${fcltyVO.rcptBgnHh}"/>:<c:out value="${fcltyVO.rcptBgnMm}"/> ~
                                <c:out value="${fcltyVO.rcptEndDe}"/> <c:out value="${fcltyVO.rcptEndHh}"/>:<c:out value="${fcltyVO.rcptEndMm}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">시설예약기간</th>
                            <td>
                                <c:out value="${tsu:toDateFormat(fcltyVO.fcltyMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/> ~
                                <c:out value="${tsu:toDateFormat(fcltyVO.fcltyMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">사용료</th>
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
                            <th scope="row" class="first">선별방법</th>
                            <td>
                                <%-- 선발방식 공통코드 - FIRST : 선착순 / CONFM : 승인 / DRWLT : 추첨 --%>
                                <c:out value="${slctMthdMap[fcltyVO.slctMthdCd]}"/>
                                <c:if test="${fcltyVO.slctMthdCd == 'DRWLT'}">
                                    / 추첨일시 : <c:out value="${tsu:toDateFormat(fcltyVO.drwtDt, 'yyyyMMddHHss', 'yyyy-MM-dd HH:mm')}"/>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">예약방법</th>
                            <td>
                                <%-- 접수방식 공통코드 - ONLIN : 온라인 / TLPHN : 전화 / VISIT : 방문 --%>
                                <c:forEach var="result" items="${fcltyVO.rcptMthdCdArr}" varStatus="status">
                                    <c:out value="${rcptMthdMap[result]}"/>
                                    <c:if test="${!status.last}">, </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                        <c:if test="${not empty fcltyVO.telNoFmt}">
                            <tr>
                                <th scope="row" class="first">문의전화</th>
                                <td><c:out value="${fcltyVO.telNoFmt}"/></td>
                            </tr>
                        </c:if>

                        <c:if test="${fn:length(cmmnAtchFileList) > 0}">
                            <tr>
                                <th scope="row" class="first">첨부파일</th>
                                <td>
                                    <c:forEach var="cmmnAtchFile" items="${cmmnAtchFileList}" varStatus="idx">
                                        <a href="./downloadFcltyFileU.do?key=<c:out value="${param.key}"/>&amp;fcltyNo=<c:out value="${fcltyVO.fcltyNo}"/>&amp;fileNo=<c:out value="${cmmnAtchFile.fileNo}"/>" class="link download"><span><c:out value="${cmmnAtchFile.fileNm}"/></span></a>
                                        <c:if test="${!idx.last}"><br></c:if>
                                    </c:forEach>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab2" id="tab2">
                <h4>상세내용</h4>
                <div class="itemWrap">
                    <c:out value="${fn:replace(fn:escapeXml(fcltyVO.detailCn), newLineChar, '<br>')}" escapeXml="false"/>
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab3" id="tab3">
                <h4>위치안내</h4>
                <div class="itemWrap">
                    <strong class="locationTitle"><c:out value="${fctPlaceMap[placeNo]}"/></strong>
                    <div class="locationInformation">
                        <ul>
                            <li>
                                <span class="locationInformationTitle">주소</span>
                                <p class="locationInformationText">
                                    <c:forEach var="result" items="${fctPlaceList}">
                                        <c:if test="${result.placeNo == fcltyVO.placeNo}">
                                            <c:out value="${result.addr}"/> <c:out value="${result.detailAddr}"/>
                                        </c:if>
                                    </c:forEach>
                                </p>
                            </li>
                            <li>
                                <span class="locationInformationTitle">전화번호</span>
                                <p class="locationInformationText"><c:out value="${not empty fcltyVO.telNoFmt ? fcltyVO.telNoFmt : '-'}"/></p>
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
                <div class="itemWrap">
                    <c:out value="${fn:replace(fn:escapeXml(fcltyVO.noticeCn), newLineChar, '<br>')}" escapeXml="false"/>
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab5" id="tab5">
                <h4>환불정책</h4>
                <div class="itemWrap">
                    <c:out value="${fn:replace(fn:escapeXml(fcltyVO.refundPlcyCn), newLineChar, '<br>')}" escapeXml="false"/>
                </div>
            </div>
        </div>
    </div>
    <div class="infoState">
        <div class="programCalendar">
            <jsp:include page="../schd/web/fcltyCalendar.jsp" />
        </div>
        <div class="shortLink">
            <span class="stateType <c:out value="${sttusType}"/>"><c:out value="${operSttusMap[fcltyVO.operSttus]}"/></span>
            <strong><c:out value="${fcltyVO.fcltyNm}"/></strong>
            <div class="linkGroup">
                <c:if test="${fcltyVO.operSttus == 'RCPT_ING' && fn:contains(fcltyVO.rcptMthdCd, 'ONLIN')}">
                    <a href="./fcltyApplCalendarWebView.do?fcltyNo=<c:out value="${fcltyVO.fcltyNo}"/>&amp;<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsWeb}"/>" class="anchorButton wide line-color-green">신청하기</a>
                </c:if>
                <a href="./myPageList.do?key=59" class="anchorButton wide line-color-green">예약확인</a>
                <a href="./selectFcltyWebList.do?<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsWeb}"/>" class="anchorButton">목록</a>
                <a href="./selectBbsNttList.do?bbsNo=1&key=70" class="anchorButton">공지사항</a>
            </div>
        </div>
    </div>
</div>

<script>

    $(document).on("click", ".prevButton, .nextButton", function () {

        var programCalendar = $('.programCalendar');
        var year = $(this).data('year');
        var month = $(this).data('month');

        $.ajax({
            cache: false,
            url: './fcltyCalendarAjax.do',
            type: 'POST',
            data: {
                fcltyNo: '<c:out value="${fcltyVO.fcltyNo}"/>',
                year: year,
                month: month
            },
            success: function (res) {
                programCalendar.html(res);
            }, // success
            error: function (request,xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                console.log("code:",request.status);
                console.log("message:",request.responseText);
                console.log("error:"+error)
            }
        });
    });

</script>
<%-- 로컬 appkey : 5d520cb928ac962ed6acc665ac464c83 --%>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@prop['daum.map.app.key']"/>&libraries=services"></script>
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
