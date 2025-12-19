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
<meta name="decorator" content="${menuInfo.siteId}" />
<title>${menuInfo.cntntsNm} 목록</title>
<!--
<style>
#iframe_wrap { position: absolute; top: 100px; left: 200px; width: 100%; height: 800px; }
#iframe_wrap iframe { width:100%; height:100%; }
#iframe_wrap .bbs_info { padding:0 30px; }
</style>
-->
</head>
<body>

<div class="p-wrap" id="board_wrap">
	
	<div class="row p-relative">
		<div class="col-10 margin_t_5">
			<span class="p-total__number">총 게시판 <em class="em_black" data-mask="#,##0" data-mask-reverse="true">${paginationInfo.totalRecordCount}</em>개
		  &nbsp;[ <em class="em_b_black">${paginationInfo.currentPageNo}</em> / ${paginationInfo.totalPageCount}페이지 ]</span>
		</div>
		<div class="col-14 right">
			<form:form modelAttribute="bbsMngSearchVO" name="bbsMngSearchForm" method="post">
			<fieldset>
			<legend>게시판 검색</legend>
			<input type="hidden" name="key" value="${param.key}"/>
			<form:select path="searchSiteId" class="p-input p-input--auto" title="검색영역선택">
				<form:option value="">사이트 전체</form:option>
				<c:forEach var="bbsMngSite" items="${bbsMngSiteList}">
					<form:option value="${bbsMngSite.siteId}">${bbsMngSite.siteNm}(${bbsMngSite.cnt})</form:option>
				</c:forEach>
			</form:select>
			<form:select path="searchCnd" class="p-input p-input--auto" title="검색영역선택">
				<form:option value="all">검색 항목 전체</form:option>
				<form:option value="bbsNm">게시판명</form:option>
				<form:option value="menuNm">메뉴명</form:option>
			</form:select>
			<form:input path="searchKrwd" class="p-input  p-input--auto" title="검색어 입력" placeholder="검색어 입력"/>
			<input value="검색" type="submit" class="p-button p-button--small primary" />
			</fieldset>
			</form:form>
		</div>
	</div>
	
	<table class="p-table p-table--bordered">
		<caption>게시판 목록 - 번호, 메뉴, 등록 수, 관등 버튼 등 제공</caption>
		<colgroup>
			<col style="width:70px"/>
			<col style="width:250px"/>
			<col />
			<col style="width:90px"/>
			<col style="width:120px"/>
			<col style="width:90px"/>
		</colgroup>
		<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">게시판명</th>
			<th scope="col">메뉴</th>
			<th scope="col">등록 수</th>
			<th scope="col">마지막 등록일</th>
			<th scope="col">관리</th>
		</tr>
		</thead>
		<tbody class="text_center">
	<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
	<c:forEach var="result" items="${bbsMngList}">
		<tr id="row_${currentPageStartNo}">
			<td>${currentPageStartNo}</td>
			<td class="p-subject"><c:out value="${result.bbsNm}"/></td>
			<td class="p-subject"><a href="/${result.siteId}/sub.do?key=${result.menuNo}" target="_blank" title="새창"><c:out value="${result.menuCours}"/></a></td>
			<td class="text_right">${result.cnt} 건</td>
			<td>${result.frstRegisterPnttmYMD}</td>
			<td><a href="/iframe/selectBbsNttList.do?bbsNo=<c:out value="${result.bbsNo}"/>&amp;key=<c:out value="${param.key}"/>" onclick="iframeShow(this.href, 'row_${currentPageStartNo}','${result.bbsNo}'); return false;" class="p-button p-button--xsmall edit">관리</a></td>
		</tr>
		<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
	</c:forEach>
	<c:if test="${fn:length(bbsMngList) eq 0}">
		<tr>
			<td colspan="6">검색 데이터가 없습니다.</td>
		</tr>
	</c:if>
		</tbody>
	</table>
	
	<div class="row">
	    <div class="col-12">
			<ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./selectBbsMngList.do?${tsu:xssLinkFilter(bbsMngSearchVO.paramsWithOutPageIndex)}&amp;key=${tsu:xssLinkFilter(param.key)}&amp;pageIndex=" />
		</div>
		<div class="col-12 right">
			<a href="./downloadBbsMngXls.do?key=<c:out value="${param.key}"/>" onclick="fn_downloadXls(this.href); return false;" class="p-button p-button--combine excel">다운로드</a>
		</div>
	</div>
	
	<script nonce="NEOCMSSCRIPT">
		function fn_downloadXls( url ) {
	    if( confirm("게시판 목록을 다운로드 하시겠습니까?") ) {
				window.location = url;
	    }
	  }    
	</script>
		
</div>

<div id="iframe_wrap" style="display:none">

	<div class="p-wrap">

		<div class="row">
			<div class="col-16">
				<h3 class="margin_t_5"><small>게시판 관리</small></h3>
			</div>
			<div class="col-8 right">
				<a href="#n" class="p-button cancel" onclick="iframeHide();">
					<svg width="14" height="14" fill="#999" focusable="false">
					<use xlink:href="/common/images/program/p-icon.svg#arrow-left" y="1"></use>
					</svg> 게시판 목록
				</a>
			</div>
		</div>

		<table class="p-table p-table--bordered">
			<caption>게시판 정보</caption>
			<colgroup>
				<col style="width:80px">
				<col>
				<col style="width:80px">
				<col>
				<col style="width:80px">
				<col style="width:100px">
				<col style="width:100px">
				<col style="width:150px">
			</colgroup>
			<tbody>
			<tr>
				<th scope="row">게시판명</th>
				<td id="bbsNm"></td>
				<th scope="row">메뉴 경로</th>
				<td id="menuCours"></td>
				<th scope="row">등록수</th>
				<td class="text_center"><span data-mask="#,##0" data-mask-reverse="true" id="nttCo"></span></td>
				<th scope="row">최종 등록일</th>
				<td class="text_center"><time id="nttFrstRegisterPnttm"></time></td>
			</tr>
			</tbody>
		</table>

		<div class="p-iframe-wrap margin_t_30" style="width:100%; height:700px;">
			<iframe src="" frameborder="0" class="p-iframe" hspace="10" vspace="10"></iframe>
		</div>
	
	</div>
	<div class="row">
		<div class="col-12">
			<a href="#n" onclick="deleteBbsNtt()" class="p-button p-button--combine delete">게시물 일괄 삭제</a>
			<a href="#n" onclick="excelUploadBbsNtt()" class="p-button p-button--combine excel">게시물 일괄 업로드</a>
		</div>
		<div class="col-12 right">
		</div>
	</div>
</div>


<script nonce="NEOCMSSCRIPT">
//$(document).ready(sizeContent());
//$(window).resize(sizeContent);
var gbbsNo = 0;
function sizeContent() {
	var resizeWidth = ($(window).width() - 200) + "px";
	var resizeHeight = ($(window).height() - 100) + "px";
	//$("#iframe_wrap").css("width", resizeWidth);
	//$("#iframe_wrap").css("height", resizeHeight);
}

function iframeShow(url, row,bbsNo) {
	gbbsNo = bbsNo;
	$('#iframe_wrap iframe').attr("src", url);
	$('#iframe_wrap').show();
	$('#board_wrap').hide();
	sizeContent();
	
	var items = $('#' + row).find('td');
	$('#bbsNm').text(items.eq(1).text());
	$('#menuCours').text(items.eq(2).text());
	$('#nttCo').text(items.eq(3).text());
	$('#nttFrstRegisterPnttm').text(items.eq(4).text());
	
}
function deleteBbsNtt() {
	location.href = "./deleteBbsNttBetweenDateForm.do?key=51&bbsNo="+gbbsNo+"&searchSiteId=<c:out value="${bbsMngSearchVO.searchSiteId}"/>&searchCnd=<c:out value="${bbsMngSearchVO.searchCnd}"/>&searchKrwd=<c:out value="${bbsMngSearchVO.searchKrwd}"/>&pageIndex=<c:out value="${bbsMngSearchVO.pageIndex}"/>";
}
function excelUploadBbsNtt() {
	location.href = "./excelUploadBbsNttForm.do?key=51&bbsNo="+gbbsNo+"&searchSiteId=<c:out value="${bbsMngSearchVO.searchSiteId}"/>&searchCnd=<c:out value="${bbsMngSearchVO.searchCnd}"/>&searchKrwd=<c:out value="${bbsMngSearchVO.searchKrwd}"/>&pageIndex=<c:out value="${bbsMngSearchVO.pageIndex}"/>";
}


function iframeHide() {
	
	$('#iframe_wrap').hide();
	$('#board_wrap').show();
	
}
</script>

</body>
</html>