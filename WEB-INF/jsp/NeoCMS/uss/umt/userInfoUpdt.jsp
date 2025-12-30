<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="USR_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>회원 등록</title>
	<meta name="decorator" content="neo" />

	<script src="/common/js/jquery-ui.js"></script>


	<script src="<c:url value='/cmm/validator.do'/>"></script>
	<validator:javascript formName="userInfoUpdate" staticJavascript="false" xhtml="true" cdata="false"/>
	<spring:hasBindErrors name="userInfo">
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
            $("#emplCode").val("");
            $("#deptCode").val("");
			$("#emplInfo").text("연결된 직원이 없습니다.");
		}
	</script>
</head>

<div class="page_location">
    <span class="depth1_title icon_user">사용자관리</span>
    <i class="sign_gt">메뉴 위치 구분 기호 ></i>
    <span class="depth2_title">사용자 관리</span>
</div>
<div class="tab_navigation">
    <a href="/neo/selectUserInfoList.do" class="current"><span>사용자 관리</span></a></li>
    <a href="/neo/selectIndvdlinfoHistList.do"><span>개인정보처리이력</span></a></li>
    <%--<a href="/neo/selectUserForceLoginHistList.do"><span>개별로그인이력</span></a></li>--%>
    <a href="/neo/updateUserConfigView.do"><span>사용자 정보 설정 관리</span></a></li>
</div>


	<div class="contents">
        <form:form modelAttribute="userInfo" name="userInfoForm" action="updateUserInfo.do" onsubmit="return validateUserInfoUpdateFrm(this)">
        <div class="form_wrap marginBottom_45">
            <form:hidden path="pwdCorrected"/>
            <form:hidden path="userId"/>
            <form:hidden path="emplCode"/>
            <form:hidden path="deptCode"/>
            <table>
                <colgroup>
                    <col class="specWidth120px"/>
                    <col/>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">사용자ID</th>
                    <td><c:out value="${userInfo.userId}"/></td>
                </tr>
                <tr>
                    <th scope="row" class="essential_input"><form:label path="userSe">사용자 구분</form:label></th>
                    <td>
                        <form:select path="userSe">
                            <form:option value="" label="--선택하세요--" />
                            <c:forEach var="opt" items="${userSeList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq userInfo.userSe ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="userSe"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="emplCode">직원연결</form:label></th>
                    <td><span id="emplInfo">
                        <c:if test="${!empty departmentList}">
                            <c:forEach var="department" items="${departmentList}" varStatus="status">
                                <c:if test="${!status.first}"><span style="color:#AAA"> &gt; </span></c:if>
                                <img src="./images/icon_tree_node_sub.gif" style="vertical-align:middle"/> <c:out value="${department.deptNm}"/>
                            </c:forEach>
                            <img src="./images/icon_arrow_r.gif" style="vertical-align:middle; margin:0 5px 0 5px"/>
                        </c:if>
                        <c:choose>
                            <c:when test="${!empty employee.emplCode}">
                                <c:out value="${employee.emplNm}"/>(<span class="em_red"><c:out value="${employee.emplCode}"/></span>)
                        </c:when>
                        <c:otherwise>
                            연결된 직원이 없습니다.
                        </c:otherwise>
                        </c:choose>
                        </span>
                        <button type="button" class="iconTextButton search emplSearch small marginLeft_10"><span>직원검색</span></button>
                        <button type="button" onclick="fn_initCharger();" class="iconTextButton delete small"><span>해제</span></button>
                    </td>
                </tr>
                <tr>
                    <th scope="row">사용자 이름</th>
                    <td><c:out value="${userInfo.userNm}"/></td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="password">비밀번호</form:label></th>
                    <td>
                        <form:password path="password" size="40" autocomplete="new-password"/>
                        <form:errors path="password"/><span class="marginLeft_10">실패횟수 : <c:out value="${userInfo.loginFailCnt}"/><a onclick="return pwdBanReset(this.href);"  href="./userInfoFailedReset.do?userId=<c:out value="${userInfo.userId}"/>" class="iconButton refresh small marginLeft_10"><span>초기화</span></a></span>
                        <p id="weak_pwd" class="info_text em_red_bold" style="display:none;">비밀번호가 취약합니다. (<spring:eval expression="@prop['password_regexr_explanation']"/>)</p>
                        <p id="power_pwd" class="info_text em_green_bold" style="display:none;">비밀번호가 강력합니다.</p>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><form:label path="email">이메일</form:label></th>
                    <td>
                        <form:input path="email" size="40"/> <form:errors path="email"/>
                    </td>
                </tr>
				<tr>
		            <th scope="row"><form:label path="moblphon">휴대전화</form:label></th>
					<td>
						<form:input path="moblphon" size="40"/> <form:errors path="moblphon"/>
					</td>
		        </tr>
                </tbody>
            </table>
            <div class="arrangementWrap marginTop_20">
                <div class="arrLeft">
                    <a href="./selectUserInfoList.do" class="iconTextButton list"><span>목록</span></a>
                </div>
                <div class="arrRight">
                    <button type="submit" class="iconTextButton edit"><span>수정</span></button>
                </div>
            </div>
        </div>
	</form:form>
        <h2>로그인 이력</h2>
        <div class="table_fixed_wrap userInfoUpdtLog">
            <div id="tableScroll" class="data_table">
                <div class="scroll_view">
                    <table>
                        <colgroup>
                            <col class="specWidth180px"/>
                            <col class="specWidth180px"/>
                            <col class="specWidth180px"/>
                            <col/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">IP</th>
                            <th scope="col">로그인구분</th>
                            <th scope="col">로그인 일시</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="sNumber" value="${fn:length(userLoginHistList)}" />
                        <c:forEach var="result" items="${userLoginHistList}" varStatus="status">
                            <tr>
                                <td class="textACenter"><c:out value="${sNumber}"/></td>
                                <td class="textACenter"><c:out value="${result.connectIp}"/></td>
                                <td class="textACenter">
                                    <c:choose>
                                        <c:when test="${result.loginSuccesAt eq 'Y'}">
                                            성공
                                        </c:when>
                                        <c:otherwise>
                                            <em class="em_red">실패</em>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="textACenter"><c:out value="${result.loginPnttmYMD}"/></td>
                            </tr>
                            <c:set var="sNumber" value="${sNumber-1}" />
                        </c:forEach>
                        <c:if test="${fn:length(userLoginHistList) == 0}">
                            <tr>
                                <td colspan="4" class="textACenter">로그인 이력이 없습니다.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    <script nonce="NEOCMSSCRIPT">
        var effect = 'slide';
        var options = { direction: 'right' };
        var duration = 500;
        //비밀번호 실시간 체크
        $(function(){

            $('input#password').keyup(function() {
                hiPw_pattern(this);
            });
            $(window).on('load',function(){
                hiPw_pattern();
            })
        })

        function validateUserInfoUpdateFrm(frm){
            var pw = $("#password").val(); //비밀번호
            if(pw != ""){
                hiPw_pattern();
                if($("#pwdCorrected").val() == ""){
                    alert("비밀번호가 취약합니다. (숫자, 특수문자 각 1회 이상, 영문은 2개 이상 사용하여 8자리 이상 입력해주세요)");
                    return false;
                }
            }else{
                validateUserInfoUpdate(frm);
            }
        }

        function hiPw_pattern() {
            var pattern1 = /<spring:eval expression="@prop['password_regexr_pattern']"/>/;
            var pw = $("#password").val(); //비밀번호
            //비밀번호 체크
            if (pattern1.test(pw)) {
                //console.log("check ok")
                $("#weak_pwd").hide();
                $("#power_pwd").show();
                $("#pwdCorrected").val("1");
            }else{
                //$('#pw_have_num').removeClass('on').find('span.skip').text('실패');
                //console.log("check no")
                $("#weak_pwd").show();
                $("#power_pwd").hide();
                $("#pwdCorrected").val("");
            }
        }


        $(document).ready(function() {

            /** 직원 검색 버튼에 대한 액션 */
            $(".emplSearch").click(function (e) {
                e.preventDefault();
                fn_ajax_search_submit("departmentForm");
                $('#slide_right_view').show(effect, options, duration);
            });

        });
        function selectEmployee(employee){

            var emplCode = $(employee).data("emplcode");
            var deptCode = $(employee).data("deptcode");
            var emplNm = $(employee).data("emplnm");
            var deptNm = $(employee).data("deptnm");

            $("#deptCode").val(deptCode);
            $("#emplCode").val(emplCode);
            $("#deptNm").val(deptNm);
            $("#emplNm").val(emplNm);


            var info = $("#employee_info").html();

            info = info.replace(/\{0\}/gi,deptNm);
            info = info.replace(/\{1\}/gi,deptCode);
            info = info.replace(/\{2\}/gi,emplNm);
            info = info.replace(/\{3\}/gi,emplCode);

            $("#emplInfo").html(info);


            closeSlideView();
        }
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
</div>

<script type="text/plain" id="employee_info">
    <img src="./images/icon_tree_node_sub.gif" style="vertical-align:middle"> {0} (<span class="em_red">{1}</span>)
    <img src="./images/icon_arrow_r.gif" style="vertical-align:middle; margin:0 5px 0 5px">
    <img src="./images/icon_tree_node_user.gif" style="vertical-align:middle"> {2}(<span class="em_red">{3}</span>)
</script>
<form id="departmentForm" name="departmentForm" action="searchMngEmployeeList.do" method="post" >
</form>
<div id="slide_right_view" class="employeeView">
</div>
<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
    $(document).ready(function(){
        formLabelText();
    })
    var dataTable = new fixedTableHead({
        target: "#tableScroll"
    });

    function pwdBanReset(url) {
        if(confirm("해당 사용자의 로그인 실패 횟수를 초기화 하시겠습니까?")){
            location.href = url;
            return true;
        }
        return false;
    }
</script>

</body>
</html>