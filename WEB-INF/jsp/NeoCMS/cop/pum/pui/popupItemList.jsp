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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>팝업항목관리 목록</title>
	<link rel="stylesheet" href="./css/neo.css" />
	<link rel="stylesheet" href="./css/subheader.css" />
	<meta name="decorator" content="neo" />
	<script nonce="NEOCMSSCRIPT">

		function fn_changeSite( val ) {
			window.location = "./selectPopupItemList.do?siteId=" + val;
		}

		function PopupView(Url ,type ,sDivName, nTop, nLeft, nHeight, nWidth)
		{
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
		function LayerPopupClose(sDivName)
		{
			/*
            어 팝업을 닫습니다.

            매개변수
            sDivName : 레이어 팝업으로 쓸 div id
            */
			var oPopup = document.getElementById(sDivName);
			oPopup.style.display = "none";
		}
	</script>
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_program">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">팝업항목관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title"><c:out value="${selectedSite.siteNm}"/>(<span class="em_red"><c:out value="${selectedSite.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title">목록</span>
</div>

<script nonce="NEOCMSSCRIPT">
	function fn_deletePopupItem( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>

<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">조회된 팝업 항목 수 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
		</div>
		<div class="arrRight">
			<div class="table_search">
				<form:form modelAttribute="popupItemVO" name="popupItemVOForm" method="get">
					<form:hidden path="siteId" />

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
						<form:option value="popupIemNm">제목</form:option>
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
						<%-- <col class="specWidth${popup.imageWidthSize+20}px"/> --%>
						<col/>
						<col class="specWidth80px"/>
						<col class="specWidth140px"/>
						<col class="specWidth100px"/>
						<col class="specWidth70px"/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
					</colgroup>
					<thead>
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
                    <tbody>
					<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
					<c:forEach var="result" items="${popupItemList}" varStatus="status">
						<tr data-display="true">
							<td class="textARight">${currentPageStartNo}</td>
								<%-- <td align="center"><img src="/DATA/popup/${result.imageFileNm}" width="${popup.imageWidthSize}" height="${popup.imageHeightSize}"/></td> --%>
							<td>
								<strong><a href="./selectPopupItemView.do?popupIemNo=${result.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" class="iconTextLink info">${result.popupIemNm}</a></strong>
								<c:if test="${result.linkUrl ne '' and result.linkUrl ne null}">
									<br/>
									<a href="${result.linkUrl}" target="_blank" class="iconTextLink site"><span>${result.linkUrl}</span></a>
								</c:if>
							</td>
							<td class="textACenter" >
								<c:if test="${result.type=='layer'}">레이어</c:if>
								<c:if test="${result.type=='window'}">새창</c:if>
							</td>
							<td>
								시작:<c:out value="${tsu:toDateFormat(result.bgnde,'yyyyMMddHHmmss','yyyy-MM-dd HH:mm:ss')}"/><br/>종료:<c:out value="${tsu:toDateFormat(result.endde,'yyyyMMddHHmmss','yyyy-MM-dd HH:mm:ss')}"/>
							</td>
							<td>
								<img src="/DATA/popup/${result.imageFileNm}" width="100px" height="100px"/>
							</td>
							<td class="textACenter" >
									${showSeMap[result.showSe]}
								<c:if test="${'periodDate' eq result.showSe}">
									<br/>
								</c:if>
							</td>
							<td class="textACenter" >${result.frstRegisterPnttmYMD}</td>
							<td class="textACenter" ><a href="./updatePopupItemView.do?popupIemNo=${result.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" class="iconTextButton edit small"><span>수정</span></a></td>
							<td class="textACenter" ><a href="./deletePopupItem.do?siteId=${popupItemVO.siteId}&amp;popupIemNo=${result.popupIemNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}" onclick="fn_deletePopupItem(this.href); return false;" class="iconTextButton delete small"><span>삭제</span></a></td>
						</tr>
						<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
					</c:forEach>
					<c:if test="${fn:length(popupItemList) == 0}">
						<tr>
							<td colspan="9" class="textACenter" >등록된 팝업 항목이 없습니다.</td>
						</tr>
					</c:if>
                    </tbody>
				</table>

			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<a href="./sortPopupItemView.do?siteId=${popupItemVO.siteId}" class="iconTextButton sort"><span>순서변경</span></a>&nbsp;
			<%-- <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="./selectPopupItemList.do?siteId=${popupItemVO.siteId}&amp;popupNo=${popupItemVO.popupNo}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=" /> --%>
		</div>
		<div class="arrRight">
			<a href="./addPopupItemView.do?siteId=${popupItemVO.siteId}&amp;pageUnit=${popupItemVO.pageUnit}&amp;searchCnd=${popupItemVO.searchCnd}&amp;searchKrwd=${popupItemVO.searchKrwd}&amp;searchShowSe=${popupItemVO.searchShowSe}&amp;pageIndex=${popupItemVO.pageIndex}"  class="iconTextButton write marginLeft_5"><span>등록</span></a>
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
