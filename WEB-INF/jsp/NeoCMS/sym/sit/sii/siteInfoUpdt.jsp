<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="SITE_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

    <title>사이트정보 수정</title>
    <meta name="decorator" content="neo" />
    <script src="<c:url value='/cmm/validator.do'/>"></script>
    <validator:javascript formName="siteInfo" staticJavascript="false" xhtml="true" cdata="false"/>

    <spring:hasBindErrors name="siteInfo">
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
    <span class="depth1_title icon_site">사이트관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title"><c:out value="${siteInfo.siteNm}"/>(<span class="em_red"><c:out value="${siteInfo.siteId}"/></span>)</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">수정</span>
</div>
<jsp:include page="./subMenu.jsp" />

<div class="dataWrap">
    <form:form modelAttribute="siteInfo" name="siteInfoForm" action="updateSiteInfo.do" onsubmit="return validateSiteInfo(this)">
        <div class="form_wrap isTopBottom">
            <div class="alignHorizontal countThree">
                <div class="elementAlign ">
                    <form:hidden path="siteId"/>
                    <form:hidden path="dfltSiteAt"/>

                    <table>
                        <colgroup>
                            <col class="specWidth140px"/>
                            <col/>
                        </colgroup>
                        <tbody>
                        <tr>
                            <th scope="row">사이트ID</th>
                            <td><c:out value="${siteInfo.siteId}"/></td>
                        </tr>
                        <tr>
                            <th scope="row" class="essential_input"><form:label path="siteSe">사이트구분</form:label></th>
                            <td>
                                <div class="form_element">
                            <span class="element_wrap">
                                <form:select path="siteSe">
                                    <form:option value='' label="--선택하세요--" />
                                    <c:forEach var="opt" items="${siteSeList}">
                                        <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq siteInfo.siteSe ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                    </c:forEach>
                                </form:select>
                                <form:errors path="siteSe"/>
                            </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="essential_input"><form:label path="siteNm">사이트명</form:label></th>
                            <td>
                                <div class="form_element full">
                                    <span class="element_wrap"><form:input path="siteNm" size="40"/> <form:errors path="siteNm"/></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><form:label path="siteAuthr">제작자</form:label></th>
                            <td>
                                <div class="form_element full">
                                    <span class="element_wrap"><form:input path="siteAuthr" size="40"/> <form:errors path="siteAuthr"/></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><form:label path="siteKwrd">키워드</form:label></th>
                            <td>
                                <div class="form_element full">
                                    <span class="element_wrap"><form:input path="siteKwrd" size="80"/> <form:errors path="siteKwrd"/></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><form:label path="siteDc">사이트설명</form:label></th>
                            <td>
                                <div class="form_element full">
                                    <span class="element_wrap"><form:input path="siteDc" size="80"/> <form:errors path="siteDc"/></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="essential_input"><form:label path="siteUrl">사이트URL</form:label></th>
                            <td>
                                <div class="form_element full">
                                    <span class="element_wrap"><form:input path="siteUrl" size="80"/> <form:errors path="siteUrl"/></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="essential_input"><label for="toggle_actvtyAt">활성여부</label></th>
                            <td>
                                <input type="hidden" name="actvtyAt" id="actvtyAt" value="<c:out value="${siteInfo.actvtyAt}"/>" />
                                <div class="toggle <c:out value="${siteInfo.actvtyAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                                    <input type="checkbox" id="toggle_actvtyAt" name="toggle_actvtyAt"  value="Y" data-true-value="Y" data-false-value="N" <c:out value="${siteInfo.actvtyAt eq 'Y' ? 'checked=\"checked\"':''}"/>/>
                                    <label for="toggle_actvtyAt">
                                        사용여부
                                        <span class="toggle_ui">on/off</span>
                                    </label>
                                </div>
                                    <%--
                                    <div class="form_element">
                                        <span class="element_wrap full">
                                            <form:select path="actvtyAt">
                                                <form:option value='' label="--선택하세요--" />
                                                <c:forEach var="opt" items="${actvtyAtList}">
                                                    <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq siteInfo.actvtyAt ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                                </c:forEach>
                                            </form:select>
                                            <form:errors path="actvtyAt"/>
                                        </span>
                                    </div>
                                    --%>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><form:label path="insttAdres">기관주소</form:label></th>
                            <td>
                                <div class="form_element full">
                            <span class="element_wrap"><form:input path="insttAdres" size="80"/> <form:errors path="insttAdres"/>
                            </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><form:label path="insttTelno">기관연락처</form:label></th>
                            <td>
                                <div class="form_element full">
                                    <span class="element_wrap"><form:input path="insttTelno" size="40"/> <form:errors path="insttTelno"/></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><form:label path="insttFax">기관팩스</form:label></th>
                            <td>
                                <div class="form_element full">
                                    <span class="element_wrap"><form:input path="insttFax" size="40"/> <form:errors path="insttFax"/></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><form:label path="insttEmail">기관이메일</form:label></th>
                            <td>
                                <div class="form_elementfull">
                                    <span class="element_wrap"><form:input path="insttEmail" size="40"/> <form:errors path="insttEmail"/></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><form:label path="siteCpyrht">사이트저작권</form:label></th>
                            <td>
                                <div class="form_element full">
                                    <span class="element_wrap"><form:input path="siteCpyrht" size="80"/> <form:errors path="siteCpyrht"/></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="essential_input"><form:label path="tmplatId">템플릿</form:label></th>
                            <td>
                                <div class="form_element">
                            <span class="element_wrap">
                                <form:select path="tmplatId">
                                    <form:option value='' label="--선택하세요--" />
                                    <c:forEach var="opt" items="${templateList}">
                                        <option value="<c:out value="${opt.tmplatId}"/>" <c:out value="${opt.tmplatId eq siteInfo.tmplatId ? 'selected=true':''}"/>><c:out value="${opt.tmplatNm}"/></option>
                                    </c:forEach>
                                </form:select>
                                <form:errors path="tmplatId"/>
                            </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="essential_input">공공누리</th>
                            <td>
                                    <%--
                                    <form:select path="koglUseAt">
                                        <c:forEach var="opt" items="${koglAtList}">
                                            <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq siteInfo.koglUseAt ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                        </c:forEach>
                                    </form:select>
                                    --%>
                                <input type="hidden" name="koglUseAt" id="koglUseAt" value="<c:out value="${siteInfo.koglUseAt}"/>" />
                                <div class="toggle  <c:out value="${siteInfo.koglUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                                    <input type="checkbox" id="toggle_koglUseAt" name="toggle_koglUseAt" <c:out value="${siteInfo.koglUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> data-true-value="Y" data-false-value="N"/>
                                    <label for="toggle_koglUseAt">
                                        사용여부
                                        <span class="toggle_ui">on/off</span>
                                    </label>
                                </div>
                                <ul class="kogl_layer">
                                    <li>
                                        <form:radiobutton path="dfltKoglTy" value="KOGLTY01"/>
                                        <label for="dfltKoglTy1">
                                            제1유형 : 출처표시
                                            <em class="kogl_summary">
                                                <i class="kogl_img type1">OPEN 출처표시 공공누리 공공저작물 자유이용허락</i>
                                            </em>
                                        </label>
                                    </li>
                                    <li>
                                        <form:radiobutton path="dfltKoglTy" value="KOGLTY02"/>
                                        <label for="dfltKoglTy2">
                                            제2유형 : 출처 표시 + 상업적 이용금지
                                            <em class="kogl_summary">
                                                <i class="kogl_img type2">OPEN 출처표시 상업용금지 공공누리 공공저작물 자유이용허락</i>
                                            </em>
                                        </label>
                                    </li>
                                    <li>
                                        <form:radiobutton path="dfltKoglTy" value="KOGLTY03"/>
                                        <label for="dfltKoglTy3">
                                            제3유형 : 출처 표시 + 변경금지
                                            <em class="kogl_summary">
                                                <i class="kogl_img type3">OPEN 출처표시 변경금지 공공누리 공공저작물 자유이용허락</i>
                                            </em>
                                        </label>
                                    </li>
                                    <li>
                                        <form:radiobutton path="dfltKoglTy" value="KOGLTY04"/>
                                        <label for="dfltKoglTy4">
                                            제4유형 : 출처표시 + 상업용금지 + 변경금지
                                            <em class="kogl_summary">
                                                <i class="kogl_img type4">OPEN 출처표시 상업용금지 변경금지 공공누리 공공저작물 자유이용허락</i>
                                            </em>
                                        </label>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="elementAlign incForm">
                    <h2 class="marginTop_0">메인 게시판 관리</h2>
                    <table>
                        <colgroup>
                            <col class="specWidth140px"/>
                            <col/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>게시판코드</th>
                            <th>게시판명</th>
                            <th>게시판번호</th>
                            <th>게시물갯수</th>
                            <th>삭제</th>
                        </tr>
                        </thead>
                        <tbody class="textACenter" id="siteBbsHolder">
                        <c:forEach items="${incBbsList}" var="item" varStatus="status" >
                            <tr>
                                <td>\${boardList<c:out value="${status.index + 1}" />}</td>
                                <td><c:out value="${item.bbsNm}" /></td>
                                <td><c:out value="${item.bbsNo}" /></td>
                                <td><c:out value="${item.viewCnt}" /></td>
                                <td><button type="button" class="delete" onclick="deleteSiteBbs('<c:out value="${item.bbsNo}" />')">삭제</button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="input_group" style="display: table-row;">
                        <div class="add_select" style="width:400px;display: table-cell;">
                            <select name="bbsNo" id="bbsNo" class="p-input p-input--auto chosen-select" style="width:400px;" data-placeholder="게시판 선택" data-no_results_text="사이트에 게시판이 존재하지 않습니다." >
                                <c:forEach items="${bbsList}" var="item" varStatus="status" >
                                    <option value="<c:out value="${item.bbsNo}"/>"><c:out value="${item.bbsNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="text" style="display: table-cell; width:100px;" name="bbsViewCnt" id="bbsViewCnt" value="" class="ipfield" title="가져올 게시물 갯수" placeholder="가져올 게시물 갯수">
                        <div class="add_btn" style="display: table-cell; width:100px;">
                            <button type="button" class="add" style="width:27px;" onclick="addSiteBbs()">추가</button>
                        </div>
                    </div>


                    <h2 class="marginTop_10">메인 배너존 관리</h2>
                    <table>
                        <colgroup>
                            <col class="specWidth140px"/>
                            <col/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>배너존코드</th>
                            <th>배너존명</th>
                            <th>배너존번호</th>
                            <th>삭제</th>
                        </tr>
                        </thead>
                        <tbody class="textACenter" id="siteBannerZoneHolder">
                        <c:forEach items="${incBannerZoneList}" var="item" varStatus="status" >
                            <tr>
                                <td>\${bannerZone<c:out value="${status.index + 1}" />}</td>
                                <td><c:out value="${item.bannerZoneNm}" /></td>
                                <td><c:out value="${item.bannerZoneNo}" /></td>
                                <td><button type="button" class="delete" onclick="deleteSiteBannerZone('<c:out value="${item.bannerZoneNo}" />')">삭제</button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="input_group" style="display: table-row;">
                        <div class="add_select" style="width:400px;display: table-cell;">
                            <select name="bannerZoneNo" id="bannerZoneNo" class="p-input p-input--auto chosen-select" style="width:400px;"  data-placeholder="배너존 선택" data-no_results_text="사이트에 배너존이 존재하지 않습니다." >
                                <c:forEach items="${bannerZoneList}" var="item" varStatus="status" >
                                    <option value="<c:out value="${item.bannerZoneNo}"/>" ><c:out value="${item.bannerZoneNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="add_btn" style="display: table-cell; width:100px;">
                            <button type="button" class="add" style="width:27px;" onclick="addSiteBannerZone()">추가</button>
                        </div>
                    </div>

                    <h2 class="marginTop_10">메인 팝업존 관리</h2>
                    <table>
                        <colgroup>
                            <col class="specWidth140px"/>
                            <col/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>팝업존코드</th>
                            <th>팝업존명</th>
                            <th>팝업존번호</th>
                            <th>삭제</th>
                        </tr>
                        </thead>
                        <tbody class="textACenter" id="sitePopupZoneHolder">
                        <c:forEach items="${incPopupZoneList}" var="item" varStatus="status" >
                            <tr>
                                <td>\${popupZone<c:out value="${status.index + 1}" />}</td>
                                <td><c:out value="${item.popupZoneNm}" /></td>
                                <td><c:out value="${item.popupZoneNo}" /></td>
                                <td><button type="button" class="delete" onclick="deleteSitePopupZone('<c:out value="${item.popupZoneNo}" />')">삭제</button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="input_group" style="display: table-row;">
                        <div class="add_select" style="width:400px;display: table-cell;">
                            <select name="popupZoneNo" id="popupZoneNo" class="p-input p-input--auto chosen-select" style="width:400px;"  data-placeholder="팝업존 선택" data-no_results_text="사이트에 팝업존이 존재하지 않습니다." >
                                <c:forEach items="${popupZoneList}" var="item" varStatus="status" >
                                    <option value="<c:out value="${item.popupZoneNo}"/>" ><c:out value="${item.popupZoneNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="add_btn" style="display: table-cell; width:100px;">
                            <button type="button" class="add" style="width:27px;" onclick="addSitePopupZone()">추가</button>
                        </div>
                    </div>



                    <h2 class="marginTop_10">메인 링크존 관리</h2>
                    <table>
                        <colgroup>
                            <col class="specWidth140px"/>
                            <col/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th>링크존코드</th>
                            <th>링크존명</th>
                            <th>링크존번호</th>
                            <th>삭제</th>
                        </tr>
                        </thead>
                        <tbody class="textACenter" id="siteLinkZoneHolder">
                        <c:forEach items="${incLinkZoneList}" var="item" varStatus="status" >
                            <tr>
                                <td>\${linkZone<c:out value="${status.index + 1}" />}</td>
                                <td><c:out value="${item.linkZoneNm}" /></td>
                                <td><c:out value="${item.linkZoneNo}" /></td>
                                <td><button type="button" class="delete" onclick="deleteSiteLinkZone('<c:out value="${item.linkZoneNo}" />')">삭제</button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="input_group" style="display: table-row;">
                        <div class="add_select" style="width:400px;display: table-cell;">
                            <select name="linkZoneNo" id="linkZoneNo" class="p-input p-input--auto chosen-select" style="width:400px;"  data-placeholder="링크존 선택" data-no_results_text="사이트에 링크존이 존재하지 않습니다." >
                                <c:forEach items="${linkZoneList}" var="item" varStatus="status" >
                                    <option value="<c:out value="${item.linkZoneNo}"/>" ><c:out value="${item.linkZoneNm}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="add_btn" style="display: table-cell; width:100px;">
                            <button type="button" class="add" style="width:27px;" onclick="addSiteLinkZone()">추가</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a href="./selectSiteInfoList.do?siteSe=<c:out value="${siteInfo.siteSe}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>수정</span></button>
            </div>
        </div>
    </form:form>
    <style>
        .chosen-select{ width:40%;}
        .chosen-single{ padding-top: 5px !important; }
        .incForm .title{display:block;font-weight:300}
        .incForm .input_group button{display:inline-block;width:calc(100% - 33px);font-size:0;vertical-align:top}
        .incForm .input_group input{width:calc(20% - 12px);padding:3px 5px;font-size:13px;height:23px;}
        .incForm .input_group input:nth-child(2){width:calc(50% - 17px);margin:3px 0 0 5px;height:23px;}
        .incForm .input_group select{width:calc(50% - 12px);padding:3px 5px;font-size:13px}
        .incForm .input_group select:nth-child(2){width:calc(50% - 17px);margin:0 0 0 5px}
        .incForm button{display:inline-block;position:relative;width:27px;height:27px;margin:0 0 0 5px;background-color:#999;border-radius:2px;vertical-align:top}
        .incForm button:before{display:block;position:absolute;top:50%;left:50%;width:13px;height:13px;color:#fff;font-size:13px;font-weight:400;line-height:13px;transform:translate(-50%,-50%)}
        .incForm .em_red,.em_red_bold,.template h3{color:#f05}
        .incForm .em_black_bold,.em_blue_bold,.em_gray_bold,.em_green_bold,.em_red_bold{font-weight:600}
        .incForm button.add:before{content:'\f067'}
        .incForm button.delete:before{content:'\f068'}
        .incForm button.add{background-color:#3eb5ae}
        .incForm button.delete{background-color:#f05}
        .incForm li button{margin:5px 0 0;font-size:0}
        .incForm td button{margin:5px 0 0;font-size:0}
    </style>


    <script nonce="NEOCMSSCRIPT">
        $(document).ready(function(){
            formLabelText();
            toggleFunction();
            $("#toggle_actvtyAt").on("change",function(e){
                $("#actvtyAt").val($(this).val());
            });
            $("#toggle_koglUseAt").on("change",function(e){
                $("#koglUseAt").val($(this).val());
            });
        });

        function deleteSiteBbs(bbsNo){
            if(confirm("정말로 삭제 하시겠습니까?")){
                var url = "/neo/deleteSiteBbs.do";
                jQuery(spinner).css('display', '');
                $.ajax({
                    cache: false,
                    url: url,
                    async: false ,
                    type: 'POST',
                    contentType: "application/json",
                    dataType : "json",
                    data: JSON.stringify({"bbsNo":bbsNo,"siteId":'${siteInfo.siteId}'}),
                    success: function (res) {
                        if(res.result == false){
                            alert("에러가 발생하였습니다. 새로고침 후 다시 시도하여주세요.");
                            return;
                        }else{
                            var _i = 0;
                            $("#siteBbsHolder").children().each(function (e){
                                if($(this).find("td:nth-child(3)").html() == bbsNo){
                                    $(this).remove();
                                    return;
                                };

                                _i++;
                                $(this).find("td:nth-child(1)").html("\${boardList" + _i + "}");
                            });
                        }

                    }, // success
                    error: function (request,xhr, status) {
                        alert("에러가 발생하였습니다.");
                        jQuery(spinner).css('display', 'none');
                    },
                    complete: function () {
                        jQuery(spinner).css('display', 'none');
                    }
                });
            }
        }

        function deleteSiteBannerZone(bannerZoneNo){
            if(confirm("정말로 삭제 하시겠습니까?")){
                var url = "/neo/deleteSiteBannerZone.do";
                jQuery(spinner).css('display', '');
                $.ajax({
                    cache: false,
                    url: url,
                    async: false ,
                    type: 'POST',
                    contentType: "application/json",
                    dataType : "json",
                    data: JSON.stringify({"bannerZoneNo":bannerZoneNo,"siteId":'${siteInfo.siteId}'}),
                    success: function (res) {
                        if(res.result == false){
                            alert("에러가 발생하였습니다. 새로고침 후 다시 시도하여주세요.");
                            return;
                        }else{
                            var _i = 0;
                            $("#siteBannerZoneHolder").children().each(function (e){
                                if($(this).find("td:nth-child(3)").html() == bannerZoneNo){
                                    $(this).remove();
                                    return;
                                };
                                _i++;
                                $(this).find("td:nth-child(1)").html("\${bannerZone" + _i + "}");
                            });
                        }

                    }, // success
                    error: function (request,xhr, status) {
                        alert("에러가 발생하였습니다.");
                        jQuery(spinner).css('display', 'none');
                    },
                    complete: function () {
                        jQuery(spinner).css('display', 'none');
                    }
                });
            }
        }
        function deleteSitePopupZone(popupZoneNo){
            if(confirm("정말로 삭제 하시겠습니까?")){
                var url = "/neo/deleteSitePopupZone.do";
                jQuery(spinner).css('display', '');
                $.ajax({
                    cache: false,
                    url: url,
                    async: false ,
                    type: 'POST',
                    contentType: "application/json",
                    dataType : "json",
                    data: JSON.stringify({"popupZoneNo":popupZoneNo,"siteId":'${siteInfo.siteId}'}),
                    success: function (res) {
                        if(res.result == false){
                            alert("에러가 발생하였습니다. 새로고침 후 다시 시도하여주세요.");
                            return;
                        }else{
                            var _i = 0;
                            $("#sitePopupZoneHolder").children().each(function (e){
                                if($(this).find("td:nth-child(3)").html() == popupZoneNo){
                                    $(this).remove();
                                    return;
                                };
                                _i++;
                                $(this).find("td:nth-child(1)").html("\${popupZone" + _i + "}");
                            });
                        }

                    }, // success
                    error: function (request,xhr, status) {
                        alert("에러가 발생하였습니다.");
                        jQuery(spinner).css('display', 'none');
                    },
                    complete: function () {
                        jQuery(spinner).css('display', 'none');
                    }
                });
            }
        }
        function deleteSiteLinkZone(linkZoneNo){
            if(confirm("정말로 삭제 하시겠습니까?")){
                var url = "/neo/deleteSiteLinkZone.do";
                jQuery(spinner).css('display', '');
                $.ajax({
                    cache: false,
                    url: url,
                    async: false ,
                    type: 'POST',
                    contentType: "application/json",
                    dataType : "json",
                    data: JSON.stringify({"linkZoneNo":linkZoneNo,"siteId":'${siteInfo.siteId}'}),
                    success: function (res) {
                        if(res.result == false){
                            alert("에러가 발생하였습니다. 새로고침 후 다시 시도하여주세요.");
                            return;
                        }else{
                            var _i = 0;
                            $("#siteLinkZoneHolder").children().each(function (e){
                                if($(this).find("td:nth-child(3)").html() == linkZoneNo){
                                    $(this).remove();
                                    return;
                                };
                                _i++;
                                $(this).find("td:nth-child(1)").html("\${linkZone" + _i + "}");
                            });
                        }

                    }, // success
                    error: function (request,xhr, status) {
                        alert("에러가 발생하였습니다.");
                        jQuery(spinner).css('display', 'none');
                    },
                    complete: function () {
                        jQuery(spinner).css('display', 'none');
                    }
                });
            }
        }
        function addSiteBbs(){
            var bbsNo = $("#bbsNo").val();
            var bbsNm = $("#bbsNo option:selected").text();
            var bbsViewCnt = $("#bbsViewCnt").val();
            if(bbsViewCnt == ""){
                alert("가져올 게시물 갯수를 숫자만 입력하여주세요.");
                return;
            }
            var url = "/neo/insertSiteBbs.do";
            jQuery(spinner).css('display', '');
            $.ajax({
                cache: false,
                url: url,
                async: false ,
                type: 'POST',
                contentType: "application/json",
                dataType : "json",
                data: JSON.stringify({"bbsNo":bbsNo,"viewCount":bbsViewCnt,"siteId":'${siteInfo.siteId}'}),
                success: function (res) {
                    console.log(res);
                    if(res.result == false){
                        alert(res.msg);
                        return;
                    }else{
                        var idx = $("#siteBbsHolder").children().length + 1;
                        var board = "<tr>\
                                        <td>\${boardList"+idx+"}</td>\
                                        <td>"+bbsNm+"</td>\
                                        <td>"+bbsNo+"</td>\
                                        <td>"+bbsViewCnt+"</td>\
                                        <td><button type=\"button\" class=\"delete\" onclick=\"deleteSiteBbs('"+bbsNo+"')\">삭제</button></td>\
                                    </tr>";
                        $("#siteBbsHolder").append(board);
                    }
                }, // success
                error: function (request,xhr, status) {
                    alert("에러가 발생하였습니다.");
                    jQuery(spinner).css('display', 'none');
                },
                complete: function () {
                    jQuery(spinner).css('display', 'none');
                }
            });
        }
        function addSiteBannerZone(){

            var bannerZoneNo = $("#bannerZoneNo").val();
            var bannerZoneNm = $("#bannerZoneNo option:selected").text();

            var url = "/neo/insertSiteBannerZone.do";
            jQuery(spinner).css('display', '');
            $.ajax({
                cache: false,
                url: url,
                async: false ,
                type: 'POST',
                contentType: "application/json",
                dataType : "json",
                data: JSON.stringify({"bannerZoneNo":bannerZoneNo,"siteId":'${siteInfo.siteId}'}),
                success: function (res) {
                    console.log(res);
                    if(res.result == false){
                        alert(res.msg);
                        return;
                    }else{
                        var idx = $("#siteBannerZoneHolder").children().length + 1;
                        var banner = "<tr>\
                                        <td>\${bannerZone"+idx+"}</td>\
                                        <td>"+bannerZoneNm+"</td>\
                                        <td>"+bannerZoneNo+"</td>\
                                        <td><button type=\"button\" class=\"delete\" onclick=\"deleteSiteBannerZone('"+bannerZoneNo+"')\">삭제</button></td>\
                                    </tr>";
                        $("#siteBannerZoneHolder").append(banner);
                    }
                }, // success
                error: function (request,xhr, status) {
                    alert("에러가 발생하였습니다.");
                    jQuery(spinner).css('display', 'none');
                },
                complete: function () {
                    jQuery(spinner).css('display', 'none');
                }
            });
        }
        function addSitePopupZone(){
            var popupZoneNo = $("#popupZoneNo").val();
            var popupZoneNm = $("#popupZoneNo option:selected").text();

            var url = "/neo/insertSitePopupZone.do";
            jQuery(spinner).css('display', '');
            $.ajax({
                cache: false,
                url: url,
                async: false ,
                type: 'POST',
                contentType: "application/json",
                dataType : "json",
                data: JSON.stringify({"popupZoneNo":popupZoneNo,"siteId":'${siteInfo.siteId}'}),
                success: function (res) {
                    console.log(res);
                    if(res.result == false){
                        alert(res.msg);
                        return;
                    }else{
                        var idx = $("#sitePopupZoneHolder").children().length + 1;
                        var popup = "<tr>\
                                        <td>\${popupZone"+idx+"}</td>\
                                        <td>"+popupZoneNm+"</td>\
                                        <td>"+popupZoneNo+"</td>\
                                        <td><button type=\"button\" class=\"delete\" onclick=\"deleteSitePopupZone('"+popupZoneNo+"')\">삭제</button></td>\
                                    </tr>";
                        $("#sitePopupZoneHolder").append(popup);
                    }
                }, // success
                error: function (request,xhr, status) {
                    alert("에러가 발생하였습니다.");
                    jQuery(spinner).css('display', 'none');
                },
                complete: function () {
                    jQuery(spinner).css('display', 'none');
                }
            });
        }
        function addSiteLinkZone(){
            var linkZoneNo = $("#linkZoneNo").val();
            var linkZoneNm = $("#linkZoneNo option:selected").text();

            var url = "/neo/insertSiteLinkZone.do";
            jQuery(spinner).css('display', '');
            $.ajax({
                cache: false,
                url: url,
                async: false ,
                type: 'POST',
                contentType: "application/json",
                dataType : "json",
                data: JSON.stringify({"linkZoneNo":linkZoneNo,"siteId":'${siteInfo.siteId}'}),
                success: function (res) {
                    console.log(res);
                    if(res.result == false){
                        alert(res.msg);
                        return;
                    }else{
                        var idx = $("#siteLinkZoneHolder").children().length + 1;
                        var link = "<tr>\
                                        <td>\${linkZone"+idx+"}</td>\
                                        <td>"+linkZoneNm+"</td>\
                                        <td>"+linkZoneNo+"</td>\
                                        <td><button type=\"button\" class=\"delete\" onclick=\"deleteSiteLinkZone('"+linkZoneNo+"')\">삭제</button></td>\
                                    </tr>";
                        $("#siteLinkZoneHolder").append(link);
                    }
                }, // success
                error: function (request,xhr, status) {
                    alert("에러가 발생하였습니다.");
                    jQuery(spinner).css('display', 'none');
                },
                complete: function () {
                    jQuery(spinner).css('display', 'none');
                }
            });

        }
    </script>
</div>
<link rel="stylesheet" href="/common/css/chosen.css" />
<script src="/common/js/chosen/chosen.jquery.min.js"></script>
<script src="/common/js/chosen/prism.js"></script>
<script src="/common/js/chosen/init.js"></script>
</body>
</html>