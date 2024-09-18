$(document).ready(function() {
  let allMenus = [];
  let allCategories = [];

  // 메뉴와 카테고리 데이터를 가져오는 AJAX 요청
  function fetchMenusAndCategories() {
    // 메뉴 데이터를 먼저 가져옴
    $.ajax({
      url: "/kiosk/api/menus",
      method: "GET",
      success: function(response) {
        allMenus = response;
        console.log("Menus:", allMenus);

        // 메뉴 데이터를 가져온 후 카테고리를 가져옴
        fetchCategories();
      },
      error: function() {
        console.log("Failed to fetch menus.");
      }
    });
  }

  // 카테고리 데이터를 가져오는 함수
  function fetchCategories() {
    $.ajax({
      url: "/kiosk/api/categories",
      method: "GET",
      success: function(response) {
        allCategories = response;
        console.log("Categories:", allCategories);
        renderCategories(); // 카테고리를 렌더링한 후 첫 번째 카테고리를 자동 선택
      },
      error: function() {
        console.log("Failed to fetch categories.");
      }
    });
  }

  // 카테고리를 렌더링하는 함수
  function renderCategories() {
    let categoryList = $("#category-list");
    categoryList.empty();

    allCategories.forEach(function(category) {
      categoryList.append(
          "<li>" +
          "<button onclick='filterMenus(\"" + category.categoryName + "\", \"" + category.categoryInfo + "\", this)'>" +
          category.categoryName +
          "</button>" +
          "</li>"
      );
    });

    // 첫 번째 카테고리 자동 선택
    if (allCategories.length > 0) {
      let firstCategory = allCategories[0];
      // 첫 번째 버튼을 직접 클릭하여 필터링 적용
      filterMenus(firstCategory.categoryName, firstCategory.categoryInfo, $("#category-list button").first());
    }
  }

  // 카테고리 클릭 시 해당 메뉴 필터링하여 표시
  window.filterMenus = function(categoryName, categoryInfo, button) {
    let menuList = $("#menu-list");
    menuList.empty();

    // 메뉴 섹션에 카테고리 이름과 정보를 표시
    $("#menu-section-title").text(categoryName);
    $("#menu-section-info").text(categoryInfo);

    // 모든 카테고리 버튼에서 active 클래스 제거
    $("#category-list button").removeClass("active");

    // 클릭된 버튼에 active 클래스 추가
    $(button).addClass("active");

    let filteredMenus = allMenus.filter(menu => menu.categoryName === categoryName);

    filteredMenus.forEach(function(menu) {
      menuList.append(
          "<div class='menu-item'>" +
          "<img src='" + menu.menuImage + "' alt='" + menu.menuName + "' />" +
          "<h3>" + menu.menuName + "</h3>" +
          "<p>" + menu.menuPrice + "원</p>" +
          "<button onclick='addToCart(" + menu.menuId + ")'>담기</button>" +
          "</div>"
      );
    });
  }

  // 장바구니 관련 로직
  function loadCartFromCookie() {
    const cookies = document.cookie.split(';');
    let cartCookie = null;

    cookies.forEach(function(cookie) {
      const [name, value] = cookie.trim().split('=');
      if (name === 'cart') {
        cartCookie = decodeURIComponent(value);
      }
    });

    return cartCookie ? JSON.parse(cartCookie) : [];
  }

  let cart = loadCartFromCookie() || [];

  if (cart.length > 0) {
    updateCartDisplay();
  }

  window.addToCart = function(menuId) {
    let found = cart.find(item => item.menuId === menuId);
    if (found) {
      found.quantity += 1;
    } else {
      let menuToAdd = allMenus.find(menu => menu.menuId === menuId);
      cart.push({ ...menuToAdd, quantity: 1 });
    }
    saveCartToCookie(cart);
    updateCartDisplay();
  }

  function updateCartDisplay() {
    let cartList = $("#cart-list");
    cartList.empty();
    let total = 0;

    if (cart.length > 0) {
      cart.forEach(function(item) {
        cartList.append(
            "<div class='cart-item'>" +
            "<h3>" + item.menuName + "</h3>" +
            "<p>가격: " + item.menuPrice + "원 (총: " + (item.menuPrice * item.quantity) + "원)</p>" +
            "<button onclick='decreaseQuantity(" + item.menuId + ")'>빼기</button>" +
            "<span> 수량: " + item.quantity + " </span>" +
            "<button onclick='increaseQuantity(" + item.menuId + ")'>추가</button>" +
            "</div>"
        );
        total += item.menuPrice * item.quantity;
      });
      cartList.append("<p>Total: " + total + "원</p>");
      $("#cart-section").show();
    } else {
      $("#cart-section").hide();
    }
  }

  function saveCartToCookie(cart) {
    document.cookie = "cart=" + encodeURIComponent(JSON.stringify(cart)) + "; path=/; max-age=60";
  }

  window.decreaseQuantity = function(menuId) {
    let found = cart.find(item => item.menuId === menuId);
    if (found && found.quantity > 1) {
      found.quantity -= 1;
    } else {
      cart = cart.filter(item => item.menuId !== menuId);
    }
    saveCartToCookie(cart);
    updateCartDisplay();
  }

  window.increaseQuantity = function(menuId) {
    let found = cart.find(item => item.menuId === menuId);
    if (found) {
      found.quantity += 1;
    }
    saveCartToCookie(cart);
    updateCartDisplay();
  }

  $("form#cart-form").on("submit", function(event) {
    event.preventDefault();
    if (cart.length === 0) {
      alert("장바구니가 비어 있습니다.");
      return;
    }

    let cartData = JSON.stringify(cart);
    $("input[name='cartData']").val(cartData);
    $(this).off("submit").submit();
  });

  fetchMenusAndCategories();
  updateCartDisplay();
});
