<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 정보 수정</title>
<meta name="decorator" content="neo" />
<script nonce="NEOCMSSCRIPT">
<c:if test="${!empty message}">
 	function fn_check_message() {
 		alert("<c:out value='${message}'/>");
    <c:if test="${!empty fieldName}">
	    $("#<c:out value="${fieldName}"/>").focus();
    </c:if>
 	}
$(window).on("load", function() {
		fn_check_message();
	});
</c:if>
	function fn_validateBbsInfoVO( frm ) {
		return true;
	}
	function fn_deleteBbsMngr( url ) {
		if( confirm("삭제 하시겠습니까?") ) {
			window.location = url;
		}
	}
</script>
</head>
<body>
<div class="page_location">
	<span class="depth1_title icon_board">게시판관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">게시판설정</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/> 권한관리</span>
</div>
<div class="tab_navigation">
	<a href="./updateBbsInfoView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=" "><span>설정관리</span></a>
	<a href="./updateBbsFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>필드관리</span></a>
	<a href="./updateBbsFieldListSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>목록 순서 변경</span></a>
	<a href="./updateBbsFieldInputSortView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>입력/보기 순서 변경</span></a>
	<a href="./selectBbsCategoryList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>카테고리관리</span></a>
	<a href="./updateBbsDescriptionView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>설명관리</span></a>
	<a href="./selectBbsAuthorList.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class="current"><span>권한관리</span></a>
	<a href="./updateBbsAtchFieldView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class=""><span>첨부파일필드 관리</span></a>
    <a href="./updateBbsBanView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" ><span>악성사용자 차단</span></a>
</div>
<div class="contents is_null">
    <form:form modelAttribute="bbsInfo" name="bbsInfoVOForm" action="updateBbsAuthor.do" cssStyle="height: auto;">
        <input type="hidden" name="siteId" id="siteId" value="<c:out value="${bbsVO.siteId}"/>"/>
        <form:hidden path="bbsNo"/>
        <input type="hidden" name="pageUnit" value="<c:out value="${bbsInfoVO.pageUnit}"/>"/>
        <input type="hidden" name="searchCnd" value="<c:out value="${bbsInfoVO.searchCnd}"/>"/>
        <input type="hidden" name="searchKrwd" value="<c:out value="${bbsInfoVO.searchKrwd}"/>"/>
        <input type="hidden" name="pageIndex" value="<c:out value="${bbsInfoVO.pageIndex}"/>"/>
        <table class="splitVertical">
            <colgroup>
                <col class="specWidth20per"/>
                <col class="specWidth20per"/>
                <col class="specWidth20per"/>
                <col class="specWidth20per"/>
                <col class="specWidth20per"/>
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">읽기</th>
                    <th scope="col">글쓰기</th>
                    <th scope="col">답변(계층형)</th>
                    <th scope="col">답변(보기형)</th>
                    <th scope="col">댓글</th>
                </tr>
            </thead>
            <tbody class="textACenter">
                <tr>

                    <td>
            <c:forEach var="result" items="${authorList}" varStatus="idx">
                        <input type="checkbox" name="redngAuthor" id="redngAuthor_<c:out value="${idx.index}"/>" value="<c:out value="${result.code}"/>" <c:if test="${fn:indexOf(bbsInfo.redngAuthor, result.code) > -1}">checked="checked"</c:if>><label for="redngAuthor_<c:out value="${idx.index}"/>" class="marginLeft_5 marginRight_15"><c:out value="${result.codeNm}"/></label>
            </c:forEach>
                    </td>
                    <td>
            <c:forEach var="result" items="${authorList}" varStatus="idx">
                        <input type="checkbox" name="writngAuthor" id="writngAuthor_<c:out value="${idx.index}"/>" value="<c:out value="${result.code}"/>" <c:if test="${fn:indexOf(bbsInfo.writngAuthor, result.code) > -1}">checked="checked"</c:if>><label for="writngAuthor_<c:out value="${idx.index}"/>" class="marginLeft_5 marginRight_15"><c:out value="${result.codeNm}"/></label>
            </c:forEach>
                    </td>
                    <td>
            <c:forEach var="result" items="${authorList}" varStatus="idx">
                        <input type="checkbox" name="replyAuthor" id="replyAuthor_<c:out value="${idx.index}"/>" value="<c:out value="${result.code}"/>" <c:if test="${fn:indexOf(bbsInfo.replyAuthor, result.code) > -1}">checked="checked"</c:if>><label for="replyAuthor_<c:out value="${idx.index}"/>" class="marginLeft_5 marginRight_15"><c:out value="${result.codeNm}"/></label>
            </c:forEach>
                    </td>
                    <td>
            <c:forEach var="result" items="${authorList}" varStatus="idx">
                        <input type="checkbox" name="answerAuthor" id="answerAuthor_<c:out value="${idx.index}"/>" value="<c:out value="${result.code}"/>" <c:if test="${fn:indexOf(bbsInfo.answerAuthor, result.code) > -1}">checked="checked"</c:if>><label for="answerAuthor_<c:out value="${idx.index}"/>" class="marginLeft_5 marginRight_15"><c:out value="${result.codeNm}"/></label>
            </c:forEach>
                    </td>
                    <td>
            <c:forEach var="result" items="${authorList}" varStatus="idx">
                        <input type="checkbox" name="commentAuthor" id="commentAuthor_<c:out value="${idx.index}"/>" value="<c:out value="${result.code}"/>" <c:if test="${fn:indexOf(bbsInfo.commentAuthor, result.code) > -1}">checked="checked"</c:if>><label for="commentAuthor_<c:out value="${idx.index}"/>" class="marginLeft_5 marginRight_15"><c:out value="${result.codeNm}"/></label>
            </c:forEach>
                    </td>
                </tr>
            </tbody>
        </table>

        <div class="arrangementWrap marginTop_15">
            <div class="arrLeft">
                <a href="./bbsAuthMapping.do" target="_blank" class="iconTextButton set"><span>권한매핑</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton edit"><span>권한수정</span></button>
            </div>
        </div>
    </form:form>
    <div class="alignHorizontal countThree">
        <div class="elementAlign">
            <div class="arrangementWrap">
                <div class="arrLeft"><h2>글쓰기 그룹</h2></div>
                <div class="arrRight"><a href="./addBbsAuthorGroupView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;groupSe=GRSE02&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class="iconTextButton write emplSearch"><span>사용자 등록</span></a></div>
            </div>
            <div class="table_fixed_wrap is_topBottom_wrap">
                <div id="tableScroll" class="data_table">
                    <div class="scroll_view">
                        <table>
                            <colgroup>
                                <col class="specWidth80px"/>
                                <col/>
                                <col/>
                                <col class="specWidth100px"/>
                                <col class="specWidth100px"/>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">아이디</th>
                                <th scope="col">이름</th>
                                <th scope="col">등록일</th>
                                <th scope="col">삭제</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set var="sNumber" value="1" />
                            <c:forEach var="result" items="${bbsAuthorGroupList}" varStatus="idx">
                            <tr>
                                <td class="textARight"><c:out value="${sNumber}"/></td>
                                <td class="textACenter"><a href="/neo/selectUserInfoView.do?userName=<c:out value="${result.userId}"/>"><c:out value="${result.userId}"/></a></td>
                                <td><a href="/neo/selectUserInfoView.do?userName=<c:out value="${result.userId}"/>"><c:out value="${result.userNm}"/></a></td>
                                <td class="textACenter"><c:out value="${result.frstRegisterPnttmYMD}"/></td>
                                <td class="textACenter"><a href="./deleteBbsAuthorGroup.do?bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;bbsAuthorGroupNo=<c:out value="${result.bbsAuthorGroupNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class="iconTextButton delete small empSearch" onclick="fn_deleteBbsMngr(this.href); return false;"><span>삭제</span></a></td>
                            </tr>
                                <c:set var="sNumber" value="${sNumber+1}" />
                            </c:forEach>
                            <c:if test="${fn:length(bbsAuthorGroupList) == 0}">
                            <tr>
                                <td colspan="5" class="textACenter">등록된 사용자가 없습니다.</td>
                            </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="elementAlign">
            <div class="arrangementWrap">
                <div class="arrLeft"><h2>관리자 목록</h2></div>
                <div class="arrRight"><a href="./addBbsMngrView.do?siteId=<c:out value="${bbsVO.siteId}"/>&amp;bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class="iconTextButton write mngSearch"><span>관리자 등록</span></a></div>
            </div>
            <div class="table_fixed_wrap is_topBottom_wrap">
                <div id="tableScroll2" class="data_table">
                    <div class="scroll_view">
                        <table>
                            <colgroup>
                                <col class="specWidth80px"/>
                                <col/>
                                <col/>
                                <col class="specWidth100px"/>
                                <col class="specWidth100px"/>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">아이디</th>
                                <th scope="col">이름</th>
                                <th scope="col">등록일</th>
                                <th scope="col">삭제</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set var="sNumber" value="1" />
                            <c:forEach var="result" items="${bbsMngrList}" varStatus="idx">
                            <tr>
                                <td class="textARight"><c:out value="${sNumber}"/></td>
                                <td class="textACenter"><a href="/neo/selectUserInfoView.do?userName=<c:out value="${result.userId}"/>"><c:out value="${result.userId}"/></a></td>
                                <td><a href="/neo/selectUserInfoView.do?userName=<c:out value="${result.userId}"/>"><c:out value="${result.userNm}"/></a></td>
                                <td class="textACenter"><c:out value="${result.frstRegisterPnttmYMD}"/></td>
                                <td class="textACenter"><a href="./deleteBbsMngr.do?bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;bbsMngrNo=<c:out value="${result.bbsMngrNo}"/>&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class="iconTextButton delete small" onclick="fn_deleteBbsMngr(this.href); return false;"><span>삭제</span></a></td>
                            </tr>
                                <c:set var="sNumber" value="${sNumber+1}" />
                            </c:forEach>
                            <c:if test="${fn:length(bbsMngrList) == 0}">
                            <tr>
                                <td colspan="5" class="textACenter">등록된 관리자가 없습니다.</td>
                            </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
		</div>
        <div class="elementAlign">

            <div class="arrangementWrap">
                <div class="arrLeft"><h2>부서 그룹</h2></div>
                <div class="arrRight"><a href="./addBbsAuthorDeptView.do?siteId=${bbsVO.siteId}&amp;bbsNo=${bbsVO.bbsNo}&amp;pageUnit=<c:out value="${bbsInfoVO.pageUnit}"/>&amp;searchCnd=<c:out value="${bbsInfoVO.searchCnd}"/>&amp;searchKrwd=<c:out value="${bbsInfoVO.searchKrwd}"/>&amp;pageIndex=<c:out value="${bbsInfoVO.pageIndex}"/>" class="iconTextButton write deptSearch"><span>부서 등록</span></a></div>
            </div>

            <div class="table_fixed_wrap is_topBottom_wrap">
                <div id="tableScroll3" class="data_table">
                    <div class="scroll_view">
                        <table>
                            <colgroup>
                                <col class="specWidth80px"/>
                                <col/>
                                <col class="specWidth100px"/>
                                <col class="specWidth100px"/>
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">부서명</th>
                                <th scope="col">등록일</th>
                                <th scope="col">삭제</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set var="sNumber" value="1" />
                            <c:forEach var="result" items="${bbsAuthorDeptList}" varStatus="idx">
                                <tr>
                                    <td class="textARight">${sNumber}</td>
                                    <td class="textACenter"><c:out value="${result.deptNm}"/></td>
                                    <td class="textACenter">${result.frstRegisterPnttmYMD}</td>
                                    <td class="textACenter"><a href="./deleteBbsAuthorDept.do?bbsNo=<c:out value="${bbsVO.bbsNo}"/>&amp;bbsAuthorDeptNo=<c:out value="${result.bbsAuthorDeptNo}"/>&amp;deptCode=<c:out value="${result.deptCode}"/>&amp;deptNm=<c:out value="${result.deptNm}"/>" onclick="fn_deleteBbsMngr(this.href); return false;" class="iconTextButton delete small" onclick="fn_deleteBbsMngr(this.href); return false;"><span>삭제</span></a></td>
                                </tr>
                                <c:set var="sNumber" value="${sNumber+1}" />
                            </c:forEach>
                            <c:if test="${fn:length(bbsAuthorDeptList) == 0}">
                                <tr>
                                    <td colspan="4" align="center">등록된 부서가 없습니다.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="/common/js/jquery-ui.js"></script>
<script src="/neo/js/calendar.js"></script>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">

    var effect = 'slide';
    var options = { direction: 'right' };
    var duration = 500;

    var callMode = "emp";


    $(document).ready(function(){

        var dataTable = new fixedTableHead({
                target: "#tableScroll"
            }),
            dataTable2 = new fixedTableHead({
                target: "#tableScroll2"
            }),
            dataTable3 = new fixedTableHead({
                target: "#tableScroll3"
            });

        /** 직원 검색 버튼에 대한 액션 */
        $(".mngSearch").click(function (e) {
            e.preventDefault();
            callMode = "mng";
            fn_ajax_search_submit("emplForm");
            $('#slide_view').show(effect, options, duration);
        });

        $(".emplSearch").click(function (e) {
            e.preventDefault();
            callMode = "emp";
            fn_ajax_search_submit("emplForm");
            $('#slide_view').show(effect, options, duration);
        });

        $(".deptSearch").click(function (e) {
            e.preventDefault();
            fn_ajax_search_submit("departmentForm");
            $('#slide_view').show(effect, options, duration);
        });


    });

    function selectEmployee(employee){

        var userid = $(employee).data("userid");

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
        closeSlideView();
    }

    function selectDepart(employee){

        var deptcode = $(employee).data("deptcode");

        if(deptcode == ""){
            alert("부서가 잘못 선택되었습니다.");
            return false;
        }
        $("#dept_deptCode").val(deptcode);
        $("#deptRegistFrm3").attr("action","addBbsAuthorDept.do");
        $("#deptRegistFrm3").submit();
        closeSlideView();
    }

    function closeSlideView(){
        $('#slide_view').hide(effect, options, duration);
    }
    function closeEmployeeView (){
        closeSlideView();
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
                $("#slide_view").html(res);
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
                $("#slide_view").html(res);
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

<div id="slide_view" class="employeeView"></div>

<form id="emplForm" name="emplForm" action="selectPopUserInfoList.do" method="post" >
</form>
<form id="departmentForm" name="departmentForm" action="addBbsAuthorDeptView.do" method="post" >
    <input type="hidden" name="bbsNo" value="<c:out value="${bbsVO.bbsNo}"/>"/>
    <input type="hidden" name="siteId" value="<c:out value="${bbsVO.siteId}"/>"/>
    <input type="hidden" name="pageUnit" value="10"/>
</form>

<form id="manageRegistFrm1" name="manageRegistFrm1" action="./addBbsMngr.do" method="post">
    <input type="hidden" name="bbsNo" value="<c:out value="${bbsVO.bbsNo}"/>"/>
    <input type="hidden" name="userId" id="mngUserId" value=""/>
    <input type="hidden" name="pageUnit" value="<c:out value="${bbsInfoVO.pageUnit}"/>"/>
    <input type="hidden" name="searchCnd" value="<c:out value="${bbsInfoVO.searchCnd}"/>"/>
    <input type="hidden" name="searchKrwd" value="<c:out value="${bbsInfoVO.searchKrwd}"/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value="${bbsInfoVO.pageIndex}"/>"/>
</form>

<form id="bagRegistFrm2" name="bagRegistFrm2" action="./addBbsAuthorGroup.do" method="post">
    <input type="hidden" name="bbsNo" value="<c:out value="${bbsVO.bbsNo}"/>"/>
    <input type="hidden" name="userId" id="bagUserId" value=""/>
    <input type="hidden" name="groupSe" id="groupSe" value="GRSE02"/>
    <input type="hidden" name="pageUnit" value="<c:out value="${bbsInfoVO.pageUnit}"/>"/>
    <input type="hidden" name="searchCnd" value="<c:out value="${bbsInfoVO.searchCnd}"/>"/>
    <input type="hidden" name="searchKrwd" value="<c:out value="${bbsInfoVO.searchKrwd}"/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value="${bbsInfoVO.pageIndex}"/>"/>
</form>

<form id="deptRegistFrm3" name="deptRegistFrm3" action="./addBbsAuthorDept.do" method="post">
    <input type="hidden" name="bbsNo" value="<c:out value="${bbsVO.bbsNo}"/>"/>
    <input type="hidden" name="deptCode" id="dept_deptCode" value=""/>
    <input type="hidden" name="pageUnit" value="<c:out value="${bbsInfoVO.pageUnit}"/>"/>
    <input type="hidden" name="searchCnd" value="<c:out value="${bbsInfoVO.searchCnd}"/>"/>
    <input type="hidden" name="searchKrwd" value="<c:out value="${bbsInfoVO.searchKrwd}"/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value="${bbsInfoVO.pageIndex}"/>"/>
</form>
</body>
</html>