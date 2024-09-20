package io.kiosk.kioskPrj.admin.repository;

import io.kiosk.kioskPrj.common.model.Promotions;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PromotionRepository extends JpaRepository<Promotions, Long> {
}