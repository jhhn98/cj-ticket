<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="active_menu" value="MENU_1" scope="request"/>

<c:set var="menuSiteId" value=""/>
<c:set var="menuMenuNo" value=""/>
<c:if test="${menu.menuNo == 0}">
	<c:set var="menuSiteId" value="${upperMenu.siteId}"/>
	<c:set var="menuMenuNo" value="${upperMenu.menuNo}"/>
</c:if>
<c:if test="${menu.menuNo != 0}">
	<c:set var="menuSiteId" value="${menu.siteId}"/>
	<c:set var="menuMenuNo" value="${menu.menuNo}"/>
</c:if>

<script nonce="NEOCMSSCRIPT">

	function fn_deleteMenu( url ) {
		if(confirm("메뉴를 삭제하시겠습니까?")) {
			moveTreeContents(url);
			return false;
		}
		return false;
	}

</script>

<div class="tab_navigation type2 double_line" id="subMenu">
	<a onclick="moveTreeContents(this.href);return false;" href="./updateMenuView.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menuEdit">메뉴 수정</a>
    <a onclick="moveTreeContents(this.href);return false;" href="./addMenuView.do?siteId=<c:out value="${menuSiteId}"/>&amp;upperMenuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menuAdd">하위메뉴 추가</a>
    <a onclick="moveTreeContents(this.href);return false;" href="./addMultiMenuView.do?siteId=<c:out value="${menuSiteId}"/>&amp;upperMenuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menusAdd">하위메뉴 다중추가</a>
    <a onclick="moveTreeContents(this.href);return false;" href="./sortMenuView.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menuSort">하위메뉴 순서변경</a>
    <a onclick="moveTreeContents(this.href);return false;" href="./updateContentsTextView.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menuContentEdit">콘텐츠 편집</a>
    <a onclick="moveTreeContents(this.href);return false;" href="./updateContentsEditorView.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menuContentEditor">콘텐츠 편집(에디터)</a>
    <a onclick="moveTreeContents(this.href);return false;" href="./selectContentsHistoryList.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menuContentEditHistory">콘텐츠 수정 이력</a>
    <a onclick="moveTreeContents(this.href);return false;" href="./selectContentsHistoryDiff.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menuCompare">수정 이력 버전별 비교</a>
    <a onclick="moveTreeContents(this.href);return false;" href="./selectContentsEvalList.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menuEvaluation">만족도 평가</a>
    <%-- <a onclick="fn_deleteMenu(this.href); return false;" href="./deleteMenu.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>" ><img src="./images/btn_menu_delete.gif"/> 메뉴 삭제</a>
    <a onclick="fn_popWindow(this.href,'menuSearchPop','toolbors=no,scrollbars=no,width=300px,height=300px');  return false;" href="/common/getQRcode.do?key=<c:out value="${menuMenuNo}"/>" ><img src="/common/images/program/p-icon-view.svg#qrcode" width="13" height="15"/> QRCode</a> --%>
    <a onclick="moveTreeContents(this.href);return false;" href="./contentsFileList.do?menuNo=<c:out value="${menuMenuNo}"/>" class="tabIcon menuFile">콘텐츠 파일관리</a>
<%--		<li><a href="./updateMenuView.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>"><img src="./images/btn_menu_modify.gif"/> 메뉴 수정</a></li>--%>
<%--		<li><a href="./addMenuView.do?siteId=<c:out value="${menuSiteId}"/>&amp;upperMenuNo=<c:out value="${menuMenuNo}"/>"><img src="./images/btn_menu_add.gif"/> 하위메뉴 추가</a></li>--%>
<%--		<li><a href="./addMultiMenuView.do?siteId=<c:out value="${menuSiteId}"/>&amp;upperMenuNo=<c:out value="${menuMenuNo}"/>"><img src="./images/btn_menu_add.gif"/> 하위메뉴 다중추가</a></li>--%>
<%--		<li><a href="./sortMenuView.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>"><img src="./images/btn_menu_sort.gif"/> 하위메뉴 순서변경</a></li>--%>
<%--		<li><a href="./updateContentsTextView.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>"><img src="./images/btn_menu_editor_text.gif"/> 콘텐츠 편집</a></li>--%>
<%--		<li><a href="./updateContentsEditorView.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>"><img src="./images/btn_menu_editor_text.gif"/> 콘텐츠 편집(에디터)</a></li>--%>
<%--		<li><a href="./selectContentsHistoryList.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>"><img src="./images/btn_menu_history.gif"/> 콘텐츠 수정 이력</a></li>--%>
<%--		<li><a href="./selectContentsHistoryDiff.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>"><img src="./images/enum.gif"/> 수정 이력 버전별 비교</a></li>--%>
<%--		<li><a href="./selectContentsEvalList.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>"><img src="<c:url value="/neo/images/btn_menu_check.gif"/>"/> 만족도 평가</a></li>--%>
<%--		<li><a href="./deleteMenu.do?siteId=<c:out value="${menuSiteId}"/>&amp;menuNo=<c:out value="${menuMenuNo}"/>" onclick="fn_deleteMenu(this.href); return false;"><img src="./images/btn_menu_delete.gif"/> 메뉴 삭제</a></li>--%>
<%--		<li><a href="/common/getQRcode.do?key=<c:out value="${menuMenuNo}"/>" onclick="fn_popWindow(this.href,'menuSearchPop','toolbors=no,scrollbars=no,width=300px,height=300px');  return false;"><img src="/common/images/program/p-icon-view.svg#qrcode" width="13" height="15"/> QRCode</a></li>--%>
<%--		<li><a href="./contentsFileList.do?menuNo=<c:out value="${menuMenuNo}"/>" ><img src="./images/enum.gif"/> 콘텐츠 파일관리</a></li>--%>
</div>