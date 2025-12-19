<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script nonce="NEOCMSSCRIPT">
	$(document).ready(function() {
		fn_jsonlwprtDeptList('<c:out value="${dept.upperDeptCode}"/>');
		alert("부서를 삭제하였습니다.");
	});
</script>