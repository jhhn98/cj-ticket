<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>사이트 배치관리</title>
	<meta name="decorator" content="neo" />
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_site">사이트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">배치관리</span>
</div>

<jsp:include page="../sii/subMenu.jsp" />

<div class="contents">

	<div class="table_fixed_wrap is_topBottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">

				<table>
					<colgroup>
						<col class="specWidth40px"/>
						<col class="specWidth160px"/>
						<col class="specWidth80px"/>
						<col class="specWidth300px"/>
						<col/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">배치명</th>
						<th scope="col">배치실행</th>
						<th scope="col">저장소 경로</th>
						<th scope="col">배치 설명</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td class="textARight">1</td>
						<td class="textACenter">메인 레이아웃</td>
						<td class="textACenter"><a href="/neo/batchMainLayout.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="iconTextButton small set"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue"><c:out value="${siteInfo.siteId}"/></span>/<span class="em_red">main</span>.jsp</td>
						<td>메인페이지 레이아웃 배치</td>
					</tr>
					<tr>
						<td class="textARight">2</td>
						<td class="textACenter">서브 레이아웃</td>
						<td class="textACenter"><a href="/neo/batchSubLayout.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="iconTextButton small set"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue"><c:out value="${siteInfo.siteId}"/></span>/<span class="em_red">sub</span>.jsp</td>
						<td>서브페이지 레이아웃 배치</td>
					</tr>
					<tr>
						<td class="textARight">3</td>
						<td class="textACenter">상단메뉴</td>
						<td class="textACenter"><a href="/neo/batchTopMenu.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="iconTextButton small set"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue"><c:out value="${siteInfo.siteId}"/></span>/menu/<span class="em_red">top</span>.jsp</td>
						<td>메인/서브 레이아웃의 상단메뉴에 사용되는 메뉴 배치</td>
					</tr>
					<tr>
						<td class="textARight">4</td>
						<td class="textACenter">왼쪽메뉴</td>
						<td class="textACenter"><a href="/neo/batchLeftMenu.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="iconTextButton small set"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue"><c:out value="${siteInfo.siteId}"/></span>/menu/left<span class="em_red">[menuNo]</span>.jsp</td>
						<td>서브 레이아웃의 왼쪽메뉴에 사용되는 메뉴 배치</td>
					</tr>
					<tr>
						<td class="textARight">5</td>
						<td class="textACenter">메뉴정보</td>
						<td class="textACenter"><a href="/neo/batchMenuInfo.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="iconTextButton small set"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue"><c:out value="${siteInfo.siteId}"/></span>/menu/<span class="em_red">[menuNo]</span>.json</td>
						<td>각 메뉴의 정보를 개별 파일로 배치</td>
					</tr>
				<%/*
					<tr>
						<td class="textARight">6</td>
						<td class="textACenter">평가결과</td>
						<td class="textACenter"><a href="/neo/batchEval.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="iconTextButton small set"><span>배치</span></a></td>
						<td class="eng_text">/repository/<span class="em_blue"><c:out value="${siteInfo.siteId}"/></span>/eval/<span class="em_red">[menuNo]</span>.json</td>
						<td>서브 레이아웃의 만족도평가결과 정보 배치</td>
					</tr>
					<tr>
						<td class="textARight">7</td>
						<td class="textACenter">새평가</td>
						<td class="textACenter"><a onclick="return newEvalStart(this.href)"href="/neo/addContentsEvalAll.do?siteId=<c:out value="${siteInfo.siteId}"/>" class="iconTextButton small set"><span>배치</span></a></td>
						<td class="eng_text"><span class="em_red">메뉴 만족도 평가를 새로 시작할때만 클릭해주세요.</span></td>
						<td>전체 메뉴에 대하여 새평가를 시작</td>
					</tr>
				*/%>
					</tbody>
				</table>
			</div>
		</div>
	</div>


    <div class="arrangementWrap data_button">
        <div class="arrLeft">
        </div>
        <div class="arrRight">
            <a href="./selectSiteInfoList.do?siteSe=<c:out value="${siteInfo.siteSe}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
    </div>
</div>




<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
	function newEvalStart(url){
		if(confirm("정말로 새 평가를 시작 하시겠습니까? 현재사이트 모든 메뉴의 만족도 조사가 초기화됩니다.")){
			location.href = url;
			return true;
		}
		return false;
	}
</script>
</body>
</html>