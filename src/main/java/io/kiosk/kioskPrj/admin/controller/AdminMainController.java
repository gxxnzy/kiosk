package io.kiosk.kioskPrj.admin.controller;

import org.springframework.stereotype.Controller;
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

    @PostMapping("menu")
    public String menuForm() {
        return "admin/menuForm";
    }

    @PostMapping("store")
    public String storeForm() {
        return "admin/storeForm";
    }

    @PostMapping("ad")
    public String adForm() {
        return "admin/adForm";
    }

}