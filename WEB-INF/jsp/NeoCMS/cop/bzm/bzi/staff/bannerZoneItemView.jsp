<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>배너 항목 상세정보</title>
    <meta name="decorator" content="${menuInfo.siteId}" />
</head>
<body>
<div class="p-wrap">

    <div class="col-20">
        <div>
            <span class="p-icon p-icon__info-circle">주의사항</span>
            <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
        </div>

        <table class="p-table">
            <colgroup>
                <col class="w15p">
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">배너이름</th>
                <td>${bannerZoneItem.bannerZoneIemNm}</td>
            </tr>
            <tr>
                <th scope="row">표시구분</th>
                <td>${showSeMap[bannerZoneItem.showSe]}</td>
            </tr>
            <tr>
                <th scope="row">기간</th>
                <td><span class="eng_text">${bannerZoneItem.bgndeYMDHM} ~ ${bannerZoneItem.enddeYMDHM}</span></td>
            </tr>
            <tr>
                <th scope="row">링크URL</th>
                <td><span class="eng_text">${bannerZoneItem.linkUrl}</span></td>
            </tr>
            <tr>
                <th scope="row">링크대상</th>
                <td>${linkTrgetMap[bannerZoneItem.linkTrget]}</td>
            </tr>
            <tr>
                <th scope="row">대체텍스트</th>
                <td>${bannerZoneItem.imageReplcText}</td>
            </tr>
            </tbody>
        </table>
        <div class="row margin_t_20">
            <div class="col-12">
                <a href="./selectBannerZoneItemList.do?key=<c:out value="${key}"/>&amp;siteId=${bannerZoneItemVO.siteId}&amp;bannerZoneNo=${bannerZoneItemVO.bannerZoneNo}&amp;pageUnit=${bannerZoneItemVO.pageUnit}&amp;searchCnd=${bannerZoneItemVO.searchCnd}&amp;searchKrwd=${bannerZoneItemVO.searchKrwd}&amp;searchShowSe=${bannerZoneItemVO.searchShowSe}&amp;pageIndex=${bannerZoneItemVO.pageIndex}" class="p-button cancel"><span>목록</span></a>
            </div>
            <div class="col-12 right">
                <a href="./updateBannerZoneItemView.do?key=<c:out value="${key}"/>&amp;siteId=${bannerZoneItemVO.siteId}&amp;bannerZoneNo=${bannerZoneItemVO.bannerZoneNo}&amp;bannerZoneIemNo=${bannerZoneItemVO.bannerZoneIemNo}&amp;pageUnit=${bannerZoneItemVO.pageUnit}&amp;searchCnd=${bannerZoneItemVO.searchCnd}&amp;searchKrwd=${bannerZoneItemVO.searchKrwd}&amp;showSe=${bannerZoneItemVO.searchShowSe}&amp;pageIndex=${bannerZoneItemVO.pageIndex}" class="p-button edit"><span>수정</span></a>
                <a href="./deleteBannerZoneItem.do?key=<c:out value="${key}"/>&amp;siteId=${bannerZoneItemVO.siteId}&amp;bannerZoneNo=${bannerZoneItemVO.bannerZoneNo}&amp;bannerZoneIemNo=${bannerZoneItemVO.bannerZoneIemNo}&amp;pageUnit=${bannerZoneItemVO.pageUnit}&amp;searchCnd=${bannerZoneItemVO.searchCnd}&amp;searchKrwd=${bannerZoneItemVO.searchKrwd}&amp;showSe=${bannerZoneItemVO.searchShowSe}&amp;pageIndex=${bannerZoneItemVO.pageIndex}" onclick="fn_deleteBannerZoneItem(this.href); return false;" class="p-button delete"><span>삭제</span></a>
            </div>
        </div>

    </div>

</div>

<script nonce="NEOCMSSCRIPT">
    function fn_deleteBannerZoneItem( url ) {
        if( confirm("삭제하시겠습니까?") ) {
            window.location = url;
        }
    }
</script>
</body>
</html>