package io.kiosk.kioskPrj.store.controller;

import io.kiosk.kioskPrj.common.model.Kiosks;
import io.kiosk.kioskPrj.common.model.Orders;
import io.kiosk.kioskPrj.common.model.OrderDetails;
import io.kiosk.kioskPrj.common.model.Store;
import io.kiosk.kioskPrj.store.service.StoreService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/store")
public class StoreController {

    private final StoreService storeService;

    public StoreController(StoreService storeService) {
        this.storeService = storeService;
    }

    @GetMapping("/main")
    public String storePage(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String storeId = authentication.getName();

        Store store = storeService.getStoreById(storeId);
        if (store != null) {
            // 결제 완료 상태가 된 주문 상세 정보 가져오기
            List<OrderDetails> paidOrderDetails = storeService.getOrderDetailsByStoreName(store.getStoreName())
                    .stream()
                    .filter(detail -> detail.getOrder().getPayStatus() == 1) // 결제 완료 상태
                    .collect(Collectors.toList());

            // 총 결제 금액 계산 - 이거 두번 곱해짐;
            // int totalPaidSales = paidOrderDetails.stream()
            //        .mapToInt(detail -> detail.getQuantity() * detail.getQuantityPrice())
            //        .sum();

            int totalPaidSales = paidOrderDetails.stream()
                    .mapToInt(detail -> detail.getQuantityPrice()) // 이미 계산된 가격을 사용
                    .sum();

            model.addAttribute("orderDetails", paidOrderDetails);
            model.addAttribute("totalSales", totalPaidSales);
            model.addAttribute("selectedStore", store.getStoreName());
            model.addAttribute("stores", List.of(store));
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
        model.addAttribute("stores", allStores);

        return "store/store";
    }

    @GetMapping("/store/loginform")
    public String loginform() {
        return "loginform";
    }

    @GetMapping("/payment")
    public String paymentPage(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String storeId = authentication.getName();

        Store store = storeService.getStoreById(storeId);
        if (store != null) {
            List<Kiosks> kiosksList = storeService.getKiosksByStoreName(store.getStoreName());

            // 결제 완료 상태가 아닌 주문만 가져오기
            List<Orders> unpaidOrders = storeService.getUnpaidOrdersByStoreName(store.getStoreName());
            model.addAttribute("kiosksList", kiosksList);
            model.addAttribute("unpaidOrders", unpaidOrders);
            model.addAttribute("selectedStore", store.getStoreName());
        }

        return "store/payment";
    }

    @GetMapping("/kioskDetails")
    public String getKioskDetails(@RequestParam("kioskNum") int kioskNum,
                                  @RequestParam("storeName") String storeName,
                                  Model model) {
        // 해당 키오스크 번호와 스토어 이름에 대한 주문을 가져옵니다.
        List<Orders> orders = storeService.getOrdersByKioskNumAndStoreName(kioskNum, storeName);

        // 주문 ID를 기준으로 상세 정보를 조회하고, 결제 상태가 0인 것만 필터링합니다.
        List<OrderDetails> orderDetailsList = orders.stream()
                .flatMap(order -> storeService.getOrderDetailsByOrderId(order.getOrderId()).stream())
                .filter(detail -> detail.getOrder().getPayStatus() == 0) // 결제 상태가 0인 것만 필터링
                .collect(Collectors.toList());

        int totalAmount = orderDetailsList.stream()
                .mapToInt(OrderDetails::getQuantityPrice)
                .sum(); // 총 결제 금액 계산

        model.addAttribute("orderDetailsList", orderDetailsList);
        model.addAttribute("kioskNum", kioskNum);
        model.addAttribute("storeName", storeName);
        model.addAttribute("totalAmount", totalAmount); // 총액을 모델에 추가

        return "store/kioskDetails";
    }
    @PostMapping("/updatePaymentStatus")
    public String updatePaymentStatus(@RequestParam("orderIds") List<Integer> orderIds, Model model) {
        storeService.updatePaymentStatusForOrders(orderIds);
        return "redirect:/store/payment";
    }

    @GetMapping("/search")
    public String search(@RequestParam("keyword") String keyword, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String storeId = authentication.getName();
        Store store = storeService.getStoreById(storeId);

        if (store != null) {
            if (keyword == null || keyword.trim().isEmpty()) {
                model.addAttribute("error", "검색어를 입력해주세요.");
            } else {
                List<OrderDetails> searchResults = storeService.searchMenuByKeyword(store.getStoreName(), keyword);
                model.addAttribute("searchResults", searchResults);
            }
            model.addAttribute("selectedStore", store.getStoreName());
        }

        return "store/store";
    }
}