<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}" />
    <title>${menuInfo.cntntsNm} 목록</title>
</head>
<body>

<div class="p-wrap">
    <div class="col-20">
        <div>
            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
            <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
        </div>

        <form name="contentsEmpl" id="contentsEmpl" action="updateBbsNttByExcel.do" method="post" enctype="multipart/form-data">
            <fieldset>
                <legend><c:out value="${bbs.bbsNm}"/> 게시물 일괄 삭제</legend>
                <input type="hidden" name="bbsNo" value="<c:out value="${bbs.bbsNo}"/>"/>
                <input type="hidden" name="key" value="<c:out value="${key}"/>"/>
                <input type="hidden" name="searchSiteId" value="<c:out value="${bbsMngSearchVO.searchSiteId}"/>"/>
                <input type="hidden" name="searchCnd" value="<c:out value="${bbsMngSearchVO.searchCnd}"/>"/>
                <input type="hidden" name="searchKrwd" value="<c:out value="${bbsMngSearchVO.searchKrwd}"/>"/>
                <input type="hidden" name="pageIndex" value="<c:out value="${bbsMngSearchVO.pageIndex}"/>"/>

                <table class="p-table">
                    <caption><c:out value="${bbs.bbsNm}"/> 게시물 일괄 삭제</caption>
                    <colgroup>
                        <col class="w20p">
                        <col />
                    </colgroup>
                    <tbody class="p-table--th-left">
                    <tr>
                        <th scope="row">게시판명</th>
                        <td><c:out value="${bbs.bbsNm}"/> </td>
                    </tr>
                    <tr>
                        <th scope="row">엑셀 업로드 양식 다운로드</th>
                        <td><a href="#n" onclick="bbsnttDownload()" class="p-button p-button--combine excel" >다운로드</a></td>
                    </tr>
                    <tr>
                        <th scope="row">엑셀파일선택</th>
                        <td><input type="file" name="file"/></td>
                    </tr>
                    </tbody>
                </table>
                <div class="row margin_t_20">
                    <div class="col-12">
                        <a href="#n" onclick="history.back()" class="p-button cancel">뒤로가기 </a>
                    </div>
                    <div class="col-12 right">
                        <input type="submit" class="p-button write" value="업로드">
                    </div>
                </div>
            </fieldset>
        </form>

    </div>
</div>

<script>
    function bbsnttDownload(){
        location.href = "downloadBbsUploadSample.do?key=<c:out value="${key}"/>&bbsNo=<c:out value="${bbs.bbsNo}"/>";
        jQuery(spinner).css('display', 'none');
    }
    function frmSubmitValidate(){

        if($("#bgnde").val() == ""){
            alert("게시물 삭제 시작일을 입력하여주세요.");
            return false;
        }
        if($("#endde").val() == ""){
            alert("게시물 삭제 종료일을 입력하여주세요.");
            return false;
        }
        if($("#bgnde").val().length != 8 || $("#endde").val().length != 8){
            alert("게시물 시작일과 종료일을 정상적으로 입력하여주세요.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>