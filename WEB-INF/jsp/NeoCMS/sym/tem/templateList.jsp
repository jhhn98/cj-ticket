<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="TMP_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

<title>템플릿 목록</title>
<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_template">템플릿설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">목록</span>
</div>

<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">템플릿 수 : ${templateCnt}건</span>
		</div>

		<div class="arrRight">
		</div>
	</div>


	<div class="table_fixed_wrap is_topBottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth40px"/>
				<%--		<col class="specWidth120px"/>--%>
				<%--		<col class="specWidth120px"/>--%>
						<col class="specWidth100px"/>
						<col/>
						<col class="specWidth400px"/>
						<col class="specWidth120px"/>
						<col class="specWidth80px"/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
						<col class="specWidth60px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
				<%--		<th scope="col">메인디자인</th>--%>
				<%--		<th scope="col">서브디자인</th>--%>
						<th scope="col">템플릿ID</th>
						<th scope="col">템플릿이름</th>
						<th scope="col">사용사이트</th>
						<th scope="col">사이트일괄배치</th>
						<th scope="col">FTL수정</th>
						<th scope="col">수정</th>
						<th scope="col">복사</th>
						<th scope="col">삭제</th>
					</tr>
					</thead>
					<tbody class="textACenter">
					<c:set var="templateNo" value="1" />
					<c:forEach var="result" items="${templateList}" varStatus="status">
					<tr data-display="true">
						<td class="textARight"><c:out value="${templateNo}"/></td>
				<%--		<td class="textACenter"><img src="/template/<c:out value="${result.tmplatId}"/>/layout/main.jpg" width="100px" height="100px" style="border:solid 1px #AAA; padding:2px"/></td>--%>
				<%--		<td class="textACenter"><img src="/template/<c:out value="${result.tmplatId}"/>/layout/sub.jpg" width="100px" height="100px" style="border:solid 1px #AAA; padding:2px"/></td>--%>
						<td class="textACenter"><c:out value="${result.tmplatId}"/></td>
						<td><a href="./selectTemplateItemList.do?tmplatId=<c:out value="${result.tmplatId}"/>" class="iconTextLink info"><c:out value="${result.tmplatNm}"/></a></td>
						<td class="textACenter">
							<c:set var="hasUseSite" value="0"/>
							<c:forEach items="${templateSiteList}" var="site">
								<c:if test="${site.tmplatId eq result.tmplatId}">
									<c:set var="hasUseSite" value="${hasUseSite + 1}"/>
									<c:out value="${site.siteNm}"/>(<c:out value="${site.siteId}"/>)<br />
								</c:if>
							</c:forEach>
						</td>
						<td class="textACenter">
							<c:if test="${hasUseSite > 0}"><a href="./selectTemplateBatchAllList.do?tmplatId=<c:out value="${result.tmplatId}"/>" class="iconTextButton small batch"><span>사이트일괄배치</span></a></c:if>
						</td>
						<td class="textACenter"><a href="./updateTemplateEditorView.do?templateId=<c:out value="${result.tmplatId}"/>&ftl" class="iconTextButton edit small"><span>FTL수정</span></a></td>
						<td class="textACenter"><a href="./updateTemplateView.do?tmplatId=<c:out value="${result.tmplatId}"/>" class="iconTextButton edit small"><span>수정</span></a></td>
						<td class="textACenter"><a href="./copyTemplateView.do?tmplatId=<c:out value="${result.tmplatId}"/>" class="iconTextButton copy small"><span>복사</span></a></td>
						<td class="textACenter">
							<c:if test="${hasUseSite == 0}">
								<a onclick = "return deleteTemplate(this.href)" href="./deleteTemplate.do?tmplatId=<c:out value="${result.tmplatId}"/>" class="iconTextButton delete small"><span>삭제</span></a>
							</c:if>
						</td>
					</tr>

						<c:set var="templateNo" value="${templateNo+1}" />
					</c:forEach>
					<c:if test="${fn:length(templateList) == 0}">
					<tr>
						<td colspan="6">등록된 템플릿이 없습니다.</td>
					</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>


	<div class="arrangementWrap data_button">
		<div class="arrLeft">
		</div>
		<div class="arrRight">
			<a href="./addTemplateView.do" class="iconTextButton write"><span>등록</span></a>
		</div>
	</div>
</div>

<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
	function deleteTemplate(src){
		if(confirm("실제 템플릿 폴더가 삭제됩니다. 정말로 삭제하시겠습니까?")){
			location.href = src;
			return true;
		}
		return false;
	}
</script>
</body>
</html>
