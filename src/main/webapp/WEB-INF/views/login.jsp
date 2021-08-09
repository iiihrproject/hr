<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"  %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous" ></script>
    <link rel="icon" href="img/favicon.png">
    <link rel="stylesheet" href="css/style.css" />
    <title>login</title>
  </head>
  <body>
    <div class="container">
      <div class="forms-container">
        <div class="signin-signup">
          <form method="post" action="<c:url value='/index'/>" class="sign-in-form">
            <h2 class="title">歡迎使用,</h2>
            <div class="input-field">
              <i class="fas fa-user"></i>
              <input type="text" placeholder="員工帳號" name="empno" autofocus/>
            </div>
            <div class="input-field">
              <i class="fas fa-lock"></i>
              <input type="password" placeholder="密碼" name="password" />
            </div>
            <input type="submit" value="登  入" class="btn solid"/>
            <span style="font-size: 14px;">如遇登入問題，請與系統管理員聯絡</span><br/><br/><br/><br/>
          </form>
        </div>
      </div>

      <div class="panels-container">
        <div class="panel left-panel">
          <div class="content">
            <img src="img/logo_frame.png">
            <h2>HR有限公司 人力資源系統</h2>
          </div>
          <img src="" class="image" alt="" />
        </div>
        <div class="panel right-panel">
          <div class="content">
          </div>
          <img src="" class="image" alt="" />
        </div>
      </div>
    </div>
  </body>
</html>
