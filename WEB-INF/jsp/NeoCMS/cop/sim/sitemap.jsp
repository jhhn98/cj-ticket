<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>

<div class="sitemap">
    <div class="sitemap_col col3 clearfix">
<c:forEach var="fmenu" items="${firstMenuList}" varStatus="idx">
        <div class="sitemap_box">
			<h3><a href="<c:out value="${fmenu.menuUrl}"/>" target="<c:out value="${fmenu.linkTrget}"/>"><c:out value="${fmenu.menuNm}"/></a></h3>
	<c:if test="${fmenu.lwprtMenuCo > 0}">
		<ul class="sm2depth">
		<c:forEach var="smenu" items="${secondMenuList}">
			<c:if test="${fmenu.menuNo eq smenu.upperMenuNo}">
				<li><a href="<c:out value="${smenu.menuUrl}"/>" target="<c:out value="${smenu.linkTrget}"/>"><c:out value="${smenu.menuNm}"/></a>
				<c:if test="${smenu.lwprtMenuCo > 0}">
					<ul class="sm3depth">
					<c:forEach var="tmenu" items="${thirdMenuList}">
						<c:if test="${smenu.menuNo eq tmenu.upperMenuNo}">
							<li><a href="<c:out value="${tmenu.menuUrl}"/>" target="<c:out value="${tmenu.linkTrget}"/>"><c:out value="${tmenu.menuNm}"/></a></li>
						</c:if>
					</c:forEach>
					</ul>
				</c:if>
				</li>
			</c:if>
		</c:forEach>		
		</ul>
	</c:if>
		</div>

	<c:if test="${(idx.index+1) % 3 eq 0}">
		<%= "</div>" %>
		<%= "<div class=\"sitemap_col col3 clearfix\">" %>
	</c:if>

</c:forEach>
    </div>
</div>


</body>
</html>