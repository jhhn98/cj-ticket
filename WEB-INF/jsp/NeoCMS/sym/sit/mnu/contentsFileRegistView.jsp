<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<%--
ajax 멀티 업로드 사용으로 변경. 해당 파일 사용 안함.
-- 2020.07.17  연구소  박경덕

<h1 class="subHeader">컨텐츠 첨부파일 관리 &gt;목록</h1>
<form:form action="contentsFileRegist.do" enctype="multipart/form-data" modelAttribute="menu" onsubmit="fn_ajax_submit(this.id);return false;">
    <form:hidden path="menuNo"/>
	<table>
	    <colgroup>
	        <col class="specWidth100px"/>
	        <col/>
	    </colgroup>
	    <c:forEach var="index" begin="0" end="10">
		    <tr>
		        <th>파일</th>
		        <td><input type="file" name="atchmnfl"/></td>
		    </tr>
	    </c:forEach>
	</table>
	

	<div class="clearfix topMargin">
		<div class="floatLeft">
			<a onclick="moveTreeContents(this.href);return false;" href="./contentsFileList.do?menuNo=<c:out value="${menu.menuNo}"/>" class="button"><span>목록</span></a>
			<a onclick="moveTreeContents(this.href);return false;" href="./contentsMultiFileRegistView.do?menuNo=<c:out value="${menu.menuNo}"/>" class="button"><span>간편업로드 페이지로</span></a>
		</div>
	    <div class="floatRight">
	        <span class="button blue"><input type="submit" value="등록" /></span>
	    </div>
	</div>
</form:form>
--%>
