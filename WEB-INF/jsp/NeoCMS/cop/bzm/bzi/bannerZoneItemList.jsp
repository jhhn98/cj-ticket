<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>배너존항목관리 목록</title>
<meta name="decorator" content="neo" />
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">배너존항목관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red eng_text"><c:out value="${siteInfo.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bannerZone.bannerZoneNm}"/> 목록</span>
</div>
<div class="contents">
	<script nonce="NEOCMSSCRIPT">
		function fn_deleteBannerZoneItem( url ) {
			if( confirm("삭제하시겠습니까?") ) {
				window.location = url;
			}
		}
	</script>
	<div class="arrangementWrap data_button marginBottom_5">
		<div class="arrLeft">
            <div class="table_text">조회된 배너 항목 수 : <c:out value="${paginationInfo.totalRecordCount}"/>건</div>
        </div>
		<div class="arrRight">
			<div class="table_search">
				<form:form modelAttribute="bannerZoneItemVO" name="bannerZoneItemVOForm" method="get">
					<form:hidden path="siteId" />
					<form:hidden path="bannerZoneNo" />
					<span class="srch_element select">
                        <form:select path="pageUnit" class="select">
                            <form:option value="10">10 페이지</form:option>
                            <form:option value="20">20 페이지</form:option>
                            <form:option value="30">30 페이지</form:option>
                            <form:option value="40">40 페이지</form:option>
                            <form:option value="50">50 페이지</form:option>
                        </form:select>
                    </span>
					<span class="srch_element select">
                        <form:select path="searchShowSe" class="select">
                            <form:option value="">표시구분 전체</form:option>
                            <form:option value="always">표시중인항목(항상표시, 기간)</form:option>
                            <form:option value="doNotShow">표시안함</form:option>
                            <form:option value="periodDate">기간에 따라표시</form:option>
                        </form:select>
                    </span>
					<span class="srch_element select">
                        <form:select path="searchCnd" class="select">
                            <form:option value="all">검색단어 전체</form:option>
                            <form:option value="bannerZoneIemNm">제목</form:option>
                            <form:option value="imageReplcText">대체텍스트</form:option>
                        </form:select>
                    </span>
					<span class="srch_element text">
                        <form:input path="searchKrwd" cssClass="txt" style="width:auto;"/>
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
						<col class="specWidth60px"/>
						<col width="<c:out value="${bannerZone.imageWidthSize+20}"/>"/>
						<col/>
						<col class="specWidth100px"/>
						<col class="specWidth80px"/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">이미지</th>
						<th scope="col">제목</th>
						<th scope="col">표시구분</th>
						<th scope="col">등록일</th>
						<th scope="col">수정</th>
						<th scope="col">삭제</th>
					</tr>
					</thead>
					<tbody class="textACenter">
					<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
					<c:forEach var="result" items="${bannerZoneItemList}" varStatus="status">
						<tr data-display="true">
							<td><c:out value="${currentPageStartNo}"/></td>
							<td><img src="/DATA/banner/<c:out value="${result.imageFileNm}"/>" width="<c:out value="${bannerZone.imageWidthSize}"/>" height="<c:out value="${bannerZone.imageHeightSize}"/>"/></td>
							<td class="textALeft">
                                <div>
                                    <a href="./selectBannerZoneItemView.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;bannerZoneIemNo=<c:out value="${result.bannerZoneIemNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="iconTextLink info"><c:out value="${result.bannerZoneIemNm}"/></a>
                                </div>
								<c:if test="${result.linkUrl ne '' and result.linkUrl ne null}">
                                <div>
									<a href="<c:out value="${result.linkUrl}"/>" target="_blank" class="iconTextLink site"><c:out value="${result.linkUrl}"/></a>
                                </div>
								</c:if>
							</td>
							<td>
								<c:out value="${showSeMap[result.showSe]}"/>
								<c:if test="${'periodDate' eq result.showSe}">
								</c:if>
							</td>
							<td><c:out value="${result.frstRegisterPnttmYMD}"/></td>
							<td><a href="./updateBannerZoneItemView.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;bannerZoneIemNo=<c:out value="${result.bannerZoneIemNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
							<td><a href="./deleteBannerZoneItem.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;bannerZoneIemNo=<c:out value="${result.bannerZoneIemNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" onclick="fn_deleteBannerZoneItem(this.href); return false;" class="iconTextButton delete small"><span>삭제</span></a></td>
						</tr>
						<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
					</c:forEach>
					<c:if test="${fn:length(bannerZoneItemList) == 0}">
						<tr>
							<td colspan="7" class="textACenter">등록된 배너 항목이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectBannerZoneItemList.do?siteId=${tsu:xssLinkFilter(bannerZoneItemVO.siteId)}&amp;bannerZoneNo=${tsu:xssLinkFilter(bannerZoneItemVO.bannerZoneNo)}&amp;pageUnit=${tsu:xssLinkFilter(bannerZoneItemVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(bannerZoneItemVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(bannerZoneItemVO.searchKrwd)}&amp;searchShowSe=${tsu:xssLinkFilter(bannerZoneItemVO.searchShowSe)}&amp;pageIndex=" />
		</div>
		<div class="arrRight">
            <a href="./selectBannerZoneList.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>" class="iconTextButton list"><span>배너존 목록</span></a>
            <a href="./sortBannerZoneItemView.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>" class="iconTextButton sort marginLeft_5"><span>순서변경</span></a>
			<a href="./addBannerZoneItemView.do?siteId=<c:out value="${bannerZoneItemVO.siteId}"/>&amp;bannerZoneNo=<c:out value="${bannerZoneItemVO.bannerZoneNo}"/>&amp;pageUnit=<c:out value="${bannerZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bannerZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bannerZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${bannerZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${bannerZoneItemVO.pageIndex}"/>" class="iconTextButton write marginLeft_5"><span>등록</span></a>
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
