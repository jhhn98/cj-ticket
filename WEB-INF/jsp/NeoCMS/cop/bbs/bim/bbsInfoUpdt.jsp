<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 정보 수정</title>
<meta name="decorator" content="neo" />
<script src="/neo/js/jquery-3.6.0.min.js"></script>
<script src="/neo/js/common.js"></script>
<script nonce="NEOCMSSCRIPT">
    <c:if test="${!empty message}">
    function fn_check_message() {
        alert("<c:out value='${message}'/>");
        <c:if test="${!empty fieldName}">
        $("#<c:out value="${fieldName}"/>").focus();
        </c:if>
    }
    $(window).on("load", function() {
        fn_check_message();
    });
    </c:if>
    function fn_validateBbsInfoVO( frm ) {
        return true;
    }
</script>
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_board">게시판관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">게시판설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/> 설정관리</span>
</div>
<div class="tab_navigation">
	<a href="./updateBbsInfoView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=" current"><span>설정관리</span></a>
	<a href="./updateBbsFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>필드관리</span></a>
	<a href="./updateBbsFieldListSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>목록 순서 변경</span></a>
	<a href="./updateBbsFieldInputSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>입력/보기 순서 변경</span></a>
	<a href="./selectBbsCategoryList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>카테고리관리</span></a>
	<a href="./updateBbsDescriptionView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>설명관리</span></a>
	<a href="./selectBbsAuthorList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>권한관리</span></a>
	<a href="./updateBbsAtchFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>첨부파일필드 관리</span></a>
    <a href="./updateBbsBanView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" ><span>악성사용자 차단</span></a>
</div>
<div class="dataWrap is_tab">
    <form:form modelAttribute="bbsInfoVO" name="bbsInfoVOForm" action="updateBbsInfo.do" onsubmit="return fn_validateBbsInfoVO(this)">
        <input type="hidden" name="siteId" id="siteId" value="<c:out value="${bbsVO.siteId}"/>"/>
        <input type="hidden" name="pageUnit" value="<c:out value="${bbsInfoVO.pageUnit}"/>"/>
        <input type="hidden" name="searchCnd" value="<c:out value="${bbsInfoVO.searchCnd}"/>"/>
        <input type="hidden" name="searchKrwd" value="<c:out value="${bbsInfoVO.searchKrwd}"/>"/>
        <input type="hidden" name="pageIndex" value="<c:out value="${bbsInfoVO.pageIndex}"/>"/>
        <form:hidden path="bbsNo"/>
        <div class="form_wrap isBottom">
            <table class="settingFormTable">
                <colgroup>
                    <col class="specWidth15per"/>
                    <col class="specWidth35per"/>
                    <col class="specWidth15per"/>
                    <col class="specWidth35per"/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">게시판명</th>
                    <td><c:out value="${bbsVO.bbsNm}"/></td>
                    <th scope="row">등록일</th>
                    <td><c:out value="${bbsVO.frstRegisterPnttmYMD}"/></td>
                </tr>
                <tr>
                    <th scope="row">사이트명</th>
                    <td><c:out value="${bbsVO.siteNm}"/></td>
                    <th scope="row">스킨명</th>
                    <td><c:out value="${bbsVO.skinNm}"/></td>
                </tr>
                <tr>
                    <th scope="row">페이징</th>
                    <td>
                        <form:label path="listCo">목록수</form:label>
                        <form:select path="listCo" cssClass="marginLeft_5">
                            <c:forEach begin="1" end="50" varStatus="idx" step="1">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>
                        <form:label path="pageCo" cssClass="marginLeft_15">페이지수</form:label>
                        <form:select path="pageCo" cssClass="marginLeft_5">
                            <c:forEach begin="5" end="50" varStatus="idx" step="5">
                                <form:option value="${idx.index}" label="${idx.index}" />
                            </c:forEach>
                        </form:select>
                    </td>
                    <th scope="row">최근 게시물 표시</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.newIconShowAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="newIconShowAt" <c:out value="${bbsInfoVO.newIconShowAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="newIconShowAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.newIconShowAt}"/>"/>
                            <label for="newIconShowAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                            <form:errors path="newIconShowAt"/>
                        </div>
                        <div class="inlineBlock">
                            <form:label path="newIconCnd">표출 기간</form:label>
                            <form:select path="newIconCnd" cssClass="marginLeft_5">
                                <c:forEach var="opt" items="${newIconCndList}">
                                    <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bbsInfoVO.newIconCnd ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">카테고리</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.ctgryUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="ctgryUseAt" <c:out value="${bbsInfoVO.ctgryUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="ctgryUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.ctgryUseAt}"/>"/>
                            <label for="ctgryUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                            <form:errors path="ctgryUseAt"/>
                        </div>
                        <div class="inlineBlock">
                            <form:label path="ctgryTy">카테고리 타입</form:label>
                            <form:select path="ctgryTy" cssClass="marginLeft_5">
                                <c:forEach var="opt" items="${ctgryTyList}">
                                    <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bbsInfoVO.ctgryTy ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </td>
                    <th scope="row">이슈 게시물 표시</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.coolIconShowAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="coolIconShowAt" <c:out value="${bbsInfoVO.coolIconShowAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="coolIconShowAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.coolIconShowAt}"/>"/>
                            <label for="coolIconShowAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                            <form:errors path="coolIconCnd"/>
                        </div>
                        <div class="inlineBlock">
                            <form:label path="coolIconCnd">표출 조건(조회수)</form:label>
                            <form:select path="coolIconCnd" cssClass="marginLeft_5">
                                <c:forEach begin="50" end="500" varStatus="idx" step="10">
                                    <form:option value="${idx.index}" label="${idx.index}"/>
                                </c:forEach>
                            </form:select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">게시물 공유</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.snsScrapUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="snsScrapUseAt" <c:out value="${bbsInfoVO.snsScrapUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="snsScrapUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.snsScrapUseAt}"/>"/>
                            <label for="snsScrapUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                            <form:errors path="snsScrapUseAt"/>
                        </div>
                        <div class="inlineBlock">
                            <form:checkbox path="twitterUseAt" value="Y" label="트위터" cssClass="marginRight_5"/>
                            <form:checkbox path="facebookUseAt" value="Y" label="페이스북" cssClass="marginRight_5 marginLeft_15"/>
                        </div>
                    </td>
                    <th scope="row">RSS 피드</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.rssUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="rssUseAt" <c:out value="${bbsInfoVO.rssUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="rssUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.rssUseAt}"/>"/>
                            <label for="rssUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                            <form:errors path="rssUseAt"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">첨부파일</th>
                    <td colspan="3">
                        <form:label path="posblAtchmnflCo">첨부파일 수</form:label>
                        <form:select path="posblAtchmnflCo" cssClass="marginLeft_5">
                            <c:forEach begin="1" end="20" varStatus="idx">
                                <form:option value="${idx.index}" label="${idx.index} 개" />
                            </c:forEach>
                        </form:select>
                        <form:label path="posblAtchmnflSize" cssClass="marginLeft_15">용량</form:label>
                        <form:select path="posblAtchmnflSize" cssClass="marginLeft_5">
                            <c:forEach begin="5" end="100" varStatus="idx" step="5">
                                <form:option value="${idx.index}" label="${idx.index} MB" />
                            </c:forEach>
                        </form:select>
                        <div class="setting_block">
                            <%//<form:input path="posblAtchmnflExtsn" size="60"/>%>
                            <div class="element_block">
                                <form:label path="posblAtchmnflExtsn">확장자</form:label>
                                <a href="#n" class="textButton small delete" onclick="resetChosen()" style="float:right;"><span>확장자 선택 초기화</span></a>
                                <select name="posblAtchmnflExtsn" id="posblAtchmnflExtsn" class="p-input p-input--auto chosen-select" style="width:600px" multiple data-placeholder=" 선택" data-no_results_text="확장자를 선택해주세요." >
                                    <option style="display: none;"></option>
                                    <c:set var="hasImage" value="0"/>
                                    <optgroup label="일반 타입" >
                                        <c:forEach var="mime" items="${mimeTypeList}">
                                            <c:if test="${mime.imgTypeAt eq '0'}">
                                                <c:set var="isChecked" value="false" />
                                                <c:if test="${fn:contains(bbsInfoVO.posblAtchmnflExtsn, mime.mimeTypeExt)}"><c:set var="isChecked" value="true" /></c:if>
                                                <option value="${mime.mimeTypeExt}"  ${isChecked ? "selected='selected'" : ''}>${mime.mimeTypeExt}</option>
                                            </c:if>
                                            <c:if test="${mime.imgTypeAt ne '0'}">
                                                <c:set var="hasImage" value="1"/>
                                            </c:if>
                                        </c:forEach>
                                    </optgroup>

                                    <c:if test="${hasImage eq '1'}">
                                        <optgroup label="이미지 타입" >
                                            <c:forEach var="mime" items="${mimeTypeList}">
                                                <c:if test="${mime.imgTypeAt ne '0'}">
                                                    <c:set var="isChecked" value="false" />
                                                    <c:if test="${fn:contains(bbsInfoVO.posblAtchmnflExtsn, mime.mimeTypeExt)}"><c:set var="isChecked" value="true" /></c:if>
                                                    <option value="${mime.mimeTypeExt}"  ${isChecked ? "selected='selected'" : ''} >${mime.mimeTypeExt}</option>
                                                </c:if>
                                            </c:forEach>
                                        </optgroup>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                        <div class="setting_block">
                            <div class="element_block">
                                <div class="toggle <c:out value="${bbsInfoVO.atchmnflStaticUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                                    <input type="checkbox" id="atchmnflStaticUseAt" <c:out value="${bbsInfoVO.atchmnflStaticUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="atchmnflStaticUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.atchmnflStaticUseAt}"/>"/>
                                    <label for="atchmnflStaticUseAt">
                                        첨부파일 고정필드 사용
                                        <span class="toggle_ui">on/off</span>
                                    </label>
                                    <form:errors path="atchmnflStaticUseAt"/>
                                </div>
                                <p class="info_text">첨부파일 고정필드를 사용하면 상단의 <span class="em_red">[첨부파일필드 관리]</span>에서 지정한 방식<span class="em_red">(예시 : 첨부파일 1번은 이미지 2번은 동영상)</span>으로 확장자와 필드명칭을 지정합니다.</p>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">이미지 첨부파일 설정</th>
                    <td colspan="3">
                        <div class="toggle <c:out value="${bbsInfoVO.imageUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="imageUseAt" <c:out value="${bbsInfoVO.imageUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="imageUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.imageUseAt}"/>"/>
                            <label for="imageUseAt">
                                이미지 사이즈 변환 사용
                                <span class="toggle_ui">on/off</span>
                            </label>
                            <form:errors path="imageUseAt"/>
                        </div>
                        <div class="setting_block element_count_two" style="width:40%;">
                            <div class="element_inlineBlock">
                                <strong class="setting_title">썸네일 사이즈(px)</strong>
                                <div class="share_area two">
                                    <div class="area_element">
                                        <form:label path="thumbSizeWidth">가로</form:label>
                                        <form:input path="thumbSizeWidth" size="1"/>
                                    </div>
                                    <div class="area_element">
                                        <form:label path="thumbSizeHeight">세로</form:label>
                                        <form:input path="thumbSizeHeight" size="1"/>
                                    </div>
                                </div>
                            </div>
                            <div class="element_inlineBlock">
                                <strong class="setting_title">프리뷰 사이즈(px)</strong>
                                <div class="share_area two">
                                    <div class="area_element">
                                        <form:label path="prevewSizeWidth">가로</form:label>
                                        <form:input path="prevewSizeWidth" size="1"/>
                                    </div>
                                    <div class="area_element">
                                        <form:label path="prevewSizeHeight">세로</form:label>
                                        <form:input path="prevewSizeHeight" size="1"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="clsdrUseAt">비공개 게시판</form:label></th>
                    <td>
                        <div class="toggle <c:out value="${bbsInfoVO.clsdrUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="clsdrUseAt" <c:out value="${bbsInfoVO.clsdrUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="clsdrUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.clsdrUseAt}"/>"/>
                            <label for="clsdrUseAt">
                                게시판 비공개 설정
                                <span class="toggle_ui">on/off</span>
                            </label>
                            <form:errors path="clsdrUseAt"/>
                        </div>
                    </td>
                    <th scope="row"><form:label path="listShowSe">목록표시구분 타입</form:label></th>
                    <td>
                        <form:select path="listShowSe">
                            <c:forEach var="opt" items="${listShowSeList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bbsInfoVO.listShowSe ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="reqstPdUseAt">신청 기능</form:label></th>
                    <td colspan="3">
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.reqstPdUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="reqstPdUseAt" <c:out value="${bbsInfoVO.reqstPdUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="reqstPdUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.reqstPdUseAt}"/>"/>
                            <label for="reqstPdUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                            <form:errors path="reqstPdUseAt"/>
                        </div>
                        <div class="marginTop_10" >
                            <p class="info_text">신청기능 사용시 지정된 기간에만 게시글 작성이 가능합니다. 지정기간이 아닐 경우 설정한 신청 메시지가 출력됩니다.</p>
                            <div class="setting_block element_count_three">
                                <div class="element_inlineBlock">
                                    <strong class="setting_title">신청메시지</strong>
                                    <form:input path="reqstPdMssage" class="specWidth240px" placeholder="신청기간 외에 출력될 신청 메시지 입력" title="신청 메시지"/>
                                </div>
                                <div class="element_inlineBlock">
                                    <strong class="setting_title">신청 시작일</strong>
                                    <div>
                                        <form:input path="sdate" placeholder="2020-01-01" size="10" class="specWidth80px"/>
                                        <form:select path="shour">
                                            <c:forEach begin="0" end="23" varStatus="idx">
                                                <form:option value="${idx.index}" label="${idx.index} 시" />
                                            </c:forEach>
                                        </form:select>
                                        <form:select path="sminute">
                                            <c:forEach begin="0" end="59" varStatus="idx">
                                                <form:option value="${idx.index}" label="${idx.index} 분" />
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="element_inlineBlock">
                                    <strong class="setting_title">신청 종료일</strong>
                                    <div>
                                        <form:input path="edate" placeholder="2020-01-01" size="10" class="specWidth80px"/>
                                        <form:select path="ehour">
                                            <c:forEach begin="0" end="23" varStatus="idx">
                                                <form:option value="${idx.index}" label="${idx.index} 시" />
                                            </c:forEach>
                                        </form:select>
                                        <form:select path="eminute">
                                            <c:forEach begin="0" end="59" varStatus="idx">
                                                <form:option value="${idx.index}" label="${idx.index} 분" />
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </div>
                            </div>
                            <div class="setting_block element_count_two" style="width:40%;">
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">답변</th>
                    <td>
                        <form:select path="replySe">
                            <c:forEach var="opt" items="${replySeList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bbsInfoVO.replySe ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>

                        <div class="toggle marginLeft_10 inlineBlock <c:out value="${bbsInfoVO.replyValidateUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="replyValidateUseAt" <c:out value="${bbsInfoVO.replyValidateUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="replyValidateUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.replyValidateUseAt}"/>"/>
                            <label for="replyValidateUseAt">
                                답변글 필수항목체크 사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div class="inlineBlock"></div>
                        <p class="info_text">계층형 답변을 사용 할 경우 게시물 정렬을 [게시물순번][오름차순]으로 지정해야 정상적으로 계층형으로 표시됩니다.</p>
                    </td>
                    <th scope="row">댓글</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.answerUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="answerUseAt" name="answerUseAt" <c:out value="${bbsInfoVO.answerUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.answerUseAt}"/>"/>
                            <label for="answerUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">게시물 상세보기 링크 설정</th>
                    <td colspan="3">
                        <p class="info_text">사용하지 않을 경우 상세보기 링크의 기본값은 게시물 제목의 링크입니다. 사용시 게시물 상세보기 링크는 별도 지정한 대상 필드에 적용됩니다.</p>
                        <div class="marginTop_10"  style="width:50%;">
                            <div class="setting_block">
                                <div class="element_block">
                                    <div class="share_area two">
                                        <div class="area_element">
                                            <form:label path="nttLinkTrgetField">클릭필드명</form:label>
                                            <form:select path="nttLinkTrgetField">
                                                <c:forEach var="field" items="${bbsFieldList}">
                                                    <option value="<c:out value="${field.fieldCode}"/>" <c:out value="${field.fieldCode eq bbsInfoVO.nttLinkTrgetField ? 'selected=true':''}"/>><c:out value="${field.fieldUseNm}"/>[<c:out value="${field.fieldCode}"/>]</option>
                                                </c:forEach>
                                            </form:select>
                                        </div>
                                        <div class="area_element">
                                            <form:label path="nttLinkTrget">링크 대상(target)</form:label>
                                            <form:select path="nttLinkTrget">
                                                <c:forEach var="opt" items="${nttLinkTrgetList}">
                                                    <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bbsInfoVO.nttLinkTrget ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                                </c:forEach>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">게시물 링크에 필드값 적용</th>
                    <td colspan="3">
                        <p class="info_text">게시물 링크 주소 필드의 값으로 링크 주소가 대체됩니다.</p>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.fieldValueLinkUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="fieldValueLinkUseAt" <c:out value="${bbsInfoVO.fieldValueLinkUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="fieldValueLinkUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.fieldValueLinkUseAt}"/>"/>
                            <label for="fieldValueLinkUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div class="marginTop_10"  style="width:30%;">
                            <div class="setting_block">
                                <div class="element_block">
                                    <div class="share_area">
                                        <div class="area_element">
                                            <form:label path="nttDetailLinkField">링크주소 필드명</form:label>
                                            <form:select path="nttDetailLinkField">
                                                <c:forEach var="field" items="${bbsFieldList}">
                                                    <option value="<c:out value="${field.fieldCode}"/>" <c:out value="${field.fieldCode eq bbsInfoVO.nttDetailLinkField ? 'selected=true':''}"/>><c:out value="${field.fieldUseNm}"/>[<c:out value="${field.fieldCode}"/>]</option>
                                                </c:forEach>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </td>
                </tr>
                <tr>
                    <th scope="row">게시물 정렬</th>
                    <td colspan="3">
                        <form:select path="sortField" title="정렬 기준 필드">
                            <c:forEach var="opt" items="${sortFieldList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bbsInfoVO.sortField ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                        <form:select path="sortMth" title="정렬 방법">
                            <c:forEach var="opt" items="${sortMthList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bbsInfoVO.sortMth ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                    </td>
                    <input type="hidden" name="nttShowPd" id="nttShowPd" value="0"/>
                    <%--<th scope="row"><form:label path="nttShowPd">게시물 표시기간</form:label></th>
                    <td>
                        <form:select path="nttShowPd">
                            <c:forEach var="opt" items="${nttShowPdList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq bbsInfoVO.nttShowPd ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                    </td>--%>
                </tr>
                <tr>
                    <th scope="row">통합 사용 여부</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.integrUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="integrUseAt" <c:out value="${bbsInfoVO.integrUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="integrUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.integrUseAt}"/>"/>
                            <label for="integrUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                    </td>
                    <th scope="row">비밀번호</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.passwordUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="passwordUseAt" <c:out value="${bbsInfoVO.passwordUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="passwordUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.passwordUseAt}"/>"/>
                            <label for="passwordUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <p class="info_text">비밀번호기능을 사용하면 비인증회원도 게시글 작성이 가능합니다. 게시글 수정시 비밀번호를 요구합니다.</p>
                    </td>
                </tr>
                <tr>
                    <th scope="row">게시기간 사용여부</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.periodUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="periodUseAt" <c:out value="${bbsInfoVO.periodUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="periodUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.periodUseAt}"/>"/>
                            <label for="periodUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <p class="info_text">시작일[BGNDE],종료일[ENDDE]사용필요</p>
                    </td>
                    <th scope="row">작성일 변경 가능 여부</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.regDateUpdateUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="regDateUpdateUseAt" <c:out value="${bbsInfoVO.regDateUpdateUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="regDateUpdateUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.regDateUpdateUseAt}"/>"/>
                            <label for="regDateUpdateUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <p class="info_text">작성일[REGDE] 필드 보기(등록,수정) 일반보기 또는 관리자만보기 사용필요</p>
                    </td>
                </tr>

                <tr>
                    <th scope="row">공지사항 사용 여부</th>
                    <td >
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.noticeUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="noticeUseAt" <c:out value="${bbsInfoVO.noticeUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="noticeUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.noticeUseAt}"/>"/>
                            <label for="noticeUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                    </td>

                    <th scope="row">삭제된 게시물 보기</th>
                    <td >
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.deleteNttShowAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="deleteNttShowAt" <c:out value="${bbsInfoVO.deleteNttShowAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="deleteNttShowAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.deleteNttShowAt}"/>"/>
                            <label for="deleteNttShowAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <p class="info_text"><span >관리자가 아닌 일반 사용자여도 삭제 사유와 함께 삭제된 게시물 목록표시. 상세보기는 불가</span></p>
                    </td>
                </tr>
                <tr>
                    <th scope="row">이름 마스킹 사용여부</th>
                    <td >
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.maskingNameUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="maskingNameUseAt" <c:out value="${bbsInfoVO.maskingNameUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="maskingNameUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.maskingNameUseAt}"/>"/>
                            <label for="maskingNameUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                    </td>

                    <th scope="row">일일 작성 한도 사용 여부</th>
                    <td >
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.dailyWriteLimitUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="dailyWriteLimitUseAt" <c:out value="${bbsInfoVO.dailyWriteLimitUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="dailyWriteLimitUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.dailyWriteLimitUseAt}"/>"/>
                            <label for="dailyWriteLimitUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div class="inlineBlock">
                            <span>일일 작성 한도 횟수</span>
                            <select name="dailyWriteLimitCnt" >
                                <c:forEach var="st" begin="0" end="9" step="1">
                                    <option value="<c:out value="${10 - st}"/>"  <c:out value="${ (10 - st) eq bbsInfoVO.dailyWriteLimitCnt ? 'selected=true':''}"/>><c:out value="${10 - st}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">에디터</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.editorUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="editorUseAt" <c:out value="${bbsInfoVO.editorUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="editorUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.editorUseAt}"/>"/>
                            <label for="editorUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <p class="info_text"><span class="em_red">웹접근성 준수 적용 필수 및 웹접근성 인증마크 필수일 경우 절대 사용 불가.</span></p>
                    </td>

                    <th scope="row">검색엔진 수집여부</th>
                    <td >
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.searchAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="searchAt" <c:out value="${bbsInfoVO.searchAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="searchAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.searchAt}"/>"/>
                            <label for="searchAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <p class="info_text"><span>검색엔진 조회 VIEW에서 해당값이 활성화 된 경우에만 해당 게시판의 게시물 수집 </span></p>
                    </td>
                </tr>
                <tr>
                    <th scope="row">암호화 사용 여부</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.encryptUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="encryptUseAt" <c:out value="${bbsInfoVO.encryptUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="encryptUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.encryptUseAt}"/>"/>
                            <label for="encryptUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <p class="info_text">[필드관리]에서 암호화로 설정된 필드가 존재할 시 해당 필드의 값은 DB에 저장할때 암호화하여 저장합니다.<br />
                            <span style="color: red;">※ 이미 게시물이 존재 하는 경우 별도의 암호화 과정 혹은 복호화 과정이 필요합니다.</span>
                        </p>
                    </td>
                    <th scope="row">주소에 지도 API사용</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.geoMapUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="geoMapUseAt" <c:out value="${bbsInfoVO.geoMapUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="geoMapUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.geoMapUseAt}"/>"/>
                            <label for="geoMapUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div>
                            <p class="info_text">설정파일에 다음 지도API 코드입력이 필요합니다.</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">개인정보동의 사용여부</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.agreementUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="agreementUseAt" <c:out value="${bbsInfoVO.agreementUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="agreementUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.agreementUseAt}"/>"/>
                            <label for="agreementUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <p class="info_text">사용할 개인정보 동의서 내용을 <a href="./updateBbsDescriptionView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>">[설명관리]</a>에서 작성하여주세요.</p>
                    </td>
                    <th scope="row">개인정보조회로그 작성여부</th>
                    <td>
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.privacyLogAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="privacyLogAt" <c:out value="${bbsInfoVO.privacyLogAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="privacyLogAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.privacyLogAt}"/>"/>
                            <label for="privacyLogAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <p class="info_text">게시물을 조회(view)하면 접근자의 정보가 개인정보로그에 기록됩니다.</p>
                    </td>
                </tr>
                <tr>
                    <th scope="row">금지어</th>
                    <td colspan="3">
                        <div class="toggle inlineBlock <c:out value="${bbsInfoVO.abuseUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="abuseUseAt" <c:out value="${bbsInfoVO.abuseUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="abuseUseAt" data-true-value="Y" data-false-value="N" value="<c:out value="${bbsInfoVO.abuseUseAt}"/>"/>
                            <label for="abuseUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <div>
                            <input id="abuseWord" name="abuseWord" title="금지어 입력" placeholder="금지어 입력(,로 구분)" type="text" value="<c:out value="${bbsInfoVO.abuseWord}"/>" class="specWidth80per">
                            <p class="info_text">작성하는 게시물에 금지어가 포함되어있다면 게시글 작성에 실패합니다.</p>
                        </div>

                    </td>
                </tr>

                <tr>
                    <th scope="row">공공누리</th>
                    <td colspan="3">
                        <div class="toggle <c:out value="${bbsInfoVO.koglUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                            <input type="checkbox" id="koglUseAt" name="koglUseAt" <c:out value="${bbsInfoVO.koglUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> value="<c:out value="${bbsInfoVO.koglUseAt eq 'Y' ? 'Y':'N'}"/>" data-true-value="Y" data-false-value="N"/>
                            <label for="koglUseAt">
                                사용여부
                                <span class="toggle_ui">on/off</span>
                            </label>
                        </div>
                        <ul class="kogl_layer">
                            <li class="block">
                                <input type="radio" name="koglBbsType" id="koglBbsType1" <c:out value="${bbsInfoVO.koglBbsType eq 'MENU_SET' || empty bbsInfoVO.koglBbsType ? 'checked=\"checked\"':''}"/> value="MENU_SET">
                                <label for="koglBbsType1">메뉴 설정값으로 사용</label>
                            </li>
                            <li>
                                <input type="radio" name="koglBbsType" id="koglBbsType2" <c:out value="${bbsInfoVO.koglBbsType eq 'KOGLTY01' ? 'checked=\"checked\"':''}"/> value="KOGLTY01">
                                <label for="koglBbsType2">
                                    제1유형 : 출처표시
                                    <em class="kogl_summary">
                                        <i class="kogl_img type1">OPEN 출처표시 공공누리 공공저작물 자유이용허락</i>
                                    </em>
                                </label>
                            </li>
                            <li>
                                <input type="radio" name="koglBbsType" id="koglBbsType3" <c:out value="${bbsInfoVO.koglBbsType eq 'KOGLTY02' ? 'checked=\"checked\"':''}"/> value="KOGLTY02">
                                <label for="koglBbsType3">
                                    제2유형 : 출처 표시 + 상업적 이용금지
                                    <em class="kogl_summary">
                                        <i class="kogl_img type2">OPEN 출처표시 상업용금지 공공누리 공공저작물 자유이용허락</i>
                                    </em>
                                </label>
                            </li>
                            <li>
                                <input type="radio" name="koglBbsType" id="koglBbsType4" <c:out value="${bbsInfoVO.koglBbsType eq 'KOGLTY03' ? 'checked=\"checked\"':''}"/> value="KOGLTY03">
                                <label for="koglBbsType4">
                                    제3유형 : 출처 표시 + 변경금지
                                    <em class="kogl_summary">
                                        <i class="kogl_img type3">OPEN 출처표시 변경금지 공공누리 공공저작물 자유이용허락</i>
                                    </em>
                                </label>
                            </li>
                            <li>
                                <input type="radio" name="koglBbsType" id="koglBbsType5"  <c:out value="${bbsInfoVO.koglBbsType eq 'KOGLTY04' ? 'checked=\"checked\"':''}"/> value="KOGLTY04">
                                <label for="koglBbsType5">
                                    제4유형 : 출처표시 + 상업용금지 + 변경금지
                                    <em class="kogl_summary">
                                        <i class="kogl_img type4">OPEN 출처표시 상업용금지 변경금지 공공누리 공공저작물 자유이용허락</i>
                                    </em>
                                </label>
                            </li>
                        </ul>
                        <div class="setting_block">
                            <div class="element_block">
                                <div class="toggle <c:out value="${bbsInfoVO.koglNttUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                                    <input type="checkbox" id="koglNttUseAt" name="koglNttUseAt" <c:out value="${bbsInfoVO.koglNttUseAt eq 'Y' ? 'checked=\"checked\"':''}"/>  value="<c:out value="${bbsInfoVO.koglNttUseAt eq 'Y' ? 'Y':'N'}"/>"  data-true-value="Y" data-false-value="N"/>
                                    <label for="koglNttUseAt">
                                        게시물별 설정 사용
                                        <span class="toggle_ui">on/off</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectBbsList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton edit"><span>수정</span></button>
            </div>
        </div>
    </form:form>
</div>

<link rel="stylesheet" href="/common/css/chosen.css" />
<script src="/neo/js/calendar.js"></script>
<script src="/common/js/chosen/chosen.jquery.min.js"></script>
<script src="/common/js/chosen/prism.js"></script>
<script src="/common/js/chosen/init.js"></script>
<script nonce="NEOCMSSCRIPT">
    $(document).ready(function(){
        toggleFunction();
    })
</script>
</body>
</html>