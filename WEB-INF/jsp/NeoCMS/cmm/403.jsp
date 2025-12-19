<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="/common/css/default.css" />
<title>403</title>
</head>
<body style="margin:0px">
<div style="position:relative; width:750px; height:450px; margin:0 auto; background: url(/common/images/error_bg.jpg) no-repeat  center top;">

		<p style=" position:absolute; left:340px; top:150px; font-size:15px; font-weight:600;">
        <em style="color:#155499">잘못된 접근입니다.</em><br /><br />
		주소를 확인 후 다시 이용바랍니다.<br /><br />
		문의사항이 있을 경우 관리자에게 문의하시기 바랍니다.<br/><br/>
		Access IP : ${pageContext.request.remoteAddr}
        </p>
        
        <ul style="position:absolute; left:180px; top:400px; font-size:16px; font-weight:600;">
        <li style="background: url(/common/images/error_btn01.gif) no-repeat left top; width:155px; height:34px; float:left; padding:9px 0 0 15px;"><a href="/" style="color:#FFF;">홈으로 이동</a></li>
        <li style="background: url(/common/images/error_btn02.gif) no-repeat left top; width:155px; height:34px; float:left; padding:9px 0 0 15px; margin-left:22px;"><a href="javascript:window.history.back();" style="color:#FFF;">이전 페이지</a></li>
        </ul>
        
</div>
</body>
</html>
