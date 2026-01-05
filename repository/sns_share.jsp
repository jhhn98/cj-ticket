<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<button type="button" class="contentShare"><svg class="active-icon"><use href="/site/www/images/sub/sprite-sub-icon.svg#icon-share"></use></svg><svg class="inactive-icon"><use href="/site/www/images/sub/sprite-sub-icon.svg#icon-dismiss"></use></svg><span>컨텐츠 공유 열기</span></button>
<div class="shareList">
    <span>공유하기</span>
    <ul>
        <li><button type="button" class="facebook" onclick="openFacebook();"><span>FaceBook</span></button></li>
        <%--<li><button type="button" class="instagram"><span>Instagram</span></button></li>--%>
        <li><button type="button" class="meta" onclick="openTwitter('청주시통합예약')"><span>Meta</span></button></li>
        <li><button type="button" class="naver-blog" onclick="openNaverbolg()"><span>NaverBlog</span></button></li>
        <li><button type="button" class="link" onclick="copy()"><span>link</span></button></li>
    </ul>
</div>

<script>
    function copy() {
        var url = '';
        var textarea = document.createElement("textarea");
        document.body.appendChild(textarea);
        url = window.document.location.href;
        textarea.value = url;
        textarea.select();
        document.execCommand("copy");
        document.body.removeChild(textarea);
        alert("URL이 복사되었습니다.")
    }
</script>
