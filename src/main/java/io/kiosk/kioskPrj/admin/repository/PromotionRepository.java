package io.kiosk.kioskPrj.admin.repository;

import io.kiosk.kioskPrj.common.model.Promotions;
import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PromotionRepository extends JpaRepository<Promotions, Integer> {

    @Query("SELECT p FROM Promotions p WHERE " +
        "(:promotionName = '' OR p.promotionName LIKE %:promotionName%) " +
        "AND (:promotionActive = -1 OR p.promotionActive = :promotionActive)")
    List<Promotions> searchPromotions(String promotionName, int promotionActive, Sort sort);
}