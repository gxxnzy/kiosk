package io.kiosk.kioskPrj.store.controller;

import io.kiosk.kioskPrj.store.entity.OrderDetails;
import io.kiosk.kioskPrj.store.entity.Stores;
import io.kiosk.kioskPrj.store.service.StoreService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/store")
public class StoreController {

    private final StoreService storeService;

    public StoreController(StoreService storeService) {
        this.storeService = storeService;
    }

    @GetMapping("/main")
    public String storePage(Model model) {
        List<Stores> allStores = storeService.getAllStores();
        model.addAttribute("stores", allStores);
        return "store";
    }

    @PostMapping("/sales")
    public String getSalesByStoreName(@RequestParam("storeName") String storeName, Model model) {
        List<OrderDetails> orderDetails = storeService.getOrderDetailsByStoreName(storeName);
        int totalSales = storeService.getTotalSalesByStoreName(storeName);

        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("totalSales", totalSales);
        model.addAttribute("selectedStore", storeName); // 선택된 지점 추가

        List<Stores> allStores = storeService.getAllStores();
        model.addAttribute("stores", allStores); // 지점 목록 추가

        return "store";
    }

    @GetMapping("/store/loginform")
    public String loginform() {
        return "loginform";
    }
}
