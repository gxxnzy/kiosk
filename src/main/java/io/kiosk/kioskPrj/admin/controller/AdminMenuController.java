package io.kiosk.kioskPrj.admin.controller;

import io.kiosk.kioskPrj.admin.service.MenuServiceImpl;
import io.kiosk.kioskPrj.common.model.Category;
import io.kiosk.kioskPrj.common.model.Menu;
import io.kiosk.kioskPrj.kiosk.repository.CategoryRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("admin/")
public class AdminMenuController {

    private final MenuServiceImpl menuServiceImpl;

    private final CacheManager cacheManager;

    private final CategoryRepository CategoryRepository;

    @Autowired
    public AdminMenuController(MenuServiceImpl menuServiceImpl, CacheManager cacheManager,
        io.kiosk.kioskPrj.kiosk.repository.CategoryRepository categoryRepository) {
        this.menuServiceImpl = menuServiceImpl;
        this.cacheManager = cacheManager;
        CategoryRepository = categoryRepository;
    }

    // 전체 메뉴 출력
    @GetMapping("menu")
    public String menu(Model model) {

        List<Menu> menus = menuServiceImpl.getAllMenus();
        List<Category> categories = CategoryRepository.findAll();

        if (menus.isEmpty()) {
            model.addAttribute("message", "등록 된 메뉴가 없습니다.");
        } else {
            model.addAttribute("menus", menus);
            model.addAttribute("categories", categories);
        }

        return "admin/menuForm";
    }

    // 메뉴 검색
    @PostMapping("/searchMenu")
    public String searchMenu(
        @RequestParam(name = "menuName", required = false, defaultValue = "") String menuName,
        @RequestParam(name = "category", required = false, defaultValue = "") String categoryName,
        @RequestParam(name = "menuActive", required = false, defaultValue = "") Integer menuActive,
        Model model) {

        List<Menu> menus = menuServiceImpl.searchMenu(menuName, categoryName, menuActive);
        List<Category> categories = CategoryRepository.findAll();

        if (menus.isEmpty()) {
            model.addAttribute("message", "조건에 해당하는 메뉴가 없습니다.");
        } else {
            model.addAttribute("menus", menus);
            model.addAttribute("menuName", menuName);
            model.addAttribute("menuActive", menuActive);
            model.addAttribute("categories", categories);
            model.addAttribute("categoryName", categoryName);
        }

        return "admin/menuForm";
    }

    // 메뉴 추가 페이지 이동
    @GetMapping("menuInsert")
    public String menuInsert(Model model) {

        List<Category> categories = CategoryRepository.findAll();
        model.addAttribute("categories", categories);

        return "admin/menuInsert";
    }

    // 메뉴 추가
    @PostMapping("menuInsertResult")
    public String menuInsertResult(
        @RequestParam("menuImage") MultipartFile file,  // 이미지 파일 파라미터 추가
        @RequestParam("menuName") String menuName,
        @RequestParam("menuPrice") int menuPrice,
        @RequestParam("info") String info,
        @RequestParam("category") String categoryName) {

        Menu menu = new Menu();
        menu.setMenuName(menuName);
        menu.setMenuPrice(menuPrice);
        menu.setInfo(info);
        menu.setMenuActive(1);
        menu.setCategoryName(categoryName);
        menuServiceImpl.saveMenu(menu, file);

        return "redirect:/admin/menu";
    }

    // 상세 메뉴 보기
    @GetMapping("menuDetail")
    public String menuDetail(@RequestParam("menuId") int menuId, Model model) {

        Menu menu = menuServiceImpl.getById(menuId);
        List<Category> categories = CategoryRepository.findAll();

        model.addAttribute("menu", menu);
        model.addAttribute("categories", categories);

        return "admin/menuDetail";
    }

    // 메뉴 수정
    @PostMapping("updateMenu")
    public String updateMenu(@ModelAttribute Menu menu) {

        Menu existingMenu = menuServiceImpl.getById(menu.getMenuId());
        menu.setMenuImage(existingMenu.getMenuImage());
        menuServiceImpl.updateMenu(menu);

        return "redirect:/admin/menu";
    }

    // 메뉴 추가,수정 시 캐시 초기화
    @GetMapping("/reset")
    public String reset() {

        cacheManager.getCache("menusCache").clear();
        cacheManager.getCache("categoryCache").clear();

        return "redirect:/admin/menu";
    }
}
