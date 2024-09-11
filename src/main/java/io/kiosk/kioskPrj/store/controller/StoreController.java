package io.kiosk.kioskPrj.store.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StoreController {

    @GetMapping("/store")
    public String storepage() {
        return "store";
    }

    @GetMapping("/store/loginform")
    public String loginform() {
        return "loginform";
    }
}
