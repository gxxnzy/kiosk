<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Management</title>
    <style>
      body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(to right, #defcf9, #cadefc); /* 부드러운 그라데이션 배경 */
      }
      header {
        background-color: #c3bef0; /* 연한 보라색 헤더 */
        color: white;
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        border-bottom: 2px solid #afc5ff;
      }
      header h1 {
        margin: 0;
        font-size: 28px;
        font-weight: bold;
      }
      .btn-select, .btn-logout {
        display: inline-block;
        padding: 10px 20px;
        font-size: 14px;
        color: white;
        background-color: #c3bef0;
        border: none;
        border-radius: 50px; /* 둥근 버튼 */
        cursor: pointer;
        text-decoration: none;
        margin-right: 10px;
        text-align: center;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
      .btn-select:hover, .btn-logout:hover {
        background-color: #afc5ff;
        box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
      }
      .container {
        width: 90%;
        margin: 20px auto;
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        position: relative;
        min-height: 400px;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        border-radius: 10px;
        overflow: hidden;
      }
      th, td {
        padding: 15px;
        text-align: left;
        border: 1px solid #ddd;
      }
      th {
        background-color: #afc5ff;
        color: white;
        position: sticky;
        top: 0; /* 테이블 헤더 고정 */
      }
      tbody tr:nth-child(even) {
        background-color: #f9f9f9;
      }
      tbody tr:hover {
        background-color: #e0dff2;
        cursor: pointer;
        transition: background-color 0.3s ease;
      }
      .store-name {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 10px;
        display: block;
        color: #333;
      }
      hr {
        border: 1px solid #afc5ff;
      }
      /* 반응형 디자인 */
      @media (max-width: 768px) {
        .container {
          width: 95%;
          padding: 10px;
        }
        table, th, td {
          font-size: 14px;
          padding: 10px;
        }
        header h1 {
          font-size: 22px;
        }
        .btn-select, .btn-logout {
          padding: 8px 12px;
          font-size: 12px;
        }
      }
    </style>
</head>
<body>
<header>
    <h1>결제 관리</h1>
    <div>
        <a href="/store/main" class="btn-logout">판매량 관리</a>
        <a href="/logout" class="btn-logout">로그아웃</a>
    </div>
</header>
<div class="container">
    <c:if test="${not empty selectedStore}">
        <span class="store-name">현재 지점: ${selectedStore}</span>
    </c:if>
    <hr>
    <!-- 결제 완료 상태가 아닌 주문을 리스트 -->
    <c:if test="${not empty unpaidOrders}">
        <h2>미결제 주문</h2>
        <table>
            <thead>
            <tr>
                <th>키오스크 번호</th>
                <th>선택하기</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="kioskNum" items="${unpaidOrders}">
                <tr>
                    <td><c:out value="${kioskNum}"/></td>
                    <td>
                        <a href="<c:url value='/store/kioskDetails?kioskNum=${kioskNum}&storeName=${selectedStore}'/>"
                           class="btn-select">상세 보기</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
</body>
</html>
