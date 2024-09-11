package io.kiosk.kioskPrj.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin/")
public class AdminController {

    @GetMapping("adminMainForm")
    public String adminMain() {
        return "admin/adminMainForm";
    }

    @PostMapping("menuForm")
    public String menuForm(Model model) {
        return "admin/menuForm";
    }

    @PostMapping("storeForm")
    public String storeForm() {
        return "admin/storeForm";
    }

    @PostMapping("adForm")
    public String adForm() {
        return "admin/adForm";
    }
}
