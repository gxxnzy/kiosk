<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kiosk Menu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/menuStyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
      $(document).ready(function() {
        let allMenus = JSON.parse('${menusJson}');
        let allCategories = JSON.parse('${categoryJson}');
        let cart = [];  // 장바구니 배열

        // 카테고리 목록 동적으로 생성
        let categoryList = $("#category-list");
        let menuSectionTitle = $("#menu-section-title");
        let menuSectionInfo = $("#menu-section-info");

        allCategories.forEach(function(category) {
          categoryList.append(
              "<li>" +
              "<button onclick='filterMenus(\"" + category.categoryName + "\", \"" + category.categoryInfo + "\")'>" +
              category.categoryName +
              "</button>"  +
              "</li>"
          );
        });
        // 카테고리 클릭 시 해당 메뉴 필터링하여 표시
        window.filterMenus = function(categoryName, categoryInfo) {
          let menuList = $("#menu-list");
          menuList.empty();

          // 메뉴 섹션에 카테고리 이름과 정보를 표시
          menuSectionTitle.text(categoryName);
          menuSectionInfo.text(categoryInfo);

          let filteredMenus = allMenus.filter(menu => menu.categoryName === categoryName);

          filteredMenus.forEach(function(menu) {
            menuList.append(
                "<div class='menu-item'>" +
                "<img src='" + menu.menuImage + "' alt='" + menu.menuName + "' />" +
                "<h3>" + menu.menuName + "</h3>" +
                "<p>Price: " + menu.menuPrice + "원</p>" +
                "<button onclick='addToCart(" + menu.menuId + ")'>Add to Cart</button>" +
                "</div>"
            );
          });
        }
        if (allCategories.length > 0) {
          let firstCategory = allCategories[0];  // 첫 번째 카테고리 가져오기
          filterMenus(firstCategory.categoryName, firstCategory.categoryInfo);
        }
        // 장바구니에 메뉴 추가
        window.addToCart = function(menuId) {
          let found = cart.find(item => item.menuId === menuId);
          if (found) {
            found.quantity += 1;  // 이미 있는 메뉴는 수량 증가
          } else {
            let menuToAdd = allMenus.find(menu => menu.menuId === menuId); // 해당 메뉴 찾기
            cart.push({ ...menuToAdd, quantity: 1 });  // 새 메뉴는 수량 1로 추가
          }
          updateCartDisplay();
        }

        // 장바구니 업데이트 함수
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
            cartList.append("<p>Total: " + total + "원</p>");
            $("#cart-section").show(); // 장바구니 섹션 보이기
          } else {
            $("#cart-section").hide(); // 장바구니가 비어있을 때 숨기기
          }
        }
        window.decreaseQuantity = function(menuId) {
          let found = cart.find(item => item.menuId === menuId);
          if (found && found.quantity > 1) {
            found.quantity -= 1;  // 수량 감소
          } else {
            cart = cart.filter(item => item.menuId !== menuId);  // 수량이 1이면 장바구니에서 제거
          }
          updateCartDisplay();
        }
        // 장바구니에서 수량 추가하기
        window.increaseQuantity = function(menuId) {
          let found = cart.find(item => item.menuId === menuId);
          if (found) {
            found.quantity += 1;  // 수량 증가
          }
          updateCartDisplay();
        }
          // 주문하기 버튼 클릭 시 장바구니 데이터를 전송
          $("form#cart-form").on("submit", function(event) {
              event.preventDefault(); // 폼의 기본 동작을 막음

              let cartData = JSON.stringify(cart);
              $("input[name='cartData']").val(cartData);
              $(this).off("submit").submit(); // 폼을 다시 제출
          });
        updateCartDisplay();
      });


    </script>
</head>
<body>
<div id="kiosk-container">
    <!-- 카테고리 섹션 -->
    <div id="category-section">
        <h2>Categories</h2>
        <ul id="category-list"></ul>
    </div>

    <!-- 메뉴 섹션 -->
    <div id="menu-section">
        <h2 id="menu-section-title">Menus</h2> <!-- 선택된 카테고리 이름을 표시 -->
        <p id="menu-section-info" style="font-size: 12px; color: gray;"></p> <!-- 선택된 카테고리 정보를 표시 -->
        <div id="menu-list"></div>
    </div>

    <!-- 장바구니 섹션 -->
    <div id="cart-section">
        <h2>Cart</h2>
        <div id="cart-list"></div>
        <form id="cart-form" action="/kiosk/checkout" method="post">
            <input type="hidden" name="cartData" />
        <button type="submit">주문하기</button>
        </form>
    </div>

</div>

</body>
</html>
