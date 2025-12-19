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

<title>NEO Administrator - UserInfo</title>
<meta name="decorator" content="neo" />


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
<script nonce="NEOCMSSCRIPT">
	$( document ).ready(function() {
		$('input:checkbox[id="addCheck"]').change(function() {
			var cnt = $(this).val();
			var index = $('input:checkbox[id="addCheck"]:checked').length-1;
			
			if($(this).is(":checked")){
				$("#userId_"+cnt).attr("name","insertList["+index+"].userId");
				$("#userNm_"+cnt).attr("name","insertList["+index+"].userNm");
			}else{
				$("#userId_"+cnt).attr("name","");
				$("#userNm_"+cnt).attr("name","");
			}
			
		});
	});
	
	function fn_allCheckValue(checked){
		if(checked){			
			$('input:checkbox[id="addCheck"]').each(function(){
				var cnt = $(this).val();
				$("#userId_"+cnt).attr("name","insertList["+cnt+"].userId");
				$("#userNm_"+cnt).attr("name","insertList["+cnt+"].userNm");
			});		
		}else{
			$('input:checkbox[id="addCheck"]').each(function(){
				var cnt = $(this).val();
				$("#userId_"+cnt).attr("name","");
				$("#userNm_"+cnt).attr("name","");
			});
		}
	}
	
	function fn_addProgrmAuthor(){
		if($('input:checkbox[id="addCheck"]:checked').length == 0){
			alert("관리자를 선택해주세요.");
			return false;
		}
		return true;
	}
	
</script>
</head>
<body>

<h1 class="subHeader topMargin">관리자정보 &gt; 목록</h1>

<div class="clearfix topMargin">
	<div class="floatLeft">
		총 : <c:out value="${paginationInfo.totalRecordCount}"/> 명
	</div>
	<div class="floatRight">
<form:form modelAttribute="progrmAuthor" name="progrmAuthor" method="get" action="./popupAdminSearchView.do">
	<form:hidden path="progrmNo"/>
	<form:label path="searchKrwd">아이디/이름</form:label>
	<form:input path="searchKrwd"/>
		<span class="button black"><input type="submit" value="검색"/></span>
</form:form>
	</div>
</div>

<table>
<colgroup>
	<col class="specWidth40px"/>
	<col class="specWidth80px"/>
	<col/>
	<col class="specWidth80px"/>
</colgroup>
<thead>
	<tr>
		<th scope="col">번호</th>
		<th scope="col">아이디</th>
		<th scope="col">이름</th>
		<th scope="col">등록</th>
	</tr>
</thead>
<tbody>
<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
<c:forEach var="result" items="${userInfoList}" varStatus="status">
	<tr>
		<td class="textARight"><c:out value="${currentPageStartNo}"/></td>
		<td class="textACenter"><c:out value="${result.userId}"/></td>
		<td><c:out value="${result.userNm}"/></td>
		<td class="textACenter"><a href="./insertProgrmAuthor.do?progrmNo=<c:out value="${progrmAuthor.progrmNo}"/>&userId=<c:out value="${result.userId}"/>&amp;userNm=<c:out value="${result.userNm}"/>" class="iconTextButton write"><span>등록</span></a></td>
	</tr>
	<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
</c:forEach>
<c:if test="${fn:length(userInfoList) == 0}">
	<tr>
		<td colspan="4">검색된 회원정보가 없습니다.</td>
	</tr>
</c:if>
</tbody>
</table>

<div>
		<ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./popupAdminSearchView.do?progrmNo=${tsu:xssLinkFilter(progrmAuthor.progrmNo)}&amp;pageUnit=${tsu:xssLinkFilter(siteMngrVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(siteMngrVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(siteMngrVO.searchKrwd)}&amp;pageIndex=" />
</div>

</body>
</html>