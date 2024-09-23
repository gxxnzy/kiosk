<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Store Sales</title>
    <style>
      body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4; /* 연한 회색 배경 */
      }
      header {
        background-color: #c3bef0; /* 연한 보라색 헤더 */
        color: white;
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      }
      header h1 {
        margin: 0;
        font-size: 24px;
      }
      header .nav-links {
        color: white;
        text-decoration: none;
        font-size: 16px;
        margin-right: 20px;
      }
      .container {
        width: 80%;
        margin: 20px auto;
        background: white;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        position: relative;
        min-height: 400px;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }
      th, td {
        padding: 15px;
        text-align: left;
        border: 1px solid #ddd;
      }
      th {
        background-color: #c3bef0; /* 연한 보라색 테이블 헤더 */
        color: white;
      }
      tbody tr:nth-child(even) {
        background-color: #f9f9f9; /* 연한 회색 */
      }
      tbody tr:hover {
        background-color: #e0dff2; /* 연한 보라색 호버 효과 */
      }

      .btn-logout {
        background-color: #c3bef0; /* 연한 보라색 */
        color: white;
        padding: 8px 16px;
        font-size: 14px;
        border-radius: 3px;
        text-align: center;
        text-decoration: none;
        margin-left: 10px;
        cursor: pointer;
      }

      .btn-logout:hover {
        background-color: #afc5ff; /* 더 연한 보라색 */
      }

      .search-form {
        margin-bottom: 20px;
        display: flex;
        justify-content: flex-end;
      }
      .search-form input[type="text"] {
        padding: 8px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 3px;
        margin-right: 10px;
      }
      .search-form input[type="submit"] {
        padding: 8px 16px;
        font-size: 14px;
        color: white;
        background-color: #c3bef0; /* 연한 보라색 */
        border: none;
        border-radius: 3px;
        cursor: pointer;
      }
      .search-form input[type="submit"]:hover {
        background-color: #afc5ff; /* 더 연한 보라색 */
      }
      .total-sales {
        text-align: right;
        margin-top: 20px;
      }
      .no-results {
        color: #dc3545; /* 빨간색 오류 메시지 */
        text-align: center;
        font-size: 18px;
        margin-top: 20px;
      }
      .store-name {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px;
        display: block;
      }
      hr {
        border: 1px solid #c3bef0; /* 연한 보라색 HR */
      }
    </style>
</head>
<body>
<header>
    <h1>판매량 확인</h1>
    <div>
        <a href="/store/payment" class="btn-logout">결제 관리</a>
        <a href="/logout" class="btn-logout">로그아웃</a>
    </div>
</header>
<div class="container">
    <c:if test="${not empty selectedStore}">
        <span class="store-name">현재 지점: ${selectedStore}</span>
    </c:if>

    <!-- 검색 폼 추가 -->
    <form action="/store/search" method="get" class="search-form">
        <input type="text" name="keyword" placeholder="메뉴 검색..." />
        <input type="submit" value="검색" />
    </form>

    <hr>

    <!-- 검색 결과 통합하여 표시 -->
    <c:choose>
        <c:when test="${not empty searchResults}">
            <h2>검색 결과</h2>
            <table>
                <thead>
                <tr>
                    <th>메뉴 이름</th>
                    <th>주문 수</th>
                    <th>가격</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="processedMenus" value="" />
                <c:set var="currentMenu" value="" />
                <c:set var="currentQuantity" value="0" />
                <c:set var="currentPrice" value="0" />

                <c:forEach var="result" items="${searchResults}">
                    <c:if test="${not fn:contains(processedMenus, result.menuName)}">
                        <!-- 메뉴 이름, 수량, 가격 초기화 -->
                        <c:set var="currentMenu" value="${result.menuName}" />
                        <c:set var="currentQuantity" value="0" />
                        <c:set var="currentPrice" value="0" />

                        <!-- 동일한 메뉴의 수량과 가격을 누적 -->
                        <c:forEach var="sameResult" items="${searchResults}">
                            <c:if test="${sameResult.menuName == currentMenu}">
                                <c:set var="currentQuantity" value="${currentQuantity + sameResult.quantity}" />
                                <c:set var="currentPrice" value="${currentPrice + sameResult.quantityPrice}" />
                            </c:if>
                        </c:forEach>

                        <!-- 합산된 메뉴 출력 -->
                        <tr>
                            <td><c:out value="${currentMenu}"/></td>
                            <td><c:out value="${currentQuantity}개"/></td>
                            <td><c:out value="${currentPrice}원"/></td>
                        </tr>

                        <!-- 처리된 메뉴 이름을 기록 -->
                        <c:set var="processedMenus" value="${processedMenus},${currentMenu}" />
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <c:if test="${param.keyword != null and param.keyword != ''}">
                <div class="no-results">
                    검색 결과가 존재하지 않습니다.
                </div>
            </c:if>
        </c:otherwise>
    </c:choose>

    <!-- 전체 주문 내역 테이블 -->
    <c:if test="${empty searchResults and (param.keyword == null or param.keyword == '')}">
        <h2>전체 주문 내역</h2>
        <table>
            <thead>
            <tr>
                <th>메뉴 이름</th>
                <th>주문 수</th>
                <th>가격</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="detail" items="${orderDetails}">
                <tr>
                    <td><c:out value="${detail.menuName}"/></td>
                    <td><c:out value="${detail.quantity}개"/></td>
                    <td><c:out value="${detail.quantityPrice}원"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <hr>
    <div class="total-sales">
        <c:if test="${not empty totalSales}">
            <h2>총 결제 금액 : ${totalSales}원</h2>
        </c:if>
    </div>
</div>
</body>
</html>
