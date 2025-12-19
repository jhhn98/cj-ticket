<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>게시판 관리 목록</title>
	<meta name="decorator" content="neo" />
	<script nonce="NEOCMSSCRIPT">
		function fn_changeSite( val ) {
			window.location = "./selectBbsList.do?siteId=" + val;
		}

        function fn_deleteBbs( url ) {
            if( confirm("삭제하시겠습니까?") ) {
                window.location = url;
            }
        }
	</script>
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_board">게시판관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">게시판 설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${selectedSite.siteNm}"/>(<span class="em_red"><c:out value="${selectedSite.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">목록</span>
</div>
<div class="contents">
    <div class="arrangementWrap data_info">
        <div class="arrLeft">
            <span class="table_text eng_text">등록된 게시판 수 : <c:out value="${paginationInfo.totalRecordCount}"/>건</span>
        </div>
        <div class="arrRight">
            <div class="table_search">
                <form:form modelAttribute="bbsVO" name="bbsVOForm" method="get">
                    <form:hidden path="siteId"/>
                    <span class="srch_element select">
                        <form:select path="pageUnit">
                            <form:option value="10">10 페이지</form:option>
                            <form:option value="20">20 페이지</form:option>
                            <form:option value="30">30 페이지</form:option>
                            <form:option value="40">40 페이지</form:option>
                            <form:option value="50">50 페이지</form:option>
                        </form:select>
                    </span>
                    <span class="srch_element select">
                        <form:select path="searchCnd">
                            <form:option value="all">검색단어 전체</form:option>
                            <form:option value="bannerZoneIemNm">게시판명</form:option>
                        </form:select>
                    </span>
                    <span class="srch_element text">
                        <form:input path="searchKrwd" cssClass="txt" placeholder="검색어 입력"/>
                    </span>
                    <span class="srch_element submit">
                        <button type="submit" class="search_button">검색</button>
                    </span>
                </form:form>
            </div>
        </div>
    </div>
    <div class="table_fixed_wrap is_topBottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth40px"/>
                        <col class="specWidth100px"/>
                        <col class="specWidth100px"/>
                        <col/>
                        <col class="specWidth400px"/>
                        <col class="specWidth80px"/>
                        <col class="specWidth60px"/>
                        <col class="specWidth60px"/>
                        <col class="specWidth60px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">사이트명</th>
                        <th scope="col">스킨명</th>
                        <th scope="col">게시판명</th>
                        <th scope="col">연결메뉴</th>
                        <th scope="col">등록일</th>
                        <th scope="col">배치</th>
                        <th scope="col">수정</th>
                        <th scope="col">복사</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
                    <c:forEach var="result" items="${bbsList}" varStatus="status">
                        <tr data-display="true">
                            <td class="textARight"><c:out value="${currentPageStartNo}"/></td>
                            <td class="textACenter"><c:out value="${siteInfoMap[result.siteId]}"/></td>
                            <td class="textACenter"><c:out value="${bbsSkinMap[result.skinId]}"/></td>
                            <td><a href="./updateBbsInfoView.do?siteId=<c:out value="${result.siteId}"/>&amp;bbsNo=<c:out value="${result.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsVO.pageIndex}"/>" class="iconTextLink set"><c:out value="${result.bbsNm}"/></a></td>
                            <td class="textALeft">
                                <c:forEach var="navi" items="${result.menuList}" varStatus="status">
                                    <c:if test="${status.index ne 0}"><br /></c:if><a href="<c:out value="${navi.menuUrl}"/>" target="_blank" class="iconTextLink site"><span><c:out value="${navi.menuNm}"/></span></a>
                                </c:forEach>
                            </td>
                            <td class="textACenter"><c:out value="${result.frstRegisterPnttmYMD}"/></td>
                            <td class="textACenter"><a href="./batchBbs.do?siteId=<c:out value="${result.siteId}"/>&amp;bbsNo=<c:out value="${result.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsVO.pageIndex}"/>" class="iconTextButton batch small"><span>배치</span></a></td>
                            <td class="textACenter"><a href="./updateBbsView.do?siteId=<c:out value="${result.siteId}"/>&amp;bbsNo=<c:out value="${result.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsVO.pageIndex}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
                            <td class="textACenter"><a href="./copyBbsView.do?siteId=<c:out value="${result.siteId}"/>&amp;bbsNo=<c:out value="${result.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsVO.pageIndex}"/>" class="iconTextButton copy small"><span>복사</span></a></td>
                        </tr>
                        <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
                    </c:forEach>
                    <c:if test="${fn:length(bbsList) == 0}">
                        <tr>
                            <td colspan="100%" class="textACenter">등록된 게시판이 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="arrangementWrap data_button">
        <div class="arrLeft">
            <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectBbsList.do?siteId=${tsu:xssLinkFilter(bbsVO.siteId)}&amp;pageUnit=${tsu:xssLinkFilter(bbsVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(bbsVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(bbsVO.searchKrwd)}&amp;pageIndex=" />
        </div>
        <div class="arrRight">
            <a href="./addBbsView.do?siteId=<c:out value="${bbsVO.siteId}"/>" class="iconTextButton write"><span>등록</span></a>
        </div>
    </div>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>
</body>
</html>
