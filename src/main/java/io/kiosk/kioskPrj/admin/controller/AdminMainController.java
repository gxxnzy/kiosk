package io.kiosk.kioskPrj.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin/")
public class AdminMainController {

    @GetMapping("adminMain")
    public String adminMain() {
        return "admin/adminMainForm";
    }

    @GetMapping("menu")
    public String menuForm(Model model) {
        return "admin/menuForm";
    }

    @PostMapping("/menuResult")
    public String menuResult() {
        return "admin/menuForm";
    }

    @GetMapping("store")
    public String storeForm() {
        return "admin/storeForm";
    }

    @GetMapping("ad")
    public String adForm() {
        return "admin/adForm";
    }
}
