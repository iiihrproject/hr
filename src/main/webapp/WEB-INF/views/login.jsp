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
    
    <style>
    .buttonst {
  	display: inline-block;
  	font-weight: 400;
  	color: #858796;
  	text-align: center;
  	vertical-align: middle;
  	background-color: white;
  	border: 1px solid #858796;
  	padding: 0.375rem 0.75rem;
  	font-size: 1rem;
  	line-height: 1.5;
  	border-radius: 0.35rem;
	}
	
	.buttonst:hover {
  	color: #3a3b45;
  	background-color: #f8f9fc;
	}
    </style>
    
    <script>
    function generalButton1 () {
    	document.getElementById('username').value = 'rd1';
    	document.getElementById('password').value = 'password';
    }
    function generalButton2 () {
    	document.getElementById('username').value = 'rd2';
    	document.getElementById('password').value = 'password';
    }
    function managerButton () {
    	document.getElementById('username').value = 'rdmanager';
    	document.getElementById('password').value = 'password';
    }
    function hrButton () {
    	document.getElementById('username').value = 'hr1';
    	document.getElementById('password').value = 'password';
    }
    function hrmanagerButton () {
    	document.getElementById('username').value = 'hrmanager';
    	document.getElementById('password').value = 'password';
    }
    
    function puButton () {
    	document.getElementById('username').value = 'pu1';
    	document.getElementById('password').value = 'password';
    }
    
    function pumanagerButton () {
    	document.getElementById('username').value = 'pumanager';
    	document.getElementById('password').value = 'password';
    }
    </script>
  </head>
  <body>
    <div class="container">
      <div class="forms-container">
        <div class="signin-signup">
          <form method="post" action="<c:url value='/login'/>" class="sign-in-form">
            <h2 class="title">歡迎使用,</h2>
            <div class="input-field">
              <i class="fas fa-user"></i>
              <input type="text" placeholder="員工帳號" name="username" id="username" autofocus/>
            </div>
            <div class="input-field">
              <i class="fas fa-lock"></i>
              <input type="password" placeholder="密碼" name="password" id="password" />
            </div>
            <input type="submit" value="登  入" class="btn solid"/>
            <span style="font-size: 14px;">如遇登入問題，請與系統管理員聯絡</span><br/><br/><br/>
            <span>
            <button type="button" class="buttonst" onclick="generalButton1()">RD1</button>
            <button type="button" class="buttonst" onclick="generalButton2()">RD2</button>
            <button type="button" class="buttonst" onclick="managerButton()">RDManager</button>
            <button type="button" class="buttonst" onclick="hrButton()">HR</button>
            <button type="button" class="buttonst" onclick="hrmanagerButton()">HR Manager</button>
            <button type="button" class="buttonst" onclick="pumanagerButton()">PU Manager</button>
            <button type="button" class="buttonst" onclick="puButton()">PU1</button>
            </span>
            <br/>
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
