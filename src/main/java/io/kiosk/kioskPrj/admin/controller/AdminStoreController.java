package io.kiosk.kioskPrj.admin.controller;

import io.kiosk.kioskPrj.admin.service.StoreService;
import io.kiosk.kioskPrj.admin.service.UserService;
import io.kiosk.kioskPrj.common.model.Kiosks;
import io.kiosk.kioskPrj.common.model.Store;
import io.kiosk.kioskPrj.common.model.User;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequestMapping("admin")
public class AdminStoreController {

    @Autowired
    private StoreService storeService;

    @Autowired
    private UserService userService;

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
        model.addAttribute("storeName", storeName);
        model.addAttribute("storeStatus", storeStatus);
        model.addAttribute("sortOrder", sortOrder);

        return "admin/storeForm";
    }

    @GetMapping("createStore")
    public String createStore() {
        return "admin/createStore";
    }

    @PostMapping("createStore")
    public String createStore(Store store,
        @RequestParam("password") String password,
        Model model) {
        log.info("createStore:" + store);
        store.setStoreStatus("영업중");

        User user = new User();
        user.setUsername(store.getStoreName()); // storeName이 username이 됨

        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(password);
        user.setPassword(encodedPassword); // 비밀번호 설정
        user.setRole("ROLE_STORE"); // 권한 설정
        user.setUserStatus(1); // 활성화 상태

        storeService.saveStoreAndUser(store, user);

        List<Store> stores = storeService.getAllStores();
        model.addAttribute("stores", stores);
        return "admin/storeForm";
    }

    @GetMapping("storeDetail/{storeId}")
    public String storeDetail(@PathVariable String storeId, Model model) {
        Store store = storeService.getStoreById(storeId);
        List<Kiosks> kiosks = storeService.getKiosksByStoreName(store.getStoreName());
        log.info("store():"+store);
        log.info("kiosks():"+kiosks);
        model.addAttribute("store", store);
        model.addAttribute("kiosks", kiosks);
        return "admin/storeDetail";
    }

    @PostMapping("storeDetail/createKiosk")
    public String createKiosk(@RequestParam("storeId") String storeId,
        @RequestParam("storeName") String storeName,
        @RequestParam("password") String password, Model model) {
        log.info("addKiosk():: storeId:" + storeId);
        log.info("addKiosk():: storeName:" + storeName);
        log.info("addKiosk():: password:" + password);

        // 키오스크 자동 생성 로직 (storeId에 따라 kioskId를 자동 생성)
        Kiosks kiosk = storeService.createKiosksForStore(storeId,storeName);

        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(password);

        User user = new User();
        user.setUsername(kiosk.getKioskId()); // Unique username for the kiosk
        user.setPassword(encodedPassword); // Password should be encoded in a real application
        user.setRole("ROLE_KIOSK");
        user.setUserStatus(1);
        userService.saveUser(user);

        return "redirect:/admin/storeDetail/" + storeId;
    }

    @PostMapping("storeDetail/deleteLastKiosk")
    public String deleteLastKiosk(@RequestParam("storeId") String storeId,
        @RequestParam("storeName") String storeName) {
        storeService.deleteLastKiosk(storeName);
        return "redirect:/admin/storeDetail/" + storeId;
    }

    @GetMapping("storeDetail/editStore")
    public String editStore(@RequestParam("storeId") String storeId, Model model) {
        log.info("editStore():: storeId:" + storeId);
        Store store = storeService.getStoreById(storeId);
        model.addAttribute("store", store);
        return "admin/storeEdit"; // storeEdit.jsp로 이동
    }

    @PostMapping("storeDetail/updateStore")
    public String updateStore(@RequestParam String storeId,
        @RequestParam String storeName,
        @RequestParam String roadAddress,
        @RequestParam String storeAddress1,
        @RequestParam String storeAddress2,
        @RequestParam String storeOpenDate,
        @RequestParam String storePhonenumber,
        @RequestParam String storeStatus,
        @RequestParam(required = false) String password) {

        // 해당 storeId로 매장 정보 가져오기
        Store store = storeService.getStoreById(storeId);

        // JSP에서 받은 데이터로 Store 정보 수정
        store.setRoadAddress(roadAddress);
        store.setStoreAddress1(storeAddress1);
        store.setStoreAddress2(storeAddress2);
        store.setStoreOpenDate(storeOpenDate); // String -> LocalDate 변환
        store.setStorePhonenumber(storePhonenumber);
        store.setStoreStatus(storeStatus);

        // 비밀번호가 입력된 경우에만 변경
        if (password != null && !password.isEmpty()) {
            userService.updatePassword(storeName, password); // 비밀번호 변경 로직
        }

        // 매장 정보 업데이트
        storeService.updateStore(store);

        return "redirect:/admin/storeDetail/" + storeId; // 수정 후 다시 해당 매장의 상세 페이지로 리디렉션
    }
}
