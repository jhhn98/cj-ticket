<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<title>강사 관리 목록</title>
</head>
<body>

<div class="p-wrap">
	<div class="row p-relative">
		<div class="col-6 margin_t_5">
			<a href="/${menuInfo.siteId}/selectEduInstrList.do?key=${key}" title="목록 초기화">
				<span>총 <strong><fmt:formatNumber value="${paginationInfo.totalRecordCount}" pattern="#,###"/></strong> 건</span>
				<span class="division_line">[ <strong><c:out value="${paginationInfo.currentPageNo}"/></strong> / <c:out value="${paginationInfo.totalPageCount}"/> 페이지 ]</span>
			</a>
		</div>
		<div class="col-18 right">
			<form id="searchListFrm" method="get" action="/${menuInfo.siteId}/selectEduInstrList.do">
				<fieldset>
					<legend>강사 검색</legend>
					<input type="hidden" name="key" value="${key}"/>
				<select id="searchInsttNo" name="searchInsttNo" onchange="insttNoChange(this.value)" class="p-input p-input--auto">
					<option value="">기관 선택</option>
					<c:forEach var="instt" items="${eduInsttList}">
						<option value="${instt.insttNo}"${instt.insttNo eq eduInstrVO.searchInsttNo ? ' selected="true"':''}><c:out value="${instt.insttNm}"/></option>
					</c:forEach>
				</select>
				<select id="searchInstrField" name="searchInstrField" onchange="this.form.submit()" class="p-input p-input--auto">
					<option value="">분야 선택</option>
					<c:forEach var="item" items="${svcTyCdList}">
						<option value="${item.code}"${eduInstrVO.searchInstrField eq item.code ? ' selected="true"':''}><c:out value="${item.codeNm}"/></option>
					</c:forEach>
				</select>
					<input type="hidden" name="searchCnd" value="all"/>
					<input name="searchKrwd" value="${eduInstrVO.searchKrwd}" title="검색어 입력" placeholder="검색어 입력" class="p-input p-input--auto"/>
					<button type="submit" class="p-button p-button--small primary">검색</button>
				</fieldset>
			</form>
		</div>
	</div>

	<table class="p-table p-table--bordered">
		<colgroup>
			<col class="w60">
			<col class="w120">
			<col class="w140">
			<col class="w120">
			<col class="w120">
			<col class="w120">
			<col>
			<col class="w180">
			<col class="w120">
			<col class="w100">
			<col class="w140">
		</colgroup>
		<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">운영기관</th>
			<th scope="col">아이디</th>
			<th scope="col">분야</th>
			<th scope="col">강사명</th>
			<%--<th scope="col">강좌명</th>--%>
			<th scope="col">이메일</th>
			<th scope="col">연락처</th>
			<th scope="col">표시여부</th>
			<th scope="col">관리</th>
		</tr>
		</thead>
		<tbody class="text_center">
		<c:set var="pageNo" value="${paginationInfo.currentPageStartNo}" />
		<c:forEach var="result" items="${eduInstrList}" varStatus="status">
			<tr class="colored">
				<td><c:out value="${pageNo}"/></td>
				<td><c:out value="${result.insttNm}"/></td>
				<td><c:out value="${result.userId}"/></td>
				<td><c:out value="${svcTyCdMap[result.instrField]}"/></td>
			<td>
				<c:out value="${result.instrNm}"/>
			</td>
				<%--<td class="text_left"><c:out value="${result.lectuNm}"/></td>--%>
				<td><c:out value="${result.email}"/></td>
				<td><c:out value="${result.telNo}"/></td>

				<td>
					<span class="p-switcher p-switcher--single">
						<input type="checkbox" class="p-switcher__input" id="useYn${result.userId}"<c:if test="${result.useYn eq 'Y'}"> checked</c:if> value="${result.userId}" onchange="fn_useYn(this, '${result.userId}', '${result.useYn}')">
						<label for="useYn${result.userId}" class="p-switcher__label"><em class="p-switcher__text blind">표시</em></label>
					</span>
				</td>
			<td>
				<a href="./updateEduInstrView.do?userId=${result.userId}&amp;<c:out value="${eduInstrVO.params}"/>" class="p-button p-button--xsmall edit">수정</a>
				<a href="./deleteEduInstr.do?userId=${result.userId}&amp;<c:out value="${eduInstrVO.params}"/>" onclick="fn_delete(this.href); return false;" class="p-button p-button--xsmall delete">삭제</a>
			</td>
			</tr>
			<c:set var="pageNo" value="${pageNo-1}" />
		</c:forEach>
		<c:if test="${fn:length(eduInstrList) == 0}">
			<tr>
				<td colspan="9" class="empty">등록된 정보가 없습니다</td>
			</tr>
		</c:if>
		</tbody>
	</table>

	<div class="row margin_t_10">
		<div class="col-4"></div>
		<div class="col-16 center">
			<ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="/${menuInfo.siteId}/selectEduInstrList.do?${fn:escapeXml(eduInstrVO.paramsExclPi)}&amp;pageIndex=" />
		</div>
		<div class="col-4 right">
			<a href="./downloadXlsInstrList.do?<c:out value="${eduInstrVO.params}"/>" onclick="fn_download(this.href); return false;" class="p-button p-button--combine excel">엑셀다운로드</a>
			<a href="./addEduInstrView.do?<c:out value="${eduInstrVO.params}"/>"  class="p-button primary">등록</a>
		</div>
	</div>

</div>

<script nonce="NEOCMSSCRIPT">
	//기관명선택 이벤트
	function insttNoChange(val) {
		$("#searchInstrField option:eq(0)").prop("selected", true);
		var selitem = '<c:out value="${eduInstrVO.searchInsttNo}"/>';
		if(selitem != val){
			document.getElementById('searchListFrm').submit();
		}
	}

	//사용여부 변경
	function fn_useYn(el, userId, useYn){
		var newUseYn = el.checked ? 'Y' : 'N';

		$.ajax({
			url: './ajaxEduInstrUseYn.do?key=${key}',
			type: 'GET',
			cache: false,
			dataType: 'json',
			data: {"userId":userId, "useYn":newUseYn},
			success: function (res) {
				if(res == 1) alert("변경되었습니다.");
				else if(res == 2) alert("잘못된 접근입니다.");
				else if(res == 0) alert("변경에 실패하였습니다.");
				$('.p-wrap').load(location.href+' .p-wrap');
			},
			error: function (request,xhr, status) {
				alert("에러가 발생하였습니다.");
				console.log("code: ",request.status);
				console.log("message: ",request.responseText);
				console.log("error: "+error)
				$('.p-wrap').load(location.href+' .p-wrap');
			}
		});
	}

	function fn_download( url ) {
		if( confirm("조회된 <c:out value="${paginationInfo.totalRecordCount}"/>건을 엑셀파일로 다운로드하시겠습니까?") ) {
			window.location = url;
		}
	}

	function fn_delete( url ) {
		if( confirm("한 번 삭제한 정보는 복구할 수 없으며\n강사의 회원정보도 모두 삭제됩니다.\n해당 항목을 정말 삭제하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>
</body>
</html>