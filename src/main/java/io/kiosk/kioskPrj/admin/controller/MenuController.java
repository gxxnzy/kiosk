package io.kiosk.kioskPrj.admin.controller;

import io.kiosk.kioskPrj.admin.Service.MenuService;
import io.kiosk.kioskPrj.admin.Service.S3Service;
import io.kiosk.kioskPrj.common.model.Menu;
import java.io.IOException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("admin/")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private S3Service s3Service;

    // 전체 메뉴 출력
    @GetMapping("menu")
    public String menu(Model model) {
        List<Menu> Menus = menuService.getAllMenus();
        model.addAttribute("Menus", Menus);
        return "admin/menuForm";
    }

    // 메뉴 검색
    @PostMapping("/searchMenu")
    public String searchMenu(
        @RequestParam(name = "menuName", required = false, defaultValue = "") String menuName,
        @RequestParam(name = "category", required = false, defaultValue = "") String categoryName,
        @RequestParam(name = "menuActive", required = false, defaultValue = "") Integer menuActive,
        Model model) {

        List<Menu> menus = menuService.searchMenu(menuName, categoryName, menuActive);
        model.addAttribute("Menus", menus);
        return "admin/menuForm";
    }

    // 메뉴 추가 페이지 이동
    @GetMapping("menuInsert")
    public String menuInsert() {
        return "admin/menuInsert";
    }

    // 메뉴 추가
    @PostMapping("menuInsertResult")
    public String menuInsertResult(
        @RequestParam("menuImage") MultipartFile file,  // 이미지 파일 파라미터 추가
        @RequestParam("menuName") String menuName,
        @RequestParam("menuPrice") int menuPrice,
        @RequestParam("info") String info,
        @RequestParam("categoryName") String categoryName,
        Model model) {

        Menu menu = new Menu(menuName, menuPrice, info, null, categoryName);

        try {
            if (!file.isEmpty()) {
                // 이미지 파일을 AWS S3에 업로드하고 URL을 가져오기
                String imageUrl = s3Service.saveFile(file);
                menu.setMenuImage(imageUrl);
            }
            menuService.saveMenu(menu);
        } catch (IOException e) {
            System.out.println("이미지 업로드 실패 : " + e.getMessage());
            return "admin/menuInsert";
        }
        return "redirect:/admin/menu";
    }

    // 상세 메뉴 보기
    @GetMapping("menuDetail")
    public String menuDetail(@RequestParam("menuId") int menuId, Model model) {
        Menu menu = menuService.getById(menuId);
        model.addAttribute("menu", menu);
        return "admin/menuDetail";
    }

    // 메뉴 수정
    @PostMapping("updateMenu")
    public String updateMenu(@ModelAttribute Menu menu) {
        // 기존 메뉴 가져오기
        Menu existingMenu = menuService.getById(menu.getMenuId());
        menu.setMenuImage(existingMenu.getMenuImage());
        menuService.updateMenu(menu);
        return "redirect:/admin/menu";
    }
}
