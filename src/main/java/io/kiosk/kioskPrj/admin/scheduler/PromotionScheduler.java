package io.kiosk.kioskPrj.admin.scheduler;

import io.kiosk.kioskPrj.admin.repository.PromotionRepository;
import io.kiosk.kioskPrj.common.model.Promotions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;

@Component
public class PromotionScheduler {

    @Autowired
    private PromotionRepository promotionRepository;

    @Scheduled(cron = "0 0 0 * * ?") // 매 시간마다 실행
    public void updatePromotionStatus() {
        List<Promotions> promotions = promotionRepository.findAll();
        LocalDate today = LocalDate.now();

        for (Promotions promotion : promotions) {
            if (promotion.getStartDate().isAfter(today) || promotion.getEndDate().isBefore(today)) {
                promotion.setPromotionActive(0); // 비활성화
            } else {
                promotion.setPromotionActive(1); // 활성화
            }
            promotionRepository.save(promotion); // 변경 사항 저장
        }
    }
}

