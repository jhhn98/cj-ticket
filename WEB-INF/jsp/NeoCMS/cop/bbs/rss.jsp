<?xml version='1.0' encoding='UTF-8' ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<rss version="2.0">
<channel>
<title><![CDATA[RSS - <c:out value="${bbsVO.bbsNm}"/>]]></title>
<link><%=request.getScheme()%>://<%=request.getLocalAddr()%>:<%=request.getServerPort()%></link>
<description><![CDATA[RSS - <c:out value="${bbsVO.bbsNm}"/>]]></description>
<c:forEach var="result" items="${bbsNttList}">
	<item>
	<title><![CDATA[ <c:out value="${result.nttSj}"/> ]]></title>
	<link><![CDATA[ <%=request.getScheme()%>://<%=request.getLocalAddr()%>:<%=request.getServerPort()%>/<c:out value="${nttUrlMap['SITE_ID']}"/>/selectBbsNttView.do?key=<c:out value="${nttUrlMap['MENU_NO']}"/>&bbsNo=<c:out value="${bbsVO.bbsNo}"/>&nttNo=<c:out value="${result.nttNo}"/> ]]></link>
	<pubDate><![CDATA[ <c:out value="${result.frstRegisterPnttmYMD}"/> ]]></pubDate>
	<department><![CDATA[ <c:out value="${result.deptNm}"/> ]]></department>
	<description><![CDATA[ <c:out value="${result.nttCn}"/>]]></description>
	</item>
</c:forEach>
</channel>
</rss>