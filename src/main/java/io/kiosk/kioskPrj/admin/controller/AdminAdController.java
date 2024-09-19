package io.kiosk.kioskPrj.admin.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin/")
public class AdminAdController {

    @GetMapping("ad")
    public String adForm() {
        return "admin/adForm";
    }
}
