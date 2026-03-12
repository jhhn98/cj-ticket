<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>신청자 출석/이수 관리</title>
    <link rel="stylesheet" type="text/css" href="/common/js/jquery-ui-1.12.1/jquery-ui.css"/>
    <script type="text/javascript" src="/common/js/jquery-ui-1.12.1/jquery-ui.min.js" nonce="NEOCMSSCRIPT"></script>
</head>

<body>
<div class="p-wrap">
    <!-- 강좌 정보 -->
    <h3 class="p-section-title margin_t_20">○ 강좌 정보</h3>
    <table class="p-table">
        <colgroup>
            <col class="w15p">
            <col/>
            <col class="w15p">
            <col/>
        </colgroup>
        <tbody class="p-table--th-left">
        <tr>
            <th scope="row">강좌명</th>
            <td colspan="3">
                <c:out value="${eduLctreVO.lctreNm}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">기관명</th>
            <td>
                <c:out value="${eduLctreVO.insttNm}"/>
            </td>
            <th scope="row">과목</th>
            <td>
                <c:out value="${eduLctreVO.subjectNm}"/>
            </td>
        </tr>
        <tr>
            <th scope="row">모집기간</th>
            <td>
                <c:if test="${not empty eduLctreVO.rcptBgnDt && fn:length(eduLctreVO.rcptBgnDt) >= 12}">
                    <c:set var="rcptBgnDe" value="${fn:substring(eduLctreVO.rcptBgnDt, 0, 8)}"/>
                    <c:set var="rcptBgnHm" value="${fn:substring(eduLctreVO.rcptBgnDt, 8, 12)}"/>
                    ${fn:substring(rcptBgnDe, 0, 4)}-${fn:substring(rcptBgnDe, 4, 6)}-${fn:substring(rcptBgnDe, 6, 8)} ${fn:substring(rcptBgnHm, 0, 2)}:${fn:substring(rcptBgnHm, 2, 4)}
                </c:if>
                ~
                <c:if test="${not empty eduLctreVO.rcptEndDt && fn:length(eduLctreVO.rcptEndDt) >= 12}">
                    <c:set var="rcptEndDe" value="${fn:substring(eduLctreVO.rcptEndDt, 0, 8)}"/>
                    <c:set var="rcptEndHm" value="${fn:substring(eduLctreVO.rcptEndDt, 8, 12)}"/>
                    ${fn:substring(rcptEndDe, 0, 4)}-${fn:substring(rcptEndDe, 4, 6)}-${fn:substring(rcptEndDe, 6, 8)} ${fn:substring(rcptEndHm, 0, 2)}:${fn:substring(rcptEndHm, 2, 4)}
                </c:if>
            </td>
            <th scope="row">교육기간</th>
            <td>
                <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 8}">
                    <c:set var="lctBgnDe" value="${fn:substring(eduLctreVO.lctBgnDt, 0, 8)}"/>
                    ${fn:substring(lctBgnDe, 0, 4)}-${fn:substring(lctBgnDe, 4, 6)}-${fn:substring(lctBgnDe, 6, 8)}
                </c:if>
                ~
                <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 8}">
                    <c:set var="lctEndDe" value="${fn:substring(eduLctreVO.lctEndDt, 0, 8)}"/>
                    ${fn:substring(lctEndDe, 0, 4)}-${fn:substring(lctEndDe, 4, 6)}-${fn:substring(lctEndDe, 6, 8)}
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">신청/모집정원</th>
            <td>
                모집인원 : 총 <c:out value="${eduLctreVO.onlineCnt}"/>명
                (
                <c:out value="${eduLctreVO.rsvCmplCnt != null ? eduLctreVO.rsvCmplCnt : 0}"/>명
                /
                <c:out value="${eduLctreVO.onlineCnt}"/>명
                )
            </td>
            <th scope="row">교육시간/요일</th>
            <td>
                <c:if test="${not empty eduLctreVO.lctBgnDt && fn:length(eduLctreVO.lctBgnDt) >= 12}">
                    <c:set var="lctBgnHm" value="${fn:substring(eduLctreVO.lctBgnDt, 8, 12)}"/>
                    ${fn:substring(lctBgnHm, 0, 2)}:${fn:substring(lctBgnHm, 2, 4)}
                </c:if>
                ~
                <c:if test="${not empty eduLctreVO.lctEndDt && fn:length(eduLctreVO.lctEndDt) >= 12}">
                    <c:set var="lctEndHm" value="${fn:substring(eduLctreVO.lctEndDt, 8, 12)}"/>
                    ${fn:substring(lctEndHm, 0, 2)}:${fn:substring(lctEndHm, 2, 4)}
                </c:if>
                <c:if test="${not empty eduLctreVO.lctWeekNm}">
                    (<c:out value="${eduLctreVO.lctWeekNm}"/>)
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row">이용요금</th>
            <td>
                <c:choose>
                    <c:when test="${not empty eduLctreVO.eduAmt && eduLctreVO.eduAmt > 0}">
                        <fmt:formatNumber value="${eduLctreVO.eduAmt}" pattern="#,###"/> 원
                    </c:when>
                    <c:otherwise>무료</c:otherwise>
                </c:choose>
            </td>
            <th scope="row">선발방법</th>
            <td>
                <c:choose>
                    <c:when test="${not empty eduLctreVO.slctMthdCd and not empty slctMthdMap[eduLctreVO.slctMthdCd]}">
                        <c:out value="${slctMthdMap[eduLctreVO.slctMthdCd]}"/>
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th scope="row">폐강조건</th>
            <td>
                <c:choose>
                    <c:when test="${eduLctreVO.closeMinCnt > 0}">
                        <c:out value="${eduLctreVO.closeMinCnt}"/>명 미만
                    </c:when>
                    <c:otherwise>
                        폐강 설정 없음
                    </c:otherwise>
                </c:choose>
            </td>
            <th scope="row">수료인정율</th>
            <td>
                <c:choose>
                    <c:when test="${eduLctreVO.cmplApprRate > 0}">
                        출석률 <c:out value="${eduLctreVO.cmplApprRate}"/>% 이상 시 자동 수료 처리
                    </c:when>
                    <c:otherwise>
                        <span style="color: #999;">수료인정율 설정 없음 (수동 처리)</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th scope="row">출석률 기준 패널티 설정<br/>(자동처리X)</th>
            <td colspan="3">
                <c:choose>
                    <c:when test="${eduLctreVO.attendMinRate > 0}">
                        출석률 기준 미달 시 패널티 적용 :
                        전체 출석일 수의 <c:out value="${eduLctreVO.attendMinRate}"/>%
                    </c:when>
                    <c:otherwise>
                        패널티 설정 없음
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        </tbody>
    </table>

    <h3 class="p-section-title margin_t_20">○ 출석부</h3>
    
    <!-- 자동 수료 처리 안내 -->
    <c:if test="${eduLctreVO.cmplApprRate > 0}">
        <div class="row p-relative margin_t_10" style="margin-left: 5px;">
            <div class="col-24">
                <div>
                    <span class="p-icon p-icon__info-circle-solid">주의사항</span>
                    <strong>자동 수료 처리 안내</strong><br/>
                    출석 처리 시 출석율이 <strong style="color: #1e90ff;"><c:out value="${eduLctreVO.cmplApprRate}"/>%</strong> 이상이면 자동으로 <strong style="color: blue;">수료</strong> 처리되며, 
                    미만이면 <strong style="color: red;">미수료</strong> 처리됩니다. 출석/결석 처리 시마다 수료여부가 자동 반영됩니다.
                </div>
            </div>
        </div>
    </c:if>
    
    <!-- 신청자명 검색 -->
    <div class="row p-relative margin_t_10" style="margin-left: 5px;">
        <div class="col-12">

        </div>
    </div>
    
    <div class="row p-relative margin_t_10">
        <div class="col-8 margin_t_5">
            <span>총 <strong id="totalCount"><c:out value="${fn:length(aplctList)}"/></strong> 명</span>
            <span id="filteredCount" style="display:none; color: #0066cc; margin-left: 10px;">
                (검색결과: <strong id="filteredNum">0</strong>명)
            </span>
        </div>
        <div class="col-16 right">
            <label for="searchApplNm" style="margin-right: 10px;">신청자명 검색:</label>
            <input type="text" id="searchApplNm" class="p-input" placeholder="이름을 입력하세요"
                   onkeyup="fn_searchApplNm()" style="width: 200px;">
            <button type="button" class="p-button p-button--small" onclick="fn_resetSearch();">초기화</button>
        </div>
    </div>
    <div class="row p-relative">

    </div>

    <div class="table-responsive" style="overflow-x: auto; max-width: 100%;">
        <table id="atendTable" class="p-table p-table--bordered" style="min-width: 800px; white-space: nowrap;">
            <caption>출석부 - 선택, 번호, 신청자명, 성별, 연락처, 출석율, 수료여부, 강의별 출석체크</caption>
            <colgroup>
                <col style="min-width: 40px;"/>
                <col style="min-width: 60px;"/>
                <col style="min-width: 120px;"/>
                <col style="min-width: 60px;"/>
                <col style="min-width: 120px;"/>
                <col style="min-width: 80px;"/>
                <col style="min-width: 80px;"/>
                <!-- 강의 날짜 컬럼들 -->
                <c:forEach var="lctreDay" items="${lctreWeek}">
                    <col style="min-width: 80px;"/>
                </c:forEach>
            </colgroup>
            <thead>
            <tr>
                <th scope="col" rowspan="2">
                    <input type="checkbox" id="checkAll" name="checkAll" class="allCheck" title="전체선택"/>
                </th>
                <th scope="col" rowspan="2">번호</th>
                <th scope="col" rowspan="2">신청자명</th>
                <th scope="col" rowspan="2">성별</th>
                <th scope="col" rowspan="2">연락처</th>
                <th scope="col" rowspan="2">출석율</th>
                <th scope="col" rowspan="2">수료여부</th>
                <th scope="col" colspan="${fn:length(lctreWeek)}">강의일별 출석</th>
            </tr>
            <tr>
                <!-- 강의 날짜 표시 및 날짜별 전체선택 체크박스 -->
                <c:forEach var="lctreDay" items="${lctreWeek}" varStatus="status">
                    <th scope="col">
                        <input type="checkbox" id="chk_${lctreDay}" class="checkAllDate" onclick="fn_atendAllCheck('${lctreDay}')" />
                        <c:if test="${not empty lctreDay && fn:length(lctreDay) >= 8}">
                            ${fn:substring(lctreDay, 4, 6)}.${fn:substring(lctreDay, 6, 8)}
                        </c:if>
                    </th>
                </c:forEach>
            </tr>
            </thead>
            <tbody class="text_center">
            <%-- 현재 날짜는 Controller에서 설정됨 (nowDate) --%>
            <c:set var="rowNum" value="1" />
            <c:forEach var="aplct" items="${aplctList}" varStatus="status">
                <tr>
                    <td><input type="checkbox" name="chk" value="${aplct.eduAplyNo}" /></td>
                    <td><c:out value="${rowNum}"/></td>
                    <td class="text_left"><c:out value="${aplct.applNm}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${aplct.genderSe eq 'M'}">남</c:when>
                            <c:when test="${aplct.genderSe eq 'F'}">여</c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <!-- 연락처 포맷 (010-1234-5678) -->
                        <c:if test="${not empty aplct.telNo && fn:length(aplct.telNo) == 11}">
                            ${fn:substring(aplct.telNo, 0, 3)}-${fn:substring(aplct.telNo, 3, 7)}-${fn:substring(aplct.telNo, 7, 11)}
                        </c:if>
                    </td>
                    <td>
                        <%-- 출석율 계산: 출석 횟수 / 전체 강의 날짜 수 * 100 --%>
                        <c:set var="atendCount" value="0" />
                        <c:set var="totalDays" value="${fn:length(lctreWeek)}" />
                        
                        <%-- 해당 신청자의 출석(Y) 횟수 카운트 --%>
                        <c:forEach var="atendData" items="${atendList}">
                            <c:if test="${atendData.eduAplyNo eq aplct.eduAplyNo && atendData.atendYn eq 'Y'}">
                                <c:set var="atendCount" value="${atendCount + 1}" />
                            </c:if>
                        </c:forEach>
                        
                        <%-- 출석율 계산 (소수점 둘째자리까지) --%>
                        <c:choose>
                            <c:when test="${totalDays > 0}">
                                <c:set var="atendRate" value="${(atendCount / totalDays) * 100}" />
                                <span class="atend-rate"><fmt:formatNumber value="${atendRate}" pattern="#0.00" />%</span>
                            </c:when>
                            <c:otherwise>
                                <span class="atend-rate">0.00%</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <%-- 수료여부 표시 --%>
                        <c:choose>
                            <c:when test="${aplct.fnshYn eq 'Y'}">
                                <span style="color:blue; font-weight: bold;">수료</span>
                            </c:when>
                            <c:when test="${aplct.fnshYn eq 'N'}">
                                <span style="color:red; font-weight: bold;">미수료</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color:#999;">-</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    
                    <!-- 강의 날짜별 출석 체크박스 -->
                    <c:forEach var="lctreDay" items="${lctreWeek}" varStatus="dateStatus">
                        <td>
                            <%-- 날짜 비교: 문자열 비교로 작동 (yyyyMMdd 형식이면 정상 작동) --%>
                            <c:choose>
                                <c:when test="${lctreDay le nowDate}">
                                    <%-- 출석 데이터 찾기 --%>
                                    <c:set var="matched" value="false" />
                                    <c:set var="currentAtendYn" value="" />
                                    <c:forEach var="atendData" items="${atendList}">
                                        <c:if test="${atendData.eduAplyNo eq aplct.eduAplyNo && atendData.atendDe eq lctreDay}">
                                            <c:set var="matched" value="true" />
                                            <c:set var="currentAtendYn" value="${atendData.atendYn}" />
                                        </c:if>
                                    </c:forEach>
                                    
                                    <%-- 체크박스: 출석인 경우 체크 --%>
                                    <input type="checkbox" 
                                           name="atendchecked" 
                                           class="atend_${lctreDay}"
                                           value="${aplct.eduAplyNo}-${lctreDay}"
                                           data-aply-no="${aplct.eduAplyNo}"
                                           data-lctre-day="${lctreDay}" />
                                    
                                    <%-- 출석 상태 표시 --%>
                                    <c:choose>
                                        <c:when test="${matched}">
                                            <c:choose>
                                                <c:when test="${currentAtendYn eq 'Y'}">
                                                    <span style="color:blue; font-weight: bold;">출석</span>
                                                </c:when>
                                                <c:when test="${currentAtendYn eq 'N'}">
                                                    <span style="color:red; font-weight: bold;">결석</span>
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color:#999;">미처리</span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#ccc;">-</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </c:forEach>
                </tr>
                <c:set var="rowNum" value="${rowNum + 1}" />
            </c:forEach>
            <c:if test="${fn:length(aplctList) == 0}">
                <tr>
                    <td colspan="${7 + fn:length(lctreWeek)}" class="empty">'신청완료' 상태인 신청자가 없습니다</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <div class="row margin_t_10">
        <div class="col-12 left">
            <!-- 수료 처리 -->
            <select id="fnshYnSelect" class="p-input p-input--auto" >
                <option value="">수료여부 선택</option>
                <option value="Y">수료</option>
                <option value="N">미수료</option>
            </select>
            <button type="button" class="p-button p-button--small primary" onclick="fn_updateCheckedFnsh();">수료여부 처리</button>
        </div>
        <div class="col-12 right">
            <!-- 출석 처리 -->
            <button type="button" class="p-button edit p-button--small" onclick="fn_updateCheckedAtend('Y');">선택 출석</button>
            <button type="button" class="p-button delete p-button--small" onclick="fn_updateCheckedAtend('N');">선택 결석</button>
            <a href="./selectEduAtendLctreList.do?key=${key}" class="p-button primary">강좌 목록</a>
            <a href="./downloadXlsAtendList.do?lctreNo=${eduLctreVO.lctreNo}&key=${key}" class="p-button p-button--combine excel">엑셀다운로드</a>
        </div>
    </div>

</div>

<!-- 처리 중 모달 -->
<div id="updtModal" style="display: none; position: fixed; left: 0; top: 0; z-index: 9999; background-color: rgba(0,0,0,0.4); width: 100%; height: 100%; overflow: auto;">
    <div style="background-color: #fefefe; padding: 20px; border: 1px solid #888; text-align: center; margin: 15% auto; width: 30%;">
        <p>출결 처리 중입니다.<br/>잠시만 기다려주세요.</p>
    </div>
</div>

<script nonce="NEOCMSSCRIPT">
    // 전체선택
    $("#checkAll").on("change", function() {
        $("input[name='chk']").prop("checked", $(this).prop("checked"));
    });

    // 날짜별 전체선택
    function fn_atendAllCheck(day) {
        if ($('#chk_' + day).prop("checked")) {
            $(".atend_" + day).prop("checked", true);
        } else {
            $(".atend_" + day).prop("checked", false);
        }
    }

    // 선택된 항목 출석처리
    function fn_updateCheckedAtend(atendYn) {
        if (!confirm("출결 처리하시겠습니까?")) {
            return false;
        }

        var atendDataStr = "";
        var atendCheckArr = $("input[name=atendchecked]:checked");
        var len = atendCheckArr.length;

        atendCheckArr.each(function (index) {
            atendDataStr += $(this).val();
            if (!(index === len - 1)) {
                atendDataStr += ",";
            }
        });

        if (!atendDataStr) {
            alert("체크 항목이 없습니다.");
            return false;
        }

        var lctreNo = ${eduLctreVO.lctreNo};
        var key = "${key}";
        location.href = "./updateCheckedAtend.do?lctreNo=" + lctreNo + "&atendDataStr=" + atendDataStr + "&atendYn=" + atendYn + "&key=" + key;

        $('#updtModal').show();
    }

    // 선택된 신청자 수료여부 처리
    function fn_updateCheckedFnsh() {
        var fnshYn = $('#fnshYnSelect').val();
        
        if (!fnshYn) {
            alert("수료여부를 선택해주세요.");
            $('#fnshYnSelect').focus();
            return false;
        }
        
        if (!confirm("선택한 신청자의 수료여부를 " + (fnshYn === 'Y' ? '수료' : '미수료') + "로 처리하시겠습니까?")) {
            return false;
        }

        var eduAplyNoStr = "";
        var checkArr = $("input[name=chk]:checked");
        var len = checkArr.length;

        if (len === 0) {
            alert("처리할 신청자를 선택해주세요.");
            return false;
        }

        checkArr.each(function (index) {
            eduAplyNoStr += $(this).val();
            if (!(index === len - 1)) {
                eduAplyNoStr += ",";
            }
        });

        var lctreNo = ${eduLctreVO.lctreNo};
        location.href = "./updateCheckedFnsh.do?lctreNo=" + lctreNo + "&eduAplyNoStr=" + eduAplyNoStr + "&fnshYn=" + fnshYn + "&key=" + "${key}";

        $('#updtModal').show();
    }

    // 신청자명 검색
    function fn_searchApplNm() {
        var searchText = $('#searchApplNm').val().toLowerCase().trim();
        var visibleCount = 0;
        var totalCount = 0;
        
        // 출석부 테이블만 선택
        $('#atendTable tbody tr').each(function() {
            totalCount++;
            var applNm = $(this).find('td').eq(2).text().toLowerCase(); // 이름 컬럼 (3번째)
            
            if (searchText === '' || applNm.indexOf(searchText) > -1) {
                $(this).show();
                visibleCount++;
            } else {
                $(this).hide();
            }
        });
        
        // 검색 결과 카운트 표시
        if (searchText !== '') {
            $('#filteredNum').text(visibleCount);
            $('#filteredCount').show();
        } else {
            $('#filteredCount').hide();
        }
    }

    // 검색 초기화
    function fn_resetSearch() {
        $('#searchApplNm').val('');
        $('#atendTable tbody tr').show();
        $('#filteredCount').hide();
    }
</script>
</body>
</html>
