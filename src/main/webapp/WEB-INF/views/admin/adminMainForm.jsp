<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>관리자 페이지</title>
    <style>
      body {
        background-color: #fff; /* 흰색 배경 */
        font-family: Arial, sans-serif;
        color: #333; /* 검은색 텍스트 */
        text-align: center;
        margin: 0;
        padding: 20px;
      }

      h1 {
        color: rgba(2, 2, 2, 0.97); /* 연한 보라색 */
        margin-bottom: 20px;
      }

      hr {
        border: 1px solid #c3bef0; /* 연한 보라색 */
        margin-bottom: 20px;
      }

      a {
        display: inline-block;
        margin: 15px;
        text-decoration: none;
      }

      a input[type="submit"] {
        background-color: #c3bef0; /* 연한 보라색 */
        color: white;
        padding: 12px 20px;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      a input[type="submit"]:hover {
        background-color: #afc5ff; /* 더 연한 보라색 */
      }

      a input[type="submit"]:active {
        transform: scale(0.98);
      }
    </style>
</head>
<body>

<h1>관리자 페이지</h1>
<hr>

<a href="menu"><input type="submit" value="메뉴 관리"></a>
<a href="store"><input type="submit" value="매장 관리"></a>
<a href="promotions"><input type="submit" value="광고 관리"></a>

</body>
</html>
