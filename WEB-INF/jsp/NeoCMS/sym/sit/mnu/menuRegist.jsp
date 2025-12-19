<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="menu" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="menu">
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
<script nonce="NEOCMSSCRIPT">
    function fn_initCharger() {
        $("#deptCode").val("");
        $("#deptNm").val("");
        $("#emplCode").val("");
        $("#emplNm").val("");
        $("#emplTelno").val("");
    }
    function fn_selectMenu(){
        fn_getAjaxSync( "./jsonSelectMenu.do?siteId=<c:out value="${menuVO.siteId}"/>&menuNo=" + $("#connectMenuNo").val(), "json", fn_selectMenuConnect );
    }
    function fn_selectMenuConnect( data ) {
        if(data.menuNo != ""){
            $("#preview_menu").val(data.menuNm);
        }else{
            alert("메뉴 정보를 찾을 수 없습니다.");
        }
    }
</script>
<jsp:include page="./subMenu.jsp" />
<div class="dataWrap is_tabNaviStyle2">
<form:form modelAttribute="menu" name="menuForm" action="addMenu.do" onsubmit="fn_ajax_submit(this.id);return false;">

    <form:hidden path="siteId"/>
    <form:hidden path="upperMenuNo"/>
    
    <form:hidden path="deptCode"/>
    <form:hidden path="emplCode"/>
    <div class="form_wrap">
    <table class="settingFormTable">
    <colgroup>
        <col class="specWidth140px"/>
        <col/>
    </colgroup>
    <tbody>
        <tr>
            <th scope="row">상위메뉴</th>
            <td><c:out value="${upperMenu.menuNm}"/></td>
        </tr>
        <tr>
            <th scope="row" class="essential_input"><form:label path="menuNm">메뉴명</form:label></th>
            <td>
                <div class="form_element full">
                    <span class="element_wrap"><form:input path="menuNm" size="60"/> <form:errors path="menuNm"/></span>
                </div>
            </td>
        </tr>
        <form:hidden path="cntntsNm"/>
        <%--<tr>
            <th scope="row"><form:label path="cntntsNm">콘텐츠명</form:label></th>
            <td>
                <div class="form_element full">
                    <span class="element_wrap">
                        <form:input path="cntntsNm" size="60"/> <form:errors path="cntntsNm"/>
                    </span>
                </div>
                <p class="info_text">해당 메뉴의 브라우저 타이틀을 개별로 설정할 수 있습니다.</p>
            </td>
        </tr>--%>
        <form:hidden path="subTitle"/>
        <%--<tr>
            <th scope="row"><form:label path="subTitle">서브 메뉴 제목</form:label></th>
            <td>
                <div class="form_element full">
                    <span class="element_wrap">
                        <form:input path="subTitle" size="60"/> <form:errors path="subTitle"/>
                    </span>
                </div>
                <p class="info_text">서브 메뉴 제목이 필요할경우 입력. sub.ftl에서 사용.<br><span class="point">ex)&#36;&#123;menuInfo.subTitle&#125;</span></p>
            </td>
        </tr>--%>
        <tr>
            <th scope="row" class="essential_input">메뉴유형</th>
            <td>
                <ul class="menuType_select">
                    <li>
                        <div class="form_label">
                            <input id="menuTy1" name="menuTy" type="radio" value="MNTY01" <c:if test="${'MNTY01' eq menu.menuTy}">checked="checked"</c:if>/>
                            <label for="menuTy1"><span class="menu_type_icon icon1">하위메뉴링크</span></label>
                        </div>
                    </li>
                    <li>
                        <div class="form_label">
                            <input id="menuTy2" name="menuTy" type="radio" value="MNTY02" <c:if test="${'MNTY02' eq menu.menuTy}">checked="checked"</c:if>/>
                            <label for="menuTy2"><span class="menu_type_icon icon2">콘텐츠</span></label>
                        </div>
                        <div class="form_input">
                            <span class="eng_text">/repository/<c:out value="${menu.siteId}"/>/contents/<c:out value="${menu.menuNo}"/>.html</span>
                            <a href="./updateContentsTextView.do?siteId=<c:out value="${menu.siteId}"/>&menuNo=<c:out value="${menu.menuNo}"/>" onclick="moveTreeContents(this.href);return false;" class="iconTextButton edit small marginLeft_10"><span>콘텐츠 편집</span></a>
                        </div>
                    </li>
                    <c:set var="buttonCount" value="one"/>
                    <c:if test="${bbsVO.bbsNm ne '' && bbsVO.bbsNm ne null}">
                        <c:set var="buttonCount" value="three"/>
                    </c:if>
                    <li class="isFormButton element_count_${buttonCount}">
                        <div class="form_label">
                            <input id="menuTy3" name="menuTy" type="radio" value="MNTY03" <c:if test="${'MNTY03' eq menu.menuTy}">checked="checked"</c:if>/>
                            <label for="menuTy3"><span class="menu_type_icon icon3">게시판</span></label>
                        </div>
                        <div class="form_input">
                            <input type="hidden" name="bbsNo" id="bbsNo" value="<c:out value="${menu.bbsNo}"/>" />
                            <input type="text" name="bbsNm" id="bbsNm" size="40" readonly="readonly" value="<c:if test="${bbsVO.bbsNm ne '' && bbsVO.bbsNm ne null}">[<c:out value="${bbsVO.skinNm}"/>] </c:if><c:out value="${bbsVO.bbsNm}"/>" placeholder="게시판 선택"/>
                        </div>
                        <div class="form_button">
                            <a href="./popupBbsNttExpView.do?siteId=<c:out value="${menu.siteId}"/>"  class="textButton small search boardSearch"><span>검색</span></a>
                            <c:if test="${bbsVO.bbsNm ne '' && bbsVO.bbsNm ne null}">
                                <a href="./updateBbsInfoView.do?siteId=<c:out value="${menu.siteId}"/>&bbsNo=<c:out value="${menu.bbsNo}"/>" class="textButton small set"><span>관리</span></a>
                                <a href="#bbsDisConnect" onclick="fn_bbsDisConnect();" class="textButton small delete"><span>연결해제</span></a>
                            </c:if>
                        </div>
                    </li>
                    <c:set var="buttonCount" value="one"/>
                    <c:if test="${programVO != null && programVO.progrmNm ne '' && programVO.progrmNm ne null}">
                        <c:set var="buttonCount" value="two"/>
                    </c:if>
                    <li class="isFormButton element_count_${buttonCount}">
                        <div class="form_label">
                            <input id="menuTy4" name="menuTy" type="radio" value="MNTY04" <c:if test="${'MNTY04' eq menu.menuTy}">checked="checked"</c:if>/>
                            <label for="menuTy4"><span class="menu_type_icon icon4">프로그램</span></label>
                        </div>
                        <div class="form_input">
                            <input type="hidden" name="progrmNo" id="progrmNo" value="<c:out value="${menu.progrmNo}"/>" />
                            <input type="text" name="progrmNm" id="progrmNm" size="40" readonly="readonly" value="<c:if test="${programVO != null && programVO.progrmNm ne '' && programVO.progrmNm ne null}"></c:if><c:out value="${programVO.progrmNm}"/>"/>
                        </div>
                        <div class="form_button">
                            <a href="./popupProgramList.do?siteId=<c:out value="${menu.siteId}"/>" class="textButton small search programSearch"><span>검색</span></a>
                            <c:if test="${programVO != null && programVO.progrmNm ne '' && programVO.progrmNm ne null}">
                                <a href="#prgDisConnect" onclick="fn_prgDisConnect();" class="textButton small delete"><span>연결해제</span></a>
                            </c:if>
                        </div>
                    </li>
                    <li class="inner_import isFormButton element_count_one">
                        <div class="form_label">
                            <input id="menuTy5" name="menuTy" type="radio" value="MNTY05" <c:if test="${'MNTY05' eq menu.menuTy}">checked="checked"</c:if>/>
                            <label for="menuTy5"><span class="menu_type_icon icon6">내부파일</span></label>
                        </div>
                        <div class="form_input">
                                <%--<form:input path="innerFile" size="60" placeholder="내부파일 선택 또는 경로 입력"/>--%>
                            <input type="text" id="innerFile" name="innerFile" value="<c:out value="${menu.innerFile}"/>" placeholder="내부파일 경로 직접 입력" <%--class="location_input"--%>/>
                            <form:hidden path="connectMenuNo" size="8" placeholder="사용할 컨텐츠의 key번호 입력" cssClass="content_number_input"/>
                        </div>
                        <div class="form_button">
                            <a href="/neo/popupContentsSearch.do" class="textButton small search contentsSearch"><span>검색</span></a>
                        </div>
                    </li>
                    <li>
                        <div class="form_label">
                            <input id="menuTy6" name="menuTy" type="radio" value="MNTY06" <c:if test="${'MNTY06' eq menu.menuTy}">checked="checked"</c:if>/>
                            <label for="menuTy6"><span class="menu_type_icon icon5">링크</span></label>
                        </div>
                        <div class="form_input"><form:input path="linkUrl" size="60"/></div>
                    </li>
                        <%--<li>
                            <div class="form_label">
                                <input id="menuTy8" name="menuTy" type="radio" value="MNTY08" <c:if test="${'MNTY08' eq menu.menuTy}">checked="checked"</c:if>/>
                                <label for="menuTy8"><span class="menu_type_icon icon7">아이프레임</span></label>
                            </div>
                            <div class="form_input input_element_two">
                                <form:input path="iframeUrl" size="60" placeholder="아이프레임 URL"/>
                                <form:input path="iframeStyle" placeholder="아이프레임 스타일(생략가능). 기본 스타일 display:block;max-width:100%;"/>
                            </div>
                            <span class="info_text">iframe에서 가져 올 url 입력</span>
                        </li>--%>
                        <%--<li>
                            <div class="form_element">
                                <span class="element_wrap form_label">
                                    <input id="menuTy9" name="menuTy" type="radio" value="MNTY09" <c:if test="${'MNTY09' eq menu.menuTy}">checked="checked"</c:if>/>
                                    <label for="menuTy9"><span class="menu_type_icon icon8">컨텐츠 연결</span></label>
                                </span>
                                <span class="element_wrap">
    
                                </span>
                            </div>
                            <span class="info_text">입력한 메뉴의 key번호의 컨텐츠를 사용</span>
                        </li>--%>
                </ul>
            </td>
        </tr>

    <%--
        <tr>
            <td><input id="menuTy9" name="menuTy" type="radio" value="MNTY09" <c:if test="${'MNTY09' eq menu.menuTy}">checked="checked"</c:if> />
                <label for="menuTy9"><img src="./images/icon_MNTY09.gif" style="vertical-align:sub"/>  컨텐츠 연결</label>

            </td>
            <td>
                <form:input path="connectMenuNo" size="8"/>
                <a href="#n" onclick="fn_selectMenu()" class="iconButton edit"><span>검색</span></a>
                <input type="text" id="preview_menu" name="preview_menu" style="border:1px solid #ccc;background-color:#eee;width:200px;" value="" readonly="readonly"/>
                <span class="info">입력한 메뉴의 key번호의 컨텐츠를 사용</span>
            </td>
        </tr>
    --%>
        <tr>
            <th scope="row"><form:label path="linkTrget">링크대상</form:label></th>
            <td>
                <div class="form_element">
                    <span class="element_wrap">
                        <form:select path="linkTrget">
                            <form:option value='' label="--선택하세요--" />
                            <c:forEach var="opt" items="${linkTrgetList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq menu.linkTrget ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="linkTrget"/>
                    </span>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row"><form:label path="paramtr">파라미터</form:label></th>
            <td>
                <div class="form_element">
                    <span class="element_wrap">
                        <form:input path="paramtr" size="60"/> <form:errors path="paramtr"/>
                    </span>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row" class="essential_input"><label for="toggle_tabMenuUseAt">하위 탭메뉴</label></th>
            <td>
                <input type="hidden" name="tabMenuUseAt" id="tabMenuUseAt" value="<c:out value="${menu.tabMenuUseAt}"/>" />
                <div class="toggle  <c:out value="${menu.tabMenuUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                    <input type="checkbox" id="toggle_tabMenuUseAt" <c:out value="${menu.tabMenuUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="toggle_tabMenuUseAt" data-true-value="Y" data-false-value="N" value="Y"/>
                    <label for="toggle_tabMenuUseAt">
                        사용여부
                        <span class="toggle_ui">on/off</span>
                    </label>
                    <form:errors path="tabMenuUseAt"/>
                </div>

                <div class="tabNavi_type">
                    <div class="form_element multi_element">
                        <c:forEach var="tabMenuTy" items="${tabMenuTyList}" varStatus="status">
                            <span class="element_wrap  <c:out value="${status.index ne 0 ? 'marginLeft_30':''}"/>">
                                <input id="tabType<c:out value="${status.index}"/>" name="tabMenuTy" type="radio" value="<c:out value="${tabMenuTy.code}"/>" <c:out value="${(menu.tabMenuTy eq tabMenuTy.code) or (empty menu.tabMenuTy and status.index eq 0) ? 'checked=\"checked\"':''}"/>/>
                                <label for="tabType<c:out value="${status.index}"/>"><span><c:out value="${tabMenuTy.codeNm}"/></span></label>
                            </span>
                        </c:forEach>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row" class="essential_input"><label for="toggle_menuShowAt">메뉴 활성화</label></th>
            <td>
                <input type="hidden" name="menuShowAt" id="menuShowAt" value="<c:out value="${menu.menuShowAt}"/>" />
                <div class="form_element">
                    <span class="element_wrap toggle">
                        <input type="checkbox" id="toggle_menuShowAt"  <c:out value="${menu.menuShowAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="toggle_menuShowAt" data-true-value="Y" data-false-value="N"/>
                        <label for="toggle_menuShowAt">
                            사용여부
                            <span class="toggle_ui">on/off</span>
                        </label>
                    </span>
                    <form:errors path="menuShowAt"/>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row" class="essential_input"><label for="toggle_upendShowAt">상단메뉴</label></th>
            <td>
                <input type="hidden" name="upendShowAt" id="upendShowAt" value="<c:out value="${menu.upendShowAt}"/>" />
                <div class="form_element">
                    <span class="element_wrap toggle">
                        <input type="checkbox" id="toggle_upendShowAt"  <c:out value="${menu.upendShowAt eq 'Y' ? 'checked=\"checked\"':''}"/> name="toggle_upendShowAt" data-true-value="Y" data-false-value="N"/>
                        <label for="toggle_upendShowAt">
                            표시여부
                            <span class="toggle_ui">on/off</span>
                        </label>
                    </span>
                    <form:errors path="upendShowAt"/>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row">담당자지정</th>
            <td>
                <div class="manager_assign">
                    <div class="manager_input">
                        <div><form:input path="deptNm" size="20" placeholder="담당부서" title="담당부서"/></div>
                        <div><form:input path="emplNm" size="12" placeholder="담당자" title="담당자"/></div>
                        <div><form:input path="emplTelno" size="12" placeholder="문의처" title="문의처"/></div>
                    </div>
                    <div class="manager_button">
                        <a href="#n" class="textButton small search emplSearch"><span>검색</span></a>
                        <button type="button" onclick="fn_initCharger();" class="textButton small delete"><span>해제</span></button>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th scope="row">공공누리</th>
            <td>
                <input type="hidden" name="koglUseAt" id="koglUseAt" value="<c:out value="${menu.koglUseAt}"/>" />
                <div class="toggle  <c:out value="${menu.koglUseAt eq 'Y' ? 'active':''}"/>" data-element-name="toggle">
                    <input type="checkbox" id="toggle_koglUseAt" name="toggle_koglUseAt" <c:out value="${menu.koglUseAt eq 'Y' ? 'checked=\"checked\"':''}"/> data-true-value="Y" data-false-value="N"/>
                    <label for="toggle_koglUseAt">
                        사용여부
                        <span class="toggle_ui">on/off</span>
                    </label>
                </div>
                <ul class="kogl_layer">
                    <li class="block">
                        <c:if test="${empty menu.koglTy}">
                            <form:radiobutton path="koglTy" value="SITE_DEFAULT" checked="checked"/>
                        </c:if>
                        <c:if test="${not empty menu.koglTy}">
                            <form:radiobutton path="koglTy" value="SITE_DEFAULT"/>
                        </c:if>
                        <label for="koglTy1">사이트 기본 설정 값</label>
                    </li>
                    <li>
                        <form:radiobutton path="koglTy" value="KOGLTY01"/>
                        <label for="koglTy2">
                            제1유형 : 출처표시
                            <em class="kogl_summary">
                                <i class="kogl_img type1">OPEN 출처표시 공공누리 공공저작물 자유이용허락</i>
                            </em>
                        </label>
                    </li>
                    <li>
                        <form:radiobutton path="koglTy" value="KOGLTY02"/>
                        <label for="koglTy3">
                            제2유형 : 출처 표시 + 상업적 이용금지
                            <em class="kogl_summary">
                                <i class="kogl_img type2">OPEN 출처표시 상업용금지 공공누리 공공저작물 자유이용허락</i>
                            </em>
                        </label>
                    </li>
                    <li>
                        <form:radiobutton path="koglTy" value="KOGLTY03"/>
                        <label for="koglTy4">
                            제3유형 : 출처 표시 + 변경금지
                            <em class="kogl_summary">
                                <i class="kogl_img type3">OPEN 출처표시 변경금지 공공누리 공공저작물 자유이용허락</i>
                            </em>
                        </label>
                    </li>
                    <li>
                        <form:radiobutton path="koglTy" value="KOGLTY04"/>
                        <label for="koglTy5">
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
    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft"></div>
        <div class="arrRight">
            <button type="submit" class="iconTextButton write"><span>등록</span></button>
        </div>
    </div>

</form:form>
</div>
<c:if test="${param.act eq 1}">
    <script nonce="NEOCMSSCRIPT">
        //parent.neo_menu.fn_jsonlwprtMenuList(<c:out value="${menu.upperMenuNo}"/>);
        fn_jsonlwprtMenuList(<c:out value="${menu.upperMenuNo}"/>);
    </script>
</c:if>
<c:if test="${param.newUpper ne  param.oldUpper}">
    <script nonce="NEOCMSSCRIPT">
        fn_jsonlwprtMenuList(<c:out value="${param.newUpper}"/>);
        fn_jsonlwprtMenuList(<c:out value="${param.oldUpper}"/>);
        //parent.neo_menu.fn_jsonlwprtMenuList(<c:out value="${param.newUpper}"/>);
        //parent.neo_menu.fn_jsonlwprtMenuList(<c:out value="${param.oldUpper}"/>);
    </script>
</c:if>

<script nonce="NEOCMSSCRIPT">
    function fn_initCharger() {
        $("#deptCode").val("");
        $("#deptNm").val("");
        $("#emplCode").val("");
        $("#emplNm").val("");
        $("#emplTelno").val("");
    }
    function fn_bbsDisConnect() {
        $("#bbsNo").val("");
        $("#bbsNm").val("");
    }
    function fn_prgDisConnect() {
        $("#progrmNo").val("");
        $("#progrmNm").val("");
    }
    function menuFormSubmit(){
        var queryString = $("form[name=menuForm]").serialize() ;
        $.ajax({
            type : "POST",
            url : "/neo/addMenu.do",
            dataType : "text",
            data : queryString,
            error : function(){
                alert("파일을 호출하지 못했습니다.");
            },
            success : function(data){
                alert(data);
            }
        });
    }
    var effect = 'slide';
    var options = { direction: 'right' };
    var duration = 500;
    $(document).ready(function(){



        /** 게시판 검색 버튼에 대한 액션 */
        $(".boardSearch").click(function (e){
            e.preventDefault();
            var url = $(this).attr("href");
            movePopupContents(url);
            $('#slide_right_view').show(effect, options, duration);
        });
        /** /// 게시판 검색 버튼에 대한 액션끝 */

        /** 프로그램 검색 버튼에 대한 액션 */
        $(".programSearch").click(function (e) {
            e.preventDefault();
            var url = $(this).attr("href");
            movePopupContents(url);
            $('#slide_right_view').show(effect, options, duration);
        });
        /** /// 프로그램 검색 버튼에 대한 액션끝 */

        /** 컨텐츠 검색 버튼에 대한 액션 */
        $(".contentsSearch").click(function (e) {
            e.preventDefault();
            var url = $(this).attr("href");
            movePopupContents(url);
            $('#slide_right_view').show(effect, options, duration);
        });
        /** /// 컨텐츠 검색 버튼에 대한 액션끝 */

        /** 직원 검색 버튼에 대한 액션 */
        $(".emplSearch").click(function (e) {
            e.preventDefault();
            fn_ajax_search_submit("departmentForm");
            $('#slide_right_view').show(effect, options, duration);
        });

        toggleFunction();


        $("#toggle_tabMenuUseAt").on("change",function(e){
            $("#tabMenuUseAt").val($(this).val());
        });
        $("#toggle_menuShowAt").on("change",function(e){
            $("#menuShowAt").val($(this).val());
        });
        $("#toggle_upendShowAt").on("change",function(e){
            $("#upendShowAt").val($(this).val());
        });
        $("#toggle_koglUseAt").on("change",function(e){
            $("#koglUseAt").val($(this).val());
        });
    })
</script>
<c:if test="${param.act eq 1}">
<script nonce="NEOCMSSCRIPT">
    fn_jsonlwprtMenuList(<c:out value="${menu.upperMenuNo}"/>);
    //parent.neo_menu.fn_jsonlwprtMenuList(<c:out value="${menu.upperMenuNo}"/>);
</script>
</c:if>

<script nonce="NEOCMSSCRIPT">

    function selectEmployee(employee){

        var emplCode = $(employee).data("emplcode");
        var deptCode = $(employee).data("deptcode");
        var emplNm = $(employee).data("emplnm");
        var emplTelno = $(employee).data("empltelno");
        var deptNm = $(employee).data("deptnm");

        $("#deptCode").val(deptCode);
        $("#emplCode").val(emplCode);
        $("#deptNm").val(deptNm);
        $("#emplNm").val(emplNm);
        $("#emplTelno").val(emplTelno);

        closeSlideView();
    }
    /** /// 직원 검색 버튼에 대한 액션끝 */

    function closeSlideView(){
        $('#slide_right_view').hide(effect, options, duration);
    }

    function fn_ajax_search_submit(form_id){
        var formData = $("#"+form_id).serialize();
        var url = $("#"+form_id).attr("action");
        jQuery(spinner).css('display', '');
        $.ajax({
            cache: false,
            url: url, // 요기에
            type: 'POST',
            data: formData,
            success: function (res) {
                jQuery(spinner).css('display', 'none');
                $("#slide_right_view").html(res);
            }, // success
            error: function (request,xhr, status) {
                //alert(request.responseText);
                alert("에러가 발생하였습니다.");
                jQuery(spinner).css('display', 'none');
            },
            complete: function () {
                jQuery(spinner).css('display', 'none');
            }
        });
        return false;
    }

    function movePopupContents(menuUrl){
        jQuery(spinner).css('display', '');
        $.ajax({
            url: menuUrl,
            method: 'post',
            success: function(res) {
                $("#slide_right_view").html(res);
                jQuery(spinner).css('display', 'none');

            },
            error : function( request, status, error ) {
                if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
                    alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                    location.href = "/neo/index.do";
                }else{
                    //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				alert("에러가 발생하였습니다. 새로고침 후 다시확인하여주세요");
                }
                jQuery(spinner).css('display', 'none');
            },
            complete: function(){
                jQuery(spinner).css('display', 'none');
            }

        });
        return false;
    }
</script>

<div id="slide_right_view" class="employeeView"></div>

<form id="departmentForm" name="departmentForm" action="searchMngEmployeeList.do" method="post" >
</form>