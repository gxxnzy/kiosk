<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <style>
      body {
        text-align: center;
        background-color: #f9f9f9; /* 배경색 */
        font-family: Arial, sans-serif;
      }

      h1 {
        margin-top: 20px;
      }

      .container {
        display: flex;
        justify-content: space-around; /* 양쪽 정렬 */
        margin: 20px;
      }

      .details, .kiosk-status {
        width: 45%; /* 너비 조정 */
        padding: 20px;
        border: 2px solid #ddd; /* 경계선 */
        border-radius: 10px;
        background-color: #fff; /* 배경색 흰색 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      table {
        width: 100%; /* 테이블 너비 조정 */
        border-collapse: collapse;
        margin: 20px auto;
      }

      th, td {
        padding: 10px;
        border: 1px solid #ddd; /* 셀 테두리 */
        text-align: left;
      }

      th {
        background-color: rgba(248, 124, 124, 0.99);
        color: white;
      }

      .button-group {
        display: flex;
        justify-content: center;
        gap: 10px; /* 버튼 간격 */
        margin-top: 20px;
      }

      .button {
        background-color: rgba(248, 124, 124, 0.99);
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }

      .button:hover {
        background-color: #ec0303;
      }

      .back-button {
        padding: 10px 20px;
        background-color: rgba(248, 124, 124, 0.99);
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
      }

      .back-button:hover {
        background-color: #ec0303;
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
