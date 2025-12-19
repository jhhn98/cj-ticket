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
<title>배너존관리 목록</title>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<script nonce="NEOCMSSCRIPT">
	function fn_changeSite( val ) {
		window.location = "./selectBannerZoneList.do?key=<c:out value="${key}"/>&siteId=" + val;
	}
</script>
<div class="p-wrap">
	
	<div class="row p-relative">
		<div class="col-4 margin_t_5">
			<span>등록된 배너존 수 <strong><c:out value="${fn:length(bannerZoneList)}"/></strong> 건</span>
		</div>
		<div class="col-20 right">
			<select name="siteId" id="siteId" class="p-input  p-input--auto" onchange="fn_changeSite(this.value)">
				<c:forEach var="result" items="${siteInfoList}">
					<c:if test="${result.siteId ne 'staff'}">
						<option value="<c:out value="${result.siteId}" />"<c:if test="${result.siteId eq bannerZone.siteId}"> selected="selected"</c:if>><c:out value="${result.siteNm}" /></option>
					</c:if>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<table class="p-table p-table--bordered">
		<colgroup>
			<col style="width:60px;">	
			<col style="width:180px;">	
			<col />	
			<col style="width:100px;">	
			<col style="width:220px;">	
			<col style="width:120px;">	
		</colgroup>
		<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">사이트명</th>
			<th scope="col">배너존이름</th>
			<th scope="col">배너존항목수</th>
			<th scope="col">이미지크기(가로 * 세로)</th>
			<th scope="col">등록일</th>
		</tr>
		</thead>
		<tbody class="text_center">
	<c:set var="sNumber" value="${fn:length(bannerZoneList)}" />
	<c:forEach var="result" items="${bannerZoneList}" varStatus="status">
		<tr data-display="true">
			<td><c:out value="${sNumber}"/></td>
			<td><c:out value="${siteInfoMap[result.siteId]}"/></td>
			<td class="text_left"><a class="iconTextLink info" href="./selectBannerZoneItemList.do?key=<c:out value="${key}"/>&siteId=<c:out value="${bannerZone.siteId}"/>&amp;bannerZoneNo=<c:out value="${result.bannerZoneNo}"/>"><c:out value="${result.bannerZoneNm}"/></a></td>
			<td><c:out value="${result.bannerZoneIemCo}"/></td>
			<td><c:out value="${result.imageWidthSize}"/>px * <c:out value="${result.imageHeightSize}"/>px</td>
			<td><c:out value="${result.frstRegisterPnttmYMD}"/></td>
		</tr>
		<c:set var="sNumber" value="${sNumber-1}" />
	</c:forEach>
	<c:if test="${fn:length(bannerZoneList) == 0}">
		<tr>
			<td colspan="6" class="text_center">등록된 배너존이 없습니다.</td>
		</tr>
	</c:if>
		</tbody>
	</table>
	
</div>

</body>
</html>
