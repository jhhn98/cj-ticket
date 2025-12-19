<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>신청자 출석/이수 관리 목록</title>
    <link rel="stylesheet" type="text/css" href="/common/js/jquery-ui-1.12.1/jquery-ui.css"/>
    <script type="text/javascript" src="/common/js/jquery-ui-1.12.1/jquery-ui.min.js" nonce="NEOCMSSCRIPT"></script>
</head>

<body>
<div class="p-wrap">
    <div class="row p-relative">
        <div class="col-6 margin_t_5">
            <a href="?key=${key}" title="목록 초기화">
                <span>총 <strong><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###"/></strong> 건</span>
                <span class="division_line">[ <strong><c:out value="${paginationInfo.currentPageNo}"/></strong> / <c:out value="${paginationInfo.totalPageCount}"/> 페이지 ]</span>
            </a>
        </div>
        <div class="col-18 right">
            <form id="schLctreFrm" method="get" action="/${menuInfo.siteId}/selectEduAtendLctreList.do">
                <fieldset>
                    <legend>강좌 검색</legend>
                    <input type="hidden" name="key" value="${key}"/>
                    <select name="searchInsttNo" onchange="insttIdChange(this.value)" class="p-input p-input--auto">
                        <option value="">기관선택</option>
                        <c:forEach var="instt" items="${eduInsttList}">
                            <option value="${instt.insttNo}"${instt.insttNo eq eduLctreVO.searchInsttNo ? ' selected="true"':''}><c:out value="${instt.insttNm}"/></option>
                        </c:forEach>
                    </select>
                    <select id="searchCtgryNo" name="searchCtgryNo" class="p-input p-input--auto">
                        <option value="">카테고리선택</option>
                    </select>
                    <select name="searchOperSttus" class="p-input p-input--auto">
                        <option value="">운영상태</option>
                        <c:forEach var="code" items="${operSttusList}">
                            <option value="${code.code}"${eduLctreVO.searchOperSttus eq code.code ? ' selected="true"':''}>
                                <c:out value="${code.codeNm}"/>
                            </option>
                        </c:forEach>
                    </select>
                    <input name="searchLctreNm" value="${eduLctreVO.searchLctreNm}" title="강좌명 입력" placeholder="강좌명 입력" class="p-input p-input--auto"/>
                    <button type="submit" class="p-button p-button--small primary">검색</button>
                </fieldset>
            </form>
        </div>
    </div>

    <table class="p-table p-table--bordered">
        <caption><c:out value="${menuInfo.cntntsNm}"/> 목록 - 번호, 기관명, 카테고리, 강좌명, 교육기간, 신청/정원(대기자), 선발방식, 운영상태, 관리</caption>
        <colgroup>
            <col class="w60"/>
            <col class="w120"/>
            <col class="w120"/>
            <col />
            <col class="w180"/>
            <col class="w150"/>
            <col class="w80"/>
            <col class="w80"/>
            <col class="w80"/>
        </colgroup>
        <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">기관명</th>
            <th scope="col">카테고리</th>
            <th scope="col">강좌명</th>
            <th scope="col">교육기간</th>
            <th scope="col">신청/정원<br/>(대기자)</th>
            <th scope="col">선발방식</th>
            <th scope="col">운영상태</th>
            <th scope="col">관리</th>
        </tr>
        </thead>
        <tbody class="text_center">
        <c:set var="pageNo" value="${paginationInfo.currentPageStartNo}" />
        <c:forEach var="result" items="${eduLctreList}" varStatus="status">
            <tr class="colored">
                <td><c:out value="${pageNo}"/></td>
                <td><c:out value="${result.insttNm}"/></td>
                <td><c:out value="${result.ctgryNm}"/></td>
                <td class="text_left p-subject"><c:out value="${result.lctreNm}"/></td>
                <td>
                    <c:if test="${not empty result.lctBgnDt && fn:length(result.lctBgnDt) >= 8}">
                        ${fn:substring(result.lctBgnDt, 0, 4)}.${fn:substring(result.lctBgnDt, 4, 6)}.${fn:substring(result.lctBgnDt, 6, 8)}
                    </c:if>
                    ~
                    <c:if test="${not empty result.lctEndDt && fn:length(result.lctEndDt) >= 8}">
                        ${fn:substring(result.lctEndDt, 0, 4)}.${fn:substring(result.lctEndDt, 4, 6)}.${fn:substring(result.lctEndDt, 6, 8)}
                    </c:if>
                </td>
                <td>
                    <c:out value="${result.rsvCmplCnt}"/> / <c:out value="${result.onlineCnt}"/><br/>
                <c:if test="${slctMthdMap[result.slctMthdCd] eq '선착순'}">
                    (<c:out value="${result.waitLstCnt}"/> / <c:out value="${result.waitCnt}"/>)
                </c:if>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty slctMthdMap[result.slctMthdCd]}">
                            <c:out value="${slctMthdMap[result.slctMthdCd]}"/>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty operSttusMap[result.operSttus]}">
                            <c:out value="${operSttusMap[result.operSttus]}"/>
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="./selectAtendList.do?lctreNo=${result.lctreNo}&amp;key=${key}" class="p-button p-button--xsmall edit">출석관리</a>
                </td>
            </tr>
            <c:set var="pageNo" value="${pageNo-1}" />
        </c:forEach>
        <c:if test="${fn:length(eduLctreList) == 0}">
            <tr>
                <td colspan="9" class="empty">등록된 정보가 없습니다</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="row margin_t_10">
        <div class="col-24 center">
            <ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="/${menuInfo.siteId}/selectEduAtendLctreList.do?${fn:escapeXml(eduLctreVO.paramsExclPi)}&amp;pageIndex=" />
        </div>
    </div>

</div>

<script nonce="NEOCMSSCRIPT">
    // 기관명선택 이벤트
    function insttIdChange(val) {
        var isVal = false;
        $('#searchCtgryNo').empty();
        $('#searchCtgryNo').append('<option value="">카테고리선택</option>');

        <c:forEach var="result" items="${eduCategoryList}">
        if(val == "${result.insttNo}" ){
            var option = $("<option value=\"${result.ctgryNo}\"${result.ctgryNo eq eduLctreVO.searchCtgryNo ? ' selected':''}>${result.ctgryNm}</option>");
            $('#searchCtgryNo').append(option);
            isVal = true;
        }
        </c:forEach>

        if(!isVal){
            $('#searchCtgryNo').empty();
            $('#searchCtgryNo').append('<option value="">카테고리 없음</option>');
            $('#searchCtgryNo').attr("disabled", true);
        } else {
            $('#searchCtgryNo').attr("disabled", false);
        }
    }

    $(document).ready(function() {
        //분류 트리거
        <c:if test="${!empty eduLctreVO.searchInsttNo}">insttIdChange('<c:out value="${eduLctreVO.searchInsttNo}"/>');</c:if>
    });
</script>
</body>
</html>