<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <style>
      body {
        background-color: rgba(248, 245, 245, 0.97); /* 연한 하늘색 */
        font-family: Arial, sans-serif;
        color: #333; /* 검은색 */
        text-align: center;
        margin: 0;
        padding: 0;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
      }

      form {
        background-color: white;
        border: 2px solid #c3bef0; /* 연한 보라색 */
        padding: 20px;
        width: 320px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      input {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #c3bef0; /* 연한 보라색 */
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 16px;
      }

      button {
        background-color: #c3bef0; /* 연한 보라색 */
        color: white;
        padding: 12px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        font-size: 16px;
      }

      button:hover {
        background-color: #afc5ff; /* 더 연한 보라색 */
      }

      h1 {
        color: #c3bef0; /* 연한 보라색 */
        margin-bottom: 20px;
      }
    </style>
</head>
<body>

<form action="/join" method="post">
    <h1>회원가입</h1>
    <input type="text" name="username" placeholder="아이디" required><br>
    <input type="password" name="password" placeholder="비밀번호" required><br>
    <button type="submit">회원가입</button>
</form>

</body>
</html>
