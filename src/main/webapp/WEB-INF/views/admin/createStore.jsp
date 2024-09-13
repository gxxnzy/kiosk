<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>지점 추가</title>
  <style>
    body {
      text-align: center;
      margin: 0;
      padding: 0;
    }

    form {
      margin: 20px auto;
      width: 100%;
      max-width: 600px;
    }

    table {
      margin: 0 auto;
      border-collapse: collapse;
      width: 100%;
    }

    th, td {
      padding: 10px;
      text-align: left;
      border: 1px solid #ddd;
    }

    th {
      background-color: #f4f4f4;
    }
  </style>
</head>
<body>

<h1>지점 추가</h1>

<form action="createStore" method="post">
  <table>
    <tr>
      <th>지점명</th>
      <td>
        <input type="text" name="storeName" required>
      </td>
    </tr>
    <tr>
      <th>지점 아이디</th>
      <td>
        <input type="text" name="storeId" required>
      </td>
    </tr>
    <tr>
      <th>도로명 주소</th>
      <td>
        <input type="text" name="roadAddress" required>
      </td>
    </tr>
    <tr>
      <th>시/구/동</th>
      <td>
        <input type="text" name="storeAddress1">
      </td>
    </tr>
    <tr>
      <th>상세 주소</th>
      <td>
        <input type="text" name="storeAddress2">
      </td>
    </tr>
    <tr>
      <th>오픈 날짜</th>
      <td>
        <input type="date" name="storeOpenDate" required>
      </td>
    </tr>
    <tr>
      <th>매장 전화번호</th>
      <td>
        <input type="text" name="storePhonenumber">
      </td>
    </tr>
    <tr>
      <td colspan="2" style="text-align: center;">
        <input type="submit" value="추가">
        <input type="button" value="취소" onclick="location.href='store'">
      </td>
    </tr>
  </table>
</form>

</body>
</html>
