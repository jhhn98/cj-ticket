<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div style="position:relative; width:1000px; height:70px; margin:0 auto;padding: 30px;">

    <p style="font-size:18px; font-weight:600;text-align: center;line-height: 30px;margin-bottom: 15px;">
        <em style="color:#155499">에러가 발생하였습니다.</em><br />
        자세한 에러 사항은 아래 메시지를 확인하여주세요.<br />
    </p>

    <div class="error_log" style="margin:0 auto;border:1px solid #ccc;line-height: 25px;padding:10px;white-space: pre-line;margin-bottom: 40px;">
        ${msg}
    </div>
    <div style="text-align: center;">
        <span style="text-align: left;font-size:16px; font-weight:600;background: url(/common/images/error_btn01.gif) no-repeat left top; width:155px; height:34px; padding:9px 0 0 15px;"><a href="/" style="color:#FFF;">홈으로 이동</a></span>
        <span style="text-align: left;font-size:16px; font-weight:600;background: url(/common/images/error_btn02.gif) no-repeat left top; width:155px; height:34px; padding:9px 0 0 15px; margin-left:22px;"><a href="javascript:window.history.back();" style="color:#FFF;">이전 페이지</a></span>
    </div>
</div>