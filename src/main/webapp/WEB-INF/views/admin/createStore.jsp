<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>지점 추가</title>
  <style>
    body {
      background-color: #f4f4f9; /* 연한 보라색 배경 */
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      height: 100vh;
      margin: 0;
      padding: 20px;
    }

    .container {
      background-color: #ffffff; /* 흰색 배경 */
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      width: 600px;
      max-width: 100%;
      border-top: 8px solid #c3bef0; /* 연한 보라색 테두리 상단 */
    }

    h2 {
      margin-bottom: 20px;
      font-size: 28px;
      font-weight: bold;
      color: #333; /* 어두운 회색 */
      text-align: center;
    }

    hr {
      border: none;
      border-bottom: 1px solid #c3bef0; /* 연한 보라색 구분선 */
      margin: 20px 0;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    th, td {
      padding: 10px;
      text-align: left;
    }

    td:first-child {
      width: 30%;
      font-weight: bold;
      color: #555; /* 어두운 회색 */
    }

    input[type="text"], input[type="date"], input[type="password"], textarea {
      width: 100%;
      padding: 12px;
      margin-bottom: 15px;
      border: 1px solid #ddd; /* 연한 회색 테두리 */
      border-radius: 5px;
      box-sizing: border-box;
      background-color: #f9f9f9; /* 연한 회색 배경 */
    }

    .button-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 30px;
    }

    input[type="submit"], input[type="button"] {
      width: 48%;
      padding: 15px;
      font-size: 16px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      box-sizing: border-box;
    }

    input[type="submit"] {
      background-color: #c3bef0; /* 연한 보라색 버튼 배경 */
      color: #333; /* 검은색 텍스트 */
    }

    input[type="button"] {
      background-color: #cadefc; /* 더 연한 보라색 버튼 배경 */
      color: #333; /* 검은색 텍스트 */
    }

    input[type="submit"]:hover {
      background-color: #b0a8f0; /* 더 진한 보라색 호버 배경 */
    }

    input[type="button"]:hover {
      background-color: #c3bef0; /* 연한 보라색 호버 배경 */
    }

    label {
      color: #333; /* 검은색 레이블 */
    }
  </style>
</head>
<body>

<div class="container">
  <h2>지점 추가</h2>
  <hr>
  <form action="createStore" method="post">
    <table>
      <tr>
        <td><label for="storeName">지점명</label></td>
        <td><input type="text" name="storeName" id="storeName" required></td>
      </tr>
      <tr>
        <td><label for="storeId">지점 아이디</label></td>
        <td><input type="text" name="storeId" id="storeId" required></td>
      </tr>
      <tr>
        <td><label for="password">비밀번호</label></td>
        <td><input type="password" name="password" id="password" required></td>
      </tr>
      <tr>
        <td><label for="roadAddress">도로명 주소</label></td>
        <td><input type="text" name="roadAddress" id="roadAddress" required></td>
      </tr>
      <tr>
        <td><label for="storeAddress1">시/구/동</label></td>
        <td><input type="text" name="storeAddress1" id="storeAddress1"></td>
      </tr>
      <tr>
        <td><label for="storeAddress2">상세 주소</label></td>
        <td><input type="text" name="storeAddress2" id="storeAddress2"></td>
      </tr>
      <tr>
        <td><label for="storeOpenDate">오픈 날짜</label></td>
        <td><input type="date" name="storeOpenDate" id="storeOpenDate" required></td>
      </tr>
      <tr>
        <td><label for="storePhonenumber">매장 전화번호</label></td>
        <td><input type="text" name="storePhonenumber" id="storePhonenumber"></td>
      </tr>
    </table>

    <div class="button-container">
      <input type="submit" value="추가">
      <input type="button" value="취소" onclick="location.href='store'">
    </div>
  </form>
</div>

</body>
</html>
