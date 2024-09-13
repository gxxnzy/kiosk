package io.kiosk.kioskPrj.admin.controller;

import io.kiosk.kioskPrj.admin.Service.StoreService;
import io.kiosk.kioskPrj.common.model.Store;
import java.util.HashMap;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequestMapping("admin")
public class AdminStoreController {

    @Autowired
    private StoreService storeService;

    @GetMapping("store")
    public String storeForm(Model model) {
        log.info("storeForm");
        List<Store> stores = storeService.getAllStores();
        model.addAttribute("stores", stores);
        return "admin/storeForm";
    }

    @PostMapping("searchStoreList")
    public String searchStoreList(
        @RequestParam String storeName,
        @RequestParam String storeStatus,
        @RequestParam String sortOrder,
        Model model) {
        log.info("searchStoreList():: storeName,storeStatus:" + storeName+storeStatus);

        Sort.Direction direction = Sort.Direction.fromString(sortOrder);
        Sort sort = Sort.by(direction, "storeOpenDate");
        List<Store> stores = storeService.searchStores(storeName,storeStatus,sort);
        model.addAttribute("stores", stores);
        return "admin/storeForm";
    }

    @GetMapping("createStore")
    public String createStore() {
        return "admin/createStore";
    }

    @PostMapping("createStore")
    public String createStore(Store store) {
        log.info("createStore:" + store);
        store.setStoreStatus("영업중");
        storeService.saveStore(store);
        return "admin/storeForm";
    }

}
