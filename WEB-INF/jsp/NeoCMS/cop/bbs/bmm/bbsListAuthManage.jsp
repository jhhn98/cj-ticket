<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="BBS_3" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="neo" />
    <script src="/neo/js/jquery-3.6.0.min.js"></script>
    <script src="/neo/js/common.js"></script>
</head>
<body>
<div class="page_location">
    <span class="depth1_title icon_board">게시판 관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth4_title"><c:out value="${bbsSkin.skinNm}"/> 게시판 권한설정</span>
</div>
<div class="contents is_null">
    <div class="arrangementWrap marginBottom_5">
        <div class="arrLeft">
            <span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
            <span class="table_text">Page : <c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/></span>
        </div>
        <div class="arrRight">
            <div class="table_search">
                <form id="programVO" name="searchForm" action="/neo/selectBbsListAuthManage.do" method="get">
                    <span class="srch_element select">
                    <select id="pageUnit" name="pageUnit">
                        <option value="10" selected="selected">10 페이지</option>
                        <option value="20">20 페이지</option>
                        <option value="30">30 페이지</option>
                        <option value="40">40 페이지</option>
                        <option value="50">50 페이지</option>
                    </select>
                    </span>
                    <span class="srch_element select">
                    <select id="searchCnd" name="searchCnd">
                        <option value="all" selected="selected">전체</option>
                        <option value="progrmNm">게시판명</option>
                        <option value="progrmUrl">담당부서</option>
                        <option value="progrmUrl">담당직원</option>
                        <option value="progrmUrl">담당자아이디</option>
                    </select>
                    </span>
                    <span class="srch_element text">
                    <input id="searchKrwd" name="searchKrwd" class="txt" type="text" value="">
                    </span>
                    <span class="srch_element submit">
                        <button type="submit" class="search_button">검색</button>
                    </span>
                </form>
            </div>
        </div>
    </div>
    <form action="#n" method="post" name="bbsAuthForm" id="bbsAuthForm">
        <div class="contents_scroll_area">
            <table class="authManage">
                <colgroup>
                    <col/>
                    <col class="specWidth8per"/>
                    <col class="specWidth20per"/>
                    <col class="specWidth20per"/>
                    <col class="specWidth20per"/>
                    <col class="specWidth5per"/>
                    <col class="specWidth5per"/>
                    <col class="specWidth5per"/>
                    <col class="specWidth5per"/>
                    <col class="specWidth5per"/>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col" rowspan="2" class="first">게시판명</th>
                    <th scope="col" rowspan="2">게시판스킨</th>
                    <th scope="col" colspan="3">담당자설정</th>
                    <th scope="col" colspan="5">기본권한설정</th>
                </tr>
                <tr>
                    <th scope="col">관리자</th>
                    <th scope="col">글쓰기</th>
                    <th scope="col">부서관리자</th>
                    <th scope="col">읽기</th>
                    <th scope="col">글쓰기</th>
                    <th scope="col">계층형 답변</th>
                    <th scope="col">보기형 답변</th>
                    <th scope="col">댓글</th>
                </tr>
                </thead>
                <tbody class="textALeft">

                <c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
                <c:forEach var="result" items="${bbsList}" varStatus="status">
                    <c:forEach var="infoData" items="${bbsInfoList}" varStatus="infoStatus">
                        <c:if test="${infoData.bbsNo eq result.bbsNo}"><c:set var="info" value="${infoData}"/></c:if>
                    </c:forEach>

                    <tr>
                        <th scope="row" class="textACenter first"><c:out value="${result.bbsNm}"/></th>
                        <td class="textACenter"><c:out value="${bbsSkinMap[result.skinId]}"/></td>
                        <td class="textACenter verticalATop">
                            <div class="chosen-container chosen-container-multi" id="writer_mng_4${status.index}_chosen">
                                <ul class="chosen-choices">
                                    <c:forEach var="mngData" items="${bbsMngrList}" varStatus="infoStatus">
                                        <c:if test="${mngData.bbsNo eq result.bbsNo}">
                                            <li class="search-choice">
                                                <button type="button" class="search-choice-close manager_name" data-bbsno="${result.bbsNo}"
                                                        data-authmode="mng" data-userid="${mngData.userId}">
                                                    <c:out value="${mngData.userNm}"/>(<c:out value="${mngData.userId}"/>)<span>담당자 제외</span>
                                                </button>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li class="chosen_btn add_manager addMng_${result.bbsNo}"><button type="button" class="changeManager add_user" data-bbsno="${result.bbsNo}" data-authmode="mng">담당자 등록</button></li>
                                    <!--<li class="chosen_btn stat accept"><span class="stat_change noButton" data-bbsno="${result.bbsNo}" data-authmode="mng" title="변경사항 있음">변경사항 있음</span></li>
                                    <li class="chosen_btn stat wait"><span class="stat_noChange noButton" data-bbsno="${result.bbsNo}" data-authmode="mng" title="변경사항 없음">변경사항 없음</span></li>-->
                                </ul>
                            </div>
                        </td>
                        <td class="verticalATop">
                            <div class="chosen-container chosen-container-multi" id="writer_mng_5${status.index}_chosen">
                                <ul class="chosen-choices">
                                    <c:forEach var="bagData" items="${bbsAuthorGroupList}" varStatus="infoStatus">
                                        <c:if test="${bagData.bbsNo eq result.bbsNo}">
                                            <li class="search-choice">
                                                <button type="button" class="search-choice-close manager_name" data-bbsno="${result.bbsNo}"
                                                        data-authmode="bag" data-userid="${bagData.userId}">
                                                    <c:out value="${bagData.userNm}"/>(<c:out value="${bagData.userId}"/>)<span>담당자 제외</span>
                                                </button>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <!--<li class="search-choice deselect"><span>박경덕(r4erad)</span><a class="search-choice-close btn_cancel" data-option-array-index="11"></a></li>-->
                                    <li class="chosen_btn add_manager addBag_${result.bbsNo}"><button type="button" class="btn_add changeManager" data-bbsno="${result.bbsNo}" data-authmode="bag">담당자 등록</button></li>
                                    <!--<li class="chosen_btn stat accept"><span class="stat_change noButton" data-bbsno="${result.bbsNo}" data-authmode="bag">변경사항 있음</span></li>
                                    <li class="chosen_btn stat wait"><span class="stat_noChange noButton" data-bbsno="${result.bbsNo}" data-authmode="bag">변경사항 없음</span></li>-->
                                </ul>
                            </div>
                        </td>
                        <td class="verticalATop">
                            <div class="chosen-container chosen-container-multi" id="writer_mng_6${status.index}_chosen">
                                <ul class="chosen-choices">
                                    <c:forEach var="badData" items="${bbsAuthorDeptList}" varStatus="infoStatus">
                                        <c:if test="${badData.bbsNo eq result.bbsNo}">
                                            <li class="search-choice">
                                                <button type="button" class="search-choice-close manager_name"
                                                        data-bbsno="${result.bbsNo}" data-authmode="dept" data-deptcode="${badData.deptCode}">
                                                    <c:out value="${badData.deptNm}"/>(<c:out value="${badData.deptCode}"/>)<span>담당자 제외</span>
                                                </button>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <!--<li class="search-choice deselect"><span>박경덕(r4erad)</span><a class="search-choice-close btn_cancel" data-option-array-index="11"></a></li>-->
                                    <li class="chosen_btn add_manager addBad_${result.bbsNo}"><button type="button" class="btn_add changeManager " data-bbsno="${result.bbsNo}" data-authmode="dept">담당자 등록</button></li>
                                    <!--<li class="chosen_btn stat accept"><span class="stat_change noButton" data-bbsno="${result.bbsNo}" data-authmode="dept">변경사항 있음</span></li>
                                    <li class="chosen_btn stat wait"><span class="stat_noChange noButton" data-bbsno="${result.bbsNo}" data-authmode="dept">변경사항 없음</span></li>-->
                                </ul>
                            </div>
                        </td>
                        <td>
                            <c:forEach var="res" items="${authorList}" varStatus="idx">
                                <div><input type="checkbox" name="redngAuthor_${result.bbsNo}" id="redngAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>" value="<c:out value="${res.code}"/>" <c:if test="${fn:indexOf(info.redngAuthor, res.code) > -1}">checked="checked"</c:if>>
                                    <label for="redngAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>"><c:out value="${res.codeNm}"/></label></div>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach var="res" items="${authorList}" varStatus="idx">
                                <div><input type="checkbox" name="writngAuthor_${result.bbsNo}" id="writngAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>" value="<c:out value="${res.code}"/>" <c:if test="${fn:indexOf(info.writngAuthor, res.code) > -1}">checked="checked"</c:if>>
                                    <label for="writngAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>"><c:out value="${res.codeNm}"/></label></div>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach var="res" items="${authorList}" varStatus="idx">
                                <div><input type="checkbox" name="replyAuthor_${result.bbsNo}" id="replyAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>" value="<c:out value="${res.code}"/>" <c:if test="${fn:indexOf(info.replyAuthor, res.code) > -1}">checked="checked"</c:if>>
                                    <label for="replyAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>"><c:out value="${res.codeNm}"/></label></div>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach var="res" items="${authorList}" varStatus="idx">
                                <div><input type="checkbox" name="answerAuthor_${result.bbsNo}" id="answerAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>" value="<c:out value="${res.code}"/>" <c:if test="${fn:indexOf(info.answerAuthor, res.code) > -1}">checked="checked"</c:if>>
                                    <label for="answerAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>"><c:out value="${res.codeNm}"/></label></div>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach var="res" items="${authorList}" varStatus="idx">
                                <div><input type="checkbox" name="commentAuthor_${result.bbsNo}" id="commentAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>" value="<c:out value="${res.code}"/>" <c:if test="${fn:indexOf(info.commentAuthor, res.code) > -1}">checked="checked"</c:if>>
                                    <label for="commentAuthor_<c:out value="${status.index}"/>_<c:out value="${idx.index}"/>"><c:out value="${res.codeNm}"/></label></div>
                            </c:forEach>
                        </td>
                    </tr>
                    <c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
                </c:forEach>
                <c:if test="${fn:length(bbsList) == 0}">
                    <tr>
                        <td colspan="10" class="textACenter">등록된 게시판이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <div class="arrangementWrap marginTop_15">
            <div class="arrLeft">
                <div class="pagination">
                    <ui:pagination paginationInfo = "${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectBbsListAuthManage.do?siteId=${tsu:xssLinkFilter(bbsVO.siteId)}&amp;pageUnit=${tsu:xssLinkFilter(bbsVO.pageUnit)}&amp;searchCnd=${tsu:xssLinkFilter(bbsVO.searchCnd)}&amp;searchKrwd=${tsu:xssLinkFilter(bbsVO.searchKrwd)}&amp;pageIndex=" />
                </div>
            </div>
            <div class="arrRight">
                <a href="./bbsAuthMapping.do" class="iconTextButton set"><span>권한매핑</span></a>
                <button type="button" onclick="bbsAuthUpdate()" class="iconTextButton write marginLeft_5"><span>저장</span></button>
            </div>
        </div>
    </form>
    <form id="emplForm" name="emplForm" action="selectPopUserInfoList.do" method="post"></form>
    <form id="departmentForm" name="departmentForm" action="addBbsAuthorDeptView.do" method="post" >
        <input type="hidden" name="siteId" value="<c:out value="${bbsVO.siteId}"/>"/>
        <input type="hidden" name="pageUnit" value="10"/>
    </form>
    <div id="employeeView" class="employeeView"></div>

    <script src="/common/js/jquery-ui.js"></script>
    <script id="mng_template" type="text/plain">
        <li class="search-choice new_mng"><button type="button" class="search-choice-close manager_name bbs_{3}_{2}" data-bbsno="{2}" data-authmode="{3}" data-userid="{4}">{0}({1})<span>담당자 제외</span></button></li>
    </script>
    <script nonce="NEOCMSSCRIPT">
        //관리자 변경 이력을 저장할 변수
        var changedMngAuth = {};
        var changedGroupAuth = {};
        var changedDeptAuth = {};
        var selectedAuthMode = "";
        var selectedBbsNo = "";

        function bbsAuthUpdate(){
            var formSerializeArray = $('#bbsAuthForm').serializeArray();
            var object = {};
            for (var i = 0; i < formSerializeArray.length; i++){
                var arrName = formSerializeArray[i]['name'].split("_");
                //arrName[0];//name
                //arrName[1];//bbsNo
                if(object[arrName[1]] == undefined) object[arrName[1]] = {};
                if(object[arrName[1]][arrName[0]] == undefined) object[arrName[1]][arrName[0]] = "";
                object[arrName[1]][arrName[0]] += formSerializeArray[i]['value']+",";
                /**
                 *  data Sample : {"608":{"redngAuthor":"BBSR01,BBSR02,BBSR03,","writngAuthor":"BBSR02,BBSR03,"},"647":{"redngAuthor":"BBSR01,BBSR02,BBSR03,","writngAuthor":"BBSR01,BBSR02,BBSR03,","answerAuthor":"BBSR03,","commentAuthor":"BBSR03,"},"648":{"redngAuthor":"BBSR01,BBSR02,BBSR03,","writngAuthor":"BBSR02,BBSR03,"},"649":{"redngAuthor":"BBSR01,BBSR02,BBSR03,","writngAuthor":"BBSR02,BBSR03,"},"650":{"redngAuthor":"BBSR01,BBSR02,BBSR03,","writngAuthor":"BBSR02,BBSR03,"},"651":{"redngAuthor":"BBSR01,BBSR02,BBSR03,","writngAuthor":"BBSR01,BBSR02,BBSR03,"},"652":{"redngAuthor":"BBSR01,BBSR02,BBSR03,","writngAuthor":"BBSR02,BBSR03,"},"667":{"redngAuthor":"BBSR01,BBSR02,BBSR03,","writngAuthor":"BBSR03,"}}
                 * */
            }

            var formJson = JSON.stringify(object);

            var url = "/neo/updateBbsListAuthManage.do";
            jQuery(spinner).css('display', '');
            $.ajax({
                cache: false,
                url: url,
                async: false ,
                type: 'POST',
                contentType: "application/json",
                dataType : "json",
                data: JSON.stringify({"changedMngAuth":JSON.stringify(changedMngAuth),"changedGroupAuth":JSON.stringify(changedGroupAuth),"changedDeptAuth":JSON.stringify(changedDeptAuth),"formData":formJson}),
                success: function (res) {
                    console.log(res);
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
        $(document).ready(function() {

            $(".btn_accept").click(function () {

            });
            $(".changeManager").click(function () {
                var effect = 'slide';
                var options = { direction: 'right' };
                var duration = 500;

                selectedAuthMode =  $(this).data("authmode");
                selectedBbsNo =   $(this).data("bbsno");

                if(selectedAuthMode == "dept"){
                    fn_ajax_search_submit("departmentForm");
                }else{
                    fn_ajax_search_submit("emplForm");
                }
                $('#employeeView').show(effect, options, duration);
            })

        });

        /* 변경사항이 존재하지 않는다면 별다른 처리없이 담당자 슬라이드를 닫는다. */
        function closeEmployeeView(){
            var effect = 'slide';
            var options = { direction: 'right' };
            var duration = 500;
            $('#employeeView').hide(effect, options, duration);

        }

        /* 변경사항이 존재한다면 해당 변경사항을 적용 한후에 담당자 슬라이드를 닫는다. */
        function changedSaveManager(){

        }

        function selectDepart(employee){

            var deptcode = $(employee).data("deptcode");

            if(deptcode == ""){
                alert("부서가 잘못 선택되었습니다.");
                return false;
            }
            var isExistDept = false;
            $(".addBad_"+selectedBbsNo).siblings().each(function(){
                if($(this).find("button").data("deptcode") == deptcode){
                    alert("이미 권한이 부여된 부서입니다.");
                    isExistDept = true;
                    return false;
                }
            });
            if(!isExistDept) selectEmployee(employee);
        }
        function selectEmployee(employee){
            var userid = $(employee).data("userid");
            var emplnm = $(employee).data("emplnm");
            var usernm = $(employee).data("usernm");
            var deptcode = $(employee).data("deptcode");
            var deptnm = $(employee).data("deptnm");
            var bbsno = selectedBbsNo;

            if(userid == ""){
                alert("선택된 직원은 연동된 사용자 계정이 존재하지 않습니다.");
                return false;
            }else{
                var mng_template = $("#mng_template").html();
                mng_template = mng_template.replace(/\{2\}/gi,selectedBbsNo);
                mng_template = mng_template.replace(/\{3\}/gi,selectedAuthMode);
                mng_template = mng_template.replace(/\{4\}/gi,userid);

                //alert(mng_template);
                if(selectedAuthMode == "mng"){
                    mng_template = mng_template.replace(/\{0\}/gi,usernm);
                    mng_template = mng_template.replace(/\{1\}/gi,userid);



                    var isExistEmpl = false;
                    $(".addMng_"+selectedBbsNo).siblings().each(function(){
                        if($(this).find("button").data("userid") == userid){
                            isExistEmpl = true;
                            return false;
                        }
                    });
                    if(isExistEmpl){
                        alert("이미 권한이 부여된 직원입니다.");
                        return false;
                    }


                    $(".addMng_"+selectedBbsNo).before(mng_template);
                }else if(selectedAuthMode == "bag"){
                    mng_template = mng_template.replace(/\{0\}/gi,usernm);
                    mng_template = mng_template.replace(/\{1\}/gi,userid);
                    var isExistEmpl = false;
                    $(".addBag_"+selectedBbsNo).siblings().each(function(){
                        if($(this).find("button").data("userid") == userid){
                            isExistEmpl = true;
                            return false;
                        }
                    });
                    if(isExistEmpl){
                        alert("이미 권한이 부여된 직원입니다.");
                        return false;
                    }
                    $(".addBag_"+selectedBbsNo).before(mng_template);
                }else{
                    mng_template = mng_template.replace(/\{0\}/gi,deptnm);
                    mng_template = mng_template.replace(/\{1\}/gi,deptcode);
                    $(".addBad_"+selectedBbsNo).before(mng_template);
                }


                if(changedGroupAuth[bbsno] == undefined ) changedGroupAuth[bbsno] = {"del":{},"add":{}};
                if(changedMngAuth[bbsno] == undefined ) changedMngAuth[bbsno] = {"del":{},"add":{}};
                if(changedDeptAuth[bbsno] == undefined ) changedDeptAuth[bbsno] = {"del":{},"add":{}};

                if(selectedAuthMode == "bag"){
                    changedGroupAuth[bbsno].add[userid] = userid;
                }else if(selectedAuthMode == "mng"){
                    changedMngAuth[bbsno].add[userid] = userid;
                }else{
                    changedDeptAuth[bbsno].add[deptcode] = deptcode;
                }



                $(".bbs_"+selectedAuthMode+"_"+bbsno).on("click",function (){
                    var bbsno = $(this).data("bbsno");
                    var userid = $(this).data("userid");
                    var deptcode = $(this).data("deptcode");
                    var authmode = $(this).data("authmode");
                    delete changedMngAuth[bbsno].add[userid];
                    if(authmode == "bag"){
                        delete changedGroupAuth[bbsno].add[userid];
                    }else if(authmode == "mng"){
                        delete changedMngAuth[bbsno].add[userid];
                    }else{
                        delete changedDeptAuth[bbsno].add[deptcode];
                    }


                    /**
                     * del버튼이 클릭되었을때 변경사항이 존재(changedMngAuth,changedGroupAuth 변수 값이 변경) 한다면
                     * submit버튼을 활성화한다.
                     */
                    if(authmode == "bag"){

                        if((changedGroupAuth[bbsno] != undefined && Object.keys(changedGroupAuth[bbsno].del).length > 0 ) ||
                            (changedGroupAuth[bbsno] != undefined && Object.keys(changedGroupAuth[bbsno].add).length > 0 )){
                            $(this).parent().parent().addClass('dataChange');
                            /*
                                                    $(this).parent().parent().children(".wait").hide();
                                                    $(this).parent().parent().children(".accept").show();
                            */
                        }else{
                            $(this).parent().parent().removeClass('dataChange');
                            /*
                                                    $(this).parent().parent().children(".wait").show();
                                                    $(this).parent().parent().children(".accept").hide();
                            */
                        }
                    }else if(authmode == "mng"){

                        if((changedMngAuth[bbsno] != undefined && Object.keys(changedMngAuth[bbsno].del).length > 0 ) ||
                            (changedMngAuth[bbsno] != undefined && Object.keys(changedMngAuth[bbsno].add).length > 0 )){
                            $(this).parent().parent().addClass('dataChange');
                            /*
                                                    $(this).parent().parent().children(".wait").hide();
                                                    $(this).parent().parent().children(".accept").show();
                            */
                        }else{
                            $(this).parent().parent().removeClass('dataChange');
                            /*
                                                    $(this).parent().parent().children(".wait").show();
                                                    $(this).parent().parent().children(".accept").hide();
                            */
                        }
                    }else{

                        if((changedDeptAuth[bbsno] != undefined && Object.keys(changedDeptAuth[bbsno].del).length > 0 ) ||
                            (changedDeptAuth[bbsno] != undefined && Object.keys(changedDeptAuth[bbsno].add).length > 0 )){
                            $(this).parent().parent().removeClass('dataChange');
                            /*
                                                    $(this).parent().parent().children(".wait").hide();
                                                    $(this).parent().parent().children(".accept").show();
                            */
                        }else{
                            $(this).parent().parent().addClass('dataChange');
                            /*
                                                    $(this).parent().parent().children(".wait").show();
                                                    $(this).parent().parent().children(".accept").hide();
                            */
                        }
                    }

                    $(this).parent().remove();
                });


                /**
                 * del버튼이 클릭되었을때 변경사항이 존재(changedMngAuth,changedGroupAuth 변수 값이 변경) 한다면
                 * submit버튼을 활성화한다.
                 */
                /* 여기 수정 */
                if(selectedAuthMode == "bag"){
                    if((changedGroupAuth[bbsno] != undefined && Object.keys(changedGroupAuth[bbsno].del).length > 0 ) ||
                        (changedGroupAuth[bbsno] != undefined && Object.keys(changedGroupAuth[bbsno].add).length > 0 )){
                        $(".addBag_"+selectedBbsNo).parent().addClass('dataChange');
                        /*
                                            $(".addBag_"+selectedBbsNo).parent().children(".wait").hide();
                                            $(".addBag_"+selectedBbsNo).parent().children(".accept").show();
                        */
                    }else{
                        $(".addBag_"+selectedBbsNo).parent().removeClass('dataChange');
                        /*
                                            $(".addBag_"+selectedBbsNo).parent().children(".wait").show();
                                            $(".addBag_"+selectedBbsNo).parent().children(".accept").hide();
                        */
                    }
                }else if(selectedAuthMode == "mng"){
                    if((changedMngAuth[bbsno] != undefined && Object.keys(changedMngAuth[bbsno].del).length > 0 ) ||
                        (changedMngAuth[bbsno] != undefined && Object.keys(changedMngAuth[bbsno].add).length > 0 )){
                        $(".addMng_"+selectedBbsNo).parent().addClass('dataChange');
                        /*
                                            $(".addMng_"+selectedBbsNo).parent().children(".wait").hide();
                                            $(".addMng_"+selectedBbsNo).parent().children(".accept").show();
                        */
                    }else{
                        $(".addMng_"+selectedBbsNo).parent().removeClass('dataChange');
                        /*
                                            $(".addMng_"+selectedBbsNo).parent().children(".wait").show();
                                            $(".addMng_"+selectedBbsNo).parent().children(".accept").hide();
                        */
                    }
                }else{
                    if((changedDeptAuth[bbsno] != undefined && Object.keys(changedDeptAuth[bbsno].del).length > 0 ) ||
                        (changedDeptAuth[bbsno] != undefined && Object.keys(changedDeptAuth[bbsno].add).length > 0 )){
                        $(".addBad_"+selectedBbsNo).parent().addClass('dataChange');
                        /*
                                            $(".addBad_"+selectedBbsNo).parent().children(".wait").hide();
                                            $(".addBad_"+selectedBbsNo).parent().children(".accept").show();
                        */
                    }else{
                        $(".addBad_"+selectedBbsNo).parent().removeClass('dataChange');
                        /*
                                            $(".addBad_"+selectedBbsNo).parent().children(".wait").show();
                                            $(".addBad_"+selectedBbsNo).parent().children(".accept").hide();
                        */
                    }
                }
                closeEmployeeView();
            }

        }

        function fn_ajax_search_submit(form_id){
            var formData = $("#"+form_id).serialize();
            var url = $("#"+form_id).attr("action");
            //var url = "/neo/searchMngEmployeeList.do";
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
        $(document).ready(function() {

            /**
             * 삭제 버튼을 클릭시 클릭 상태 UI변경과
             * 삭제를 위해서 삭제 정보를 json객체
             * changedGroupAuth또는 changedMngAuth에 저장한다.
             */
            $(".manager_name").on('click',function(){
                var authmode = $(this).data("authmode");
                var bbsno = $(this).data("bbsno");
                if(changedGroupAuth[bbsno] == undefined ) changedGroupAuth[bbsno] = {"del":{},"add":{}};
                if(changedMngAuth[bbsno] == undefined ) changedMngAuth[bbsno] = {"del":{},"add":{}};
                if(changedDeptAuth[bbsno] == undefined ) changedDeptAuth[bbsno] = {"del":{},"add":{}};

                if(authmode == "bag"){
                    if($(this).parent().hasClass("deselect")){
                        $(this).parent().removeClass("deselect");
                        delete changedGroupAuth[bbsno].del[$(this).data("userid")];
                    }else{
                        $(this).parent().addClass("deselect");
                        changedGroupAuth[bbsno].del[$(this).data("userid")] = $(this).data("userid");
                    }
                }else if(authmode == "mng"){

                    if($(this).parent().hasClass("deselect")){
                        $(this).parent().removeClass("deselect");
                        delete changedMngAuth[bbsno].del[$(this).data("userid")];
                    }else{
                        $(this).parent().addClass("deselect");
                        changedMngAuth[bbsno].del[$(this).data("userid")] = $(this).data("userid");
                    }
                }else{

                    if($(this).parent().hasClass("deselect")){
                        $(this).parent().removeClass("deselect");
                        delete changedDeptAuth[bbsno].del[$(this).data("deptcode")];
                    }else{
                        $(this).parent().addClass("deselect");
                        changedDeptAuth[bbsno].del[$(this).data("deptcode")] = $(this).data("deptcode");
                    }
                }

                /**
                 * del버튼이 클릭되었을때 변경사항이 존재(changedMngAuth,changedGroupAuth 변수 값이 변경) 한다면
                 * submit버튼을 활성화한다.
                 */
                if(authmode == "bag"){
                    if((changedGroupAuth[bbsno] != undefined && Object.keys(changedGroupAuth[bbsno].del).length > 0 ) ||
                        (changedGroupAuth[bbsno] != undefined && Object.keys(changedGroupAuth[bbsno].add).length > 0 )){
                        $(this).parent().parent().addClass('dataChange');
                        /*
                                            $(this).parent().parent().children(".wait").hide();
                                            $(this).parent().parent().children(".accept").show();
                        */
                    }else{
                        $(this).parent().parent().removeClass('dataChange');
                        /*
                                            $(this).parent().parent().children(".wait").show();
                                            $(this).parent().parent().children(".accept").hide();
                        */
                    }
                }else if(authmode == "mng"){
                    if((changedMngAuth[bbsno] != undefined && Object.keys(changedMngAuth[bbsno].del).length > 0 ) ||
                        (changedMngAuth[bbsno] != undefined && Object.keys(changedMngAuth[bbsno].add).length > 0 )){
                        $(this).parent().parent().addClass('dataChange');
                        /*
                                            $(this).parent().parent().children(".wait").hide();
                                            $(this).parent().parent().children(".accept").show();
                        */
                    }else{
                        $(this).parent().parent().removeClass('dataChange');
                        /*
                                            $(this).parent().parent().children(".wait").show();
                                            $(this).parent().parent().children(".accept").hide();
                        */
                    }
                }else{
                    if((changedDeptAuth[bbsno] != undefined && Object.keys(changedDeptAuth[bbsno].del).length > 0 ) ||
                        (changedDeptAuth[bbsno] != undefined && Object.keys(changedDeptAuth[bbsno].add).length > 0 )){
                        $(this).parent().parent().addClass('dataChange');
                        /*
                                            $(this).parent().parent().children(".wait").hide();
                                            $(this).parent().parent().children(".accept").show();
                        */
                    }else{
                        $(this).parent().parent().removeClass('dataChange');
                        /*
                                            $(this).parent().parent().children(".wait").show();
                                            $(this).parent().parent().children(".accept").hide();
                        */
                    }
                }
            });

        });
    </script>
</div>
</body>
</html>