<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="tab_navigation type2">
    <a href="./updateDepartmentView.do?deptCode=<c:out value="${paramDeptCode}"/>"><span>기간별 접속로그</span></a>
    <a href="./addDepartmentView.do?upperDeptCode=<c:out value="${paramDeptCode}"/>"><span>운영체제별 접속로그</span></a>
    <a href="./sortDepartmentView.do?upperDeptCode=<c:out value="${paramDeptCode}"/>"><span>브라우저별 접속로그</span></a>
    <a href="./deleteDepartment.do?deptCode=<c:out value="${paramDeptCode}"/>"><span>메뉴별 접속로그</span></a>
</div>
