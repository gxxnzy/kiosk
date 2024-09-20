<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
      #header{
        background-color: #ffe5e5; /* 연한 빨간색 배경 */
      }
      body {
        background-color: #ffffff; /* 연한 빨간색 배경 */
        font-family: Arial, sans-serif;
        color: #a83c3c; /* 진한 빨간색 텍스트 */
        text-align: center;
      }

      h1 {
        color: #990000; /* 더 짙은 빨간색 */
      }

      form {
        background-color: #ffffff; /* 연한 빨간색 박스 */
        border: 2px solid #e60000;
        padding: 20px;
        width: 300px;
        margin: 0 auto;
        border-radius: 10px;
      }

      input {
        width: 90%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #cc3333;
        border-radius: 5px;
        box-sizing: border-box;
      }

      button {
        background-color: #cc3333; /* 버튼 빨간색 */
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }

      button:hover {
        background-color: #b32424; /* 버튼 호버 시 더 짙은 빨간색 */
      }

      a {
        display: inline-block;
        margin-top: 15px;
        color: #a83c3c;
        text-decoration: none;
      }

      a:hover {
        text-decoration: underline;
      }

      hr {
        border: 1px solid #e60000;
      }
    </style>
</head>
<body>
<div id = "header">
<h1>아웃Back</h1>
</div>
<form action="/login" method="post">
    <input type="text" name="username" placeholder="Username"><br>
    <input type="password" name="password" placeholder="Password"><br>
    <button>로그인</button>
</form>
<a href="/joinForm">회원가입</a>
</body>
</html>
