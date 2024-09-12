$(document).ready(function() {
  let allMenus = JSON.parse('${menusJson}');
  let cart = [];  // 장바구니 배열

  // 카테고리 목록 동적으로 생성
  let categories = [...new Set(allMenus.map(menu => menu.categoryName))]; // 중복 제거된 카테고리
  let categoryList = $("#category-list");

  categories.forEach(function(category) {
    categoryList.append("<li><button onclick='filterMenus(\"" + category + "\")'>" + category + "</button></li>");
  });

  // 카테고리 클릭 시 해당 메뉴 필터링하여 표시
  window.filterMenus = function(category) {
    let menuList = $("#menu-list");
    menuList.empty();

    let filteredMenus = allMenus.filter(menu => menu.categoryName === category);

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

  // 장바구니에서 수량 줄이기
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

  // 장바구니 업데이트
  function updateCartDisplay() {
    let cartList = $("#cart-list");
    cartList.empty();

    let total = 0;
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
  }
});