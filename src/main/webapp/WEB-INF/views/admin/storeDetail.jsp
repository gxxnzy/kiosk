<%--
  Created by IntelliJ IDEA.
  User: KOSA
  Date: 2024-09-17
  Time: 오후 6:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
      body {
        text-align: center;
      }

      table {
        margin: 0 auto;
        border-collapse: collapse;
        width: 50%;
        border: 2px solid black; /* 테두리 명확히 표시 */
      }

      th, td {
        padding: 10px;
        border: 1px solid black; /* 셀 테두리도 명확히 표시 */
        text-align: left;
      }

      th {
        background-color: #f2f2f2;
      }
    </style>
    <title>Title</title>
</head>
<body>
<h1>Store Detail</h1>

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
<a href="../store">목록으로 돌아가기</a>
</body>
</html>
