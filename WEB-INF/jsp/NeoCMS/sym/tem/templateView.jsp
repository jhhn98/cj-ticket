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

	<title>템플릿 상세정보</title>
	<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_template">템플릿설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">상세정보</span>
</div>

<div class="contents">

	<div class="table_fixed_wrap is_bottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth40px"/>
						<col class="specWidth120px"/>
						<col class="specWidth120px"/>
						<col class="specWidth100px"/>
						<col/>
						<col class="specWidth80px"/>
						<col class="specWidth80px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">메인디자인</th>
						<th scope="col">서브디자인</th>
						<th scope="col">템플릿ID</th>
						<th scope="col">템플릿이름</th>
						<th scope="col">항목보기</th>
						<th scope="col">수정</th>
					</tr>
					</thead>
					<tbody>
					<c:set var="templateNo" value="1" />
					<c:forEach var="result" items="${templateList}" varStatus="status">
						<tr>
							<td class="textARight"><c:out value="${templateNo}"/></td><%--
			<td class="textACenter"><img src="<c:out value="${result.tmplatLayoutStorePath}"/>/main.jpg" width="100px" height="100px" style="border:solid 1px #AAA; padding:2px"/></td>
			<td class="textACenter"><img src="<c:out value="${result.tmplatLayoutStorePath}"/>/sub.jpg" width="100px" height="100px" style="border:solid 1px #AAA; padding:2px"/></td>--%>
							<td class="textACenter"><c:out value="${result.tmplatId}"/></td>
							<td><c:out value="${result.tmplatNm}"/></td>
							<td class="textACenter"><a href="" class="iconTextButton small edit"><span>항목보기</span></a></td>
							<td class="textACenter"><a href="./updateTemplateView.do?tmplatId=<c:out value="${result.tmplatId}"/>" class="iconTextButton small edit"><span>수정</span></a></td>
						</tr>
						<c:set var="templateNo" value="${templateNo+1}" />
					</c:forEach>
					<c:if test="${fn:length(templateList) == 0}">
						<tr>
							<td colspan="7">등록된 템플릿이 없습니다.</td>
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
</body>
</html>