<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>게시판 첨부파일필드 관리 목록</title>
	<meta name="decorator" content="neo" />
	<script src="/neo/js/jquery-3.6.0.min.js"></script>
	<script src="/neo/js/common.js"></script>


	<script  src="<c:url value='/cmm/validator.do'/>"></script>
	<validator:javascript formName="bbsAtchFieldVO" staticJavascript="false" xhtml="true" cdata="false"/>
	<spring:hasBindErrors name="bbsAtchFieldVO">
		<script nonce="NEOCMSSCRIPT">
			<c:forEach items="${errors.allErrors}" var="error" varStatus="status">
			<c:if test="${status.first}">
			<c:set var="errMsg"><spring:message code="${error.code}" arguments="${error.arguments}" /></c:set>
			alert("<c:out value="${errMsg}"/>");
			</c:if>
			</c:forEach>
		</script>
	</spring:hasBindErrors>
	<c:if test="${!empty message}">
		<script nonce="NEOCMSSCRIPT">
			function fn_check_message() {
				alert("<c:out value='${message}'/>");
				<c:if test="${!empty fieldName}">
				$("#<c:out value="${fieldName}"/>").focus();
				</c:if>
			}
			$(window).on("load", function() {
				fn_check_message();
			});
		</script>
	</c:if>
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_board">게시판관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">게시판설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bbsVO.bbsNm}"/> 첨부파일필드 관리</span>
</div>
<div class="tab_navigation">
	<a href="./updateBbsInfoView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class=" "><span>설정관리</span></a>
	<a href="./updateBbsFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class=""><span>필드관리</span></a>
	<a href="./updateBbsFieldListSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class=""><span>목록 순서 변경</span></a>
	<a href="./updateBbsFieldInputSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class=""><span>입력/보기 순서 변경</span></a>
	<a href="./selectBbsCategoryList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class=""><span>카테고리관리</span></a>
	<a href="./updateBbsDescriptionView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class=""><span>설명관리</span></a>
	<a href="./selectBbsAuthorList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class=""><span>권한관리</span></a>
	<a href="./updateBbsAtchFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" ><span>첨부파일필드 관리</span></a>
	<a href="./updateBbsBanView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class="current"><span>악성사용자 차단</span></a>
</div>
<div class="contents is_tab">
	<div class="arrangementWrap marginBottom_10">
		<div class="arrLeft">
			<p class="info_text">차단을 하려면 IP혹은 ID를 입력하여야합니다. ID는 DI,CI거나 실제 사용자 로그인 ID입니다.</p>
		</div>
		<div class="arrRight">
			<div class="table_search">
				<form:form modelAttribute="bbsBan" name="addBbsBan" action="addBbsBan.do" onsubmit="return validateBbsBan(this)" >
					<form:hidden path="bbsNo"/>
					<input type="hidden" name="pageUnit" value="${bbsBan.pageUnit}"/>
					<input type="hidden" name="searchCnd" value="${bbsBan.searchCnd}"/>
					<input type="hidden" name="searchKrwd" value="${bbsBan.searchKrwd}"/>
					<input type="hidden" name="pageIndex" value="${bbsBan.pageIndex}"/>
					<span class="srch_element text">
                        <form:input path="banIp" placeholder="차단할 IP"/>
                    </span>
					또는
					<span class="srch_element text">
                        <form:input path="banId" placeholder="식별 ID"/>
                    </span>
					<span class="srch_element submit">
                        <button type="submit" class="add"><span>추가</span></button>
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
						<col class="specWidth100px"/>
						<col class="specWidth200px"/>
						<col class="specWidth200px"/>
						<col class="specWidth100px"/>
						<col class="specWidth100px"/>
						<col class="specWidth100px"/>
						<col class="specWidth100px"/>
						<col class="specWidth150px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">차단IP</th>
						<th scope="col">차단ID</th>
						<th scope="col">등록일</th>
						<th scope="col">등록자</th>
						<th scope="col">수정일</th>
						<th scope="col">수정자</th>
						<th scope="col">관리</th>
					</tr>
					</thead>
					<tbody>
					<c:set var="sNumber" value="1"/>
					<c:forEach var="result" items="${bbsBanList}" varStatus="status">
						<tr data-display="true">
							<form action="./updateBbsBan.do" method="post">
								<input type="hidden" name="banNo" value="<c:out value="${result.banNo}"/>"/>
								<input type="hidden" name="bbsNo" value="<c:out value="${result.bbsNo}"/>"/>
								<input type="hidden" name="pageUnit" value="${bbsBan.pageUnit}"/>
								<input type="hidden" name="searchCnd" value="${bbsBan.searchCnd}"/>
								<input type="hidden" name="searchKrwd" value="${bbsBan.searchKrwd}"/>
								<input type="hidden" name="pageIndex" value="${bbsBan.pageIndex}"/>
								<td class="textACenter"><c:out value="${sNumber}"/></td>
								<td class="textACenter"><input type="text" name="banIp" value="<c:out value="${result.banIp}"/>"/></td>
								<td class="textACenter"><input type="text" name="banId" value="<c:out value="${result.banId}"/>"/></td>
								<td class="textACenter"><c:out value="${result.frstRegisterPnttmYMD}"/></td>
								<td class="textACenter"><c:out value="${result.frstRegisterId}"/></td>
								<td class="textACenter"><c:out value="${result.lastUpdusrPnttmYMDWithBar}"/></td>
								<td class="textACenter"><c:out value="${result.lastUpdusrId}"/></td>
								<td class="textACenter"><button type="submit" class="iconTextButton edit small"><span>수정완료</span></button>
									<a href="./deleteBbsBan.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;banNo=<c:out value="${result.banNo}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class="iconTextButton delete small marginLeft_5"><span>삭제</span></a></td>
							</form>
						</tr>
						<c:set var="sNumber" value="${sNumber+1}" />
					</c:forEach>
					<c:if test="${fn:length(bbsBanList) == 0}">
						<td class="textACenter" colspan="100%">차단된 사용자가 없습니다.</td>
					</c:if>
					</tbody>
				</table>
			</div>
			<div class="arrangementWrap marginTop_20">
				<div class="arrLeft">
					<a href="./selectBbsList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;pageUnit=<c:out value="${bbsBan.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsBan.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsBan.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsBan.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
				</div>
				<div class="arrRight">
				</div>
			</div>
		</div>
	</div>
</div>
<script nonce="NEOCMSSCRIPT">
	function validateBbsBan(){
		if($("#banIp").val()== "" && $("#banId").val()== ""){
			alert("차단할 IP를 입력하거나 차단할 ID(식별번호)를 입력하여주세요.");
			return false;
		}
		return true;
	}
</script>

<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>
</body>
</html>
