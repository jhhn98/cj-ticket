<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<c:set var="active_menu" value="USR_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>NEO Administrator - UserLoginLog</title>
<meta name="decorator" content="neo" />


</head>
<body>

<link rel="stylesheet" href="/site/staff/css/program.css">
<script src="/common/js/program.js"></script>

<div class="page_location">
	<span class="depth1_title icon_user">사용자관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">개인정보처리 이력</span>
</div>
<div class="tab_navigation">
    <a href="/neo/selectUserInfoList.do"><span>사용자 관리</span></a></li>
    <a href="/neo/selectIndvdlinfoHistList.do" class="current"><span>개인정보처리이력</span></a></li>
    <%--<a href="/neo/selectUserForceLoginHistList.do"><span>개별로그인이력</span></a></li>--%>
    <a href="/neo/updateUserConfigView.do"><span>사용자 정보 설정 관리</span></a></li>
</div>


<div class="contents is_tab">

	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
			<span class="table_text"><c:if test="${null eq param.userId || '' eq param.userId}">
				<c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/>
			</c:if></span>
		</div>
		<div class="arrRight">
			<form name="userInfoForm" id="userInfoForm" method="get" action="selectIndvdlinfoHistList.do">
				<div class="table_search">
					<span class="srch_element select">
						<select id="pageUnit" name="pageUnit">
							<option value="10" <c:if test="${10 eq indvdlinfoHist.pageUnit}">selected="selected"</c:if>>10 페이지</option>
							<option value="20" <c:if test="${20 eq indvdlinfoHist.pageUnit}">selected="selected"</c:if>>20 페이지</option>
							<option value="30" <c:if test="${30 eq indvdlinfoHist.pageUnit}">selected="selected"</c:if>>30 페이지</option>
							<option value="40" <c:if test="${40 eq indvdlinfoHist.pageUnit}">selected="selected"</c:if>>40 페이지</option>
							<option value="50" <c:if test="${50 eq indvdlinfoHist.pageUnit}">selected="selected"</c:if>>50 페이지</option>
						</select>
					</span>
					<span class="srch_element select">
						<select id="searchAtnddu" name="searchAtnddu">
							<option value="" selected="selected">수행업무</option>
						<c:forEach var="result" items="${atndduList}" varStatus="status">
							<option value="<c:out value="${result.code}"/>" <c:if test="${result.code eq indvdlinfoHist.searchAtnddu}">selected="selected"</c:if>><c:out value="${result.codeNm}"/></option>
						</c:forEach>
						</select>
					</span>
					<span class="srch_element select">
						<select name="searchCnd" id="searchCnd">
							<option value="all">전체</option>
							<option value="infoMbyId" <c:if test="${'infoMbyId' eq indvdlinfoHist.searchCnd}">selected="selected"</c:if>>정보주체 ID</option>
							<option value="infoMbyNm" <c:if test="${'infoMbyNm' eq indvdlinfoHist.searchCnd}">selected="selected"</c:if>>정보주체 이름</option>
							<option value="hndlrId" <c:if test="${'hndlrId' eq indvdlinfoHist.searchCnd}">selected="selected"</c:if>>취급자정보 ID</option>
							<option value="hndlrNm" <c:if test="${'hndlrNm' eq indvdlinfoHist.searchCnd}">selected="selected"</c:if>>취급자정보 이름</option>
							<option value="bbsNo" <c:if test="${'bbsNo' eq indvdlinfoHist.searchCnd}">selected="selected"</c:if>>게시판번호</option>
						</select>
					</span>


					<span class="srch_element text">
						<input type="text" id="searchKrwd" name="searchKrwd" class="txt" value="<c:out value="${indvdlinfoHist.searchKrwd}"/>"/>
					</span>
					<span class="srch_element submit">
						<button type="submit" class="search_button">검색</button>
					</span>
				</div>
			</form>

		</div>
	</div>
    <div class="table_fixed_wrap is_topBottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth50px"/>
						<col class="specWidth100px"/>
						<col class="specWidth100px"/>
						<col class="specWidth100px"/>
						<col class="specWidth110px"/>
						<col class="specWidth80px"/>
				<%--		<col class="specWidth120px"/>--%>
						<col />
				<%--		<col/>--%>
				<%--		<col class="specWidth160px"/>--%>
				<%--		<col class="specWidth160px"/>--%>
						<col class="specWidth100px"/>
						<col class="specWidth140px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">정보주체 ID</th>
						<th scope="col">정보주체 이름</th>
						<th scope="col">취급자정보 ID</th>
						<th scope="col">취급자정보 이름</th>
						<th scope="col">수행업무</th>
				<%--		<th scope="col">상세업무</th>--%>
						<th scope="col">목적</th>
				<%--		<th scope="col">항목</th>--%>
				<%--		<th scope="col">변경 전</th>--%>
				<%--		<th scope="col">변경 후</th>--%>
						<th scope="col">접속지</th>
						<th scope="col">접속일시</th>
					</tr>
					</thead>
					<tbody>
				<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
				<c:forEach var="result" items="${indvdlinfoHistList}" varStatus="status">
					<tr data-display="true">
						<td class="textACenter"><c:out value="${currentPageStartNo}"/></td>
						<td class="textACenter"><c:out value="${result.infoMbyId}"/></td>
						<td class="textACenter"><c:out value="${result.infoMbyNm}"/></td>
						<td class="textACenter"><c:out value="${result.agentInfoId}"/></td>
						<td class="textACenter"><c:out value="${result.agentInfoNm}"/></td>
						<td class="textACenter"><c:out value="${atndduMap[result.atnddu]}"/></td>
				<%--		<td class="textACenter"><c:out value="${trtiemMap[result.trtmntIem]}"/></td>--%>
						<td class="textACenter"><c:out value="${result.trtmntPurps}"/></td>
				<%--		<td><c:out value="${result.searchWrd}"/></td>--%>
				<%--		<td><c:out value="${result.bfchg}"/></td>--%>
				<%--		<td><c:out value="${result.aftch}"/></td>--%>
						<td class="textACenter"><c:out value="${result.connectIp}"/></td>
						<td class="textACenter"><c:out value="${tsu:toDateFormat(result.connectPnttm,'yyyyMMddHHmmss', 'yyyy-MM-dd HH:mm:ss')}"/></td>
					</tr>
					<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
				</c:forEach>
				<c:if test="${fn:length(indvdlinfoHistList) == 0}">
					<tr>
						<td colspan="100%" class="textACenter">개인정보처리 이력이 없습니다.</td>
					</tr>
				</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
		<c:if test="${null eq param.userId || '' eq param.userId}">
			<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectIndvdlinfoHistList.do?pageUnit=${tsu:xssLinkFilter(indvdlinfoHist.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(indvdlinfoHist.searchCnd)}&amp;searchAtnddu=${tsu:xssLinkFilter(indvdlinfoHist.searchAtnddu)}&amp;searchTrtmntIem=${tsu:xssLinkFilter(indvdlinfoHist.searchTrtmntIem)}&amp;searchKrwd=${tsu:xssLinkFilter(indvdlinfoHist.searchKrwd)}&amp;pageIndex=" />
		</c:if>
		</div>
		<div class="arrRight">
			<div style="position:relative" id="calpop"></div>
			<form name="indvdlinfoDwld" method="post" action="./downloadIndvdlinfoHist.do" onsubmit="return validateDownloadIndvdlinfoHist(this);" class="download" >
                <div class="form_element calendar_input p-datepicker__wrap">
                    <input name="searchAtnddu" type="hidden" value="<c:out value="${indvdlinfoHist.searchAtnddu}"/>"/>
                    <input name="searchTrtmntIem" type="hidden" value="<c:out value="${indvdlinfoHist.searchTrtmntIem}"/>"/>
                    <input name="searchCnd" type="hidden" value="<c:out value="${indvdlinfoHist.searchCnd}"/>"/>
                    <input name="searchKrwd" type="hidden" value="<c:out value="${indvdlinfoHist.searchKrwd}"/>"/>
                    <div class="element_wrap p-datepicker__wrap  p-form-group p-date" id="sdate">
                        <label for="sdate">조회 시작일</label>
                        <input  name="sdate" type="text" value="" class="p-input"  placeholder="시작일 입력하기"/>
                        <button type="button" class="p-input__item  p-date__icon">달력 선택</button>
                    </div>

                    <div class="element_wrap p-datepicker__wrap p-form-group p-date" id="edate">
                        <label for="edate">조회 종료일</label>
                        <input  name="edate" type="text" value="" class="p-input"  placeholder="종료일 입력하기"/>
                        <button type="button" class="p-input__item  p-date__icon">달력 선택</button>
                    </div>
                    <div class="element_wrap submit_element">
                        <button type="submit" class="iconTextButton download"><span>개인정보처리 이력 다운로드</span></button>
                    </div>
                            <!-- <a href="./selectIndvdlinfoDwldHistList.do" class="button blue"><span>이력 다운로드 목록</span></a> -->
                </div>
			</form>
		</div>
	</div>

	<script nonce="NEOCMSSCRIPT">
		$('#sdate').datepicker({
			orientation:"top",container:"#calpop"
		});
		$('#edate').datepicker({
			orientation:"top",container:"#calpop"
		});

		function validateDownloadIndvdlinfoHist(frm) {

			if( !frm.sdate.value ) {
				alert('기간 시작일을 선택하여주세요.');
				frm.sdate.focus();
				return false;
			}

			if( !frm.edate.value ) {
				alert('기간 종료일을 선택하여주세요.');
				frm.edate.focus();
				return false;
			}

			return true;

		}

	</script>
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>
</body>
</html>

