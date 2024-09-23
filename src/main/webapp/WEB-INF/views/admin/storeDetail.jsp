<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <style>
      body {
        text-align: center;
        background-color: #f4f4f9; /* Light purple background */
        font-family: Arial, sans-serif;
      }

      h1 {
        margin-top: 20px;
        color: #333; /* Darker text color */
      }

      .container {
        display: flex;
        justify-content: space-around; /* Space around content */
        margin: 20px;
      }

      .details, .kiosk-status {
        width: 45%; /* Adjust width */
        padding: 20px;
        border: 2px solid #ddd; /* Border color */
        border-radius: 10px;
        background-color: #ffffff; /* White background */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      table {
        width: 100%; /* Table width */
        border-collapse: collapse;
        margin: 20px auto;
      }

      th, td {
        padding: 10px;
        border: 1px solid #ddd; /* Cell border */
        text-align: left;
      }

      th {
        background-color: #d3c0eb; /* Light purple table header */
        color: #333; /* Header text color */
      }

      .button-group {
        display: flex;
        justify-content: center;
        gap: 10px; /* Button gap */
        margin-top: 20px;
      }

      .button {
        background-color: #c3bef0; /* Medium purple button */
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }

      .button:hover {
        background-color: #9e8cba; /* Darker purple on hover */
      }

      .back-button {
        padding: 10px 20px;
        background-color: #c3bef0; /* Sky blue button */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }

      .back-button:hover {
        background-color: #b0e0e6; /* Lighter sky blue on hover */
      }
    </style>
    <title>매장 상세</title>
</head>
<body>
<h1>매장 상세</h1>

<div class="container">
    <div class="details">
        <h2>매장 정보</h2>
        <table>
            <tr>
                <th>매장 아이디</th>
                <td>${store.storeId}</td>
            </tr>
            <tr>
                <th>지점명</th>
                <td>${store.storeName}</td>
            </tr>
            <tr>
                <th>도로명 주소</th>
                <td>${store.roadAddress}</td>
            </tr>
            <tr>
                <th>지번 주소</th>
                <td>${store.storeAddress1} ${store.storeAddress2}</td>
            </tr>
            <tr>
                <th>상태</th>
                <td>${store.storeStatus}</td>
            </tr>
            <tr>
                <th>오픈 날짜</th>
                <td>${store.storeOpenDate}</td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>${store.storePhonenumber}</td>
            </tr>
        </table>

        <form action="editStore" method="get">
            <input type="hidden" name="storeId" value="${store.storeId}">
            <button type="submit" class="button">매장 수정</button>
        </form>
    </div>

    <div class="kiosk-status">
        <h2>키오스크 현황</h2>

        <table>
            <thead>
            <tr>
                <th>키오스크 아이디</th>
                <th>키오스크 넘버</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="kiosk" items="${kiosks}">
                <tr>
                    <td>${kiosk.kioskId}</td>
                    <td>${kiosk.kioskNum}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="button-group">
            <form action="createKiosk" method="post">
                <input type="hidden" name="storeId" value="${store.storeId}">
                <input type="hidden" name="storeName" value="${store.storeName}">
                비밀번호 <input type="password" name="password" required>
                <button type="submit" class="button">키오스크 추가</button>
            </form>
            <form action="deleteLastKiosk" method="post">
                <input type="hidden" name="storeId" value="${store.storeId}">
                <input type="hidden" name="storeName" value="${store.storeName}">
                <button type="submit" class="button">키오스크 삭제</button>
            </form>
        </div>
    </div>
</div>

<button class="back-button" onclick="location.href='../store'">목록으로 돌아가기</button>
</body>
</html>
