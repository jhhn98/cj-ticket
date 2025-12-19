<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div style="text-align:center;">
<div style="display:inline-block; width:300px; margin-top:140px; border:solid 2px #9BC3DD; padding:20px; background-color:#EEE; text-align:center; font-weight:bold; color:red;">

	메뉴를 삭제하였습니다.

</div>
</div>

<script nonce="NEOCMSSCRIPT">
	//parent.neo_menu.fn_jsonlwprtMenuList(<c:out value="${menu.upperMenuNo}"/>);
	fn_jsonlwprtMenuList(<c:out value="${menu.upperMenuNo}"/>);
</script>

</body>
</html>