package io.kiosk.kioskPrj.admin.controller;

import io.kiosk.kioskPrj.admin.Service.StoreService;
import io.kiosk.kioskPrj.common.model.Store;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin/store")
public class AdminStoreController {

    @Autowired
    private StoreService storeService;

    @GetMapping("")
    public String storeForm(Model model) {
        List<Store> stores = storeService.getAllStores();
        model.addAttribute("stores", stores);
        return "admin/storeForm";
    }
}
