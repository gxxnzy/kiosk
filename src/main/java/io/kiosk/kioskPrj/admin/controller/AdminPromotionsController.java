package io.kiosk.kioskPrj.admin.controller;


import io.kiosk.kioskPrj.admin.service.PromotionService;
import io.kiosk.kioskPrj.common.model.Promotions;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
}
