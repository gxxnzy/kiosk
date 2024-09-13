<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Kiosk Menu</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/menuStyle.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }
    #category-section {
      position: fixed;
      top: 0;
      width: 100%;
      background-color: white;
      z-index: 1000;
      padding: 10px;
      text-align: center;
    }
    #category-section ul {
      display: flex;
      justify-content: center;
      padding: 0;
      list-style: none;
    }
    #category-section ul li {
      margin: 0 10px;
    }
    #category-section ul li button {
      padding: 10px 20px;
      font-size: 16px;
      width: 150px;
      height: 50px;
      cursor: pointer;
    }
    #kiosk-container {
      display: flex;
      justify-content: center;
      align-items: flex-start;
      margin-top: 100px;
      position: relative;
    }
    /* 장바구니가 있을 때 메뉴 섹션을 왼쪽으로 이동 */
    #menu-section.with-cart {
      justify-content: flex-start; /* 왼쪽 정렬 */
    }

    /* 기본적으로 메뉴 리스트는 가운데 정렬 */
    #menu-section {
      display: flex;
      justify-content: center; /* 가운데 정렬 */
      flex-wrap: wrap;
      transition: justify-content 0.3s ease; /* 부드러운 이동 효과 */
    }
    .menu-item {
      display: inline-block;
      width: 180px;
      margin: 20px;
      text-align: center;
    }
    .menu-item img {
      width: 100%;
      height: auto;
    }
    #cart-section {
      position: fixed;
      top: 100px;
      right: 0;
      width: 400px;
      padding: 10px;
      background-color: #f4f4f4;
      border: 1px solid #ccc;
      display: none; /* 처음에는 숨김 */
    }
    .cart-item {
      margin-bottom: 20px;
    }
    .cart-item button {
      margin: 5px;
    }

    .category-title {
      text-align: center;
      font-size: 24px;
      margin-bottom: 20px;
    }

    /* 카테고리 고정 부분 */
    h2 {
      width: 100%;
      text-align: center;
      margin-top: 50px;
    }

  </style>
  <script>
    $(document).ready(function() {
      let allMenus = JSON.parse('${menusJson}');
      let cart = [];

      // 카테고리 목록 동적으로 생성
      let categories = [...new Set(allMenus.map(menu => menu.categoryName))];
      let categoryList = $("#category-list");

      categories.forEach(function(category) {
        categoryList.append("<li><button onclick='scrollToCategory(\"" + category + "\")'>" + category + "</button></li>");
      });

      // 메뉴 섹션 동적 생성
      let menuSection = $("#menu-section");
      categories.forEach(function(category) {
        menuSection.append("<h2 id='" + category + "'>" + category + "</h2>");
        allMenus.filter(menu => menu.categoryName === category).forEach(function(menu) {
          menuSection.append(
                  "<div class='menu-item'>" +
                  "<img src='" + menu.menuImage + "' alt='" + menu.menuName + "' />" +
                  "<h3>" + menu.menuName + "</h3>" +
                  "<p>Price: " + menu.menuPrice + "원</p>" +
                  "<button onclick='addToCart(" + menu.menuId + ")'>Add to Cart</button>" +
                  "</div>"
          );
        });
      });

      // 카테고리 클릭 시 해당 메뉴 섹션으로 스크롤 이동
      window.scrollToCategory = function(category) {
        $('html, body').animate({
          scrollTop: $("#" + category).offset().top - 50
        }, 500);
      }

      // 장바구니에 메뉴 추가
      window.addToCart = function(menuId) {
        let found = cart.find(item => item.menuId === menuId);
        if (found) {
          found.quantity += 1;
        } else {
          let menuToAdd = allMenus.find(menu => menu.menuId === menuId);
          cart.push({ ...menuToAdd, quantity: 1 });
        }
        updateCartDisplay();
      }

      // 장바구니 업데이트 함수 수정
      function updateCartDisplay() {
        let cartList = $("#cart-list");
        cartList.empty();

        let total = 0;
        if (cart.length > 0) {
          cart.forEach(function(item) {
            cartList.append(
                    "<div class='cart-item'>" +
                    "<h4>" + item.menuName + "</h4>" +
                    "<p>Price: " + item.menuPrice + "원 (Total: " + (item.menuPrice * item.quantity) + "원)</p>" +
                    "<button onclick='decreaseQuantity(" + item.menuId + ")'>Remove one</button>" +
                    "<span> Quantity: " + item.quantity + " </span>" +
                    "<button onclick='increaseQuantity(" + item.menuId + ")'>Add one</button>" +
                    "</div>"
            );
            total += item.menuPrice * item.quantity;
          });

          // 총 금액 표시
          cartList.append("<p>Total: " + total + "원</p>");
          $("#cart-section").show(); // 장바구니 섹션 보이기
          $("#menu-section").addClass("with-cart"); // 장바구니가 있을 때 메뉴 위치 조정
        } else {
          cartList.append("<p>The cart is empty.</p>");
          $("#cart-section").hide(); // 장바구니 섹션 숨기기
          $("#menu-section").removeClass("with-cart"); // 장바구니가 없을 때 메뉴 원래 위치로
        }
      }


      // 장바구니에서 메뉴 수량 줄이기
      window.decreaseQuantity = function(menuId) {
        let found = cart.find(item => item.menuId === menuId);
        if (found && found.quantity > 1) {
          found.quantity -= 1;
        } else {
          cart = cart.filter(item => item.menuId !== menuId);
        }
        updateCartDisplay();
      }

      // 장바구니에서 메뉴 수량 추가하기
      window.increaseQuantity = function(menuId) {
        let found = cart.find(item => item.menuId === menuId);
        if (found) {
          found.quantity += 1;
        }
        updateCartDisplay();
      }
    });
  </script>
</head>
<body>
<div id="category-section">
  <ul id="category-list"></ul>
</div>

<div id="kiosk-container">
  <!-- 메뉴 섹션 -->
  <div id="menu-section"></div>

  <!-- 장바구니 섹션 -->
  <div id="cart-section">
    <h2>Cart</h2>
    <div id="cart-list"></div>
  </div>
</div>
</body>
</html>
