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
<title>${menuInfo.cntntsNm} 목록</title>
<meta name="decorator" content="${menuInfo.siteId}" />
<script src="/common/js/default.js"></script>  
</head>
<body>

<script nonce="NEOCMSSCRIPT">
	function fn_changeSite( val ) {
		window.location = "./selectPopupItemList.do?key=<c:out value="${key}"/>&siteId=" + val;
	}
</script>
<div class="p-wrap">

	<div class="row p-relative">
		<div class="col-4 margin_t_5">
			<span class="table_text">조회된 팝업 항목 수 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
		</div>
		<div class="col-20 right">
			<form:form modelAttribute="popupItemVO" name="popupItemVOForm" method="get">
			<input type="hidden" name="key" id="key2" value="<c:out value="${key}"/>" />
			
			<form:select path="siteId" class="p-input  p-input--auto" onchange="fn_changeSite(this.value)">
				<form:option value="" label="사이트 선택" />
			<c:forEach var="result" items="${siteInfoList}">
				<c:if test="${result.siteId ne 'staff'}">
				<form:option value="${result.siteId}" label="${result.siteNm}" />
				</c:if>
			</c:forEach>
			</form:select>

			<form:select path="searchShowSe" class="p-input  p-input--auto">
				<form:option value="">표시구분 전체</form:option>
				<form:option value="always">표시중인항목(항상표시, 기간)</form:option>
				<form:option value="doNotShow">표시안함</form:option>
				<form:option value="periodDate">기간에 따라표시</form:option>
			</form:select>
			
			<form:hidden path="searchCnd" />
			<form:input path="searchKrwd" class="p-input  p-input--auto"/>
			<button type="submit" class="p-button p-button--small primary">검색</button>
			<a href="./sortPopupItemView.do?key=<c:out value="${key}"/>&amp;siteId=${popupItemVO.siteId}" class="p-button p-button-small edit">순서변경</a>
			</form:form>
		</div>
	</div>
	
	<table class="p-table p-table--bordered">
		<colgroup>
			<col style="width:60px" />
			<%-- <col class="specWidth${popup.imageWidthSize+20}px"/> --%>
			<col />
			<col style="width:70px" />
			<col style="width:190px" />
			<col style="width:130px" />
			<col style="width:110px" />
			<col style="width:110px" />
			<col style="width:70px" />
			<col style="width:70px" />
		<thead>
		</colgroup>
		<tr>
			<th scope="col">번호</th>
			<!-- <th scope="col">이미지</th> -->
			<th scope="col">제목</th>
			<th scope="col">타입</th>
			<th scope="col">기간</th>
			<th scope="col">이미지</th>
			<th scope="col">표시구분</th>
			<th scope="col">등록일</th>
			<th scope="col">수정</th>
			<th scope="col">삭제</th>
		</tr>
		</thead>
		<tbody class="text_center">
		<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
		<c:forEach var="result" items="${popupItemList}" varStatus="status">
			<tr data-display="true">
				<td>${currentPageStartNo}</td>
					<%-- <td align="center"><img src="/DATA/popup/${result.imageFileNm}" width="${popup.imageWidthSize}" height="${popup.imageHeightSize}"/></td> --%>
				<td class="text_left">
					<strong><a href="./selectPopupItemView.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${result.siteId}"/>&amp;popupIemNo=${result.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" class="iconTextLink info">${result.popupIemNm}</a></strong>
					<c:if test="${result.linkUrl ne '' and result.linkUrl ne null}">
						<br/>
						<a href="${result.linkUrl}" target="_blank" class="iconTextLink site"><span>${result.linkUrl}</span></a>
					</c:if>
				</td>
				<td>
					<c:if test="${result.type=='layer'}">레이어</c:if>
					<c:if test="${result.type=='window'}">새창</c:if>
				</td>
				<td>
					시작:<c:out value="${tsu:toDateFormat(result.bgnde,'yyyyMMddHHmmss','yyyy-MM-dd HH:mm:ss')}"/><br/>종료:<c:out value="${tsu:toDateFormat(result.endde,'yyyyMMddHHmmss','yyyy-MM-dd HH:mm:ss')}"/>
				</td>
				<td><img src="/DATA/popup/${result.imageFileNm}" width="100px" height="100px"/></td>
				<td>
						${showSeMap[result.showSe]}
					<c:if test="${'periodDate' eq result.showSe}">
						<br/>
					</c:if>
				</td>
				<td>${result.frstRegisterPnttmYMD}</td>
				<td>
					<a href="./updatePopupItemView.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${result.siteId}"/>&amp;popupIemNo=${result.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" class="p-button p-button--xsmall edit">수정</a>
				</td>
				<td>
					<a href="./deletePopupItem.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${result.siteId}"/>&amp;popupIemNo=${result.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" onclick="fn_deletePopupItem(this.href); return false;" class="p-button p-button--xsmall delete">삭제</a>
				</td>
			</tr>
			<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
		</c:forEach>
		<c:if test="${fn:length(popupItemList) == 0}">
			<tr>
				<td colspan="9" class="text_center">등록된 팝업 항목이 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
	
	<div class="row margin_t_20">
		<div class="col-12">
			<ui:pagination paginationInfo = "${paginationInfo}" type="board" jsFunction="./selectPopupItemList.do?&amp;key=${key}&amp;siteId=${popupItemVO.siteId}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=" />

		</div>
		<div class="col-12 right">
			<a href="./addPopupItemView.do?siteId=${popupItemVO.siteId}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}&amp;key=<c:out value="${key}"/>" class="p-button write">등록</a>
		</div>
	</div>

</div>

<script nonce="NEOCMSSCRIPT">
	function fn_deletePopupItem( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			window.location = url;
		}
	}
	
	function PopupView(Url ,type ,sDivName, nTop, nLeft, nHeight, nWidth) {
		/*
		레이어 팝업을 띄웁니다.
		팝업의 크기는 내용물의 크기에 영향을 받습니다.
		그렇기 때문에 내용물에 따라 정확하지 않은 크기가 적용될수 있습니다.

		매개변수
		sDivName : 레이어 팝업으로 쓸 div id
		nTop : 팝업의 세로 위치
		nLeft : 팝업의 가로 위치
		nHeight : 팝업의 세로 크기
		nWidth : 팝업의 가로 크기
		*/

		if(type=='layer'){
			//사용할 레이어를 불러온다.
			var oPopup = document.getElementById(sDivName);
			//어을 표시하고
			oPopup.style.display = "block";

			//위치 및 크기 설정
			oPopup.style.top = nTop + "px";
			oPopup.style.left = nLeft + "px";
			oPopup.style.height = nHeight + "px";
			oPopup.style.width = nWidth + "px";
		}else if(type='window'){

			var popOption = "top=" + nTop + ", left=" + nLeft + ", width=" + nWidth + ", height=" + nHeight + ", resizable='false', scrollbars='false', status='false'";
			window.open(Url, "", popOption);
		}
	}

	function LayerPopupClose(sDivName) {
		/*
		어 팝업을 닫습니다.

		매개변수
		sDivName : 레이어 팝업으로 쓸 div id
		*/
		var oPopup = document.getElementById(sDivName);
		oPopup.style.display = "none";
	}
</script>

</body>
</html>
