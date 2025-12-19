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
    <form:form modelAttribute="menu" name="menuForm" action="addMultiMenu.do" onsubmit="fn_ajax_submit(this.id);return false;">

        <form:hidden path="siteId"/>
        <form:hidden path="upperMenuNo"/>

        <form:hidden path="deptCode"/>
        <form:hidden path="emplCode"/>
        <div class="form_wrap">
            <p class="info_text">동일한 속성(메뉴명 개별 지정)의 메뉴들을 동시에 생성합니다.</p>
            <table>
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
                        <div class="form_element">
                            <div class="element_wrap el_textarea">
                                <form:textarea path="menuNm" rows="5"/>
                                <form:errors path="menuNm"/>
                            </div>
                        </div>
                        <p class="info_text">메뉴명 입력시 줄바꿈으로 구분하여 메뉴가 생성됩니다.</p>
                    </td>
                </tr>
                <input type="hidden" name="cntntsNm" />
                <input type="hidden" name="subTitle" />
                <input type="hidden" name="menuTy" value="MNTY02" />
                <input type="hidden" name="linkTrget" value="_self" />
                <input type="hidden" name="paramtr" value="" />
                <input type="hidden" name="tabMenuUseAt" id="tabMenuUseAt" value="N" />
                <input type="hidden" name="menuShowAt" id="menuShowAt" value="Y" />
                <input type="hidden" name="deptNm" value="" />
                <input type="hidden" name="emplNm" value="" />
                <input type="hidden" name="emplTelno" value="" />
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
                <input type="hidden" name="koglUseAt" value="<c:out value="${menu.koglUseAt}"/>"/>
                <%--<tr>
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
                </tr>--%>
                </tbody>
            </table>
        </div>
        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
            </div>
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
            url : "/neo/addMultiMenu.do",
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



        formLabelText();
        toggleFunction();

        $("#toggle_upendShowAt").on("change",function(e){
            $("#upendShowAt").val($(this).val());
        });
        $("#toggle_koglUseAt").on("change",function(e){
            $("#koglUseAt").val($(this).val());
        });
    })
</script>

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
<c:if test="${param.act eq 1}">
    <script nonce="NEOCMSSCRIPT">
        //parent.neo_menu.fn_jsonlwprtMenuList(<c:out value="${menu.upperMenuNo}"/>);
        fn_jsonlwprtMenuList(<c:out value="${menu.upperMenuNo}"/>);
    </script>
</c:if>
<div id="slide_right_view" class="employeeView " style="width:600px;height:800px;position:fixed;right:0;top:0;display: none;">

</div>

<form id="departmentForm" name="departmentForm" action="searchMngEmployeeList.do" method="post" >
</form>
