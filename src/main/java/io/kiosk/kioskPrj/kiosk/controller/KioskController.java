package io.kiosk.kioskPrj.kiosk.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.kiosk.kioskPrj.kiosk.model.Category;
import io.kiosk.kioskPrj.kiosk.model.Menu;
import io.kiosk.kioskPrj.kiosk.repository.CategoryRepository;
import io.kiosk.kioskPrj.kiosk.repository.MenuRepository;
import io.kiosk.kioskPrj.kiosk.service.MenuService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
