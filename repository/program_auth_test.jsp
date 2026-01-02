<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html lang="ko">
<head>

    <meta name="decorator" content="neo" />
    <script nonce="NEOCMSSCRIPT">

        function fn_checkAuthorCode( code, url ) {

            if(code==""){
                alert("프로그램 권한코드를 설정해주세요.");
                return;
            }else{
                window.location = url;
            }
        }

    </script>

</head>
<body>
<style>
    td,th {border: 1px solid #000 !important;}
</style>
<div class="contents">
    <h1 class="subHeader">게시판 사용자 권한</h1>
    <div style="margin:5px 0 5px 0">

        <form id="programVO" name="searchForm" action="/neo/selectProgramList.do" method="get">

            <select id="pageUnit" name="pageUnit">
                <option value="10" selected="selected">10 페이지</option>
                <option value="20">20 페이지</option>
                <option value="30">30 페이지</option>
                <option value="40">40 페이지</option>
                <option value="50">50 페이지</option>
            </select>

            <select id="searchCnd" name="searchCnd">
                <option value="all" selected="selected">전체</option>
                <option value="progrmNm">게시판명</option>
                <option value="progrmUrl">담당부서</option>
                <option value="progrmUrl">담당직원</option>
                <option value="progrmUrl">담당자아이디</option>
            </select>
            <input id="searchKrwd" name="searchKrwd" class="txt" type="text" value="">

            <span class="button black"><input type="submit" value="검색"></span>

        </form>

    </div>
    <div class="clearfix topMargin">
        <div class="floatLeft">
            총 : ${fn:length(mapControllers)} 건
        </div>
        <div class="floatRight">
            5 / 123
        </div>
    </div>
    <div class="table_fixed_wrap is_bottom_wrap">
        <div id="tableScroll" class="data_table">
            <div class="scroll_view">
                <table>
                    <colgroup>
                        <col class="specWidth100px"/>
                        <col class="specWidth160px"/>
                        <col class="specWidth160px"/>
                        <col class="specWidth160px"/>
                        <col class="specWidth80px"/>
                        <col class="specWidth80px"/>
                        <col class="specWidth60px"/>
                        <col class="specWidth60px"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>컴포넌트명</th>
                        <th>컴포넌트URL</th>
                        <th>인터셉터</th>
                        <th>파람</th>
                        <%--        <th>담당자</th>--%>
                        <th>작성</th>
                        <th>삭제</th>
                        <th>보기</th>
                        <th>목록</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${mapControllers}" var="cont">
                        <tr>
                            <th colspan="8">${cont.key}</th>
                        </tr>
                        <tr>
                            <th colspan="8"><select name="ctgryNm" id="ctgryNm" class="p-input p-input--auto chosen-select" multiple data-placeholder=" 선택" data-no_results_text="담당자가 존재하지 않습니다." >
                                <optgroup label="부서">
                                    <option value="|관리부서(DEPT101011)|" selected="selected" >관리부서(DEPT101011)</option>
                                    <option value="|관리부서(DEPT101011)|" >관리부서1(DEPT201011)</option>
                                    <option value="|관리부서(DEPT101011)|" >관리부서2(DEPT301011)</option>
                                    <option value="|관리부서(DEPT101011)|" >관리부서3(DEPT401011)</option>
                                </optgroup>
                                <optgroup label="직원코드">
                                    <option value="|김직원(EMPL102912)|"  >김직원(EMPL102912)</option>
                                    <option value="|박직원(EMPL222222)|"   >박직원(EMPL222222)</option>
                                    <option value="|신직원(EMPL333333)|">신직원(EMPL333333)</option>
                                    <option value="|이직원(EMPL444444)|" >이직원(EMPL444444)</option>
                                </optgroup>
                                <optgroup label="직원아이디">
                                    <option value="|박경덕(r4erad)|"  >박경덕(r4erad)</option>
                                    <option value="|박삼덕(r4erad)|" >박삼덕(r3erad)</option>
                                    <option value="|박이덕(r4erad)|"  >박이덕(r2erad)</option>
                                </optgroup>
                            </select></th>
                        </tr>
                        <c:forEach items="${cont.value}" var="methods">
                            <c:set var="name" value="${fn:split(methods, '_')[0]}"/>
                            <c:set var="val" value="${fn:split(methods, '_')[1]}"/>
                            <c:set var="intercept" value="${fn:split(methods, '_')[2]}"/>
                            <c:set var="params" value="${fn:split(methods, '_')[3]}"/>
                            <c:set var="priv" value="${fn:split(methods, '_')[4]}"/>


                            <tr <c:if test="${fn:trim(priv) eq 'true' }">class="privacy"</c:if>>
                                <td>${name}</td>
                                <td>${val}</td>
                                <td>${intercept}</td>
                                <td>${params}</td>
                                <td class="textACenter">${priv}</td>
                                <td class="textACenter"><input type="checkbox" /></td>
                                <td class="textACenter"><input type="checkbox" /></td>
                                <td class="textACenter"><input type="checkbox" /></td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="8" style="border-left:0px !important;border-right:0px !important;background-color: white !important;"><br /><br />&nbsp;</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>



    <div class="clearfix topMargin">
        <div class="floatLeft">
        </div>
        <div class="floatRight">
            <a href="#1" class="iconButton blue"><span>등록</span></a>
        </div>
    </div>
    <style>
        tbody tr th:nth-child( 1 ) {width:150px;}
        tbody tr th:nth-child( 2 ) {width:150px;}
        .chosen-select{ width:97%;}
        tbody tr td:nth-child( 1 ) {width:150px;}
        tbody tr td:nth-child( 2 ) {width:150px;}
        tbody tr td:nth-child( 3 ) {width:150px;}
        tbody tr td:nth-child( 4 ) {width:150px;}
        tbody tr td:nth-child( n + 5 ) {width:50px;}
        tbody tr.privacy td {background: #999999 !important;}
    </style>

    <link rel="stylesheet" href="/common/css/chosen.css" />
    <script src="/common/js/chosen/chosen.jquery.min.js"></script>
    <script src="/common/js/chosen/prism.js"></script>
    <script src="/common/js/chosen/init.js"></script>
</div>


<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>
</body>
</html>