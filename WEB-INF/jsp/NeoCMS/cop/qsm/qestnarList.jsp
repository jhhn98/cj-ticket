<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<title>${menuInfo.cntntsNm} 목록</title>
	<link rel="stylesheet" href="/common/css/board.css" />
	<script src="/common/js/board.js"></script>
	<script src="/common/js/calendar.js"></script>
</head>
<body>
<script type="text/javascript">

function fn_changeSite( val ) {
	window.location = "./selectQestnarMngList.do?key=${key}&siteId=" + val;
}

function fn_updateQestnarUseAt(val,obj){
	var useAt='N';
	if(obj.checked){
		useAt = 'Y';
	}
	window.location = "./updateQestnarMngUseAt.do?key=${key}&siteId=${searchVO.siteId}&qestnarNo="+val+"&useAt="+useAt;
}

function fn_deleteQestnar( url ) {
	if( confirm("설문을 삭제 하시겠습니까?") ) {
		window.location = url;
	}
}
</script>


<div class="p-wrap">

</div>

<h1 class="subHeader">설문조사 관리 &gt;
<select name="siteId" onchange="fn_changeSite(this.value)" class="p-input p-input--auto">
<c:if test="${fn:length(siteSeList) != 0}">
	<c:forEach var="siteSeList" items="${siteSeList}" varStatus="status">
		<optgroup label="${siteSeList.codeNm}">
		<c:forEach var="siteInfoList" items="${siteInfoList}" varStatus="status">
			<c:if test="${siteSeList.code eq siteInfoList.siteSe && siteInfoList.siteId ne 'staff'}">
			<option value="${siteInfoList.siteId}" <c:if test="${searchVO.siteId eq siteInfoList.siteId}">selected="selected"</c:if>>${siteInfoList.siteNm}</option>
			</c:if>
		</c:forEach>
		</optgroup>
	</c:forEach>
</c:if>
<c:if test="${fn:length(siteSeList) == 0}">
	<c:forEach var="siteInfoList" items="${siteInfoList}" varStatus="status">
		<c:if test="${siteSeList.code eq siteInfoList.siteSe}">
		<option value="${siteInfoList.siteId}" <c:if test="${searchVO.siteId eq siteInfoList.siteId}">selected="selected"</c:if>>${siteInfoList.siteNm}</option>
		</c:if>
	</c:forEach>
</c:if>
</select>
&gt; 목록</h1>


<div class="row p-relative">
	<div class="col-6 margin_t_5">
		<span>총 <strong>${paginationInfo.totalRecordCount}</strong> 건</span>
		, <span class="division_line">페이지 <strong>${paginationInfo.currentPageNo}</strong> / ${paginationInfo.totalPageCount}</span>
	</div>
	<div class="col-18 right">
		<form:form modelAttribute="searchVO" name="searchForm" method="get">
			<input type="hidden" name="key" value="${param.key }" />
			<div class="bbs_right">
				<form:input path="searchKrwd" class="p-input  p-input--auto" placeholder="설문조사명"/>
				<label><span class="btn"><input type="submit" class="p-button p-button--small primary" value="검색"/><i class="view"></i></span></label>
			</div>
		</form:form>
	</div>
</div>

<table class="p-table p-table--bordered" data-rwdb="yes">
	<colgroup>
		<col width="40">
		<col/>
		<col width="250"/>
		<col width="50"/>
		<col width="50"/>
		<col width="50"/>
		<col width="50"/>
		<col width="70"/>
		<col width="70"/>
		<col width="70"/>
		<col width="50"/>
		<col width="50"/>
	</colgroup>
	<tr>
		<th>번호</th>
		<th>설문조사 제목</th>
		<th>기간</th>
		<th>문항수</th>
		<th>참여수</th>
		<th>상태</th>
		<th>표시</th>
		<th>엑셀</th>
		<th>결과보기</th>
		<th>문항설정</th>
		<th>수정</th>
		<th>삭제</th>		
	</tr>
	<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<tr>
		<td align="right">${currentPageStartNo}</td>  
		<td>${result.qestnarSj}</td>		
		<td align="center">${result.bgndeYMD} ~ ${result.enddeYMD}</td>
		<td align="center">${result.qestnCo}</td>
		<td align="center">${result.respondCo}</td>
		<td align="center">${codeMapQest3[result.sttus]}</td>
		<td align="center"><input type="checkbox" onclick="fn_updateQestnarUseAt(${result.qestnarNo},this)" <c:if test="${result.useAt eq 'Y'}">checked</c:if> /></td>
		<td align="center"><a href="./selectQestnarResultExcel.do?key=${key}&amp;qestnarNo=${result.qestnarNo}" title="새창" target="_blank" class="p-button p-button--xsmall excel"><span>엑셀다운로드</span></a></td>
		<td align="center"><a href="/staff/selectQestnarMngResult.do?key=${key}&amp;qestnarNo=${result.qestnarNo}" class="p-button p-button--xsmall cancel" ><span>설문결과보기</span></a></a></td>
		<td align="center"><a href="./addQestnarQestnMngView.do?key=${key}&amp;qestnarNo=${result.qestnarNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button p-button--xsmall cancel"><span>문항설정</span></a></td>
		<td align="center"><a href="./updateQestnarMngView.do?key=${key}&amp;qestnarNo=${result.qestnarNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button p-button--xsmall info"><span>수정</span></a></td>
		<td align="center"><a href="./deleteMngQestnar.do?key=${key}&amp;qestnarNo=${result.qestnarNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" onclick="fn_deleteQestnar(this.href); return false;" class="p-button p-button--xsmall restore"><span>삭제</span></a></td>
	</tr>
		<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
	<tr>
		<td colspan="12" align="center">등록된 설문조사가 없습니다.</td>
	</tr>
	</c:if>
</table>

<div class="row margin_t_20">
	<div class="col-12">
		<ui:pagination paginationInfo = "${paginationInfo}" type="board" jsFunction="./selectQestnarMngList.do?key=${key}&amp;${searchVO.paramsExclPi}&amp;pageIndex=" />
	</div>
	<div class="col-12 right">
		<a href="./addQestnarMngView.do?key=${key}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button write"><span>등록</span></a>
	</div>
</div>
</body>
</html>