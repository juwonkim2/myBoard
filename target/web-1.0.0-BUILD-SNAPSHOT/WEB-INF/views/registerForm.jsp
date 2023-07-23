<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URLDecoder"%>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
  <link rel="stylesheet" href="<c:url value='/css/register.css'/>">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
  <style>
  </style>
  <title>Register</title>
</head>
<body>
<div id="menu">
  <ul class="menu-container">
    <li id="logo">juwonKim</li>
    <li><a href="<c:url value='/'/>">Home</a></li>
    <li><a href="<c:url value='/board/list'/>">Board</a></li>
    <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
    <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
    <li><a href=""><i class="fa fa-search"></i></a></li>
  </ul>
</div>
<form action="<c:url value='/register/add'/>" method="post" class="regForm" onsubmit="return formCheck(this)">
  <div class="title">Register</div>
  <div id="msg" class="msg">
    <c:if test="${not empty param.msg}">
      <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
    </c:if>
  </div>
  <label for="id" class="regLabel">아이디</label>
  <input class="input-field" type="text" name="id" id="id" placeholder="8~12자리의 영대소문자와 숫자 조합">
  <label for="pwd" class="regLabel">비밀번호</label>
  <input class="input-field" type="password" name="pwd" id="pwd" placeholder="8~12자리의 영대소문자와 숫자 조합">
  <label for="name" class="regLabel">이름</label>
  <input class="input-field" type="text" name="name" id="name" placeholder="홍길동">
  <label for="email" class="regLabel">이메일</label>
  <input class="input-field" type="text" name="email" id="email" placeholder="example@gmail.com">
  <label for="birth" class="regLabel">생일</label>
  <input class="input-field" type="text" name="birth" id="birth" placeholder="2020/12/31">
  <button class="regBtn">회원 가입</button>
</form>
<script>
  function formCheck(frm) {
    let msg ='';

    if(frm.id.value.length<3) {
      setMessage('ID의 길이는 3자 이상이어야 합니다.', frm.id);
      return false;
    }

    if(frm.pwd.value.length<3) {
      setMessage('암호의 길이는 3자 이상이어야 합니다.', frm.pwd);
      return false;
    }

    return true;
  }

  function setMessage(msg, element){
    document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;

    if(element) {
      element.select();
    }
  }
</script>
</body>
</html>