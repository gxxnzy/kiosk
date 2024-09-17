package io.kiosk.kioskPrj.store.controller;
import io.kiosk.kioskPrj.common.model.Kiosks;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import io.kiosk.kioskPrj.common.model.OrderDetails;
import io.kiosk.kioskPrj.common.model.Store;
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
        // 로그인한 사용자 정보 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String storeId = authentication.getName(); // store_id로 사용자의 store_id를 가져옴

        // store_id를 통해 store 정보를 조회
        Store store = storeService.getStoreById(storeId);
        if (store != null) {
            List<OrderDetails> orderDetails = storeService.getOrderDetailsByStoreName(store.getStoreName());
            int totalSales = storeService.getTotalSalesByStoreName(store.getStoreName());

            model.addAttribute("orderDetails", orderDetails);
            model.addAttribute("totalSales", totalSales);
            model.addAttribute("selectedStore", store.getStoreName());
            model.addAttribute("stores", List.of(store)); // 현재 선택된 점포만을 전달
        }

        return "store/store";
    }

    @PostMapping("/sales")
    public String getSalesByStoreName(@RequestParam("storeName") String storeName, Model model) {
        List<OrderDetails> orderDetails = storeService.getOrderDetailsByStoreName(storeName);
        int totalSales = storeService.getTotalSalesByStoreName(storeName);

        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("totalSales", totalSales);
        model.addAttribute("selectedStore", storeName);

        List<Store> allStores = storeService.getAllStores();
        model.addAttribute("stores", allStores); // 지점 목록 추가

        return "store/store";
    }

    @GetMapping("/store/loginform")
    public String loginform() {
        return "loginform";
    }

    // 새로운 메서드 추가
    @GetMapping("/payment")
    public String paymentPage(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String storeId = authentication.getName(); // Store ID로 storeName을 가져오거나 직접 전달받을 수 있음

        // Store 정보를 조회하는 로직 필요
        Store store = storeService.getStoreById(storeId); // 이 메서드를 StoreService에 추가
        if (store != null) {
            List<Kiosks> kiosksList = storeService.getKiosksByStoreName(store.getStoreName());
            model.addAttribute("kiosksList", kiosksList);
            model.addAttribute("selectedStore", store.getStoreName());
        }

        return "store/payment"; // payment.jsp 파일로 이동
    }


}