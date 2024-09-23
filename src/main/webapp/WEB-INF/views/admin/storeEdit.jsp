<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>지점 수정</title>
    <style>
      body {
        background-color: #f0f0f0;
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        height: 100vh;
        margin: 0;
        padding: 20px;
      }

      .container {
        background-color: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width: 600px;
        max-width: 100%;
        border-top: 8px solid rgba(248, 124, 124, 0.99);
      }

      h2 {
        margin-bottom: 20px;
        font-size: 28px;
        font-weight: bold;
        color: rgba(2, 2, 2, 0.97);
        text-align: center;
      }

      hr {
        border: none;
        border-bottom: 1px solid rgba(248, 124, 124, 0.99);
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
        color: #555;
      }

      input[type="text"], input[type="date"], input[type="password"], textarea {
        width: 100%;
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
        background-color: #f9f9f9;
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
        background-color: rgba(248, 124, 124, 0.99);
        color: white;
      }

      input[type="button"] {
        background-color: #f4f4f4;
        color: #333;
      }

      input[type="submit"]:hover {
        background-color: #ec0303;
      }

      input[type="button"]:hover {
        background-color: #e0e0e0;
      }

      label {
        color: #bb2528;
      }
    </style>
</head>
<body>

<div class="container">
    <h2>매장 수정</h2>
    <hr>
    <form action="updateStore" method="post">
        <table>
            <tr>
                <td><label for="storeName">지점명</label></td>
                <td><input type="text" id="storeName" name="storeName" value="${store.storeName}" readonly></td>
            </tr>
            <tr>
                <td><label for="storeId">지점 아이디</label></td>
                <td><input type="text" id="storeId"name="storeId" value="${store.storeId}" readonly></td>
            </tr>
            <tr>
                <td><label for="password">비밀번호</label></td>
                <td><input type="password" id="password" name="password" placeholder="비밀번호를 변경하려면 입력"></td>
            </tr>
            <tr>
                <td><label for="roadAddress">도로명 주소</label></td>
                <td><input type="text" id="roadAddress" name="roadAddress" value="${store.roadAddress}" required></td>
            </tr>
            <tr>
                <td><label for="storeAddress1">시/구/동</label></td>
                <td><input type="text" id="storeAddress1" name="storeAddress1" value="${store.storeAddress1}"></td>
            </tr>
            <tr>
                <td><label for="storeAddress2">상세 주소</label></td>
                <td><input type="text" id="storeAddress2" name="storeAddress2" value="${store.storeAddress2}"></td>
            </tr>
            <tr>
                <td><label for="storeOpenDate">오픈 날짜</label></td>
                <td><input type="date" id="storeOpenDate" name="storeOpenDate" value="${store.storeOpenDate}" required></td>
            </tr>
            <tr>
                <td><label for="storePhonenumber">매장 전화번호</label></td>
                <td><input type="text" id="storePhonenumber" name="storePhonenumber" value="${store.storePhonenumber}"></td>
            </tr>
            <tr>
                <td><label for="storeStatus">영업 상태</label></td>
                <td>
                    <select id="storeStatus" name="storeStatus" required>
                        <option value="영업중" ${store.storeStatus == '영업중' ? 'selected' : ''}>영업중</option>
                        <option value="폐점" ${store.storeStatus == '폐점' ? 'selected' : ''}>폐점</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <input type="submit" value="수정">
                    <input type="button" value="취소" onclick="location.href='${store.storeId}'">
                </td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>
