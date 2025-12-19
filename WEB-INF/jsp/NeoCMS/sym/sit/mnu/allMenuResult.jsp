<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="active_menu" value="MENU_1" scope="request"/>
<!DOCTYPE html>
<html lang="ko">
<head>

	<title>메뉴 일괄 등록</title>
	<meta name="decorator" content="neo" />
	<script src="/neo/js/jquery-3.6.0.min.js"></script>
	<script src="./js/common.js"></script>
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_program">메뉴관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title ">${selectedSite.siteNm}(<em class="em_red">${selectedSite.siteId}</em>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title">메뉴 일괄 업로드</span>
</div>
<div class="contents ">
	<style>
		td{border:1px solid !important;}
		.p-progress{margin:12px 0}
		.p-progress__list{width:100%;display:block}
		.p-progress__list:after{display:block;clear:both}
		.p-progress__item{float:left;display:inline-block;position:relative;border:1px solid #d7d7d7;border-left:none;box-sizing:border-box;box-shadow:0 2px 0 #f0f0f0}
		.p-progress__item:before{display:none}
		.p-progress__item:first-child{border-left:1px solid #e9e9e9;border-top-left-radius:4px;border-bottom-left-radius:4px;overflow:hidden}
		.p-progress__item:first-child.active{overflow:visible}
		.p-progress__item:last-child{border-top-right-radius:4px;border-bottom-right-radius:4px;overflow:hidden}
		.p-progress__item.active{border-color:#02a0dc}
		.p-progress__item.active .p-progress__link{background:#02a0dc;color:#fff}
		.p-progress__item.active .p-progress__link:after{display:block;position:absolute;right:-9px;top:0;width:0;height:0;border-top:22px solid transparent;border-left:8px solid #02a0dc;border-bottom:20px solid transparent;z-index:10}
		.p-progress__item.passing .p-progress__link{background:#f0f0f0;background:linear-gradient(to bottom,#fff 0,#e1e1e1 50%)}
		.p-progress__link{display:block;text-align:center;background:#f0f0f0;background:linear-gradient(to bottom,#fff 0,#f0f0f0 100%);padding:9px 0;text-decoration:none}
		.p-progress .item1 .p-progress__item{width:100%}
		.p-progress .item2 .p-progress__item{width:50%}
		.p-progress .item3 .p-progress__item{width:33.33333%}
		.p-progress .item4 .p-progress__item{width:25%}
		.p-progress .item5 .p-progress__item{width:20%}
		.p-progress .item6 .p-progress__item{width:16.66667%}
		.p-progress .item7 .p-progress__item{width:14.28571%}
		.p-progress .item8 .p-progress__item{width:12.5%}
		.p-progress .item9 .p-progress__item{width:11.11111%}
		.p-progress .item10 .p-progress__item{width:10%}
		.p-progress--ellipse .p-progress__list{width:auto;margin-right:-30px;margin-left:-30px}
		.p-progress--ellipse .p-progress__item{position:relative;box-sizing:border-box;padding-right:30px;padding-left:30px;border:none;box-shadow:none}
		.p-progress--ellipse .p-progress__item:not(:first-child):after{display:block;position:absolute;left:0;top:8px;z-index:10;transform:translateX(-50%)}
		.p-progress--ellipse .p-progress__item:last-child{overflow:inherit}
		.p-progress--ellipse .p-progress__link{display:block;border:1px solid #d7d7d7;background:#f0f0f0;background:linear-gradient(to bottom,#fff 0,#f0f0f0 100%);padding:6px 0 8px;text-align:center;text-decoration:none;border-radius:20px}
		.p-progress--ellipse .p-progress__link:after{display:none}
		.p-progress--ellipse .active .p-progress__link{background:#02a0dc;border:1px solid #02a0dc;color:#fff}
		.p-progress--ellipse .passing .p-progress__link{background:#0f3c82;border:1px solid #0f3c82;color:#fff}
	</style>

	<div class="p-progress p-progress--ellipse">
		<ol class="p-progress__list item3">
			<li class="p-progress__item  "><span class="p-progress__link">1. 메뉴 엑셀파일 선택</span></li>
			<li class="p-progress__item "><span class="p-progress__link">2. 메뉴 미리보기</span></li>
			<li class="p-progress__item active"><span class="p-progress__link">3. 등록완료</span></li>
		</ol>
	</div>
	<div class="table_fixed_wrap is_topBottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view" >
				<table>
					<colgroup>
						<col class="specWidth80px"/>
						<col class="specWidth80px"/>
						<col class="specWidth30px"/>
						<col class="specWidth30px"/>
						<col class="specWidth30px"/>
						<col class="specWidth30px"/>
						<col/>
						<col class="specWidth50px"/>
						<col class="specWidth300px"/>
						<col class="specWidth50px"/>
						<col class="specWidth50px"/>
						<col class="specWidth80px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">상위번호</th>
						<th scope="col">1차메뉴</th>
						<th scope="col">2차메뉴</th>
						<th scope="col">3차메뉴</th>
						<th scope="col">4차메뉴</th>
						<th scope="col">5차메뉴</th>
						<th scope="col">구분</th>
						<th scope="col">기존URL</th>
						<th scope="col">상단표시</th>
						<th scope="col">탭메뉴</th>
						<th scope="col">탭메뉴 유형</th>
					</tr>
					</thead>
					<tr style="height: 0px !important;line-height: 0px !important;">
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
						<td style="height: 0px;padding:0 10px;margin:0;" ></td>
					</tr>
					<c:forEach var="result" items="${menuParseList}">

						<tr>
							<td class="textACenter">${result.menuNo}</td>
							<td class="textACenter">${result.upperMenuNo}</td>
							<c:choose>
								<c:when test="${not empty result.menuNm5}">
									<td>${result.menuNm1}</td>
									<td>${result.menuNm2}</td>
									<td>${result.menuNm3}</td>
									<td>${result.menuNm4}</td>
									<td>${result.menuNm5}</td>
								</c:when>
								<c:when test="${not empty result.menuNm4}">
									<td>${result.menuNm1}</td>
									<td>${result.menuNm2}</td>
									<td>${result.menuNm3}</td>
									<td colspan="2">${result.menuNm4}</td>
								</c:when>
								<c:when test="${not empty result.menuNm3}">
									<td>${result.menuNm1}</td>
									<td>${result.menuNm2}</td>
									<td colspan="3">${result.menuNm3}</td>
								</c:when>
								<c:when test="${not empty result.menuNm2}">
									<td>${result.menuNm1}</td>
									<td colspan="4">${result.menuNm2}</td>
								</c:when>
								<c:when test="${not empty result.menuNm1}">
									<td colspan="5">${result.menuNm1}</td>
								</c:when>
							</c:choose>

							<td class="textACenter">${result.menuSe}</td>
							<td>${result.legacyUrl}</td>
							<td class="textACenter">${result.upperShowAt}</td>
							<td class="textACenter">${result.tabMenuAt}</td>
							<td class="textACenter">${result.tabMenuTy}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<a href="/neo/addAllMenuView.do" class="iconTextButton list" ><span>돌아가기</span></a>
		</div>
		<div class="arrRight">
		</div>
	</div>
</div>



<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>
</body>
</html>