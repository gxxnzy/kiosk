<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 추가된 fmt 태그 라이브러리 -->
<!DOCTYPE html>
<html>
<head>
    <title>Store Sales</title>
    <style>
      body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background: linear-gradient(to right, #defcf9, #cadefc); /* 부드러운 그라데이션 배경 */
      }
      header {
        background-color: #c3bef0;
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
      .btn-logout {
        background-color: #c3bef0;
        color: white;
        padding: 10px 20px;
        font-size: 14px;
        border-radius: 50px; /* 둥근 버튼 모양 */
        text-align: center;
        text-decoration: none;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
      .btn-logout:hover {
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
      .search-form {
        margin-bottom: 20px;
        display: flex;
        justify-content: flex-end;
        gap: 10px;
      }
      .search-form input[type="text"] {
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 20px;
        transition: border-color 0.3s ease;
      }
      .search-form input[type="text"]:focus {
        border-color: #afc5ff;
        outline: none;
      }
      .search-form input[type="submit"] {
        padding: 10px 20px;
        font-size: 14px;
        color: white;
        background-color: #c3bef0;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
      }
      .search-form input[type="submit"]:hover {
        background-color: #afc5ff;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
      .total-sales h2 {
        font-size: 22px;
        font-weight: bold;
        color: #333;
        margin-top: 30px;
      }
      .no-results {
        color: #dc3545;
        text-align: center;
        font-size: 18px;
        margin-top: 20px;
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
        .btn-logout {
          padding: 8px 12px;
          font-size: 12px;
        }
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
        <input type="text" name="keyword" placeholder="메뉴 검색..."/>
        <input type="submit" value="검색"/>
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
                <c:set var="processedMenus" value=""/>
                <c:set var="currentMenu" value=""/>
                <c:set var="currentQuantity" value="0"/>
                <c:set var="currentPrice" value="0"/>

                <c:forEach var="result" items="${searchResults}">
                    <c:if test="${not fn:contains(processedMenus, result.menuName)}">
                        <!-- 메뉴 이름, 수량, 가격 초기화 -->
                        <c:set var="currentMenu" value="${result.menuName}"/>
                        <c:set var="currentQuantity" value="0"/>
                        <c:set var="currentPrice" value="0"/>

                        <!-- 동일한 메뉴의 수량과 가격을 누적 -->
                        <c:forEach var="sameResult" items="${searchResults}">
                            <c:if test="${sameResult.menuName == currentMenu}">
                                <c:set var="currentQuantity"
                                       value="${currentQuantity + sameResult.quantity}"/>
                                <c:set var="currentPrice"
                                       value="${currentPrice + sameResult.quantityPrice}"/>
                            </c:if>
                        </c:forEach>

                        <!-- 합산된 메뉴 출력 -->
                        <tr>
                            <td><c:out value="${currentMenu}"/></td>
                            <td><c:out value="${currentQuantity}개"/></td>
                            <td><fmt:formatNumber value="${currentPrice}" type="number"/>원</td>
                        </tr>

                        <!-- 처리된 메뉴 이름을 기록 -->
                        <c:set var="processedMenus" value="${processedMenus},${currentMenu}"/>
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
                    <td><fmt:formatNumber value="${detail.quantityPrice}" type="number"/>원</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <hr>
    <div class="total-sales">
        <c:if test="${not empty totalSales}">
            <h2>총 결제 금액 : <fmt:formatNumber value="${totalSales}" type="number"/>원</h2>
        </c:if>
    </div>
</div>
</body>
</html>
