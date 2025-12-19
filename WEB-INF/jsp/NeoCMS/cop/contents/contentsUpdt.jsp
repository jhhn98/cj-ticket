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
<meta name="decorator" content="staff" />
<title>${menuInfo.cntntsNm} 관리 > <c:out value="${siteInfoData.siteNm}"/>(<span class="em_red"><c:out value="${siteInfoData.siteId}"/></span>) > <c:out value="${menu.menuNm}"/> 관리</title>
</head>
<body>

<div class="p-wrap">
	<div class="row">
		
		<div class="col-16">
		<form:form modelAttribute="contentsEdit" name="contentsEditForm" action="updateContentsManage.do">
    <fieldset>
    <legend>${menuInfo.cntntsNm} 콘텐츠 수정</legend>
		<form:hidden path="siteId"/>
    <form:hidden path="menuNo"/>
    <input type="hidden" name="key" value="<c:out value="${param.key}"/>"/>
			<div class="row"">
				<div class="col-12">
					<h3 class="margin_t_5">콘텐츠 수정</h3>
				</div>
				<div class="col-12 right">
					<a href="./selectContentsList.do?key=<c:out value="${param.key}"/>&amp;<c:out value="${contentsSearchVO.params}"/>" class="p-button p-button--small cancel">목록</a>
					<a href="#n" onclick="fn_previewContents(); return false;" class="p-button p-button--small info">미리보기</a>
					<input type="submit" value="수정" class="p-button p-button--small edit"/>
				</div>
			</div>
			
			<div style="height:600px;">
				<table class="p-table p-table--bordered">
					<caption>정보 표시</caption>
					<colgroup>
						<col style="width:80px">
						<col>
						<col style="width:80px">
						<col>
						<col style="width:100px">
						<col>
					</colgroup>
					<tbody>
					<tr>
						<th scope="row">사이트명</th>
						<td><c:out value="${siteInfoData.siteNm}"/></td>
						<th scope="row">메뉴명</th>
						<td><c:out value="${menu.menuNm}"/></td>
						<th scope="row">최종수정일</th>
						<td><time class="em_green"><c:out value="${tsu:toDateFormat(menu.cntntsLastUpdusrPnttm,'yyyyMMddHHmmss','yyyy-MM-dd HH:mm:ss')}"/></time></td>
					</tr>
					</tbody>
				</table>

				<textarea name="contentsCn" id="contentsCn" cols="30" rows="10" required="required" class="p-input" style="height:100%;">${contentsCn}</textarea>
				<div class="margin_t_5">
					<svg width="14" height="18" fill="#999" focusable="false"><title>복원</title><use xlink:href="/common/images/program/p-icon.svg#file-alt"></use></svg>
					콘텐츠 파일 : /repository/<c:out value="${menu.siteId}"/>/contents/<c:out value="${menu.menuNo}"/>.html
				</div>
			</div>
		</fieldset>
		</form:form>
		</div>
		
		 <form name="previewForm" id="previewForm" method="post" action="/<c:out value="${menu.siteId}"/>/previewContents.do" target="_blank">
		 <input type="hidden" name="menuNo" value="<c:out value="${menu.menuNo}"/>"/>
		 <input type="hidden" name="cntntsCn" id="cntntsCn"/>
		 </form>

		<div class="col-8">
			<h3 class="margin_t_5">콘텐츠 수정 이력</h3>
			<div class="p-overflow--y" style="height: 600px;">
				
				<table class="p-table p-table--bordered">
					<caption>{게시판명} 목록 - 번호, 제목, 작성자, 파일, 조회수, 작성일 정보  제공</caption>
					<colgroup>
						<col style="width:60px">
						<col style="width:140px">
						<col>
						<col style="width:100px">
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">수정일</th>
						<th scope="col">수정자</th>
						<th scope="col">관리</th>
					</tr>
					</thead>
					<tbody class="text_center">
					<tr class="p-table__cheecked">
						<td><svg width="18" height="18" fill="#f00" focusable="false"><title>사용중</title><use xlink:href="/common/images/program/p-icon.svg#check"></use></svg></td>
						<td><time><c:out value="${tsu:toDateFormat(menu.cntntsLastUpdusrPnttm,'yyyyMMddHHmmss','yyyy-MM-dd HH:mm:ss')}"/></time></td>
						<td><c:if test="${!empty menu.cntntsWrterId}"><c:out value="${menu.cntntsWrterNm}"/> (<em class="em_red"><c:out value="${menu.cntntsWrterId}"/></em>)</c:if></td>
						<td>
							<a href="/<c:out value="${menu.siteId}"/>/contents.do?key=<c:out value="${menu.menuNo}"/>" target="_blank" title="새창" class="p-button p-button--xsmall info">미리보기</a>
						</td>
					</tr>
					<c:set var="sNumber" value="${contentsHistoryTotCnt}"/>
			    <c:forEach var="result" items="${contentsHistoryList}" varStatus="status">
					<tr>
						<td><c:out value="${sNumber}"/></td>
						<td><time><c:out value="${tsu:toDateFormat(menu.cntntsLastUpdusrPnttm,'yyyyMMddHHmmss','yyyy-MM-dd HH:mm:ss')}"/></time></td>
						<td><c:if test="${!empty result.cntntsWrterId}"><c:out value="${result.cntntsWrterNm}"/> (<em class="em_red"><c:out value="${result.cntntsWrterId}"/></em>)</c:if></td>
						<td>
							<a href="/<c:out value="${menu.siteId}"/>/previewContentsHistory.do?menuNo=<c:out value="${menu.menuNo}"/>&amp;cntntsHistNo=<c:out value="${result.cntntsHistNo}"/>" target="_blank" title="새창" class="p-button p-button--xsmall p-button--icon info">
								<svg width="16" height="14" fill="#fff" focusable="false"><title>미리보기</title><use xlink:href="/common/images/program/p-icon.svg#eye"></use></svg>
							</a>
							<a href="./restoreContentsManageHistory.do?key=<c:out value="${param.key}"/>&amp;siteId=<c:out value="${menu.siteId}"/>&amp;menuNo=<c:out value="${menu.menuNo}"/>&amp;cntntsHistNo=<c:out value="${result.cntntsHistNo}"/>" class="p-button p-button--xsmall p-button--icon restore">
								<svg width="14" height="14" fill="#fff" focusable="false"><title>복원</title><use xlink:href="/common/images/program/p-icon.svg#history"></use></svg>
							</a>
						</td>
					</tr>
						<c:set var="sNumber" value="${sNumber-1}"/>
					</c:forEach>
					</tbody>
				</table>
			
			</div>
		</div>

	</div>
</div>


<script nonce="NEOCMSSCRIPT">
	function fn_previewContents() {
		$("#cntntsCn").val($("#contentsCn").val());
		$("#previewForm").submit();
	}
	
	function fn_restoreContents( url ) {
		if( confirm("선택한 콘텐츠로 복원하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>

</body>
</html>