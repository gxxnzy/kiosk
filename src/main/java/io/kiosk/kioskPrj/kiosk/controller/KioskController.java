package io.kiosk.kioskPrj.kiosk.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.kiosk.kioskPrj.common.model.Category;
import io.kiosk.kioskPrj.common.model.Menu;
import io.kiosk.kioskPrj.kiosk.model.Kiosks;
import io.kiosk.kioskPrj.kiosk.model.Promotions;
import io.kiosk.kioskPrj.kiosk.repository.CategoryRepository;
import io.kiosk.kioskPrj.kiosk.repository.KiosksRepository;
import io.kiosk.kioskPrj.kiosk.repository.MenuRepository;
import io.kiosk.kioskPrj.kiosk.repository.PromotionsRepository;
import io.kiosk.kioskPrj.kiosk.service.MenuService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    private final KiosksRepository kiosksRepository;
    private final PromotionsRepository promotionsRepository;

    public KioskController(MenuRepository menuRepository, ObjectMapper objectMapper, CategoryRepository categoryRepository, KiosksRepository kiosksRepository, PromotionsRepository promotionsRepository){
        this.menuRepository = menuRepository;
        this.objectMapper = objectMapper;
        this.categoryRepository = categoryRepository;
        this.kiosksRepository = kiosksRepository;
        this.promotionsRepository = promotionsRepository;
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
    public String checkout(@CookieValue(value = "cart", defaultValue = "") String cartCookie, Model model) throws Exception {
        String kioskId = SecurityContextHolder.getContext().getAuthentication().getName();
        Kiosks kiosks = kiosksRepository.findAllByKioskId(kioskId);
        // 쿠키가 존재하면 디코딩 및 파싱, 그렇지 않으면 빈 배열 처리
        if (!cartCookie.isEmpty()) {
            String decodedCart = URLDecoder.decode(cartCookie, "UTF-8");  // 쿠키 값을 디코딩
            List<Map<String, Object>> cart = objectMapper.readValue(decodedCart, List.class);
            int totalAmount = 0;
            for (Map<String, Object> item : cart) {
                int price = ((Number) item.get("menuPrice")).intValue();
                int quantity = ((Number) item.get("quantity")).intValue();
                totalAmount += price * quantity;
            }
            model.addAttribute("cartItems", cart);
            model.addAttribute("totalAmount", totalAmount);
            model.addAttribute("kiosks",kiosks);
        } else {
            model.addAttribute("cartItems", new ArrayList<>());  // 빈 장바구니
        }
        return "kiosk/checkout";  // checkout.jsp로 이동
    }
    @GetMapping("/kioskAd")
    public String kioskAd(Model model){
        List<Promotions> promotionsList = promotionsRepository.findActivePromotionsBetweenDates();
        System.out.println(promotionsList);
        model.addAttribute("promotionsList", promotionsList);
        return "kiosk/kioskAd";
    }
}
