package io.kiosk.kioskPrj.store.controller;

import io.kiosk.kioskPrj.store.entity.OrderDetails;
import io.kiosk.kioskPrj.store.service.StoreService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class StoreController {

    private final StoreService storeService;

    public StoreController(StoreService storeService) {
        this.storeService = storeService;
    }

    @GetMapping("/store")
    public String storepage(Model model) {

        String storeName = "건대점";
        List<OrderDetails> orderDetails = storeService.getOrderDetailsByStoreName(storeName);


        model.addAttribute("orderDetails", orderDetails);
        return "store";
    }

    @GetMapping("/store/loginform")
    public String loginform() {
        return "loginform";
    }
}