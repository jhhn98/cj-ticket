<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="paramDeptCode" value=""/>
<c:choose>
	<c:when test="${department.deptCode eq '' or department.deptCode eq null}">
		<c:set var="paramDeptCode" value="${department.upperDeptCode}"/>
	</c:when>
	<c:otherwise>
		<c:set var="paramDeptCode" value="${department.deptCode}"/>
	</c:otherwise>
</c:choose>
<script nonce="NEOCMSSCRIPT">
	function fn_deleteDepartment( url ) {
		if(confirm("하위부서 및 직원 정보도 삭제 됩니다.\n부서를 삭제하시겠습니까?")) {
			moveTreeContents(url);
			return false;
			//window.location = url;
		}
		return false;
	}
</script>
<div class="tab_navigation type2 department">
    <a onclick="moveTreeContents(this.href);return false;" href="./updateDepartmentView.do?deptCode=<c:out value="${paramDeptCode}"/>" class="tabIcon deptEdit"><span>부서정보 수정</span></a>
    <a onclick="moveTreeContents(this.href);return false;" href="./addDepartmentView.do?upperDeptCode=<c:out value="${paramDeptCode}"/>" class="tabIcon deptAdd"><span>하위부서 등록</span></a>
    <a onclick="moveTreeContents(this.href);return false;" href="./sortDepartmentView.do?upperDeptCode=<c:out value="${paramDeptCode}"/>" class="tabIcon deptOrder"><span>하위부서 순서변경</span></a>
    <a href="./deleteDepartment.do?deptCode=<c:out value="${paramDeptCode}"/>" onclick="fn_deleteDepartment(this.href); return false;" class="tabIcon deptDel"><span>부서 삭제</span></a>
</div>