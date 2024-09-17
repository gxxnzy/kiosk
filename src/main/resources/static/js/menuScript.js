$(document).ready(function() {
  // Use the global variables set in the JSP
  let allMenus = menusJson;
  let allCategories = categoryJson;

  // 쿠키에서 장바구니 데이터 불러오기
  function loadCartFromCookie() {
    const cookies = document.cookie.split(';'); // 쿠키들을 세미콜론으로 구분하여 배열로 변환
    let cartCookie = null;

    // 각 쿠키 항목을 순회하면서 "cart" 쿠키를 찾음
    cookies.forEach(function(cookie) {
      const [name, value] = cookie.trim().split('='); // 쿠키 이름과 값을 분리
      if (name === 'cart') {
        cartCookie = decodeURIComponent(value); // "cart" 쿠키 값을 디코딩하여 저장
      }
    });

    // cart 쿠키가 있으면 JSON 파싱하여 반환, 없으면 빈 배열 반환
    return cartCookie ? JSON.parse(cartCookie) : [];
  }

  // 쿠키에서 장바구니 데이터를 로드하거나 비어있는 배열 사용
  let cart = loadCartFromCookie() || [];
  console.log(cart);

  // 페이지가 로드될 때 쿠키에 저장된 장바구니 데이터를 UI에 반영
  if (cart.length > 0) {
    updateCartDisplay();  // 쿠키에서 가져온 장바구니 데이터를 UI에 반영
  }

  let menuSectionTitle = $("#menu-section-title");
  let menuSectionInfo = $("#menu-section-info");

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

  // 카테고리 목록 동적으로 생성
  let categoryList = $("#category-list");

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
    filterMenus(firstCategory.categoryName, firstCategory.categoryInfo, $("#category-list button").first());
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
    saveCartToCookie(cart);  // 장바구니 데이터를 쿠키에 저장
    updateCartDisplay();  // UI 업데이트
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
      $("#cart-section").show(); // 장바구니 섹션 보이기
    } else {
      $("#cart-section").hide(); // 장바구니가 비어있을 때 숨기기
    }
  }

  // 쿠키에 장바구니 데이터 저장
  function saveCartToCookie(cart) {
    document.cookie = "cart=" + encodeURIComponent(JSON.stringify(cart)) + "; path=/; max-age=60";  // 쿠키 만료 시간을 1분(60초)으로 설정
  }

  // 장바구니에서 수량 감소
  window.decreaseQuantity = function(menuId) {
    let found = cart.find(item => item.menuId === menuId);
    if (found && found.quantity > 1) {
      found.quantity -= 1;  // 수량 감소
    } else {
      cart = cart.filter(item => item.menuId !== menuId);  // 수량이 1이면 장바구니에서 제거
    }
    saveCartToCookie(cart);  // 쿠키에 장바구니 저장
    updateCartDisplay();  // UI 업데이트
  }

  // 장바구니에서 수량 증가
  window.increaseQuantity = function(menuId) {
    let found = cart.find(item => item.menuId === menuId);
    if (found) {
      found.quantity += 1;  // 수량 증가
    }
    saveCartToCookie(cart);  // 쿠키에 장바구니 저장
    updateCartDisplay();  // UI 업데이트
  }

  // 주문하기 버튼 클릭 시 장바구니 데이터를 전송
  $("form#cart-form").on("submit", function(event) {
    event.preventDefault(); // 폼의 기본 동작을 막음

    if (cart.length === 0) {
      alert("장바구니가 비어 있습니다.");
      return;
    }

    let cartData = JSON.stringify(cart);
    $("input[name='cartData']").val(cartData);
    $(this).off("submit").submit(); // 폼을 다시 제출
  });

  // 페이지 로드 시 장바구니 상태 업데이트
  updateCartDisplay();  // 쿠키에서 로드한 데이터를 화면에 반영
});
