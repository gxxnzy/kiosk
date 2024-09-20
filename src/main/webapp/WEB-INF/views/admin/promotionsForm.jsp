<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>광고 관리</title>
    <style>
      table {
        width: 100%;
        border-collapse: collapse;
      }

      th, td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
      }

      th {
        background-color: #f4f4f4;
      }
    </style>
</head>
<body>

<h1>광고 관리</h1>

<table>
    <thead>
    <tr>
        <th>광고 ID</th>
        <th>광고 이름</th>
        <th>시작 날짜</th>
        <th>종료 날짜</th>
        <th>상태</th>
        <th>활성화 여부</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="promotion" items="${promotions}">
        <tr>
            <td>${promotion.promotionId}</td>
            <td>${promotion.promotionName}</td>
            <td>${promotion.startDate}</td>
            <td>${promotion.endDate}</td>
            <td>${promotion.promotionStatus}</td>
            <td>${promotion.promotionActive ? '활성' : '비활성'}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<a href="adminMain">메인으로 돌아가기</a>
</body>
</html>
