package io.kiosk.kioskPrj.admin.controller;


import io.kiosk.kioskPrj.admin.service.PromotionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
