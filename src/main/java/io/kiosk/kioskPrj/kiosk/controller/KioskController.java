package io.kiosk.kioskPrj.kiosk.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.kiosk.kioskPrj.common.model.Category;
import io.kiosk.kioskPrj.common.model.Menu;
import io.kiosk.kioskPrj.kiosk.repository.CategoryRepository;
import io.kiosk.kioskPrj.kiosk.repository.MenuRepository;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/kiosk")
public class KioskController {
    private final MenuRepository menuRepository;
    private final ObjectMapper objectMapper;
    private final CategoryRepository categoryRepository;

    public KioskController(MenuRepository menuRepository, ObjectMapper objectMapper, CategoryRepository categoryRepository){
        this.menuRepository = menuRepository;
        this.objectMapper = objectMapper;
        this.categoryRepository = categoryRepository;
    }
    @GetMapping("/menu")
    public String menu(Model model) throws JsonProcessingException {
        String user = SecurityContextHolder.getContext().getAuthentication().getName();
        List<Menu> list = menuRepository.findByMenuActive(1);
        String menusJson = objectMapper.writeValueAsString(list);
        List<Category> list1 = categoryRepository.findAll();
        String categoryJson = objectMapper.writeValueAsString(list1);
        model.addAttribute("menusJson", menusJson);
        model.addAttribute("categoryJson",categoryJson);
        System.out.println(user);
        return "kiosk/menu";
    }
    @PostMapping("/checkout")
    public String checkout(@CookieValue(value = "cartData", defaultValue = "") String cartDataCookie, HttpServletResponse response, Model model) throws JsonProcessingException, UnsupportedEncodingException {
        List<Map<String, Object>> cart = new ArrayList<>();


        if (!cartDataCookie.isEmpty()) {
            String decodedCartData = URLDecoder.decode(cartDataCookie, "UTF-8");
            cart = objectMapper.readValue(decodedCartData, List.class);
        }

        // 총 결제 금액 계산
        int totalAmount = 0;
        for (Map<String, Object> item : cart) {
            int price = ((Number) item.get("menuPrice")).intValue();
            int quantity = ((Number) item.get("quantity")).intValue();
            totalAmount += price * quantity;
        }

        // 모델에 장바구니 데이터와 총 결제 금액 추가
        model.addAttribute("cartItems", cart);
        model.addAttribute("totalAmount", totalAmount);


        String encodedCartData = URLEncoder.encode(objectMapper.writeValueAsString(cart), "UTF-8");
        // 새로운 쿠키 생성
        Cookie cartDataCookieNew = new Cookie("cartData", encodedCartData);
        cartDataCookieNew.setMaxAge(60); // 60초 동안 유지
        cartDataCookieNew.setPath("/");
        response.addCookie(cartDataCookieNew);


        return "kiosk/checkout";
    }







//    @GetMapping("/menu2")
//    public String menu2(Model model) throws JsonProcessingException {
//        String user = SecurityContextHolder.getContext().getAuthentication().getName();
//        List<Menu> list = menuRepository.findByMenuActive(1);
//        String menusJson = objectMapper.writeValueAsString(list);
//        model.addAttribute("menusJson", menusJson);
//        System.out.println(user);
//        return "kiosk/menu2";
//    }
}
