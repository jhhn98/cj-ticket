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
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_program">메뉴관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title ">${selectedSite.siteNm}(<em class="em_red">${selectedSite.siteId}</em>)</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth3_title">메뉴 일괄 업로드</span>
</div>
<div class="contents">
	<form name="uploadMenuFileForm" id="uploadMenuFileForm" method="post" action="./addAllMenuPreview.do" enctype="multipart/form-data">
		<input type="hidden" name="siteId"   value="${selectedSite.siteId}"/>
        <ol class="programFlow element_count3">
            <li class="current"><span class="step_text step1">STEP<span>01</span></span><p class="flow_text">메뉴 엑셀파일 선택</p></li>
            <li><span class="step_text step2">STEP<span>02</span></span><p class="flow_text">메뉴 미리보기</p></li>
            <li><span class="step_text step3">STEP<span>03</span></span><p class="flow_text">등록완료</p></li>
        </ol>
        <div class="info_box_text">
            <div class="text_wrap">
                <ul class="ul">
                    <li>선택한 엑셀 파일로부터 메뉴 업로드를 진행합니다.</li>
                    <li>업로드를 진행하면 기존에 있던 메뉴를 전체 삭제한 후 다시 업로드합니다.</li>
                    <li>메뉴번호도 다시 채번되니 사용에 주의바랍니다.</li>
                    <li>전송클릭시 엑셀파일 미리보기 페이지로 이동됩니다.</li>
                </ul>
                <div class="textARight">
                    <a href="/neo/sample_menu_upload.xlsx" class="iconTextButton download">엑셀 업로드 샘플 다운로드</a>
                </div>
            </div>
        </div>
        <ul class="data_form_list">
            <li>
                <div class="list_element">
                    <div class="element el_title">
                        <strong>${selectedSite.siteNm}(<em class="em_red">${selectedSite.siteId}</em>)</strong>
                    </div>
                    <div class="element el_text">
                        <input type="file" name="menuFile"/>
                        <select name="sheetNo">
                            <option value="1">1번 시트</option>
                            <option value="2">2번 시트</option>
                            <option value="3">3번 시트</option>
                            <option value="4">4번 시트</option>
                            <option value="5">5번 시트</option>
                            <option value="6">6번 시트</option>
                            <option value="7">7번 시트</option>
                            <option value="8">8번 시트</option>
                            <option value="9">9번 시트</option>
                            <option value="10">10번 시트</option>
                        </select>
                        <button type="button" onclick="xlsUpload()" class="iconTextButton file_upload small"><span>전송</span></button>
                    </div>
                </div>
            </li>
        </ul>
	</form>
</div>
<script nonce="NEOCMSSCRIPT">
	function xlsUpload(){
		if(confirm("기존 메뉴가 삭제되고 새로 업로드됩니다. 정말로 메뉴 일괄 업로드를 진행하시겠습니까?")){
			$("#uploadMenuFileForm").submit();
		}
	}
</script>
</body>
</html>