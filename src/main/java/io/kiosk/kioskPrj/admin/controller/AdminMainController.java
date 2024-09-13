package io.kiosk.kioskPrj.admin.controller;

import io.kiosk.kioskPrj.admin.Service.StoreService;
import io.kiosk.kioskPrj.common.model.Store;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin/")
public class AdminMainController {

    //@Autowired
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

    @GetMapping("ad")
    public String adForm() {
        return "admin/adForm";
    }
}
