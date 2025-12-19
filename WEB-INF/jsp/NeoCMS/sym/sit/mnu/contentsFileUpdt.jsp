<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<jsp:include page="../mnu/subMenu.jsp" />
<div class="dataWrap is_tabNaviStyle2">
    <form name="atchFileForm" id="atchFileForm" method="post" action="/neo/contentsFileUpdt.do" enctype="multipart/form-data" onsubmit="return updateAtchFile(this)">
        <input type="hidden" name="menuNo" value="<c:out value="${menuResult.menuNo}"/>" />
        <input type="hidden" name="fileNo" value="<c:out value="${cmmnAtchFileInfo.fileNo}"/>" />
        <input type="hidden" name="encAt" id="encAt" value="<c:out value="${cmmnAtchFileInfo.encAt}"/>"/>
        <table>
            <colgroup>
                <col class="specWidth150px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">저장경로</th>
                <td class="eng_text">/<c:out value="${cmmnAtchFileInfo.storePath}"/></td>
            </tr>
            <tr>
                <th scope="row">원본파일명</th>
                <td class="eng_text"><c:out value="${cmmnAtchFileInfo.fileNm}"/></td>
            </tr>
            <tr>
                <th scope="row">저장파일명</th>
                <td class="eng_text"><c:out value="${cmmnAtchFileInfo.storeFileNm}"/></td>
            </tr>
            <tr>
                <th scope="row">확장자</th>
                <td class="eng_text"><c:out value="${cmmnAtchFileInfo.fileExtsn}"/></td>
            </tr>
            <tr>
                <th scope="row">다운로드 URL</th>
                <td class="eng_text"><a href ="/downloadContentsFile.do?key=${menuResult.menuNo}&amp;fileNo=${cmmnAtchFileInfo.fileNo }" class="iconTextLink file">/downloadContentsFile.do?key=${menuResult.menuNo }&fileNo=${cmmnAtchFileInfo.fileNo }</a></td>
            </tr>
            <tr>
                <th scope="row">파일</th>
                <td class="eng_text"><input type="file" name="atchmnfl" id="atchmnfl" /></td>
            </tr>
        </table>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a onclick="moveTreeContents(this.href);return false;" href="./contentsFileList.do?menuNo=<c:out value="${menuResult.menuNo}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton edit"><span>수정</span></button>
            </div>
        </div>
    </form>
</div>
<script nonce="NEOCMSSCRIPT">
    function updateAtchFile(frm) {
        if( !frm.atchmnfl.value ) {
            alert("첨부파일을 선택해 주세요");
            return false;
        }

        fn_ajax_file_submit("atchFileForm","atchmnfl");
        return false
    }
</script>