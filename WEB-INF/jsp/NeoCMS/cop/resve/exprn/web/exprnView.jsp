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

<h3>체험 상세보기 - "<c:out value="${exprnVO.exprnNm}"/>"</h3>
<div class="viewProgram simpleInformation">
    <div class="simpleTextArea">
        <div class="title">
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
        <div class="linkGroup">
            <c:if test="${exprnVO.operSttus == 'RCPT_ING' && fn:contains(exprnVO.rcptMthdCd, 'ONLIN')}">
                <a href="./exprnApplCalendarWebView.do?exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsWeb}"/>" class="anchorButton wide line-color-green">신청하기</a>
            </c:if>
            <a href="./myPageList.do?key=59" class="anchorButton wide line-color-green">예약확인</a>
            <a href="./selectExprnWebList.do?<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsWeb}"/>" class="anchorButton">목록</a>
            <a href="./selectBbsNttList.do?bbsNo=1&key=70" class="anchorButton">공지사항</a>
        </div>
    </div>
    <div class="simpleImage">
        <div class="imageSlide">
            <div class="slideList">
                <div class="slideItem">
                    <c:choose>
                        <c:when test="${fn:length(cmmnAtchImgList) == 0}">
                            <img src="/DATA/exprn/img/no_img_<c:out value="${exprnVO.svcTyCd}"/>.jpg" alt="<c:out value="${exprnVO.exprnNm}"/> 이미지 없음">
                       </c:when>
                        <c:otherwise>
                            <c:forEach var="result" items="${cmmnAtchImgList}">
                                <img src="/<c:out value="${result.storePath}"/>/thumb/p_<c:out value="${result.storeFileNm}"/>" alt="<c:out value="${exprnVO.exprnNm}"/> 이미지">
                             </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
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
            <a href="#tab1" type="button" data-content-key="tab1" class="current"><span>체험정보</span></a>
            <a href="#tab2" data-content-key="tab2"><span>상세내용</span></a>
            <a href="#tab3" data-content-key="tab3"><span>위치안내</span></a>
            <a href="#tab4" data-content-key="tab4"><span>유의사항</span></a>
            <a href="#tab5" data-content-key="tab5"><span>환불정책</span></a>
        </div>
        <div class="tabContent">
            <div class="tabContentItem" data-content-key="tab1" id="tab1">
                <h4 class="noLine">체험정보</h4>
                <div class="itemWrap">
                    <table class="table default">
                        <caption>체험정보 - 운영기관, 대상, 장소, 주소, 접수기간, 체험기간, 모집수, 체험요금, 선별방법, 예약방법, 문의전화, 첨부파일</caption>
                        <tbody>
                        <tr>
                            <th scope="row" class="first">운영기관</th>
                            <td>
                                <c:set var="insttNo" value="instt${exprnVO.insttNo}"/>
                                <c:out value="${expInsttMap[insttNo]}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">대상</th>
                            <td>
                                <c:choose>
                                    <c:when test="${fn:length(targetList) == fn:length(exprnVO.targetCdArr)}">
                                        제한없음
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="result" items="${exprnVO.targetCdArr}" varStatus="status">
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
                                <c:set var="placeNo" value="place${exprnVO.placeNo}"/>
                                <c:out value="${expPlaceMap[placeNo]}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">주소</th>
                            <td>
                                <c:forEach var="result" items="${expPlaceList}">
                                    <c:if test="${result.placeNo == exprnVO.placeNo}">
                                        <c:out value="${result.addr}"/> <c:out value="${result.detailAddr}"/>
                                    </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">접수기간</th>
                            <td>
                                <c:out value="${exprnVO.rcptBgnDe}"/> <c:out value="${exprnVO.rcptBgnHh}"/>:<c:out value="${exprnVO.rcptBgnMm}"/> ~
                                <c:out value="${exprnVO.rcptEndDe}"/> <c:out value="${exprnVO.rcptEndHh}"/>:<c:out value="${exprnVO.rcptEndMm}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">체험기간</th>
                            <td>
                                <c:out value="${tsu:toDateFormat(exprnVO.exprnMinBgnDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/> ~
                                <c:out value="${tsu:toDateFormat(exprnVO.exprnMaxEndDe, 'yyyyMMdd', 'yyyy-MM-dd')}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">모집수</th>
                            <td>
                                <c:out value="${exprnVO.rcritCnt}"/> <c:out value="${exprnVO.rcritUnit}"/></td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">체험요금</th>
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
                            <th scope="row" class="first">선별방법</th>
                            <td>
                                <%-- 선발방식 공통코드 - FIRST : 선착순 / CONFM : 승인 / DRWLT : 추첨 --%>
                                <c:out value="${slctMthdMap[exprnVO.slctMthdCd]}"/>
                                <%--<c:if test="${exprnVO.slctMthdCd == 'DRWLT'}">
                                    / 추첨일시 : <c:out value="${tsu:toDateFormat(exprnVO.drwtDt, 'yyyyMMddHHss', 'yyyy-MM-dd HH:mm')}"/>
                                </c:if>--%>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">예약방법</th>
                            <td>
                                <%-- 접수방식 공통코드 - ONLIN : 온라인 / TLPHN : 전화 / VISIT : 방문 --%>
                                <c:forEach var="result" items="${exprnVO.rcptMthdCdArr}" varStatus="status">
                                    <c:out value="${rcptMthdMap[result]}"/>
                                    <c:if test="${!status.last}">, </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">문의전화</th>
                            <td><c:out value="${exprnVO.telNoFmt}"/></td>
                        </tr>
                        <tr>
                            <th scope="row" class="first">첨부파일</th>
                            <td>
                                <c:forEach var="cmmnAtchFile" items="${cmmnAtchFileList}" varStatus="idx">
                                    <a href="./downloadExprnFile.do?key=<c:out value="${param.key}"/>&amp;exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;fileNo=<c:out value="${cmmnAtchFile.fileNo}"/>" class="link download"><span><c:out value="${cmmnAtchFile.fileNm}"/></span></a>
                                </c:forEach>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="linkGroup marginTop30">
                    <c:if test="${exprnVO.operSttus == 'RCPT_ING' && fn:contains(exprnVO.rcptMthdCd, 'ONLIN')}">
                        <a href="./exprnApplCalendarWebView.do?exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsWeb}"/>" class="anchorButton wide line-color-green">신청하기</a>
                    </c:if>
                    <a href="./myPageList.do?key=59" class="anchorButton wide line-color-green">예약확인</a>
                    <a href="./selectExprnWebList.do?<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsWeb}"/>" class="anchorButton">목록</a>
                    <a href="./selectBbsNttList.do?bbsNo=1&key=70" class="anchorButton">공지사항</a>
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab2" id="tab2">
                <h4>상세내용</h4>
                <div class="itemWrap">
                    ${tsu:nl2br(exprnVO.detailCn)}
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab3" id="tab3">
                <h4>위치안내</h4>
                <div class="itemWrap">
                    <strong class="locationTitle"><c:out value="${expPlaceMap[placeNo]}"/></strong>
                    <div class="locationInformation">
                        <c:set var="expPlace" value=""/>
                        <c:set var="lat" value=""/>
                        <c:set var="lon" value=""/>
                        <c:forEach var="result" items="${expPlaceList}">
                            <c:if test="${result.placeNo == exprnVO.placeNo}">
                                <c:set var="expPlace" value="${result.addr} ${result.detailAddr}"/>
                                <c:set var="lat" value="${result.lat}"/>
                                <c:set var="lon" value="${result.lon}"/>
                            </c:if>
                        </c:forEach>
                        <ul>
                            <li>
                                <span class="locationInformationTitle">주소</span>
                                <p class="locationInformationText" id="place" data-lat="<c:out value="${lat}"/>" data-lon="<c:out value="${lon}"/>">
                                    <c:out value="${expPlace}"/>
                                </p>
                            </li>
                            <li>
                                <span class="locationInformationTitle">전화번호</span>
                                <p class="locationInformationText"><c:out value="${exprnVO.telNoFmt}"/></p>
                            </li>
                        </ul>
                        <a href="https://map.kakao.com/link/to/<c:out value="${expPlace}"/>,<c:out value="${lat}"/>,<c:out value="${lon}"/>" target="_blank" class="mapLink">길찾기</a>
                    </div>
                    <div class="locationMap">
                        <div id="map"></div>
                    </div>
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab4" id="tab4">
                <h4>유의사항</h4>
                <div class="itemWrap">
                    ${tsu:nl2br(exprnVO.noticeCn)}
                </div>
            </div>
            <div class="tabContentItem" data-content-key="tab5" id="tab5">
                <h4>환불정책</h4>
                <div class="itemWrap">
                    ${tsu:nl2br(exprnVO.refundPlcyCn)}
                </div>
            </div>
        </div>
    </div>
    <div class="infoState">
        <div class="programCalendar">
            <jsp:include page="../schd/web/exprnCalendar.jsp" />
        </div>
        <div class="shortLink">
            <span class="stateType <c:out value="${sttusType}"/>"><c:out value="${operSttusMap[exprnVO.operSttus]}"/></span>
            <strong><c:out value="${exprnVO.exprnNm}"/></strong>
            <div class="linkGroup">
                <c:if test="${exprnVO.operSttus == 'RCPT_ING' && fn:contains(exprnVO.rcptMthdCd, 'ONLIN')}">
                    <a href="./exprnApplCalendarWebView.do?exprnNo=<c:out value="${exprnVO.exprnNo}"/>&amp;<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsWeb}"/>" class="anchorButton wide line-color-green">신청하기</a>
                </c:if>
                <a href="./myPageList.do?key=59" class="anchorButton wide line-color-green">예약확인</a>
                <a href="./selectExprnWebList.do?<c:out value="${exprnSearchVO.params}"/><c:out value="${exprnSearchVO.paramsWeb}"/>" class="anchorButton">목록</a>
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
            url: './exprnCalendarAjax.do',
            type: 'POST',
            data: {
                exprnNo: '<c:out value="${exprnVO.exprnNo}"/>',
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

<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=21afdca76805d74b4e167d981b8fe3e3&autoload=false"></script>
<script>
    if (document.getElementById('map')) {
        kakao.maps.load(function () {
            const container = document.getElementById('map');
            if (!container) return;

            var x = $('#place').data('lon');
            var y = $('#place').data('lat');

            if (!x || !y) {
                // 청주시청 좌표
                x = 127.48905348976224;
                y = 36.642630276128315;
            }

            const options = {
                center: new kakao.maps.LatLng(y, x),
                level: 3
            };

            const map = new kakao.maps.Map(container, options);

            // ---- 여기 아래만 추가 ----
            const markerPosition = new kakao.maps.LatLng(y, x);

            const marker = new kakao.maps.Marker({
                position: markerPosition
            });

            marker.setMap(map);
        });
    }
</script>

</body>
</html>
