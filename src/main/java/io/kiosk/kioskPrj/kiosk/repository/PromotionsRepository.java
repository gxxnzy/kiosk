package io.kiosk.kioskPrj.kiosk.repository;

import io.kiosk.kioskPrj.common.model.Promotions;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface PromotionsRepository extends JpaRepository<Promotions, Integer> {
    @Query("SELECT p FROM Promotions p WHERE p.promotionActive = 1 AND CURRENT_DATE BETWEEN p.startDate AND p.endDate")
    public List<Promotions> findActivePromotionsBetweenDates();
}
