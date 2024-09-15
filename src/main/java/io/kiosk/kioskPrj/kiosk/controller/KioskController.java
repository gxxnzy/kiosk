package io.kiosk.kioskPrj.kiosk.controller;

import io.kiosk.kioskPrj.common.model.Kiosks;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.kiosk.kioskPrj.common.model.Category;
import io.kiosk.kioskPrj.common.model.Menu;
import io.kiosk.kioskPrj.common.model.Promotions;
import io.kiosk.kioskPrj.kiosk.repository.KiosksRepository;
import io.kiosk.kioskPrj.kiosk.repository.PromotionsRepository;
import io.kiosk.kioskPrj.kiosk.service.CategoryService;
import io.kiosk.kioskPrj.kiosk.service.MenuService;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import io.kiosk.kioskPrj.common.model.Kiosks;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/kiosk")
public class KioskController {

    private final CacheManager cacheManager;
    private final MenuService menuService;
    private final ObjectMapper objectMapper;
    private final CategoryService categoryService;
    private final KiosksRepository kiosksRepository;
    private final PromotionsRepository promotionsRepository;

    public KioskController(CacheManager cacheManager, MenuService menuService, ObjectMapper objectMapper, CategoryService categoryService, KiosksRepository kiosksRepository, PromotionsRepository promotionsRepository){
        this.cacheManager = cacheManager;
        this.menuService = menuService;
        this.objectMapper = objectMapper;
        this.categoryService = categoryService;
        this.kiosksRepository = kiosksRepository;
        this.promotionsRepository = promotionsRepository;
    }
    // 메뉴 데이터를 캐시에서 불러오거나 새로 조회
    @Cacheable(value = "menusCache")
    public List<Menu> getCachedMenus() {
        return menuService.getActiveMenus();
    }

    // 카테고리 데이터를 캐시에서 불러오거나 새로 조회
    @Cacheable(value = "categoryCache")
    public List<Category> getCachedCategories() {
        return categoryService.selectAll();
    }
    @GetMapping("/reset")
    public String reset(){
        cacheManager.getCache("menusCache").clear();
        cacheManager.getCache("categoryCache").clear();
        return "redirect:/kiosk/menu";
    }
    @GetMapping("/menu")
    public String menu(Model model) throws JsonProcessingException {
        List<Menu> list = getCachedMenus();
        String menusJson = objectMapper.writeValueAsString(list);
        List<Category> list1 = getCachedCategories();
        String categoryJson = objectMapper.writeValueAsString(list1);
        model.addAttribute("menusJson", menusJson);
        model.addAttribute("categoryJson",categoryJson);
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
