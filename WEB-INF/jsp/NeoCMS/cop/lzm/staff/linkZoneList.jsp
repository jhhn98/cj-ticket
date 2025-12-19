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

	<title>링크존관리 목록</title>
	<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<script nonce="NEOCMSSCRIPT">
	function fn_changeSite( val ) {
		window.location = "./selectLinkZoneList.do?key=<c:out value="${key}"/>&siteId=" + val;
	}
</script>
<script nonce="NEOCMSSCRIPT">
	function fn_deleteLinkZone( url ) {
		if( confirm("삭제하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>

<div class="p-wrap">
	
	<div class="row p-relative">
		<div class="col-4 margin_t_5">
			<span>등록된 링크존 수 : <strong><c:out value="${fn:length(linkZoneList)}"/></strong> 건</span>
		</div>
		<div class="col-20 right">
			
			<select name="siteId" id="siteId" class="p-input  p-input--auto" onchange="fn_changeSite(this.value)">
		<c:forEach var="result" items="${siteInfoList}">
			<c:if test="${result.siteId ne 'staff'}">
				<option value="<c:out value="${result.siteId}" />"<c:if test="${result.siteId eq linkZone.siteId}"> selected="selected"</c:if>><c:out value="${result.siteNm}" /></option>
			</c:if>
		</c:forEach>
			</select>

		</div>
	</div>
	
	<table class="p-table p-table--bordered">
		<colgroup>
			<col style="width:80px;">	
			<col style="width:220px;">
			<col >
			<col style="width:130px;">
			<col style="width:130px;">
		</colgroup>
		<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">사이트명</th>
			<th scope="col">링크존이름</th>
			<th scope="col">링크존항목수</th>
			<th scope="col">등록일</th>
		</tr>
		</thead>
		<tbody class="text_center">
	<c:set var="sNumber" value="${fn:length(linkZoneList)}" />
	<c:forEach var="result" items="${linkZoneList}" varStatus="status">
		<tr>
			<td><c:out value="${sNumber}"/></td>
			<td><c:out value="${siteInfoMap[result.siteId]}"/></td>
			<td class="text_left"><a href="./selectLinkZoneItemList.do?key=<c:out value="${key}"/>&amp;siteId=<c:out value="${linkZone.siteId}"/>&amp;linkZoneNo=<c:out value="${result.linkZoneNo}"/>"><c:out value="${result.linkZoneNm}"/></a></td>
			<td><c:out value="${result.linkZoneIemCo}"/></td>
			<td><c:out value="${result.frstRegisterPnttmYMD}"/></td>
		</tr>
		<c:set var="sNumber" value="${sNumber-1}" />
	</c:forEach>
	<c:if test="${fn:length(linkZoneList) == 0}">
			<tr>
				<td colspan="5">등록된 링크존이 없습니다.</td>
			</tr>
	</c:if>
		</tbody>
	</table>

</div>

</body>
</html>
