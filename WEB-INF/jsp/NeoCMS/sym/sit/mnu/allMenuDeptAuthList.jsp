<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<c:set var="active_menu" value="MENU_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="neo" />
    <script src="/neo/js/jquery-3.6.0.min.js"></script>
    <script src="/neo/js/common.js"></script>
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
<div class="contentWrap">
    <div class="page_location">
        <span class="depth1_title icon_site">메뉴관리</span>
        <i class="sign_gt">메뉴 위치 구분 기호 &gt;</i>
        <span class="depth2_title">부서담당자설정</span>
    </div>
    <div class="tab_navigation">
        <a href="./allMenuAuthList.do?siteId=${menu.siteId}&upperMenuNo=${menu.upperMenuNo}" class=" "><span>직원관리자설정</span></a>
        <a href="./allMenuDeptAuthList.do?siteId=${menu.siteId}&upperMenuNo=${menu.upperMenuNo}" class=" current "><span> 부서담당자설정</span></a>
        <a href="#n" class="allArrangement_site iconTextButton write" onclick="changedSaveManager()"><span>변경사항 저장하기</span></a>
    </div>
    <div class="contents is_tab">
        <div class="arrangementWrap data_info">
            <div class="arrLeft" style="width:70%">
                <p class="info_text">메뉴에 부서 단위의 권한을 부여합니다. <span class="em_red">만약 기존에 부서가 아닌 직원담당자가 연결</span>되어있는 메뉴라면 반드시 해제를 선택하여 연결을 제거한 후 등록하여야합니다.</p>
            </div>
            <div class="arrRight" style="width:30%">
                <form id="userInfoVO" name="searchForm" action="/neo/allMenuDeptAuthList.do" method="get">
                    <div class="table_search">
                        <input type="hidden" name="siteId" value="<c:out value="${menu.siteId}"/>"/>
                        <input type="hidden" name="upperMenuNo" value="<c:out value="${menu.upperMenuNo}"/>"/>
                        <span class="srch_element text">
                            <input id="searchKrwd" name="searchKrwd" class="input_text" placeholder="검색어 입력" type="text" value="<c:out value="${menu.searchKrwd}"/>">
                        </span>
                        <span class="srch_element submit">
                            <button type="submit" class="search_button">검색</button>
                        </span>
                    </div>
                </form>
            </div>
        </div>
        <form name="menuMngFrm" id="menuMngFrm" method="post" onsubmit="">
            <div class="table_fixed_wrap">
                <div id="tableScroll" class="data_table">
                    <div class="scroll_view">
                        <table class="allMenuList">
                            <colgroup>
                                <col style="width:auto;"/>
                                <col style="width:145px;"/>
                                <col style="width:145px;"/>
                                <col style="width:145px;"/>
                                <col style="width:60px;"/>
                                <col style="width:60px;"/>
                                <col style="width:140px;"/>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">메뉴명</th>
                                <th scope="col">부서</th>
                                <th scope="col">담당자</th>
                                <th scope="col">문의처</th>
                                <th scope="col">변경</th>
                                <th scope="col">해제</th>
                                <th scope="col">최종변경일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="result" items="${menuList}" varStatus="ix">
                                <c:if test="${ix.first eq false}">
                                    <c:set var="cos" value="${5 - result.menuLevel}" />
                                    <c:if test="${(empty result.emplCode)}">
                                        <tr class="menuLevel mLv${cos}" data-display="true">
                                            <td><div class="menu_name"><span class="menuType ${result.menuTy}">${result.menuNm}</span></div></td>
                                            <td class="textACenter"><input type="hidden" name="menuNo" id="menuNo_${result.menuNo}" value="${result.menuNo}" />
                                                <input type="hidden" name="emplCode" id="emplCode_${result.menuNo}" value="${result.emplCode}"  />
                                                <input type="hidden" name="deptCode" id="deptCode_${result.menuNo}" value="${result.deptCode}"  />
                                                <input type="text" name="deptNm" id="deptNm_${result.menuNo}" value="${result.deptNm}" readonly="readonly" class="disabled"/></td>
                                            <td class="textACenter"><input type="text" name="emplNm" id="emplNm_${result.menuNo}" value="${result.emplNm}" style="color:black;" onchange="emplNmChange('${result.menuNo}')"/></td>
                                            <td class="textACenter"><input type="text" name="emplTelno" id="emplTelno_${result.menuNo}" value="${result.emplTelno}" style="color:black;"  onchange="emplTelnoChange('${result.menuNo}')"/></td>
                                            <td class="textACenter"><a href="#1" class="iconButton userLink changeManager"><span>변경</span></a>
                                                <a href="#1" class="iconButton unlink selectManager" data-menuno="${result.menuNo}"  style="display: none"><span>선택</span></a>
                                            </td>
                                            <td class="textACenter"><a href="#1" class="iconButton userUnlink clearManager" data-menuno="${result.menuNo}"><span>해제</span></a></td>
                                            <td class="textACenter">${result.lastUpdusrPnttmYMDHMSWithBar}</td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${(not empty result.emplCode)}">
                                        <tr class="menuLevel mLv${cos}" data-display="true">
                                            <td><div class="menu_name"><span class="menuType ${result.menuTy}">${result.menuNm}</span></div></td>
                                            <td class="textACenter"><input type="hidden" name="menuNo" id="menuNo_${result.menuNo}" value="${result.menuNo}" />
                                                <input type="hidden" name="emplCode" id="emplCode_${result.menuNo}" value="${result.emplCode}"  />
                                                <input type="hidden" name="deptCode" id="deptCode_${result.menuNo}" value="${result.deptCode}"  />
                                                <input type="text" name="deptNm" id="deptNm_${result.menuNo}" value="${result.deptNm}" readonly="readonly" class="disabled"/></td>
                                            <td class="textACenter"><input type="text" name="emplNm" id="emplNm_${result.menuNo}" value="${result.emplNm}" readonly="readonly" class="disabled" onchange="emplNmChange('${result.menuNo}')"/></td>
                                            <td class="textACenter"><input type="text" name="emplTelno" id="emplTelno_${result.menuNo}" value="${result.emplTelno}" readonly="readonly" class="disabled" onchange="emplTelnoChange('${result.menuNo}')"/></td>
                                            <td class="textACenter"><a href="#1" class="iconButton userLink changeManager"><span>변경</span></a>
                                                <a href="#1" class="iconButton unlink selectManager" data-menuno="${result.menuNo}"  style="display: none"><span>선택</span></a>
                                            </td>
                                            <td class="textACenter"><a href="#1" class="iconButton userUnlink clearManager" data-menuno="${result.menuNo}"><span>해제</span></a></td>
                                            <td class="textACenter">${result.lastUpdusrPnttmYMDHMSWithBar}</td>
                                        </tr>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>

                        <script src="/common/js/jquery-ui.js"></script>
                        <script nonce="NEOCMSSCRIPT">
                            //관리자 변경 이력을 저장할 변수
                            var changedValues = {};
                            function emplNmChange(menuNo){
                                var deptCode = $("#deptCode_"+menuNo).val();
                                var deptNm = $("#deptNm_"+menuNo).val();
                                var changeNm = $("#emplNm_"+menuNo).val();
                                if(changedValues[menuNo] == null){
                                    changedValues[menuNo] = {"emplCode":"","deptCode":deptCode,"emplNm":changeNm,"emplTelno":"","deptNm":deptNm};
                                }else{
                                    changedValues[menuNo].emplNm = changeNm;
                                }

                            }
                            function emplTelnoChange(menuNo){
                                var deptCode = $("#deptCode_"+menuNo).val();
                                var deptNm = $("#deptNm_"+menuNo).val();
                                var changeTelno = $("#emplTelno_"+menuNo).val();

                                if(changedValues[menuNo]  == null){
                                    changedValues[menuNo] = {"emplCode":"","deptCode":deptCode,"emplNm":"","emplTelno":changeTelno,"deptNm":deptNm};
                                }else{
                                    changedValues[menuNo].emplTelno = changeTelno;
                                }

                            }
                            function disable_menu_mng(menuNo){
                                $("#emplCode_"+menuNo).val("");
                                $("#deptCode_"+menuNo).val("");
                                $("#deptNm_"+menuNo).val("");
                                $("#emplNm_"+menuNo).val("");
                                $("#emplTelno_"+menuNo).val("");

                                changedValues[menuNo] = {"emplCode":"","deptCode":"","emplNm":"","emplTelno":"","deptNm":""};
                            }
                            function enable_menu_mng(menuNo){
                                $(".changeManager").hide();
                                $(".selectManager").show();
                            }

                            $(document).ready(function() {
                                $(".clearManager").click(function () {
                                    disable_menu_mng($(this).data("menuno"));
                                });
                                $(".changeManager").click(function () {
                                    enable_menu_mng($(this).data("menuno"));
                                    var effect = 'slide';
                                    var options = { direction: 'right' };
                                    var duration = 500;
                                    fn_ajax_search_submit("emplForm");
                                    $('#employeeView').show(effect, options, duration);
                                })
                                $(".selectManager").click(function () {
                                    if( !$(this).hasClass('active') ) {
                                        $(this).addClass('active');
                                        updateMenuManager($(this).data("menuno"));
                                    } else {
                                        //$(this).removeClass('active');
                                        return false;
                                    }
                                });
                            });

                            /* 변경사항이 존재하지 않는다면 별다른 처리없이 담당자 슬라이드를 닫는다. */
                            function closeEmployeeView(){
                                var effect = 'slide';
                                var options = { direction: 'right' };
                                var duration = 500;
                                $('#employeeView').hide(effect, options, duration);

                                $(".selectManager").hide();
                                $(".changeManager").show();
                            }

                            /* 변경사항이 존재한다면 해당 변경사항을 적용 한후에 담당자 슬라이드를 닫는다. */
                            function changedSaveManager(){
                                if(Object.keys(changedValues).length == 0) {
                                    alert("변경사항이 존재하지 않습니다.");
                                    return false;
                                }else{
                                    var url = "/neo/jsonUpdateMenuAuth.do";
                                    jQuery(spinner).css('display', '');
                                    $.ajax({
                                        cache: false,
                                        url: url, // 요기에
                                        async: false ,
                                        type: 'POST',
                                        contentType: "application/json",
                                        dataType : "json",
                                        data: JSON.stringify(changedValues),
                                        success: function (res) {
                                            alert("변경이 완료되었습니다.");
                                            location.reload();
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

                                }

                            }

                            function selectEmployee(employee){

                                var $this = $(employee),
                                    $employeeWrap = $('.employeeView'),
                                    $tableFunction = $employeeWrap.find('.data_info'),
                                    $tablePaging = $employeeWrap.find('.pagingWrap');

                                if( $this.hasClass('selected_empl') ) {

                                    $(".selected_empl").parent().parent().removeClass("selected_empl_tr");
                                    $(".selected_empl").removeClass("selected_empl");
                                    $('[data-list="employeeList"]').find('tbody').find('tr').css('display','');
                                    $tableFunction.show();
                                    $tablePaging.show();

                                } else {

                                    $this.addClass("selected_empl");
                                    $this.parent().parent().addClass("selected_empl_tr");
                                    $('[data-list="employeeList"]').find('tbody').find('tr').css('display','none');
                                    $('[data-list="employeeList"]').find('tbody').find('.selected_empl_tr').css('display','');
                                    $tableFunction.hide();
                                    $tablePaging.hide();

                                }

                            }

                            function updateMenuManager(menuNo){
                                var selected_empl = $(".selected_empl");
                                var emplCode = selected_empl.data("emplcode");
                                var deptCode = selected_empl.data("deptcode");
                                var emplNm = selected_empl.data("emplnm");
                                var emplTelno = selected_empl.data("empltelno");
                                var deptNm = selected_empl.data("deptnm");

                                if(deptCode == undefined || deptNm == ""){
                                    alert("우측 부서 목록에서 담당부서를 선택하여주세요.");
                                    return false;
                                }
                                $("#emplCode_"+menuNo).val(emplCode);
                                $("#deptCode_"+menuNo).val(deptCode);
                                $("#emplNm_"+menuNo).val(emplNm);
                                $("#emplTelno_"+menuNo).val(emplTelno);
                                $("#deptNm_"+menuNo).val(deptNm);
                                changedValues[menuNo] = {"emplCode":emplCode,"deptCode":deptCode,"emplNm":emplNm,"emplTelno":emplTelno,"deptNm":deptNm};


                            }

                            ///neo/searchMngEmployeeList.do

                            function fn_ajax_search_submit(form_id){
                                var formData = $("#"+form_id).serialize();
                                var url = "/neo/addBbsAuthorDeptView.do";
                                jQuery(spinner).css('display', '');
                                $.ajax({
                                    cache: false,
                                    url: url, // 요기에
                                    type: 'POST',
                                    data: formData,
                                    success: function (res) {
                                        jQuery(spinner).css('display', 'none');
                                        $("#employeeView").html(res);
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

                            function moveTreeContents(menuUrl){
                                jQuery(spinner).css('display', '');
                                $.ajax({
                                    url: menuUrl,
                                    method: 'post',
                                    success: function(res) {
                                        $("#employeeView").html(res);
                                        jQuery(spinner).css('display', 'none');

                                    },
                                    error       : function( request, status, error ) {
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
                            function movePopupContents(menuUrl){
                                jQuery(spinner).css('display', '');
                                $.ajax({
                                    url: menuUrl,
                                    method: 'post',
                                    success: function(res) {
                                        $("#employeeView").html(res);
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

                            function selectDepart(employee){



                                //////////////////

                                var $this = $(employee),
                                    $employeeWrap = $('.employeeView'),
                                    $tableFunction = $employeeWrap.find('.data_info'),
                                    $tablePaging = $employeeWrap.find('.pagingWrap');

                                if( $this.hasClass('selected_empl') ) {

                                    $(".selected_empl").parent().parent().removeClass("selected_empl_tr");
                                    $(".selected_empl").removeClass("selected_empl");
                                    $('[data-list="employeeList"]').find('tbody').find('tr').css('display','');
                                    $tableFunction.show();
                                    $tablePaging.show();

                                } else {

                                    $this.addClass("selected_empl");
                                    $this.parent().parent().addClass("selected_empl_tr");
                                    $('[data-list="employeeList"]').find('tbody').find('tr').css('display','none');
                                    $('[data-list="employeeList"]').find('tbody').find('.selected_empl_tr').css('display','');
                                    $tableFunction.hide();
                                    $tablePaging.hide();

                                }
                                //////////////////
                                /*var userid = $(employee).data("userid");

                                if(userid == ""){
                                    alert("선택된 직원은 연동된 사용자 계정이 존재하지 않습니다.");
                                    return false;
                                }

                                if(callMode == "mng"){
                                    $("#mngUserId").val(userid);
                                    $("#manageRegistFrm1").attr("action","addBbsMngr.do");
                                    $("#manageRegistFrm1").submit();
                                }else{
                                    $("#bagUserId").val(userid);
                                    $("#bagRegistFrm2").attr("action","addBbsAuthorGroup.do");
                                    $("#bagRegistFrm2").submit();
                                }
                                closeSlideView();*/
                            }
                        </script>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<form id="emplForm" name="emplForm" action="addBbsAuthorDeptView.do" method="post"></form>

<div id="employeeView" class="employeeView"></div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });
</script>
</body>
</html>
