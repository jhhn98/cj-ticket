<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="ATC_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

    <title>공통첨부파일 등록</title>
    <meta name="decorator" content="neo" />
    <script src="<c:url value="/common/js/jquery-3.6.0.min.js"/>"></script>
    <script nonce="NEOCMSSCRIPT">
        function fn_regist(){
            $('[name=cmmnAtchThmbInfoVO]').attr("action","./cmmnAtchThmbInfoRegist.do")

            fn_submit("#regist")
        }
        function fn_updt(prefix){
            $('[name=cmmnAtchThmbInfoVO]').attr("action","./cmmnAtchThmbInfoUpdt.do")

            fn_submit("#updt_"+prefix);
        }
        function fn_submit(prefix) {
            var filePrefix = prefix+"_filePrefix";
            var thmbInfoNm = prefix+"_thmbInfoNm";
            var imgWidth   = prefix+"_imgWidth";
            var imgHeight  = prefix+"_imgHeight";

            if($(filePrefix).val() == ""){
                alert("접두사가 입력되지 않았습니다.");
                return false;
            }
            if($(thmbInfoNm).val() == ""){
                alert("썸네일 명칭이 입력되지 않았습니다.");
                return false;
            }
            if($(imgWidth).val() == ""){
                alert("가로값이 입력되지 않았습니다.");
                return false;
            }
            if($(imgHeight).val() == ""){
                alert("세로값이 입력되지 않았습니다.");
                return false;
            }

            $('[name=filePrefix]').val($(filePrefix).val());
            $('[name=thmbInfoNm]').val($(thmbInfoNm).val());
            $('[name=imgWidth]').val($(imgWidth).val());
            $('[name=imgHeight]').val($(imgHeight).val());

            $('[name=cmmnAtchThmbInfoVO]').submit();
        }
    </script>
</head>
<body>

<div class="page_location">
    <span class="depth1_title icon_attch">첨부파일설정</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">공통첨부파일관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">상세보기</span>
</div>
<div class="contents">
    <h2>설정 상세정보</h2>
    <table>
        <colgroup>
            <col class="specWidth170px"/>
            <col/>
        </colgroup>
        <tbody>
        <tr>
            <th scope="row">파일정보 코드</th>
            <td><c:out value="${resultVO.infoCode}"/></td>
        </tr>
        <tr>
            <th scope="row">파일정보 명칭</th>
            <td><c:out value="${resultVO.infoNm}"/></td>
        </tr>
        <tr>
            <th scope="row">파일정보 설명</th>
            <td><c:out value="${resultVO.infoDc}"/></td>
        </tr>
        <tr>
            <th scope="row">저장경로</th>
            <td><c:out value="${realPath }"/><c:out value="${resultVO.storePath}"/></td>
        </tr>
        <tr>
            <th scope="row">파일 최대 사이즈(MB)</th>
            <td><c:out value="${resultVO.fileMaxSize}"/>MB</td>
        </tr>
        <tr>
            <th scope="row">파일 최대 업로드 개수</th>
            <td><c:out value="${resultVO.fileMaxCo}"/></td>
        </tr>
        <tr>
            <th scope="row">허용확장자(,로 구분)</th>
            <td><c:out value="${resultVO.fileLmttExtns}"/></td>
        </tr>
        </tbody>
    </table>
    <h2>이미지 첨부파일 썸네일 설정</h2>
    <table>
        <colgroup>
            <col/>
            <col/>
            <col/>
            <col/>
            <col style="width:8%;"/>
        </colgroup>
        <thead>
        <tr>
            <th scope="col">접두사</th>
            <th scope="col">썸네일 명칭</th>
            <th scope="col">가로</th>
            <th scope="col">세로</th>
            <th scope="col">변경저장</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${tmhbResults}" varStatus="status">
            <tr>
                <td class="textACenter">
                    <input type="hidden" value="<c:out value="${result.filePrefix }"/>" id="updt_<c:out value="${result.filePrefix }"/>_filePrefix"/>
                    <c:out value="${result.filePrefix }"/>
                </td>
                <td class="textACenter">
                    <input type="hidden" value="<c:out value="${result.thmbInfoNm }"/>" id="updt_<c:out value="${result.filePrefix }"/>_thmbInfoNm"/>
                    <c:out value="${result.thmbInfoNm }"/></td>
                <td class="textACenter"><input type="text" value="<c:out value="${result.imgWidth }"/>"   id="updt_<c:out value="${result.filePrefix }"/>_imgWidth"/> px</td>
                <td class="textACenter"><input type="text" value="<c:out value="${result.imgHeight }"/>"  id="updt_<c:out value="${result.filePrefix }"/>_imgHeight"/> px</td>
                <td class="textACenter">
                    <a href="#n" class="iconButton edit" onclick="fn_updt('<c:out value="${result.filePrefix}"/>')"><span>수정</span></a>
                    <%--<a href="./cmmnAtchThmbInfoDelete.do?infoCode=<c:out value="${result.infoCode }"/>&amp;filePrefix=<c:out value="${result.filePrefix }"/>" class="iconButton delete" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>--%>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="arrangementWrap marginTop_10">
        <div class="arrLeft">
            <a href="./cmmnAtchInfoList.do?pageIndex=<c:out value="${cmmnAtchInfoVO.pageIndex}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
            <a href="./cmmnAtchInfoUpdtView.do?infoCode=<c:out value="${cmmnAtchInfoVO.infoCode }"/>&amp;pageIndex=<c:out value="${cmmnAtchInfoVO.pageIndex}"/>" class="iconTextButton edit"><span>수정</span></a>
        </div>
    </div>
    <form name="cmmnAtchThmbInfoVO">
        <input type="hidden" name="pageIndex" value="<c:out value="${cmmnAtchInfoVO.pageIndex }"/>"/>
        <input type="hidden" name="infoCode" value="<c:out value="${cmmnAtchInfoVO.infoCode }"/>"/>
        <input type="hidden" name="filePrefix"/>
        <input type="hidden" name="thmbInfoNm"/>
        <input type="hidden" name="imgWidth"/>
        <input type="hidden" name="imgHeight"/>
    </form>
</div>
</body>
</html>