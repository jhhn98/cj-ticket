<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
    <title>${menuInfo.cntntsNm} 목록</title>
    <script type="text/javascript" src="/common/js/jquery-ui.js" nonce="NEOCMSSCRIPT"></script>
</head>
<body>

<h3>교육 목록</h3>
<div class="programSearch
        <c:if test="${eduLctreVO.searchInsttNo > 0
                  or not empty eduLctreVO.svcTyCd
                  or not empty eduLctreVO.searchAreaGu
                  or not empty eduLctreVO.searchAreaEmd
                  or not empty eduLctreVO.searchChrgeSe
                  or fn:length(eduLctreVO.searchTargetCdList) > 0}">
         showDetail
        </c:if>">
    <form method="post">
        <fieldset>
            <legend>검색</legend>
            <div class="searchFormWrap default">
                <div class="defaultFormWrap">
                    <div class="formElement">
                        <label for="searchOperSttus">운영상태</label>
                        <div class="customSelect">
                            <select id="searchOperSttus" name="searchOperSttus">
                                <option value="">전체</option>
                                <c:forEach var="code" items="${operSttusList}">
                                    <option value="${code.code}"${eduLctreVO.searchOperSttus eq code.code ? ' selected="true"':''}>
                                        <c:out value="${code.codeNm}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="formElement widthWide">
                        <label for="searchLctreNm">강좌명</label>
                        <input type="text" name="searchLctreNm" id="searchLctreNm" value="<c:out value='${eduLctreVO.searchLctreNm}'/>" placeholder="강좌명을 입력해주세요" class="customInputDefault">
                    </div>
                </div>
            </div>
            <div class="searchFormWrap detail srcEdu">
                <div class="selectElementGroup eduGroup">
                    <div class="formElement">
                        <label for="svcTyCd">서비스 유형</label>
                        <div class="customSelect">
                            <select name="svcTyCd" id="svcTyCd" class="customSelect">
                                <option value="">선택하세요</option>
                                <c:forEach var="item" items="${svcTyCdList}">
                                    <option value="${item.code}"${item.code eq eduLctreVO.svcTyCd ? ' selected="selected"' : ''}>${item.codeNm}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="formElement elementCount2">
                        <span class="formElement-label">지역명</span>
                        <div class="customSelect">
                            <select name="searchAreaGu" id="searchAreaGu" title="지역 구 선택" class="customSelect">
                                <option value="">전체</option>
                                <c:forEach var="result" items="${areaGuList}">
                                    <option value="<c:out value="${result.code}"/>"${result.code eq eduLctreVO.searchAreaGu ? ' selected="selected"' : ''}><c:out value="${result.codeNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="customSelect">
                            <select name="searchAreaEmd" id="searchAreaEmd" title="지역 읍/면/동 선택" class="customSelect">
                                <option value="">전체</option>
                                <c:forEach var="result" items="${sdguList}">
                                    <option value="<c:out value='${result.code}'/>"
                                            class="areaEmdList SDGU"
                                            style="display:none;"
                                            ${result.code eq eduLctreVO.searchAreaEmd ? ' selected="selected"' : ''}>
                                        <c:out value='${result.codeNm}'/>
                                    </option>
                                </c:forEach>
                                <c:forEach var="result" items="${hdguList}">
                                    <option value="<c:out value='${result.code}'/>"
                                            class="areaEmdList HDGU"
                                            style="display:none;"
                                            ${result.code eq eduLctreVO.searchAreaEmd ? ' selected="selected"' : ''}>
                                        <c:out value='${result.codeNm}'/>
                                    </option>
                                </c:forEach>
                                <c:forEach var="result" items="${cwguList}">
                                    <option value="<c:out value='${result.code}'/>"
                                            class="areaEmdList CWGU"
                                            style="display:none;"
                                            ${result.code eq eduLctreVO.searchAreaEmd ? ' selected="selected"' : ''}>
                                        <c:out value='${result.codeNm}'/>
                                    </option>
                                </c:forEach>
                                <c:forEach var="result" items="${swguList}">
                                    <option value="<c:out value='${result.code}'/>"
                                            class="areaEmdList SWGU"
                                            style="display:none;"
                                            ${result.code eq eduLctreVO.searchAreaEmd ? ' selected="selected"' : ''}>
                                        <c:out value='${result.codeNm}'/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="formElement">
                        <label for="searchChrgeSe">이용요금</label>
                        <div class="customSelect">
                            <select name="searchChrgeSe" id="searchChrgeSe" class="customSelect">
                                <option value="">전체</option>
                                <option value="F"${eduLctreVO.searchChrgeSe == 'F' ? ' selected="selected"' : ''}>무료</option>
                                <option value="P"${eduLctreVO.searchChrgeSe == 'P' ? ' selected="selected"' : ''}>유료</option>
                            </select>
                        </div>
                    </div>
                    <div class="formElement">
                        <label for="searchInsttNo">운영기관</label>
                        <div class="customSelect">
                            <select name="searchInsttNo" id="searchInsttNo" class="customSelect">
                                <option value="">운영기관 선택</option>
                                <c:forEach var="instt" items="${eduInsttList}">
                                    <option value="${instt.insttNo}"${instt.insttNo eq eduLctreVO.searchInsttNo ? ' selected="true"':''}>
                                        <c:out value="${instt.insttNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="formElement w100per marginTop12">
                    <span class="formElement-label">생애주기</span>
                    <div class="formElement-selectGroup">
                        <c:forEach var="target" items="${trgetList}" varStatus="sts">
                            <c:set var="isChecked" value="false"/>
                            <c:if test="${not empty eduLctreVO.searchTargetCdList}">
                                <c:forEach var="selectedTarget" items="${eduLctreVO.searchTargetCdList}">
                                    <c:if test="${selectedTarget eq target.code}">
                                        <c:set var="isChecked" value="true"/>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <label for="searchTargetCd${sts.index+1}" class="customIconOption">
                                <input type="checkbox" id="searchTargetCd${sts.index+1}" name="searchTargetCdList" value="${target.code}"${isChecked ? ' checked="checked"' : ''}/>
                                <span class="optionWrap">
                                    <i class="optionIcon <c:out value="${target.code}"/>"></i>
                                    <em><c:out value="${target.codeNm}"/></em>
                                </span>
                            </label>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="formButton">
                <button type="submit" class="button submit">검색</button>
                <button type="reset" class="button reset">초기화</button>
            </div>
        </fieldset>
    </form>
    <button type="button" class="detailCloseButton"><span>상세검색 <em class="openText">열기</em><em class="closeText">닫기</em></span></button>
</div>
<div class="dataList-program">
    <div class="asideInformation">
        <button type="button" class="viewType thumb active" data-list-view="thumbnail">썸네일 보기</button>
        <button type="button" class="viewType detail" data-list-view="detail">리스트 보기</button>
    </div>
    <div class="listWrap thumbnail show">
        <div class="dataCount">
            총 : <em><c:out value="${paginationInfo.totalRecordCount}"/> </em>건
            / 페이지 <c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/>
        </div>
        <ul>
            <c:choose>
                <c:when test="${empty eduLctreList}">
                    <li class="noDataList">
                        <div class="noData">
                            <div class="noData-innerWrap">
                                <span class="noDataTitle">검색하신 내용을 찾을 수 없습니다.</span>
                                <p>조건을 바꾸어 다른 검색어를 입력하시거나<span>철자와 띄어쓰기를 확인해보세요.</span></p>
                            </div>
                        </div>
                    </li>
                </c:when>
                <c:otherwise>
                    <c:forEach var="result" items="${eduLctreList}" varStatus="status">
                        <li>
                            <a href="./selectEduLctreWebView.do?key=${key}&lctreNo=${result.lctreNo}">
                                <span class="image">
                                    <img src="/<c:out value="${result.mainImg.storePath}"/>/thumb/p_<c:out value="${result.mainImg.storeFileNm}"/>" alt="<c:out value="${result.lctreNm}"/> 이미지">
                                </span>
                                <div class="option">
                                    <%-- [운영상태]
                                        OPER_CNCL 폐강 | OPER_END 종료 | OPER_ING 운영중
                                        RCPT_ADD 추가모집 | RCPT_END 접수마감 | RCPT_ING 접수중
                                        RCPT_WAIT 접수예정 | WAIT_ING 대기자접수
                                    --%>
                                    <span class="stateType type1"><c:out value="${operSttusMap[result.operSttus]}"/></span>
                                    <span class="organ"><c:out value="${result.insttNm}"/></span>
                                    <c:choose>
                                        <c:when test="${!empty result.eduAmt and result.eduAmt > 0}">
                                            <span class="pay">유료</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="pay free">무료</span>
                                        </c:otherwise>
                                    </c:choose>
                                    </span>
                                </div>
                                <span class="title"><c:out value="${result.lctreNm}"/></span>
                                <ul class="prgInformation">
                                    <li><span>장소</span>
                                        <c:set var="placeNo" value="place${result.placeNo}"/>
                                        <c:out value="${eduPlaceMap[placeNo]}"/>
                                    </li>
                                    <li><span>대상</span>
                                        <c:set var="isAllTargets" value="${not empty trgetList}"/>
                                        <c:forEach var="cd" items="${trgetList}">
                                            <c:if test="${isAllTargets and !result.trgetList.contains(cd.code)}">
                                                <c:set var="isAllTargets" value="false"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${isAllTargets}">
                                                제한없음
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="targetCd" items="${result.trgetList}" varStatus="status">
                                                    <c:out value="${targetMap[targetCd]}"/>
                                                    <c:if test="${!status.last}">|</c:if>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                    <li><span>접수</span>
                                        <c:if test="${not empty result.rcptBgnDt && fn:length(result.rcptBgnDt) >= 12}">
                                            <c:set var="rcptBgnDe" value="${fn:substring(result.rcptBgnDt, 0, 8)}"/>
                                            <c:set var="rcptBgnHm" value="${fn:substring(result.rcptBgnDt, 8, 12)}"/>
                                            ${fn:substring(rcptBgnDe, 0, 4)}.${fn:substring(rcptBgnDe, 4, 6)}.${fn:substring(rcptBgnDe, 6, 8)}
                                            ${fn:substring(rcptBgnHm, 0, 2)}시
                                        </c:if>
                                        ~
                                        <c:if test="${not empty result.rcptEndDt && fn:length(result.rcptEndDt) >= 12}">
                                            <c:set var="rcptEndDe" value="${fn:substring(result.rcptEndDt, 0, 8)}"/>
                                            <c:set var="rcptEndHm" value="${fn:substring(result.rcptEndDt, 8, 12)}"/>
                                            ${fn:substring(rcptEndDe, 0, 4)}.${fn:substring(rcptEndDe, 4, 6)}.${fn:substring(rcptEndDe, 6, 8)}
                                            ${fn:substring(rcptEndHm, 0, 2)}시
                                        </c:if>
                                    </li>
                                    <li><span>운영</span>
                                        <c:if test="${not empty result.lctBgnDt && fn:length(result.lctBgnDt) >= 8}">
                                            <c:set var="lctBgnDe" value="${fn:substring(result.lctBgnDt, 0, 8)}"/>
                                            ${fn:substring(lctBgnDe, 0, 4)}-${fn:substring(lctBgnDe, 4, 6)}-${fn:substring(lctBgnDe, 6, 8)}
                                        </c:if>
                                        ~
                                        <c:if test="${not empty result.lctEndDt && fn:length(result.lctEndDt) >= 8}">
                                            <c:set var="lctEndDe" value="${fn:substring(result.lctEndDt, 0, 8)}"/>
                                            ${fn:substring(lctEndDe, 0, 4)}-${fn:substring(lctEndDe, 4, 6)}-${fn:substring(lctEndDe, 6, 8)}
                                        </c:if>
                                    </li>
                                </ul>
                            </a>
                        </li>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </ul>
        <div class="p-pagination">
            <div class="p-page">
            <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="/${menuInfo.siteId}/selectEduLctreWebList.do?${fn:escapeXml(eduLctreVO.paramsExclPi)}&amp;pageIndex=" />
            </div>
        </div>
    </div>
    <div class="listWrap detail">
        <div class="dataCount">
            총 : <em><c:out value="${paginationInfo.totalRecordCount}"/> </em>건
            / 페이지 <c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/>
        </div>
        <table>
            <caption>강좌목록-No, 강좌명/교육정보, 접수기간, 대상, 이용요금, 신청/정원(대기), 운영상태</caption>
            <colgroup>
                <col style="width:80px">
                <col>
                <col>
                <col>
                <col>
                <col>
                <col>
            </colgroup>
            <thead>
            <tr>
                <th scope="col" class="first">No</th>
                <th scope="col">강좌명/교육정보</th>
                <th scope="col">접수기간</th>
                <th scope="col">대상</th>
                <th scope="col">이용요금</th>
                <th scope="col">신청/정원(대기)</th>
                <th scope="col" class="last">운영상태</th>
            </tr>
            </thead>
            <tbody class="textAlignCenter">
            <c:choose>
                <c:when test="${empty eduLctreList}">
                    <tr>
                        <td colspan="7">
                            <div class="noData">
                                <div class="noData-innerWrap">
                                    <span class="noDataTitle">검색하신 내용을 찾을 수 없습니다.</span>
                                    <p>조건을 바꾸어 다른 검색어를 입력하시거나<span>철자와 띄어쓰기를 확인해보세요.</span></p>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}"/>
                    <c:forEach var="result" items="${eduLctreList}" varStatus="status">
                        <tr>
                            <td class="first">
                                <span class="mobile-th">No</span>
                                <a href="selectEduLctreWebView.do?key=${key}&lctreNo=${result.lctreNo}" class="trFullLink" title="<c:out value="${result.lctreNm}"/> 상세보기"><span>"<c:out value="${result.lctreNm}"/>" 상세보기</span></a>
                                <c:out value="${currentPageStartNo}"/>
                            </td>
                            <td class="textAlignLeft">
                                <span class="mobile-th">강좌명/교육정보</span>
                                <div class="titleArea">
                                    <span class="tableProgramTitle"><c:out value="${result.lctreNm}"/></span>
                                    <div class="programDetailInformation">
                                            <%-- 교육기간 --%>
                                        <span class="date">
                                <c:if test="${not empty result.lctBgnDt && fn:length(result.lctBgnDt) >= 8}">
                                    <c:set var="lctBgnDe" value="${fn:substring(result.lctBgnDt, 0, 8)}"/>
                                    ${fn:substring(lctBgnDe, 0, 4)}-${fn:substring(lctBgnDe, 4, 6)}-${fn:substring(lctBgnDe, 6, 8)}
                                </c:if>
                                        ~
                                <c:if test="${not empty result.lctEndDt && fn:length(result.lctEndDt) >= 8}">
                                    <c:set var="lctEndDe" value="${fn:substring(result.lctEndDt, 0, 8)}"/>
                                    ${fn:substring(lctEndDe, 0, 4)}-${fn:substring(lctEndDe, 4, 6)}-${fn:substring(lctEndDe, 6, 8)}
                                </c:if>
                            </span>
                                        <span class="day"><c:out value="${result.lctWeekNm}"/></span>
                                        <span class="time">
                                    <c:if test="${not empty result.lctBgnDt && fn:length(result.lctBgnDt) >= 12}">
                                        <c:set var="lctBgnHm" value="${fn:substring(result.lctBgnDt, 8, 12)}"/>
                                        <c:out value="${tsu:toDateFormat(lctBgnHm, 'HHmm', 'HH:mm')}"/>
                                    </c:if>
                                    ~
                                    <c:if test="${not empty result.lctEndDt && fn:length(result.lctEndDt) >= 12}">
                                        <c:set var="lctEndHm" value="${fn:substring(result.lctEndDt, 8, 12)}"/>
                                        <c:out value="${tsu:toDateFormat(lctEndHm, 'HHmm', 'HH:mm')}"/>
                                    </c:if>
                                </span>
                                        <span class="place">
                                <c:set var="placeNo" value="place${result.placeNo}"/>
                                <c:out value="${eduPlaceMap[placeNo]}"/>
                            </span>
                                    </div>
                                </div>
                            </td>
                                <%-- 접수기간 --%>
                            <td>
                                <span class="mobile-th">접수기간</span>
                                <c:if test="${not empty result.rcptBgnDt && fn:length(result.rcptBgnDt) >= 12}">
                                    <c:set var="rcptBgnDe" value="${fn:substring(result.rcptBgnDt, 0, 8)}"/>
                                    <c:set var="rcptBgnHm" value="${fn:substring(result.rcptBgnDt, 8, 12)}"/>
                                    ${fn:substring(rcptBgnDe, 0, 4)}.${fn:substring(rcptBgnDe, 4, 6)}.${fn:substring(rcptBgnDe, 6, 8)}
<%--                                    ${fn:substring(rcptBgnHm, 0, 2)}시--%>
                                </c:if>
                                ~
                                <c:if test="${not empty result.rcptEndDt && fn:length(result.rcptEndDt) >= 12}">
                                    <c:set var="rcptEndDe" value="${fn:substring(result.rcptEndDt, 0, 8)}"/>
                                    <c:set var="rcptEndHm" value="${fn:substring(result.rcptEndDt, 8, 12)}"/>
                                    ${fn:substring(rcptEndDe, 0, 4)}.${fn:substring(rcptEndDe, 4, 6)}.${fn:substring(rcptEndDe, 6, 8)}
<%--                                    ${fn:substring(rcptEndHm, 0, 2)}시--%>
                                </c:if>
                            </td>
                            <td>
                                <span class="mobile-th">대상</span>
                                <c:forEach var="targetCd" items="${result.trgetList}" varStatus="status">
                                    <c:out value="${targetMap[targetCd]}"/>
                                    <c:if test="${!status.last}">|</c:if>
                                </c:forEach>
                            </td>
                            <td><span class="mobile-th">이용요금</span><span class="pay">
                        <c:choose>
                            <c:when test="${!empty result.eduAmt and result.eduAmt > 0}">
                                유료
                            </c:when>
                            <c:otherwise>무료</c:otherwise>
                        </c:choose>
                    </span></td>
                            <td>
                                <span class="mobile-th">신청/정원(대기)</span>
                                <strong>
                                    <c:out value="${result.rsvCmplCnt != null ? result.rsvCmplCnt : 0}"/>
                                </strong>/
                                <c:out value="${result.onlineCnt != null ? result.onlineCnt : 0}"/>
                                <c:if test="${result.waitCnt != null && result.waitCnt > 0}">
                                    <span class="block">
                                        (<c:out value="${result.waitLstCnt != null ? result.waitLstCnt : 0}"/>/
                                        <c:out value="${result.waitCnt}"/>)
                                    </span>
                                </c:if>
                            </td>
                            <td class="last"><span class="mobile-th">운영상태</span><span class="stateType type1"><c:out value="${operSttusMap[result.operSttus]}"/></span></td>
                        </tr>
                        <c:set var="currentPageStartNo" value="${currentPageStartNo-1}"/>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            </tbody>
        </table>
        <div class="p-pagination">
            <div class="p-page">
            <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="/${menuInfo.siteId}/selectEduLctreWebList.do?${fn:escapeXml(eduLctreVO.paramsExclPi)}&amp;pageIndex=" />
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function () {

        function changeEmdList(isInitialLoad) {
            var selectedGu = $("#searchAreaGu").val(); // SDGU / HDGU / CWGU / SWGU / ""
            var selectedEmd = $("#searchAreaEmd").val(); // 현재 선택된 읍/면/동 값
            var $emdSelect = $("#searchAreaEmd");

            // 초기 로딩이 아니고 구가 변경된 경우에만 읍/면/동 선택 초기화
            if (!isInitialLoad) {
            $emdSelect.val("");
            }

            // 전체 읍/면/동 옵션 숨기기
            $emdSelect.find(".areaEmdList").hide();

            // 구가 선택된 경우 해당 구의 읍/면/동만 보여주기
            if (selectedGu) {
                $emdSelect.find("." + selectedGu).show();
                
                // 초기 로딩 시 선택된 읍/면/동이 해당 구에 속하는지 확인
                if (isInitialLoad && selectedEmd) {
                    var $selectedOption = $emdSelect.find("option[value='" + selectedEmd + "']");
                    // 선택된 옵션이 현재 구에 속하지 않으면 초기화
                    if ($selectedOption.length === 0 || !$selectedOption.hasClass(selectedGu)) {
                        $emdSelect.val("");
                    }
                }
            }
            // else: 구 = 전체일 땐 "전체" 옵션만 보이게 두고 나머지는 숨김 상태 유지
        }

        // 구 선택 변경 시 읍/면/동 리스트 갱신
        $("#searchAreaGu").on("change", function () {
            changeEmdList(false);
        });

        // 페이지 로딩 시, 기존 선택 값이 있으면 반영
        changeEmdList(true);
    });

</script>

</body>
</html>
