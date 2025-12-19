<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 첨부파일필드 관리 목록</title>
<meta name="decorator" content="neo" />
<script src="/neo/js/jquery-3.6.0.min.js"></script>
<script src="/neo/js/common.js"></script>


    <script  src="<c:url value='/cmm/validator.do'/>"></script>
    <validator:javascript formName="bbsAtchFieldVO" staticJavascript="false" xhtml="true" cdata="false"/>
    <spring:hasBindErrors name="bbsAtchFieldVO">
        <script nonce="NEOCMSSCRIPT">
            <c:forEach items="${errors.allErrors}" var="error" varStatus="status">
            <c:if test="${status.first}">
            <c:set var="errMsg"><spring:message code="${error.code}" arguments="${error.arguments}" /></c:set>
            alert("<c:out value="${errMsg}"/>");
            </c:if>
            </c:forEach>
        </script>
    </spring:hasBindErrors>
    <c:if test="${!empty message}">
        <script nonce="NEOCMSSCRIPT">
            function fn_check_message() {
                alert("<c:out value='${message}'/>");
                <c:if test="${!empty fieldName}">
                $("#<c:out value="${fieldName}"/>").focus();
                </c:if>
            }
            $(window).on("load", function() {
                fn_check_message();
            });
        </script>
    </c:if>
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_program">게시판관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">게시판설정</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title"><c:out value="${bbsVO.bbsNm}"/> 첨부파일필드 관리</span>
</div>
<div class="tab_navigation">
    <a href="./updateBbsInfoView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class=" "><span>설정관리</span></a>
    <a href="./updateBbsFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class=""><span>필드관리</span></a>
    <a href="./updateBbsFieldListSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class=""><span>목록 순서 변경</span></a>
    <a href="./updateBbsFieldInputSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class=""><span>입력/보기 순서 변경</span></a>
    <a href="./selectBbsCategoryList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class=""><span>카테고리관리</span></a>
    <a href="./updateBbsDescriptionView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class=""><span>설명관리</span></a>
    <a href="./selectBbsAuthorList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class=""><span>권한관리</span></a>
    <a href="./updateBbsAtchFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class="current"><span>첨부파일필드 관리</span></a>
    <a href="./updateBbsBanView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>"><span>악성사용자 차단</span></a>
</div>
<div class="contents is_tab">
    <div class="arrangementWrap">
        <div class="arrLeft">
    <p class="info_text">게시판 설정관리에서 지정한 첨부파일 갯수를 초과한 필드는 등록하여도 무시됩니다. <span class="em_red">수정된 내용은 하단의 배치를 새로해야 적용됩니다.</span></p>
        </div>
        <div class="arrRight">
            <div class="table_search">
                <form:form modelAttribute="bbsAtchFieldVO" name="addBbsAtchField" action="addBbsAtchFieldMng.do" onsubmit="return validateBbsAtchFieldVO(this)" >
                    <form:hidden path="bbsNo"/>
                    <input type="hidden" name="pageUnit" value="${bbsAtchFieldVO.pageUnit}"/>
                    <input type="hidden" name="searchCnd" value="${bbsAtchFieldVO.searchCnd}"/>
                    <input type="hidden" name="searchKrwd" value="${bbsAtchFieldVO.searchKrwd}"/>
                    <input type="hidden" name="pageIndex" value="${bbsAtchFieldVO.pageIndex}"/>
                    <span class="srch_element text">
                        <form:input path="attachNm" placeholder="필드명"/>
                    </span>
                    <span class="srch_element text specWidth250px " style="border:0px;">
                        <select name="attachExt" class="p-input p-input--auto chosen-select " multiple data-placeholder="확장자를 선택해주세요." data-no_results_text="확장자를 선택해주세요." >
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
                    </span>
                    <span class="srch_element submit">
                        <button type="submit" class="add"><span>추가</span></button>
                    </span>
                </form:form>
            </div>
        </div>
    </div>
    <div class="attachmentList">
        <ul class="tableTh">
            <li class="number">번호</li>
            <li class="field">파일필드명</li>
            <li class="extension">사용확장자</li>
            <li class="insert">본문삽입</li>
            <li class="alt">대체텍스트</li>
            <li class="new_date">등록일</li>
            <li class="edit_date">수정일</li>
            <li class="set">관리</li>
        </ul>
        <ul class="tableTd">
        <c:set var="sNumber" value="1"/>
        <c:forEach var="result" items="${BbsAtchFieldList}" varStatus="status">
            <li>
                <form action="./updateBbsAtchFieldMng.do" method="post">
                    <input type="hidden" name="attachNo" value="<c:out value="${result.attachNo}"/>"/>
                    <input type="hidden" name="bbsNo" value="<c:out value="${result.bbsNo}"/>"/>
                    <input type="hidden" name="pageUnit" value="${bbsAtchFieldVO.pageUnit}"/>
                    <input type="hidden" name="searchCnd" value="${bbsAtchFieldVO.searchCnd}"/>
                    <input type="hidden" name="searchKrwd" value="${bbsAtchFieldVO.searchKrwd}"/>
                    <input type="hidden" name="pageIndex" value="${bbsAtchFieldVO.pageIndex}"/>
                    <div class="td_inner">
                        <div class="td_el number" title="번호"><c:out value="${sNumber}"/></div>
                        <div class="td_el field" title="파일필드명"><input type="text" name="attachNm" value="<c:out value="${result.attachNm}"/>"/></div>
                        <div class="td_el extension" title="사용확장자"><%--<input type="text" name="attachExt" value="<c:out value="${result.attachExt}"/>" class="p-input" style="width:100%"/>--%>
                            <select name="attachExt" id="attachExt" class="p-input p-input--auto chosen-select" multiple data-placeholder="확장자를 선택해주세요." data-no_results_text="확장자를 선택해주세요." >
                                <option style="display: none;"></option>
                                <c:set var="hasImage" value="0"/>
                                <optgroup label="일반 타입" >
                                    <c:forEach var="mime" items="${mimeTypeList}">
                                        <c:if test="${mime.imgTypeAt eq '0'}">
                                            <c:set var="isChecked" value="false" />
                                            <c:if test="${fn:contains(result.attachExt, mime.mimeTypeExt)}"><c:set var="isChecked" value="true" /></c:if>
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
                                                <c:if test="${fn:contains(result.attachExt, mime.mimeTypeExt)}"><c:set var="isChecked" value="true" /></c:if>
                                                <option value="${mime.mimeTypeExt}"  ${isChecked ? "selected='selected'" : ''} >${mime.mimeTypeExt}</option>
                                            </c:if>
                                        </c:forEach>
                                    </optgroup>
                                </c:if>
                            </select>
                        </div>
                        <div class="td_el insert" title="본문삽입">
                            <input type="checkbox" name="bdtInsertAt" value="Y" <c:out value="${result.bdtInsertAt eq 'Y' ? 'checked=checked':''}"/> title="본문삽입">
                        </div>
                        <div class="td_el alt" title="대체텍스트">
                            <input type="checkbox" name="replcUseAt" value="Y" <c:out value="${result.replcUseAt eq 'Y' ? 'checked=checked':''}"/> title="대체텍스트">
                        </div>
                        <div class="td_el new_date" title="등록일"><c:out value="${result.frstRegisterPnttmYMD}"/></div>
                        <div class="td_el edit_date" title="수정일"><c:out value="${result.lastUpdusrPnttmYMD}"/></div>
                        <div class="td_el set" title="관리">
                            <button type="submit" class="iconTextButton edit small"><span>수정완료</span></button>
                            <a href="./deleteBbsAtchFieldMng.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;attachNo=<c:out value="${result.attachNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class="iconTextButton delete small marginLeft_5"><span>삭제</span></a>
                        </div>
                    </div>
                </form>
            </li>
            <c:set var="sNumber" value="${sNumber+1}" />
        </c:forEach>
        <c:if test="${fn:length(BbsAtchFieldList) == 0}">
            <li class="textACenter">등록된 파일정보가 없습니다.</li>
        </c:if>
        </ul>
    </div>
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
            <a href="./selectBbsList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
            <a href="./attachBatchBbs.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class="iconTextButton batch"><span>배치</span></a>
            <a href="./updateBbsAtchFieldSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsAtchFieldVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsAtchFieldVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsAtchFieldVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsAtchFieldVO.pageIndex}"/>" class="iconTextButton sort marginLeft_5"><span>순서변경</span></a>
        </div>
    </div>
</div>
<style>
    .attachmentList .tableTd{height:calc(100% - 31px);}
</style>
<link rel="stylesheet" href="/common/css/chosen.css" />
<script src="/common/js/chosen/chosen.jquery.min.js"></script>
<script src="/common/js/chosen/prism.js"></script>
<script src="/common/js/chosen/init.js"></script>
</body>
</html>