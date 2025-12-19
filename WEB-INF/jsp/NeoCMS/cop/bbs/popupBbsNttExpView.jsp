<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<script nonce="NEOCMSSCRIPT">
	function fn_bbsSelect( bbsNo, bbsNm ) {
		$("#bbsNo").val(bbsNo);
		$("#bbsNm").val(bbsNm);
		closeSlideView();
	}
</script>
<%--
<div class="arrangementWrap data_info">
	<div class="arrLeft" style="width:0% !important;">
	<span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
		<span class="table_text">Page : <c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/></span>
	</div>
</div>
--%>
<div class="textARight marginBottom_5">
    <div class="table_search">
        <form:form modelAttribute="bbsVO" name="bbsVOForm" method="get" action="/neo/popupBbsNttExpView.do" onsubmit=" return fn_ajax_search_submit(this.id);return false;">
            <span class="srch_element select">
                <select name="siteId" id="siteId" class="select">
                <c:forEach var="siteSeList" items="${siteSeList}" varStatus="status">
                    <optgroup label="<c:out value="${siteSeList.codeNm}"/>">
                    <c:forEach var="siteInfoList" items="${siteInfoList}" varStatus="status">
                        <c:if test="${siteSeList.code eq siteInfoList.siteSe}">
                            <option value="<c:out value="${siteInfoList.siteId}"/>" <c:if test="${bbsVO.siteId eq siteInfoList.siteId}">selected="selected"</c:if>><c:out value="${siteInfoList.siteNm}"/></option>
                        </c:if>
                    </c:forEach>
                    </optgroup>
                </c:forEach>
                </select>
            </span>
            <span class="srch_element select">
                <form:select path="skinId" cssClass="select">
                    <form:option value="">스킨 전체</form:option>
                    <c:forEach var="opt" items="${bbsSkinList}">
                        <option value="<c:out value="${opt.skinId}"/>" <c:out value="${opt.skinId eq bbsVO.skinId ? 'selected=true':''}"/>><c:out value="${opt.skinNm}"/></option>
                    </c:forEach>
                </form:select>
            </span>
            <span class="srch_element select">
                <form:select path="searchCnd" cssClass="select">
                    <form:option value="all">검색단어 전체</form:option>
                    <form:option value="bannerZoneIemNm">게시판명</form:option>
                </form:select>
            </span>
            <span class="srch_element text">
                <form:input path="searchKrwd" cssClass="txt" style="width:auto;"/>
            </span>
            <span class="srch_element submit"><button type="submit" class="search_button">검색</button></span>
            </span>
        </form:form>
    </div>
</div>


<div class="table_fixed_wrap is_bottom_wrap">
	<div id="tableScroll" class="data_table">
		<div class="scroll_view">

			<table>
				<colgroup>
					<col class="specWidth40px"/>
					<col class="specWidth100px"/>
					<col/>
					<col class="specWidth80px"/>
					<col class="specWidth60px"/>
				</colgroup>
				<thead>
				<tr>
					<th>번호</th>
					<th>스킨명</th>
					<th>게시판명</th>
					<th>등록일</th>
					<th>선택</th>
				</tr>
				</thead>
				<tbody>
				<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
				<c:forEach var="result" items="${bbsList}" varStatus="status">
					<tr>
						<td class="textARight"><c:out value="${currentPageStartNo}"/></td>
						<td class="textACenter"><c:out value="${bbsSkinMap[result.skinId]}"/></td>
						<td><c:out value="${result.bbsNm}"/></td>
						<td class="textACenter"><c:out value="${result.frstRegisterPnttmYMD}"/></td>
						<td class="textACenter"><a href="#bbsSelect" onclick="fn_bbsSelect('<c:out value="${result.bbsNo}"/>', '[<c:out value="${bbsSkinMap[result.skinId]}"/>] <c:out value="${result.bbsNm}"/>')" class="iconTextButton small edit"><span>선택</span></a></td>
					</tr>
					<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
				</c:forEach>
				<c:if test="${fn:length(bbsList) == 0}">
					<tr>
						<td colspan="6" class="textACenter">등록된 게시판이 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="textACenter marginTop_20">
    <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="neoTreePop" jsFunction="./popupBbsNttExpView.do?siteId=${tsu:xssLinkFilter(bbsVO.siteId)}&amp;pageUnit=${tsu:xssLinkFilter(bbsVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(bbsVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(bbsVO.searchKrwd)}&amp;pageIndex=" />
</div>
<button type="button" onclick="closeSlideView()" class="layerCloseBtn">닫기</button>