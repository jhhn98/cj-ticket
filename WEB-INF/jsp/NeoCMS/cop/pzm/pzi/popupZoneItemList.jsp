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

	<title>팝업존항목관리 목록</title>
	<meta name="decorator" content="neo" />
</head>
<body>


<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">팝업존항목관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${popupZone.popupZoneNm}"/> 목록</span>
</div>
<div class="contents">
	<script nonce="NEOCMSSCRIPT">
		function fn_deletePopupZoneItem( url ) {
			if( confirm("삭제하시겠습니까?") ) {
				window.location = url;
			}
		}
	</script>
	<div class="arrangementWrap data_button marginBottom_5">
		<div class="arrLeft">
            <div class="table_text">조회된 팝업 항목 수 : <c:out value="${paginationInfo.totalRecordCount}"/>건</div>
        </div>
		<div class="arrRight">
			<div class="table_search">
			<form:form modelAttribute="popupZoneItemVO" name="popupZoneItemVOForm" method="get">
				<form:hidden path="siteId" />
				<form:hidden path="popupZoneNo" />

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
						<form:option value="displayNone">표시중이지않은항목(표시안함,기간)</form:option>
						<form:option value="doNotShow">표시안함</form:option>
						<form:option value="periodDate">기간에 따라표시</form:option>
					</form:select>
				</span>

				<span class="srch_element select">
					<form:select path="searchCnd" class="select">
						<form:option value="all">검색단어 전체</form:option>
						<form:option value="popupZoneIemNm">제목</form:option>
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
						<col />
						<col/>
						<col class="specWidth140px"/>
						<col class="specWidth100px"/>
						<col class="specWidth100px"/>
						<col class="specWidth100px"/>
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
					<c:forEach var="result" items="${popupZoneItemList}" varStatus="status">
						<tr data-display="true">
							<td class="textARight"><c:out value="${currentPageStartNo}"/></td>
							<td><img src="/DATA/popup/<c:out value="${result.imageFileNm}"/>" width="<c:out value="${popupZone.imageWidthSize}"/>" height="<c:out value="${popupZone.imageHeightSize}"/>"/></td>
							<td class="textALeft">
                                <div>
								    <a href="./selectPopupZoneItemView.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;popupZoneIemNo=<c:out value="${result.popupZoneIemNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" class="iconTextLink info"><c:out value="${result.popupZoneIemNm}"/></a>
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
									<br/>
								</c:if>
							</td>
							<td><c:out value="${result.frstRegisterPnttmYMD}"/></td>
							<td><a href="./updatePopupZoneItemView.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;popupZoneIemNo=<c:out value="${result.popupZoneIemNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
							<td><a href="./deletePopupZoneItem.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;popupZoneIemNo=<c:out value="${result.popupZoneIemNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" onclick="fn_deletePopupZoneItem(this.href); return false;" class="iconTextButton delete small"><span>삭제</span></a></td>
						</tr>
						<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
					</c:forEach>
					<c:if test="${fn:length(popupZoneItemList) == 0}">
						<tr>
							<td colspan="7">등록된 팝업 항목이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectPopupZoneItemList.do?siteId=${tsu:xssLinkFilter(popupZoneItemVO.siteId)}&amp;popupZoneNo=${tsu:xssLinkFilter(popupZoneItemVO.popupZoneNo)}&amp;pageUnit=${tsu:xssLinkFilter(popupZoneItemVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(popupZoneItemVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(popupZoneItemVO.searchKrwd)}&amp;searchShowSe=${tsu:xssLinkFilter(popupZoneItemVO.searchShowSe)}&amp;pageIndex=" />
		</div>
		<div class="arrRight">
            <a href="./selectPopupZoneList.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>" class="iconTextButton list"><span>팝업존 목록</span></a>
            <a href="./sortPopupZoneItemView.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>" class="iconTextButton sort marginLeft_5"><span>순서변경</span></a>
			<a href="./addPopupZoneItemView.do?siteId=<c:out value="${popupZoneItemVO.siteId}"/>&amp;popupZoneNo=<c:out value="${popupZoneItemVO.popupZoneNo}"/>&amp;pageUnit=<c:out value="${popupZoneItemVO.pageUnit}"/>&amp;searchCnd=<c:out value="${popupZoneItemVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${popupZoneItemVO.searchKrwd}"/>&amp;searchShowSe=<c:out value="${popupZoneItemVO.searchShowSe}"/>&amp;pageIndex=<c:out value="${popupZoneItemVO.pageIndex}"/>" class="iconTextButton write marginLeft_5"><span>등록</span></a>
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
