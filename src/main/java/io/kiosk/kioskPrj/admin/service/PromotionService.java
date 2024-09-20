package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.common.model.Promotions;
import java.util.List;
import org.springframework.data.domain.Sort;

public interface PromotionService {

    List<Promotions> getAllPromotions();

    List<Promotions> searchPromotions(String promotionName, int promotionActive, Sort sort);
}
