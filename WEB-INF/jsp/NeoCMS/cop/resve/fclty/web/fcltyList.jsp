<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html>
<html>
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
    <title>${menuInfo.cntntsNm} 목록</title>
</head>
<body>

<div class="programSearch">
    <form method="post" name="fcltySearchVO" action="./selectFcltyWebList.do">
        <input type="hidden" name="key" value="<c:out value="${key}"/>" />
        <input type="hidden" name="pageUnit" value="<c:out value="${fcltySearchVO.pageUnit}"/>" />
        <fieldset>
            <legend>검색</legend>
            <div class="searchFormWrap default">
                <div class="defaultFormWrap">
                    <div class="formElement">
                        <label for="searchOperSttus">운영상태</label>
                        <div class="customSelect">
                            <select name="searchOperSttus" id="searchOperSttus">
                                <option value="">전체</option>
                                <c:forEach var="result" items="${operSttusList}">
                                    <option value="<c:out value="${result.code}"/>"<c:if test="${fcltySearchVO.searchOperSttus == result.code}"> selected</c:if>><c:out value="${result.codeNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="formElement widthWide">
                        <label for="searchKrwd">시설명</label>
                        <input type="text" name="searchKrwd" id="searchKrwd" placeholder="시설명을 입력해주세요" class="customInputDefault">
                    </div>
                </div>
                <div class="formElement w100per marginTop12">
                    <span class="formElement-label">서비스유형</span>
                    <div class="formElement-selectGroup facilityOptions">
                        <label for="searchSvcTyCd0" class="customIconOption">
                            <input type="radio" name="searchSvcTyCd" id="searchSvcTyCd0" value=""/>
                            <span class="optionWrap">
                                <i class="optionIcon icon1-1 searchSvcTyCd0"></i>
                                <em>전체</em>
                            </span>
                        </label>
                        <c:forEach var="result" items="${svcTyList}" varStatus="status">
                            <label for="searchSvcTyCd<c:out value="${status.count}"/>" class="customIconOption">
                                <input type="radio" name="searchSvcTyCd" id="searchSvcTyCd<c:out value="${status.count}"/>" value="<c:out value="${result.code}"/>"<c:if test="${fcltySearchVO.searchSvcTyCd == result.code}"> checked</c:if>/>
                                <span class="optionWrap">
                                    <i class="optionIcon <c:out value="${result.code}"/>"></i>
                                    <em><c:out value="${result.codeNm}"/></em>
                                </span>
                            </label>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="searchFormWrap detail">
                <div class="selectElementGroup facilityGroup">
                    <div class="formElement">
                        <label for="searchInsttNo0">운영기관</label>
                        <div class="customSelect">
                            <select name="searchInsttNo" id="searchInsttNo0" class="customSelect">
                                <option value="0">전체</option>
                                <c:forEach var="result" items="${fctInsttList}">
                                    <option value="<c:out value="${result.insttNo}"/>"<c:if test="${fcltySearchVO.searchInsttNo == result.insttNo}"> selected</c:if>><c:out value="${result.insttNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="formElement elementCount2">
                        <span class="formElement-label">지역</span>
                        <div class="customSelect">
                            <select name="searchAreaGu" id="searchAreaGu" title="지역 구 선택" class="customSelect">
                                <option value="">전체</option>
                                <c:forEach var="result" items="${areaGuList}">
                                    <option value="<c:out value="${result.code}"/>"<c:if test="${fcltySearchVO.searchAreaGu == result.code}"> selected</c:if>><c:out value="${result.codeNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="customSelect">
                            <select name="searchAreaEmd" id="searchAreaEmd" title="지역 읍/면/동 선택" class="customSelect">
                                <option value="">전체</option>
                                <c:forEach var="result" items="${sdguList}">
                                    <option value="<c:out value="${result.code}"/>" class="areaEmdList SDGU"<c:if test="${fcltySearchVO.searchAreaEmd == result.code}"> selected</c:if> style="display:none;"><c:out value="${result.codeNm}"/></option>
                                </c:forEach>
                                <c:forEach var="result" items="${hdguList}">
                                    <option value="<c:out value="${result.code}"/>" class="areaEmdList HDGU"<c:if test="${fcltySearchVO.searchAreaEmd == result.code}"> selected</c:if> style="display:none;"><c:out value="${result.codeNm}"/></option>
                                </c:forEach>
                                <c:forEach var="result" items="${cwguList}">
                                    <option value="<c:out value="${result.code}"/>" class="areaEmdList CWGU"<c:if test="${fcltySearchVO.searchAreaEmd == result.code}"> selected</c:if> style="display:none;"><c:out value="${result.codeNm}"/></option>
                                </c:forEach>
                                <c:forEach var="result" items="${swguList}">
                                    <option value="<c:out value="${result.code}"/>" class="areaEmdList SWGU"<c:if test="${fcltySearchVO.searchAreaEmd == result.code}"> selected</c:if> style="display:none;"><c:out value="${result.codeNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="formElement">
                        <label for="searchFcltyAmt">이용요금</label>
                        <div class="customSelect">
                            <select name="searchFcltyAmt" id="searchFcltyAmt" class="customSelect">
                                <option value="">전체</option>
                                <option value="Y"<c:if test="${fcltySearchVO.searchFcltyAmt == 'Y'}"> selected</c:if>>유료</option>
                                <option value="N"<c:if test="${fcltySearchVO.searchFcltyAmt == 'N'}"> selected</c:if>>무료</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="formElement w100per marginTop12">
                    <span class="formElement-label">생애주기</span>
                    <div class="formElement-selectGroup">
                        <c:set var="searchTargetCdStr" value="${fn:join(fcltySearchVO.searchTargetCd, '|')}"/>
                        <c:forEach var="result" items="${targetList}" varStatus="status">
                            <label for="searchTargetCd<c:out value="${status.count}"/>" class="customIconOption">
                                <input type="checkbox" name="searchTargetCd" id="searchTargetCd<c:out value="${status.count}"/>" value="<c:out value="${result.code}"/>"<c:if test="${fn:indexOf(searchTargetCdStr, result.code) > -1}"> checked</c:if>/>
                                <span class="optionWrap">
                                    <i class="optionIcon <c:out value="${result.code}"/>"></i>
                                    <em><c:out value="${result.codeNm}"/></em>
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
        <div class="dataCount">총 : <em><c:out value="${paginationInfo.totalRecordCount}"/></em>건 / 페이지 <c:out value="${paginationInfo.currentPageNo}"/>/<c:out value="${paginationInfo.totalPageCount}"/></div>
        <ul>
            <!-- 검색결과, 데이터 없을때 -->
            <c:if test="${fn:length(fcltyList) == 0}">
                <li class="noDataList">
                    <div class="noData">
                        <div class="noData-innerWrap">
                            <span class="noDataTitle">검색하신 내용을 찾을 수 없습니다.</span>
                            <p>조건을 바꾸어 다른 검색어를 입력하시거나<span>철자와 띄어쓰기를 확인해보세요.</span></p>
                        </div>
                    </div>
                </li>
            </c:if>
            <!-- //검색결과, 데이터 있을때 -->
            <c:forEach var="result" items="${fcltyList}" begin="0" end="7">
                <li>
                    <a href="./selectFcltyWebView.do?fcltyNo=<c:out value="${result.fcltyNo}"/>&<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsWeb}"/>">
                        <span class="image<c:out value="${not empty result.mainImg ? '' : ' noImage'}"/>">
                            <c:choose>
                                <c:when test="${empty result.mainImg}">
                                    <img src="/site/www/images/program/no-image.png" alt="<c:out value="${result.fcltyNm}"/> 이미지 없음">
                                </c:when>
                                <c:otherwise>
                                    <img src="/<c:out value="${result.mainImg.storePath}"/>/thumb/p_<c:out value="${result.mainImg.storeFileNm}"/>" alt="<c:out value="${result.fcltyNm}"/> 이미지">
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <div class="option">
                            <span class="stateType type1"><c:out value="${operSttusMap[result.operSttus]}"/></span>
                            <span class="organ">
                                <c:set var="insttNo" value="instt${result.insttNo}"/>
                                <c:out value="${fctInsttMap[insttNo]}"/>
                            </span>
                            <c:choose>
                                <c:when test="${result.fcltyAmt > 0}">
                                    <span class="pay">유료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="pay free">무료</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <span class="title"><c:out value="${result.fcltyNm}"/></span>
                        <ul class="prgInformation">
                            <c:set var="placeNo" value="place${result.placeNo}"/>
                            <li><span>장소</span><c:out value="${fctPlaceMap[placeNo]}"/></li>
                            <li>
                                <span>대상</span>
                                <c:forEach var="targetCd" items="${result.targetCdArr}" varStatus="status">
                                    <c:out value="${targetMap[targetCd]}"/>
                                    <c:if test="${!status.last}">|</c:if>
                                </c:forEach>
                            </li>
                            <li><span>접수</span><c:out value="${result.rcptBgnDe}"/> ~ <c:out value="${result.rcptEndDe}"/></li>
                            <li>
                                <span>운영</span>
                                <c:out value="${tsu:toDateFormat(result.fcltyMinBgnDe, 'yyyyMMdd', 'yyy-MM-dd')}"/> ~
                                <c:out value="${tsu:toDateFormat(result.fcltyMaxEndDe, 'yyyyMMdd', 'yyy-MM-dd')}"/>
                            </li>
                        </ul>
                    </a>
                </li>
            </c:forEach>
        </ul>

        <c:if test="${fn:length(fcltyList) > 0}">
            <div class="p-pagination">
                <div class="p-page">
                <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectFcltyWebList.do?${fcltySearchVO.paramsExclPi}${fcltySearchVO.paramsWeb}&amp;pageIndex=" />
                </div>
            </div>
        </c:if>
    </div>
    <div class="listWrap detail">
        <div class="dataCount">총 : <em><c:out value="${paginationInfo.totalRecordCount}"/></em>건 / 페이지 <c:out value="${paginationInfo.currentPageNo}"/>/<c:out value="${paginationInfo.totalPageCount}"/></div>
        <table>
            <caption>시설목록-No, 시설명, 운영기간, 접수기간, 대상, 이용요금, 운영상태</caption>
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
                <th scope="col">시설명</th>
                <th scope="col">접수기간</th>
                <th scope="col">대상</th>
                <th scope="col">이용요금</th>
                <th scope="col">접수방식</th>
                <th scope="col" class="last">운영상태</th>
            </tr>
            </thead>
            <tbody class="textAlignCenter">
            <!-- 게시물 없을때 -->
            <c:if test="${fn:length(fcltyList) == 0}">
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
            </c:if>
            <!-- //게시물 있을때 -->
            <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
            <c:forEach var="result" items="${fcltyList}">
                <tr>
                    <td class="first">
                        <span class="mobile-th">No</span>
                        <a href="./selectFcltyWebView.do?fcltyNo=<c:out value="${result.fcltyNo}"/>&<c:out value="${fcltySearchVO.params}"/><c:out value="${fcltySearchVO.paramsWeb}"/>" class="trFullLink" title="<c:out value="${result.fcltyNm}"/> 상세보기"><span>"<c:out value="${result.fcltyNm}"/>" 상세보기</span></a>
                        <c:out value="${currentPageStartNo}"/>
                    </td>
                    <td class="textAlignLeft">
                        <div class="titleArea">
                            <span class="mobile-th">시설명</span>
                            <span class="tableProgramTitle"><c:out value="${result.fcltyNm}"/></span>
                            <div class="programDetailInformation">
                                <span class="date">
                                    <c:out value="${tsu:toDateFormat(result.fcltyMinBgnDe, 'yyyyMMdd', 'yyy-MM-dd')}"/> ~
                                    <c:out value="${tsu:toDateFormat(result.fcltyMaxEndDe, 'yyyyMMdd', 'yyy-MM-dd')}"/>
                                </span>
                                <span class="organ"><c:out value="${fctInsttMap[insttNo]}"/></span>
                                <span class="place">
                                    <c:set var="placeNo" value="place${result.placeNo}"/>
                                    <c:out value="${fctPlaceMap[placeNo]}"/>
                                </span>
                            </div>
                        </div>
                    </td>
                    <td class="mobile-date">
                        <span class="mobile-th">접수기간</span>
                        <span class="mobile-td"><c:out value="${result.rcptBgnDe}"/> ~ <c:out value="${result.rcptEndDe}"/></span></td>
                    <td><span class="mobile-th">대상</span>
                        <c:forEach var="targetCd" items="${result.targetCdArr}" varStatus="status">
                            <c:out value="${targetMap[targetCd]}"/>
                            <c:if test="${!status.last}">|</c:if>
                        </c:forEach>
                    </td>
                    <td><span class="mobile-th">이용요금</span>
                        <c:choose>
                            <c:when test="${result.fcltyAmt > 0}">
                                <span class="pay">유료</span>
                            </c:when>
                            <c:otherwise>
                                <span class="pay free">무료</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><span class="mobile-th">접수방식</span>
                        <c:out value="${slctMthdMap[result.slctMthdCd]}"/>
                    </td>
                    <c:set var="operSttus" value="${result.operSttus}"/>
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
                    <td class="last"><span class="mobile-th">운영상태</span><span class="stateType <c:out value="${sttusType}"/>"><c:out value="${operSttusMap[result.operSttus]}"/></span></td>
                </tr>
                <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
            </c:forEach>
            </tbody>
        </table>
        <c:if test="${fn:length(fcltyList) > 0}">
            <div class="p-pagination">
                <div class="p-page">
                    <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectFcltyWebList.do?${fcltySearchVO.paramsExclPi}${fcltySearchVO.paramsWeb}&amp;pageIndex=" />
                </div>
            </div>
        </c:if>
    </div>
</div>

<script>

    $(document).ready(function () {
        var areaGu = $('select[name=searchAreaGu]').val();
        if (areaGu != '') {
            $('#searchAreaEmd option.' + areaGu).show();
        }

        $('select[name=searchAreaGu]').on("change",function(){
            $('#searchAreaEmd').val('');
            $('#searchAreaEmd option.areaEmdList').hide();
            $('#searchAreaEmd option.' + $(this).val()).show();
        });

    });

</script>

</body>
</html>