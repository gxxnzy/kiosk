package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.admin.repository.PromotionRepository;
import io.kiosk.kioskPrj.common.model.Promotions;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class PromotionServiceImpl implements PromotionService{

    private final PromotionRepository promotionRepository;

    public PromotionServiceImpl(PromotionRepository promotionRepository) {
        this.promotionRepository = promotionRepository;
    }

    public List<Promotions> getAllPromotions() {
        return promotionRepository.findAll();
    }
}
