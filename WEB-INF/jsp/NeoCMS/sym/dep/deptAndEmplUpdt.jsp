<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="DEPT_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="neo" />
	<script src="/neo/js/jquery-3.6.0.min.js"></script>
	<script src="./js/common.js"></script>
	<script nonce="NEOCMSSCRIPT">
		function mSelectChange() {
			document.pbhlthStoreVOForm.submit();
		}
	</script>
</head>
<body>
<div class="contents">

	<h1 class="subHeader">부서 및 직원정보 업데이트</h1>

	<h2>부서정보 업데이트</h2>
	부서정보 일괄 업데이트를 위한 엑셀파일을 업로드 해주십시오.
	<table class="table_t1" width="100%">
		<colgroup>
			<col width="140"/>
			<col />
		</colgroup>
		<tbody>
		<tr>
			<th>서식 예제다운로드</th>
			<td><a href="/neo/dept.xlsx" class="iconTextButton small download"><span>서식 다운로드</span></a></td>
		</tr>
		<tr>
			<th>부서정보 업로드</th>
			<td>
				<form enctype="multipart/form-data" action="/neo/updateDepartmentAllByExcel.do" method="post">
					<input type="file" name="file"/>
					<button type="submit" class="iconTextButton file_upload small" style="padding: 5px 5px;"><span>엑셀 업로드</span></button>

				</form>
			</td>
		</tr>
		</tbody>
	</table>
	<br />

	<h2>직원정보 업데이트</h2>
	직원정보 일괄 업데이트를 위한 엑셀파일을 업로드 해주십시오.
	<table class="table_t1" width="100%">
		<colgroup>
			<col width="140"/>
			<col />
		</colgroup>
		<tbody>
		<tr>
			<th>서식 예제다운로드</th>
			<td><a href="/neo/empl.xlsx" class="iconTextButton small download">서식 다운로드</a></td>
		</tr>
		<tr>
			<th>직원정보 업로드</th>
			<td>
				<form enctype="multipart/form-data" action="/neo/updateEmployeeAllByExcel.do" method="post">
					<input type="file" name="file"/>
					<button type="submit" class="iconTextButton file_upload small" style="padding: 5px 5px;"><span>엑셀 업로드</span></button>
				</form>
			</td>
		</tr>
		</tbody>
	</table>
	<div align="center" class="marginTop_30">
		<div class="topMargin" style="width:600px; border:solid 2px #CCC; padding:10px">
			<p><strong>부서 및 직원정보를 업데이트 합니다.</strong></p>
			<p>일괄 업데이트 시 기존 담당자 정보 및 권한정보가 변경되거나 삭제되오니 신중하게 작업해 주십시오.</p>
			<p><span style="color:red">부서 및 직원 업데이트 버튼을 여러번 클릭하지 말고 기다려 주시기 바랍니다.</span></p>
		</div>
	</div>

</div>
</body>
</html>