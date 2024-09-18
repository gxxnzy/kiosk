<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kiosk Menu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/menuStyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/menuScript.js"></script>
</head>
<body>
<div id="kiosk-container">
    <!-- 카테고리 섹션 -->
    <div id="category-section">
        <h1>${kiosk.storeName}</h1>
        <h2>${kiosk.kioskNum}번 테이블</h2>
        <ul id="category-list"></ul>
        <div class="order-history-button-container">
            <a href="orderHistory"><button>주문 내역</button></a>
        </div>
    </div>

    <!-- 메뉴 섹션 -->
    <div id="menu-section">
        <h2 id="menu-section-title">Menus</h2> <!-- 선택된 카테고리 이름을 표시 -->
        <p id="menu-section-info" style="font-size: 15px; color: gray;"></p> <!-- 선택된 카테고리 정보를 표시 -->
        <div id="menu-list"></div>
    </div>

    <!-- 장바구니 섹션 -->
    <div id="cart-section">
        <h2>Cart</h2>
        <div id="cart-list"></div>
        <form id="cart-form" action="checkout" method="post">
            <button type="submit">주문하기</button>
        </form>
    </div>

</div>

</body>
</html>
