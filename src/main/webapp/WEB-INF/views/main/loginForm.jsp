<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>아웃Back 로그인</title>
    <style>
      body {
        background-color: #f0f0f0;
        font-family: Arial, sans-serif;
        color: #a83c3c;
        margin: 0;
        padding: 0;
        height: 90vh;
        display: flex;
        justify-content: center;
        align-items: center;
      }

      #header {
        background-color: #F87C7CFC;
        padding: 15px;
        width: 100%;
        text-align: center;
        position: absolute;
        top: 0;
        left: 0;
      }

      #header h1 {
        color: white;
        margin: 0;
      }

      .content {
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
      }

      form {
        background-color: white;
        border: 2px solid #F87C7CFC;
        padding: 20px;
        width: 320px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 15px;
      }

      input {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #F87C7CFC;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 16px;
      }

      button {
        background-color: #F87C7CFC;
        color: white;
        padding: 12px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        font-size: 16px;
      }

      button:hover {
        background-color: #ec0303;
      }

      a {
        display: block;
        margin-top: 10px;
        color: #F87C7CFC;
        text-decoration: none;
        text-align: center;
      }

      a:hover {
        text-decoration: underline;
      }

    </style>
</head>
<body>

<div id="header">
    <h1>아웃Back</h1>
</div>

<div class="content">
    <form action="/login" method="post">
        <input type="text" name="username" placeholder="아이디" required><br>
        <input type="password" name="password" placeholder="비밀번호" required><br>
        <button type="submit">로그인</button>
    </form>

    <a href="/joinForm">회원가입</a>
</div>

</body>
</html>
