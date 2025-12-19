<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="decorator" content="${menuInfo.siteId}" />
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/program.js"></script>
    <title>${menuInfo.cntntsNm} 등록</title>
</head>
<body>

<div class="p-wrap">

        <div>
            <svg width="20" height="25" fill="#202e70" focusable="false"><use xlink:href="/common/images/program/p-icon.svg#exclamation-circle"></use></svg>
            <span class="p-form__required--icon margin_l_5">필수</span> 표시는 필수 항목 입니다.
        </div>

        <form:form modelAttribute="placeVO" name="placeVO" method="post" action="addPlace.do" onsubmit="return fn_addPlaceCheck(this)">
            <fieldset>
                <legend>장소 등록</legend>
                <c:forEach var="result" items="${placeSearchVO.paramsMap}">
                    <input type="hidden" name="<c:out value="${result.key}"/>" value="<c:out value="${result.value}"/>"/>
                </c:forEach>
                <table class="p-table">
                    <caption>장소 등록</caption>
                    <colgroup>
                        <col class="w10p">
                        <col />
                    </colgroup>
                    <tbody class="p-table--th-left">
                    <tr>
                        <th scope="row"><form:label path="prgSe">운영기관</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:select path="prgSe" class="p-input p-input--auto">
                                <form:option value="" label="구분 선택"/>
                                <form:options items="${prgSeList}" itemValue="code" itemLabel="codeNm"/>
                            </form:select>
                            <form:select path="insttNo" class="p-input p-input--auto">
                                <form:option value="" label="운영기관 선택"/>
                                <form:options items="${eduInsttList}" itemValue="insttNo" itemLabel="insttNm" class="insttList EDU" style="display:none;"/>
                                <form:options items="${expInsttList}" itemValue="insttNo" itemLabel="insttNm" class="insttList EXP" style="display:none;"/>
                                <form:options items="${fctInsttList}" itemValue="insttNo" itemLabel="insttNm" class="insttList FCT" style="display:none;"/>
                            </form:select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="placeNm">장소명</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <form:input path="placeNm" style="width:300px" class="p-input"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="zip">주소</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <div class="p-form-group w10p">
                                <form:input path="zip" style="width:100px" class="p-input" placeholder="(우편번호)" readonly="true"/>
                                <span class="p-input__addon">
                                    <button type="button" class="p-button primary" onclick="openDaumZipAddress();">주소검색</button>
                                </span>
                            </div>
                            <div class="p-form-group w25p">
                                <form:input path="addr" style="width:300px" class="p-input" placeholder="주소" readonly="true"/>
                            </div>
                            <div class="p-form-group w25p">
                                <form:input path="detailAddr" style="width:300px" class="p-input" placeholder="상세주소"/>
                            </div>
                            <div class="p-form-group w25p">
                                <form:input path="lat" style="width:147.5px" class="p-input margin_r_5" placeholder="위도" readonly="true"/>
                                <form:input path="lon" style="width:147.5px" class="p-input margin_r_5" placeholder="경도" readonly="true"/>
                            </div>
                            <div class="p-form-group w25p" id="map"></div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><form:label path="useYn">사용여부</form:label> <span class="p-form__required--icon margin_l_5">필수</span></th>
                        <td>
                            <span class="p-form-checkbox">
                                <input type="radio" name="useYn" id="useYn1" class="p-form-radio__input" value="Y" checked>
                                <label for="useYn1" class="p-form-radio__label">사용</label>
                            </span>
                                <span class="p-form-checkbox">
                                <input type="radio" name="useYn" id="useYn2" class="p-form-radio__input" value="N">
                                <label for="useYn2" class="p-form-radio__label">미사용</label>
                            </span>
                            </td>
                    </tr>
                    </tbody>
                </table>
                <div class="row margin_t_20">
                    <div class="col-12">
                        <a href="./selectPlaceList.do?<c:out value="${placeSearchVO.params}"/>" class="p-button cancel">목록 </a>
                    </div>
                    <div class="col-12 right">
                        <input type="submit" class="p-button write" value="등록">
                    </div>
                </div>
            </fieldset>
        </form:form>

</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

    $('select[name=prgSe]').on("change",function(){
        $('#insttNo').val('');
        $('#insttNo option.insttList').hide();
        $('#insttNo option.' + $(this).val()).show();
    });

    function openDaumZipAddress() {
        new daum.Postcode({
            oncomplete:function(data) {
                $("#zip").val(data.zonecode);
                $("#addr").val(data.address);
                $("#detailAddr").focus();
                fn_mapShow(data.address);
            }
        }).open();
    }

    function fn_mapShow(address) {

        $.ajax({
            cache: false,
            type: "GET",
            url: "https://dapi.kakao.com/v2/local/search/address.json?query=" + address,
            headers: {
                Authorization: 'KakaoAK c2e4fdee6520fa5d20bdd9e112ab8d06', //KakaoAK 뒤에 위에서 얻은 REST API KEY를 입력
            },
            error: function (request, status, error) {
                if (request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1) {
                    alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
                    location.href = "/neo/index.do";
                } else {
                    alert('좌표를 확인하는 중 오류가 발생했습니다.');
                    console.log("code:", request.status);
                    console.log("message:", request.responseText);
                    console.log("error:" + error)
                }
            },
            success: function (result) {
                var latitude = result.documents[0].address.y;	//위도(latitude)
                var longitude = result.documents[0].address.x;	//경도(longitude)
                $('#lat').val(latitude);
                $('#lon').val(longitude);
            }
        });
    }

    function fn_addPlaceCheck(form){

        if (!form.prgSe.value) {
            alert("구분을 선택해주세요.");
            form.prgSe.focus();
            return false;
        }

        if (!form.insttNo.value) {
            alert("운영기관을 선택해주세요.");
            form.insttNo.focus();
            return false;
        }

        if (!form.placeNm.value) {
            alert("장소명을 입력해주세요.");
            form.placeNm.focus();
            return false;
        }

        if (!form.zip.value || !form.addr.value || !form.lat.value || !form.lon.value) {
            alert("주소를 검색해주세요.");
            return false;
        }

        if (!form.detailAddr.value) {
            alert("상세주소를 입력해주세요.");
            form.placeNm.focus();
            return false;
        }

        if (!form.useYn.value) {
            alert("사용여부를 확인해주세요.");
            $('#useYn1').focus();
            return false;
        }

        return true;
    }

</script>

</body>
</html>
