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

  // 카테고리 필터링 함수와 추가된 모달 기능
  window.filterMenus = function(categoryName, categoryInfo, button) {
    let menuList = $("#menu-list");
    menuList.empty();
    $("#menu-section-title").text(categoryName);
    $("#menu-section-info").text(categoryInfo);
    $("#category-list button").removeClass("active");
    $(button).addClass("active");

    let filteredMenus = allMenus.filter(menu => menu.categoryName === categoryName);
    filteredMenus.forEach(function(menu) {
      menuList.append(
          "<div class='menu-item'>" +
          "<img src='" + menu.menuImage + "' alt='" + menu.menuName + "' />" +
          "<h3>" + menu.menuName + "</h3>" +
          "<p>" + menu.menuPrice.toLocaleString() + "원</p>" +
          "<button onclick='openModal(" + menu.menuId + ")'>담기</button>" +
          "</div>"
      );
    });
  }
  let isModalOpen = false;

// 모달 열기 함수
  window.openModal = function(menuId) {
    event.stopPropagation(); // 클릭 이벤트 전파 방지
    selectedMenu = allMenus.find(menu => menu.menuId === menuId);
    $("#modal-menu-name").text(selectedMenu.menuName);
    $("#modal-menu-info").text(selectedMenu.info);
    $("#modal-menu-price").text("가격 : " + selectedMenu.menuPrice.toLocaleString() + "원");
    $("#modal-menu-image").attr("src", selectedMenu.menuImage);
    $("#menu-modal").show();
    isModalOpen = true; // 모달이 열렸음을 표시
  }

// 모달 닫기
  $("#modal-close-button").click(function() {
    $("#menu-modal").hide();
    isModalOpen = false; // 모달이 닫혔음을 표시
  });

  $(window).on("click", function(event) {
    // 모달이 열려있을 때만 외부 클릭 이벤트가 동작
    if (isModalOpen && !$(event.target).closest("#menu-modal").length) {
      $("#menu-modal").hide();
      isModalOpen = false; // 모달이 닫혔음을 표시
    }
  });


  // 모달에서 '담기' 버튼 클릭 시
  $("#modal-add-to-cart").click(function() {
    addToCart(selectedMenu.menuId);
    $("#menu-modal").hide();
  });

  function updateQuantityDisplay() {
    $("#quantity").text(quantity);
    $("#modal-menu-price").text((selectedMenu.menuPrice * quantity).toLocaleString() + "원");
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
            "<p>가격: " + item.menuPrice.toLocaleString() + "원 (총: " + (item.menuPrice * item.quantity).toLocaleString() + "원)</p>" +
            "<button onclick='decreaseQuantity(" + item.menuId + ")'>빼기</button>" +
            "<span> 수량: " + item.quantity + " </span>" +
            "<button onclick='increaseQuantity(" + item.menuId + ")'>추가</button>" +
            "</div>"
        );
        total += item.menuPrice * item.quantity;
      });
      cartList.append("<p>Total: " + total.toLocaleString() + "원</p>");
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