package io.kiosk.kioskPrj.admin.controller;


import io.kiosk.kioskPrj.admin.service.PromotionService;
import io.kiosk.kioskPrj.common.model.Promotions;
import java.time.LocalDate;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@Slf4j
@RequestMapping("admin/")
public class AdminPromotionsController {

    private final PromotionService promotionService;

    public AdminPromotionsController(PromotionService promotionService) {
        this.promotionService = promotionService;
    }

    @GetMapping("promotions")
    public String promotionsForm(Model model) {
        model.addAttribute("promotions", promotionService.getAllPromotions());
        log.info("promotions: {}", promotionService.getAllPromotions());
        return "admin/promotionsForm";
    }

    @PostMapping("searchAdList")
    public String searchAdList(
        @RequestParam String promotionName,
        @RequestParam(defaultValue = "-1") int promotionActive,
        @RequestParam String sortOrder,
        Model model) {

        Sort.Direction direction = Sort.Direction.fromString(sortOrder);
        Sort sort = Sort.by(direction, "startDate");
        List<Promotions> promotions = promotionService.searchPromotions(promotionName, promotionActive, sort);
        model.addAttribute("promotions", promotions);
        model.addAttribute("promotionName", promotionName);
        model.addAttribute("promotionActive", promotionActive);
        model.addAttribute("sortOrder", sortOrder);

        return "admin/promotionsForm";
    }

    @GetMapping("createPromotion")
    public String addPromotionForm() {
        return "admin/createPromotionForm"; // addPromotion.jsp로 이동
    }

    @PostMapping("createPromotion")
    public String createPromotion(@RequestParam("promotionName") String promotionName,
        @RequestParam("startDate") LocalDate startDate,
        @RequestParam("endDate") LocalDate endDate,
        @RequestParam("promotionImage") MultipartFile promotionImage,
        Model model) {

        Promotions promotion = new Promotions();
        promotion.setPromotionName(promotionName);
        promotion.setStartDate(startDate);
        promotion.setEndDate(endDate);
        promotionService.savePromotion(promotion,promotionImage);

        return "redirect:/admin/promotions"; // 광고 목록 페이지로 리디렉션
    }

    @GetMapping("editPromotion")
    public String editPromotionForm(@RequestParam("promotionId") int promotionId, Model model) {
        Promotions promotion = promotionService.getPromotionById(promotionId); // ID로 광고 정보 가져오기
        model.addAttribute("promotion", promotion); // 광고 정보를 모델에 추가
        return "admin/promotionEdit"; // 수정 폼으로 이동
    }

    @PostMapping("updatePromotion")
    public String updatePromotion(@RequestParam("promotionId") int promotionId,
        @RequestParam("promotionName") String promotionName,
        @RequestParam("startDate") LocalDate startDate,
        @RequestParam("endDate") LocalDate endDate,
        @RequestParam("promotionImage") MultipartFile promotionImage,
        Model model) {

        // 해당 ID의 광고 정보를 가져옵니다.
        Promotions promotion = promotionService.getPromotionById(promotionId);

        // 새로운 정보로 업데이트합니다.
        promotion.setPromotionName(promotionName);
        promotion.setStartDate(startDate);
        promotion.setEndDate(endDate);

        // 이미지를 업데이트합니다.
        promotionService.savePromotion(promotion, promotionImage);

        return "redirect:/admin/promotions"; // 광고 목록 페이지로 리디렉션
    }
}
