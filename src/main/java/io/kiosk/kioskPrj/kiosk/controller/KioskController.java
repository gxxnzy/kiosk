package io.kiosk.kioskPrj.kiosk.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.util.WebUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.kiosk.kioskPrj.common.model.Category;
import io.kiosk.kioskPrj.common.model.Menu;
import io.kiosk.kioskPrj.kiosk.repository.CategoryRepository;
import io.kiosk.kioskPrj.kiosk.repository.MenuRepository;
import io.kiosk.kioskPrj.kiosk.service.MenuService;

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
    @PostMapping("/details")
    public String checkout(@RequestParam(value = "cartData", required = false) String cartData, Model model) throws JsonProcessingException {
        List<Map<String, Object>> cart = new ArrayList<>();

        if (cartData != null && !cartData.isEmpty()) {
            cart = objectMapper.readValue(cartData, List.class);
        }

        int totalAmount = 0;

        for (Map<String, Object> item : cart) {
            int price = ((Number) item.get("menuPrice")).intValue();
            int quantity = ((Number) item.get("quantity")).intValue();
            totalAmount += price * quantity;
        }

        model.addAttribute("cartItems", cart);
        model.addAttribute("totalAmount", totalAmount);

        return "kiosk/details";
    }

    @GetMapping("/details")
    public String showDetails(Model model, HttpServletRequest request) throws JsonProcessingException, UnsupportedEncodingException {
        // 쿠키에서 장바구니 데이터를 읽어오기
        Cookie[] cookies = request.getCookies();
        String cartData = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("cart".equals(cookie.getName())) {
                    // URL 디코딩
                    cartData = URLDecoder.decode(cookie.getValue(), "UTF-8");
                    break;
                }
            }
        }

        // 쿠키에 저장된 장바구니 데이터가 있으면 처리
        if (cartData != null) {
            List<Map<String, Object>> cart = objectMapper.readValue(cartData, List.class);
            int totalAmount = 0;

            for (Map<String, Object> item : cart) {
                int price = ((Number) item.get("menuPrice")).intValue();
                int quantity = ((Number) item.get("quantity")).intValue();
                totalAmount += price * quantity;
            }

            model.addAttribute("cartItems", cart);
            model.addAttribute("totalAmount", totalAmount);
        }
        System.out.println("쿠키 데이터: " + cartData);
        return "kiosk/details";
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
