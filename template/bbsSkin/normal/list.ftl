<#ftl encoding="utf-8"/>
<#function getClassName index hasNext fieldCode>
    <#local className="">
    <#if fieldCode = "SJ">
        <#local className = className + "p-subject"/>
    </#if>
    <#if className != "">
        <#local className = "class=\"" + className + "\""/>
    </#if>
    <#return className>
</#function>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>


<html lang="ko">
<head>
    <meta name="decorator" content="@@{menuInfo.siteId}" />

    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/jquery-3.6.0.min.js"></script>


</head>
<body>

<link rel="stylesheet" href="/common/css/chosen.css" />
<div class="p-wrap bbs bbs__list">
    <#if  (bbsInfo.clsdrUseAt!"")?string = 'Y' &&  (bbsInfo.listShowSe!"")?string = 'LSSE02'>
        <#if  (bbsDescription.clsdrDcReplcAt!"")?string = 'N'>
            <#if (bbsDescription.clsdrDc!"")?string != ''>
                ${bbsDescription.clsdrDc!""}
            </#if>
        <#else>
            <c:if test="@@{isExistCntntsFile}">
                <c:set var="contentsFile" value="/repository/@@{menuInfo.siteId}/contents/@@{key}.html"/>
                <c:import var="Content" url="@@{contentsFile}" charEncoding="UTF-8" />
                <c:out value="@@{Content}" escapeXml="false" />
            </c:if>
        </#if>
    <#else>
        <#if  (bbsDescription.listUpendDcReplcAt!"")?string = 'N'>
            <#if (bbsDescription.listUpendDc!"")?string != ''>
                <div class="card card--line top">
                    <div class="card-content">
                        ${bbsDescription.listUpendDc!""}
                    </div>
                </div>
            </#if>
        <#else>
            <c:if test="@@{isExistCntntsFile}">
                <c:set var="contentsFile" value="/repository/@@{menuInfo.siteId}/contents/@@{key}.html"/>
                <c:import var="Content" url="@@{contentsFile}" charEncoding="UTF-8" />
                <c:out value="@@{Content}" escapeXml="false" />
            </c:if>
        </#if>
    </#if>

    <#if  (bbsInfo.listShowSe!"")?string != 'LSSE02'>

        <#if  (bbsInfo.ctgryUseAt!"")?string = 'Y' &&  (bbsInfo.ctgryTy!"")?string = 'CTGY02' && bbsCategoryList?size gt 0>
            <div class="p-nav p-nav--group">
                <ul class="p-nav__list">
                    <#list bbsCategoryList as bbsCategory>
                        <c:url var="categoryUrl" value="./selectBbsNttList.do">
                            <c:param name="key" value="@@{key}"/>
                            <c:param name="bbsNo" value="@@{bbsNo}"/>
                            <c:param name="searchCtgry" value="${bbsCategory.ctgryNm}"/>
                            <c:param name="integrDeptCode" value="@@{bbsNttVO.integrDeptCode}"/>
                        </c:url>
                        <li><a href="<c:out value="@@{categoryUrl}"/>" class="p-nav__link <c:if test="@@{bbsNttVO.searchCtgry eq '${bbsCategory.ctgryNm}'}">active</c:if>">${bbsCategory.ctgryNm}</a></li>
                    </#list>
                </ul>
            </div>
        </#if>

        <form name="bbsNttSearchForm" action="./selectBbsNttList.do" method="get" class="boardSearchForm">
            <fieldset>
                <legend>게시물 검색</legend>
                <input type="hidden" name="key" id="key" value="<c:out value="@@{key}"/>"/>
                <input type="hidden" name="bbsNo" id="bbsNo" value="<c:out value="@@{bbsNo}"/>"/>
                <input type="hidden" name="searchCtgry" id="searchCtgry" value="<c:out value="@@{bbsNttVO.searchCtgry}"/>"/>
                <input type="hidden" name="integrDeptCode" id="integrDeptCode" value="<c:out value="@@{bbsNttVO.integrDeptCode}"/>"/>
                <div class="card card--bgcolor p-search">
                    <div class="p-form-group">
                        <select name="searchCnd" id="searchCnd" class="p-input" title="검색항목선택">
                            <#list bbsFieldSearchList as bbsFieldSearch>
                                <option value="${bbsFieldSearch.fieldCode}" <c:if test="@@{bbsNttVO.searchCnd eq '${bbsFieldSearch.fieldCode}'}">selected="selected"</c:if>>${bbsFieldSearch.fieldUseNm}</option>
                            </#list>
                        </select>
                        <span class="p-form__split"></span>
                        <input type="text" name="searchKrwd" class="p-input p-input--beside" title="검색단어 입력" value="<c:out value="@@{bbsNttVO.searchKrwd}"/>" placeholder="검색단어 입력">
                        <span class="p-form-group__button">
						<button type="submit" class="p-button black">검색</button>
					</span>
                    </div>
                </div>
            </fieldset>
        </form>

        <div class="row">
            <div class="col-12 col-sm-24 margin_t_10 small">
                총 <em class="em_black" data-mask="#,##0" data-mask-reverse="true"><fmt:formatNumber value="@@{tsu:xssNumberFilter(paginationInfo.totalRecordCount)}" pattern="#,###"/></em>건   [ <em class="em_b_black"><fmt:formatNumber value="@@{tsu:xssNumberFilter(paginationInfo.currentPageNo)}" pattern="#,###"/></em> / <fmt:formatNumber value="@@{tsu:xssNumberFilter(paginationInfo.totalPageCount)}" pattern="#,###"/> 페이지 ]
                <#if  (bbsInfo.rssUseAt!"")?string = 'Y'>
                    <c:url var="rssUrl" value="/rssBbsNtt.do">
                        <c:param name="bbsNo" value="@@{bbsNo}"/>
                        <c:param name="searchCtgry" value="@@{bbsNttVO.searchCtgry}"/>
                        <c:param name="integrDeptCode" value="@@{bbsNttVO.integrDeptCode}"/>
                    </c:url>
                    <a href="<c:out value="@@{rssUrl}"/>" class="margin_l_5" target="_blank" title="새창">
                    <svg width="16" height="26" fill="#f86400" focusable="false">

                        <use xlink:href="/common/images/program/p-icon.svg#rss"></use>
                        <switch>
                            <foreignObject width="20" height="20">RSS보기</foreignObject>
                        </switch>
                    </svg>
                    </a>
                </#if>
            </div>
            <div class="col-12 col-sm-24 right">
                <#if  (bbsInfo.ctgryUseAt!"")?string = 'Y' &&  (bbsInfo.ctgryTy!"")?string = 'CTGY01' && bbsCategoryList?size gt 0>
                    <form name="bbsNttCategorySearchForm" method="get" action="./selectBbsNttList.do">
                        <fieldset>
                            <legend>${ctgryNm!""}</legend>
                            <input type="hidden" name="key" value="<c:out value="@@{key}"/>"/>
                            <input type="hidden" name="bbsNo" value="<c:out value="@@{bbsNo}"/>"/>
                            <input type="hidden" name="integrDeptCode" value="<c:out value="@@{bbsNttVO.integrDeptCode}"/>"/>
                            <input type="hidden" name="searchCnd" value="<c:out value="@@{bbsNttVO.searchCnd}"/>"/>
                            <input type="hidden" name="searchKrwd" value="<c:out value="@@{bbsNttVO.searchKrwd}"/>"/>
                            <select name="searchCtgry" id="searchCtgry" class="p-input p-input--auto" title="${ctgryNm!""} 선택">
                                <option value="">${ctgryNm!""} 선택</option>
                                <#list bbsCategoryList as bbsCategory>
                                    <option value="${bbsCategory.ctgryNm}" <c:if test="@@{bbsNttVO.searchCtgry eq '${bbsCategory.ctgryNm}'}">selected="selected"</c:if>>${bbsCategory.ctgryNm}</option>
                                </#list>
                            </select>
                            <button type="submit" class="p-button p-button--small primary">확인</button>
                        </fieldset>
                    </form>
                </#if>
            </div>
        </div>

        <#assign lastFieldCode=""/>
        <#assign fieldList="">
        <#list bbsFieldListShowList as bbsFieldListShow>
            <#assign fieldList=fieldList + "${bbsFieldListShow.fieldUseNm}">
            <#if bbsFieldListShow_has_next>
                <#assign fieldList=fieldList + ", "/>
            <#else>
                <#assign lastFieldCode="${bbsFieldListShow.fieldCode}"/>
            </#if>
        </#list>

        <form name="bbsNttForm"  id="bbsNttForm" method="post" action="./deleteBbsNttMulti.do" data-select="checkall" data-checkallid="#check-all" data-checkname="checkid">
            <input type="hidden" name="key" value="<c:out value="@@{key}"/>"/>
            <input type="hidden" name="bbsNo" value="<c:out value="@@{bbsNo}"/>"/>
            <input type="hidden" name="searchCtgry" value="<c:out value="@@{bbsNttVO.searchCtgry}"/>"/>
            <input type="hidden" name="searchCnd" value="<c:out value="@@{bbsNttVO.searchCnd}"/>"/>
            <input type="hidden" name="searchKrwd" value="<c:out value="@@{bbsNttVO.searchKrwd}"/>"/>
            <fieldset>
                <legend>게시물 목록</legend>
                <table class="p-table simple" data-table="rwd" data-tabletype="simple" data-breakpoint="760">
                    <caption>${bbs.bbsNm} 목록 - ${fieldList} 정보  제공</caption>
                    <colgroup>
                        <c:if test="@@{bbsNttVO.bbsManageMode eq true }" >
                            <col style="width:60px"/>
                        </c:if>
                        <#list bbsFieldListShowList as bbsFieldListShow>
                            <#if bbsFieldListShow.listMngOnlyShowAt = '0' >
                                <col <#if bbsFieldListShow.listWidthSize?has_content>style="width:${bbsFieldListShow.listWidthSize}<#if !(bbsFieldListShow.listWidthSize?contains("%") || bbsFieldListShow.listWidthSize?contains("px"))>px</#if>"</#if>/>
                            </#if>
                            <#if bbsFieldListShow.listMngOnlyShowAt != '0' >
                                <c:if test="@@{bbsNttVO.bbsManageMode eq true }">
                                    <col <#if bbsFieldListShow.listWidthSize?has_content>style="width:${bbsFieldListShow.listWidthSize}<#if !(bbsFieldListShow.listWidthSize?contains("%") || bbsFieldListShow.listWidthSize?contains("px"))>px</#if>"</#if>/>
                                </c:if>
                            </#if>
                        </#list>
                    </colgroup>
                    <thead>
                    <tr><c:if test="@@{bbsNttVO.bbsManageMode eq true }" >
                        <th scope="col" class="first">
                            <span class="p-form-checkbox p-form-checkbox--single">
                                <input type="checkbox" name="" id="check-all" class="p-form-checkbox__input">
                                <label for="check-all" class="p-form-checkbox__label">전체 선택</label>
                            </span>
                        </th>
                        </c:if>
                        <#list bbsFieldListShowList as bbsFieldListShow>
                            <#if bbsFieldListShow.listMngOnlyShowAt = '0' >
                                <th scope="col" <#if bbsFieldListShow_index = 0>class="first"</#if>>${bbsFieldListShow.fieldUseNm}</th>
                            </#if>
                            <#if bbsFieldListShow.listMngOnlyShowAt != '0' >
                                <c:if test="@@{bbsNttVO.bbsManageMode eq true }">
                                    <th scope="col" <#if bbsFieldListShow_index = 0>class="first"</#if>>${bbsFieldListShow.fieldUseNm}</th>
                                </c:if>
                            </#if>
                        </#list>
                        <#if (bbsInfo.replySe!"")?string = 'RTSY03'>
                            <th scope="col">처리상태</th>
                        </#if>
                    </tr>
                    </thead>
                    <tbody class="text_center">
                    <c:set var="currentPageStartNo" value="@@{paginationInfo.currentPageStartNo}" />
                    <c:forEach var="result" items="@@{bbsNttList}" varStatus="Status">
                        <c:set var="row_class"></c:set>
                        <c:set var="expired_ntt" value="false" />
                        <c:if test="@@{result.notice eq true}"><c:set var="row_class">@@{row_class} notice</c:set></c:if>
                        <c:if test="@@{ not (((result.bgnde <= bbsNttVO.periodNow and (not empty result.bgnde)) and ((bbsNttVO.periodNow <= result.endde) and (not empty result.endde)))
                                or  ((result.bgnde <= bbsNttVO.periodNow and (not empty result.bgnde)) and (empty result.endde))
                                or  ((bbsNttVO.periodNow <= result.endde and (not empty result.endde)) and (empty result.bgnde))
                                or  ((empty result.bgnde) and (empty result.endde)))}">
                            <c:set var="expired_ntt" value="true" />
                        </c:if>
                        <#list bbsFieldList as bbsFieldListShow>
                            <#if  (bbsInfo.fieldValueLinkUseAt!"")?string = 'Y' && bbsInfo.nttDetailLinkField?? &&  (bbsInfo.nttDetailLinkField!"")?string = bbsFieldListShow.fieldCode>
                                <#if  (bbsFieldListShow.fieldCode!"")?string = 'SJ'>
                                    <c:url var="nttUrl" value="@@{result.nttSj}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'CTGRY'>
                                    <c:url var="nttUrl" value="@@{result.ctgryNm}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'DEPT'>
                                    <c:url var="nttUrl" value="@@{result.deptNm}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'WRTER'>
                                    <c:url var="nttUrl" value="@@{result.writerNm}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'OTHBCAT'>
                                    <c:url var="nttUrl" value="@@{result.othbcAt}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'WRITERIP'>
                                    <c:url var="nttUrl" value="@@{result.writerIp}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'CTTPC'>
                                    <c:url var="nttUrl" value="@@{result.telno}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'MOBLPHON'>
                                    <c:url var="nttUrl" value="@@{result.moblphon}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'EMAIL'>
                                    <c:url var="nttUrl" value="@@{result.email}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'HMPG'>
                                    <c:url var="nttUrl" value="@@{result.hmpg}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADRES'>
                                    <c:url var="nttUrl" value="@@{result.adres}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'CN'>
                                    <c:url var="nttUrl" value="@@{result.nttCn}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'BGNDE'>
                                    <c:url var="nttUrl" value="@@{result.bgnde}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ENDDE'>
                                    <c:url var="nttUrl" value="@@{result.endde}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD1'>
                                    <c:url var="nttUrl" value="@@{result.aditfield1}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD2'>
                                    <c:url var="nttUrl" value="@@{result.aditfield2}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD3'>
                                    <c:url var="nttUrl" value="@@{result.aditfield3}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD4'>
                                    <c:url var="nttUrl" value="@@{result.aditfield4}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD5'>
                                    <c:url var="nttUrl" value="@@{result.aditfield5}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD6'>
                                    <c:url var="nttUrl" value="@@{result.aditfield6}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD7'>
                                    <c:url var="nttUrl" value="@@{result.aditfield7}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD8'>
                                    <c:url var="nttUrl" value="@@{result.aditfield8}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD9'>
                                    <c:url var="nttUrl" value="@@{result.aditfield9}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD10'>
                                    <c:url var="nttUrl" value="@@{result.aditfield10}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD11'>
                                    <c:url var="nttUrl" value="@@{result.aditfield11}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD12'>
                                    <c:url var="nttUrl" value="@@{result.aditfield12}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD13'>
                                    <c:url var="nttUrl" value="@@{result.aditfield13}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD14'>
                                    <c:url var="nttUrl" value="@@{result.aditfield14}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD15'>
                                    <c:url var="nttUrl" value="@@{result.aditfield15}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD16'>
                                    <c:url var="nttUrl" value="@@{result.aditfield16}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD17'>
                                    <c:url var="nttUrl" value="@@{result.aditfield17}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD18'>
                                    <c:url var="nttUrl" value="@@{result.aditfield18}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD19'>
                                    <c:url var="nttUrl" value="@@{result.aditfield19}"></c:url>
                                <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD20'>
                                    <c:url var="nttUrl" value="@@{result.aditfield20}"></c:url>
                                </#if>
                            </#if>
                        </#list>
                        <tr <c:if test="@@{not empty row_class}">class="@@{row_class}"</c:if>>
                        <c:if test="@@{bbsNttVO.bbsManageMode eq true }" >
                            <td class="p-table__checkbox">
                                <span class="p-form-checkbox p-form-checkbox--single">
                                    <input type="checkbox" name="bbsNttNoList" id="n1@@{Status.index}" value="@@{result.nttNo}" class="p-form-checkbox__input">
                                    <label for="n1@@{Status.index}" class="p-form-checkbox__label">{@@{result.nttSj}} 선택</label>
                                </span>
                            </td>
                        </c:if>
                        <#list bbsFieldListShowList as bbsFieldListShow>
                            <#if  (bbsInfo.fieldValueLinkUseAt!"")?string = 'N' &&  (bbsInfo.nttLinkTrgetField!"")?string = bbsFieldListShow.fieldCode>
                                <c:url var="nttUrl" value="./selectBbsNttView.do">
                                    <c:param name="key" value="@@{key}"/>
                                    <c:param name="bbsNo" value="@@{bbsNo}"/>
                                    <c:param name="nttNo" value="@@{result.nttNo}"/>
                                    <c:param name="searchCtgry" value="@@{bbsNttVO.searchCtgry}"/>
                                    <c:param name="searchCnd" value="@@{bbsNttVO.searchCnd}" />
                                    <c:param name="searchKrwd" value="@@{bbsNttVO.searchKrwd}" />
                                    <c:param name="integrDeptCode" value="@@{bbsNttVO.integrDeptCode}"/>
                                    <c:param name="pageIndex" value="@@{bbsNttVO.pageIndex}"/>
                                </c:url>
                            </#if>
                            <#assign tdClass = "${getClassName(bbsFieldListShow_index, bbsFieldListShow_has_next, bbsFieldListShow.fieldCode)}">

                            <c:choose>
                                <c:when test="@@{bbsNttVO.bbsManageMode eq false && '${bbsFieldListShow.listMngOnlyShowAt}' ne '0'}">
                                </c:when>
                                <c:otherwise>

                                    <td ${tdClass}>
                                        <#if  (bbsInfo.nttLinkTrgetField!"")?string = bbsFieldListShow.fieldCode>
                                        <c:if test="@@{bbsNttVO.bbsManageMode eq true || result.deleteAt ne 'Y'}"><a href="<c:out value="@@{nttUrl}"/>" target="${bbsInfo.nttLinkTrget}"></c:if>
                                        </#if>
                                        <#if  (bbsFieldListShow.fieldCode!"")?string = 'NO'>
                                            <c:if test="@@{result.notice eq true}">
                                                공지
                                            </c:if>
                                            <c:if test="@@{result.notice ne true}">
                                                <fmt:formatNumber value="@@{tsu:xssNumberFilter(currentPageStartNo)}" pattern="#,###"/>
                                            </c:if>


                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'SJ'>

                                            <c:if test="@@{result.upperNttNo ne 0}">
                                                <c:forEach var="i" begin="2" end="@@{result.nttLevel}" step="1"><span class="indent10"></span></c:forEach>
                                                <span class="p-icon p-icon__reply">답변글</span>
                                            </c:if>
                                            <c:if test="@@{result.othbcAt eq 'N'}">
                                                <span class="p-icon p-icon__secret">비밀글</span>
                                            </c:if>
                                            <#if  (bbsInfo.ctgryUseAt!"")?string = 'Y' &&  (bbsInfo.ctgryTy!"")?string = 'CTGY03'>
                                                <c:if test="@@{!empty result.ctgryNm}">[<c:out value="@@{fn:replace(result.ctgryNm,'|','')}"/>] </c:if>
                                            </#if>
                                            <c:if test="@@{result.deleteAt eq 'Y'}"><del></c:if>
                                            <c:if test="@@{expired_ntt eq true}"><i></c:if>
                                            <c:out value="@@{result.nttSj}"/>
                                            <c:if test="@@{expired_ntt eq true}"></i></c:if>
                                            <c:if test="@@{result.deleteAt eq 'Y'}"></del></c:if>
                                            <#if  (bbsInfo.newIconShowAt!"")?string = 'Y'><c:if test="@@{result.newIcon}"><span class="p-icon p-icon__new">새글</span></c:if></#if>
                                            <#if  (bbsInfo.coolIconShowAt!"")?string = 'Y'><c:if test="@@{result.coolIcon}"><span class="p-icon p-icon__hot">핫이슈</span></c:if></#if>
                                            <c:if test="@@{result.deleteAt eq 'Y'}">
                                                <span class="p-icon p-icon__delete">삭제된 글</span>
                                                <div class="p-deleted__info"><#--삭제자 : <c:out value="@@{result.deleteId}"/> / -->삭제사유 : <c:out value="@@{result.deleteResn}"/> / 삭제일 : <c:out value="@@{result.deletePnttmYMD}"/></div>
                                            </c:if>
                                            <#if  (bbsInfo.periodUseAt!"")?string = 'Y'>
                                            <c:if test="@@{ expired_ntt eq true}">
                                                <span class="p-icon p-icon__delete">게시기간이 아닌글</span>
                                                <div class="p-deleted__info">게시기간 : <c:out value="@@{result.bgndeYMDHMS}"/> ~ <c:out value="@@{result.enddeYMDHMS}"/></div>
                                            </c:if>
                                            </#if>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'CTGRY'>
                                            <c:out value="@@{fn:replace(result.ctgryNm,'|','')}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'DEPT'>
                                            <c:out value="@@{result.deptNm}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'WRTER'>
                                            <#if  (bbsInfo.maskingNameUseAt!"")?string = 'Y'>
                                                <c:out value="@@{fn:substring(result.writerNm,0,1)}*@@{fn:substring(result.writerNm,fn:length(result.writerNm)-1,fn:length(result.writerNm))}"/>
                                            <#else>
                                                <c:out value="@@{result.writerNm}"/>
                                            </#if>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'FILE'>

                                            <c:if test="@@{result.atchmnflCnt >= 2}"><span class="p-icon p-icon__folder">여러개의 파일 첨부</span></c:if>
                                            <c:if test="@@{result.atchmnflCnt eq 1}"><span class="p-icon p-icon__<c:out value="@@{result.fileExtsn}"/>"><c:out value="@@{result.fileExtsn}"/> 파일 첨부</span></c:if>

                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'RDCNT'>
                                            <fmt:formatNumber value="@@{tsu:xssNumberFilter(result.rdcnt)}" pattern="#,###"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'RGSDE'>
                                            <c:out value="@@{result.frstRegisterPnttmYMD}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'OTHBCAT'>
                                            <c:out value="@@{result.othbcAt}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'WRITERIP'>
                                            <c:out value="@@{result.writerIp}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'CTTPC'>
                                            <c:out value="@@{result.telno}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'MOBLPHON'>
                                            <c:out value="@@{result.moblphon}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'EMAIL'>
                                            <c:out value="@@{result.email}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'HMPG'>
                                            <c:out value="@@{result.hmpg}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADRES'>
                                            <c:out value="@@{result.adres}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'CN'>
                                            <c:out value="@@{result.nttCn}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'BGNDE'>
                                            <c:out value="@@{result.bgndeYMDHMS}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ENDDE'>
                                            <c:out value="@@{result.enddeYMDHMS}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD1'>
                                            <c:out value="@@{result.aditfield1}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD2'>
                                            <c:out value="@@{result.aditfield2}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD3'>
                                            <c:out value="@@{result.aditfield3}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD4'>
                                            <c:out value="@@{result.aditfield4}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD5'>
                                            <c:out value="@@{result.aditfield5}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD6'>
                                            <c:out value="@@{result.aditfield6}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD7'>
                                            <c:out value="@@{result.aditfield7}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD8'>
                                            <c:out value="@@{result.aditfield8}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD9'>
                                            <c:out value="@@{result.aditfield9}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD10'>
                                            <c:out value="@@{result.aditfield10}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD11'>
                                            <c:out value="@@{result.aditfield11}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD12'>
                                            <c:out value="@@{result.aditfield12}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD13'>
                                            <c:out value="@@{result.aditfield13}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD14'>
                                            <c:out value="@@{result.aditfield14}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD15'>
                                            <c:out value="@@{result.aditfield15}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD16'>
                                            <c:out value="@@{result.aditfield16}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD17'>
                                            <c:out value="@@{result.aditfield17}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD18'>
                                            <c:out value="@@{result.aditfield18}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD19'>
                                            <c:out value="@@{result.aditfield19}"/>
                                        <#elseif  (bbsFieldListShow.fieldCode!"")?string = 'ADITFIELD20'>
                                            <c:out value="@@{result.aditfield20}"/>
                                        </#if>
                                        <#if  (bbsInfo.nttLinkTrgetField!"")?string = bbsFieldListShow.fieldCode>
                                        <c:if test="@@{bbsNttVO.bbsManageMode eq true || result.deleteAt ne 'Y'}"></a></c:if>
                                        </#if>
                                    </td>
                                </c:otherwise>
                            </c:choose>
                        </#list>
                        <#if (bbsInfo.replySe!"")?string = 'RTSY03'>
                            <td><c:out value="@@{result.replyState}"/></td>
                        </#if>
                        </tr>
                        <c:if test="@@{result.notice ne true}">
                            <c:set var="currentPageStartNo" value="@@{currentPageStartNo-1}" />
                        </c:if>
                    </c:forEach>
                    <c:if test="@@{fn:length(bbsNttList) == 0}">
                        <tr>
                            <td class="p-empty" colspan="${bbsFieldListShowList?size}">
                                등록된 게시물이 없습니다.
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
                <div class="p-pagination">
                    <div class="p-page">
                        <c:url var="paginationUrl" value="./selectBbsNttList.do">
                            <c:param name="key" value="@@{key}"/>
                            <c:param name="bbsNo" value="@@{bbsNo}"/>
                            <c:param name="searchCtgry" value="@@{bbsNttVO.searchCtgry}"/>
                            <c:param name="searchCnd" value="@@{bbsNttVO.searchCnd}" />
                            <c:param name="searchKrwd" value="@@{bbsNttVO.searchKrwd}" />
                            <c:param name="integrDeptCode" value="@@{bbsNttVO.integrDeptCode}"/>
                            <c:param name="pageIndex" value=""/>
                        </c:url>
                        <ui:pagination paginationInfo="@@{tsu:xssPagingFilter(paginationInfo)}" type="board" jsFunction="@@{tsu:htmlSpecialChars(paginationUrl)}" />
                    </div>
                </div>

                <div class="text_right">
                    <c:if test="@@{bbsAuthor.addBtnAuth}">
                        <c:url var="writeUrl" value="./addBbsNttView.do">
                            <c:param name="key" value="@@{key}"/>
                            <c:param name="bbsNo" value="@@{bbsNo}"/>
                            <c:param name="integrDeptCode" value="@@{bbsNttVO.integrDeptCode}"/>
                        </c:url>
                        <a href="<c:out value="@@{writeUrl}"/>" class="p-button write">글 쓰기</a>
                    </c:if>
                    <c:if test="@@{bbsNttVO.bbsManageMode eq true}">
                        <a href="selectBbsNttListXlsDown.do?bbsNo=<c:out value="@@{bbsNo}"/>&key=<c:out value="@@{key}"/>" class="p-button write">엑셀다운로드</a>
                    </c:if>
                </div>

                <c:if test="@@{bbsNttVO.bbsManageMode eq true }" >
                <div class="card card--bgcolor bbs__manage">
                    <a href="#n"  onclick="checkedDelete()" class="p-button p-button--small p-button--bordered delete">삭제</a>
                    <a href="#n"  onclick="checkedRestore()" class="p-button p-button--small p-button--bordered restore  margin_r_20">복원</a>
                    <div class="bbs__move">
                        <select name="target" id="target" class="p-input p-input--auto" title="이동할 게시판 선택">
                            <c:forEach var="si" items="@@{siteList}" varStatus="status">
                                <optgroup label="@@{si.siteNm}">
                                    <c:forEach var="bbs" items="@@{bbsMap[si.siteId]}" varStatus="status">
                                        <c:if test="@@{bbs.bbsNo eq bbsNo}"></c:if>
                                        <c:if test="@@{bbs.bbsNo ne bbsNo}"><option value="@@{bbs.bbsNo}"><c:out value="@@{bbs.bbsNm}"/></option></c:if>
                                    </c:forEach>
                                </optgroup>
                            </c:forEach>
                        </select>
                        <button type="button" onclick="checkedMove()" class="p-button p-button--small darken">게시물이동</button>

                        <select name="target" id="target" class="p-input p-input--auto  chosen-select" data-placeholder="복사할 게시판 선택" data-no_results_text="게시판이 존재하지 않습니다." title="복사할 게시판 선택" multiple>
                            <c:forEach var="si" items="@@{siteList}" varStatus="status">
                                <optgroup label="@@{si.siteNm}">
                                    <c:forEach var="bbs" items="@@{bbsMap[si.siteId]}" varStatus="status">
                                        <c:if test="@@{bbs.bbsNo eq bbsNo}"></c:if>
                                        <c:if test="@@{bbs.bbsNo ne bbsNo}"><option value="@@{bbs.bbsNo}"><c:out value="@@{bbs.bbsNm}"/></option></c:if>
                                    </c:forEach>
                                </optgroup>
                            </c:forEach>
                        </select>
                        <button type="button" onclick="checkedCopy()" class="p-button p-button--small darken" style="float:right;">게시물복사</button>
                    </div>
                </div>
                </c:if>
            </fieldset>
        </form>
    </#if>


    <#if (bbsDescription.listLptDcReplcAt!"")?string = 'N'>
        <#if (bbsDescription.listLptDc!"")?string != ''>
            <div class="card card--line bottom">
                <div class="card-content">
                    ${bbsDescription.listLptDc!""}
                </div>
            </div>
        </#if>
    <#else>
        <c:if test="@@{isExistCntntsFile}">
            <c:set var="contentsFile" value="/repository/@@{menuInfo.siteId}/contents/@@{key}.html"/>
            <c:import var="Content" url="@@{contentsFile}" charEncoding="UTF-8" />
            <c:out value="@@{Content}" escapeXml="false" />
        </c:if>
    </#if>

    <#if  (bbsInfo.clsdrDcReplcAt!"")?string != 'Y' &&  (bbsInfo.listShowSe!"")?string = 'LSSE02'>
        <a href="/www/addBbsNttView.do?bbsNo=@@{bbsNo}&key=@@{key}" class="btn">작성하기</a>
        <a href="/www/selectBbsNttMyList.do?bbsNo=@@{bbsNo}&key=@@{key}" class="btn">내 게시물보기</a>
    </#if>
</div>

<script>
    $(document).ready(function() {
        $(".bbs__manage .delete");
        $(".bbs__manage .restore");
        $("#check-all").on("change", function(){
            $("input[name=bbsNttNoList]").prop("checked",$(this).prop("checked"));
        });
    });
    function checkedDelete(){
        if($("input[name=bbsNttNoList]:checked").length <= 0){
            alert("게시물을 선택하여주세요.");
            return false;
        }
        if(confirm("선택한 게시물을 정말로 삭제 하시겠습니까?")){
            $("#bbsNttForm").attr("action","./deleteBbsNttMulti.do");
            $("#bbsNttForm").submit();
        }
    }
    function checkedRestore(){
        if($("input[name=bbsNttNoList]:checked").length <= 0){
            alert("게시물을 선택하여주세요.");
            return false;
        }
        if(confirm("선택한 게시물을 정말로 복원 하시습니까?")){
            $("#bbsNttForm").attr("action","./restoreBbsNttMulti.do");
            $("#bbsNttForm").submit();
        }
    }
    function checkedMove(){
        if($("input[name=bbsNttNoList]:checked").length <= 0){
            alert("게시물을 선택하여주세요.");
            return false;
        }
        if(confirm("선택한 게시물을 정말로 이동 하시습니까?")){
            $("#bbsNttForm").attr("action","./moveBbsNttMulti.do");
            $("#bbsNttForm").submit();
        }
    }
    function checkedCopy(){
        if($("input[name=bbsNttNoList]:checked").length <= 0){
            alert("게시물을 선택하여주세요.");
            return false;
        }
        if(confirm("선택한 게시물을 정말로 복사 하시습니까?")){
            $("#bbsNttForm").attr("action","./copyBbsNttMulti.do");
            $("#bbsNttForm").submit();
        }
    }
</script>
<script src="/common/js/chosen/chosen.jquery.min.js"></script>
<script src="/common/js/chosen/prism.js"></script>
<script src="/common/js/chosen/init.js"></script>
</body>
</html>
