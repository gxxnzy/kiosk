package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.common.model.Promotions;
import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.web.multipart.MultipartFile;

public interface PromotionService {

    List<Promotions> getAllPromotions();

    List<Promotions> searchPromotions(String promotionName, int promotionActive, Sort sort);

    void savePromotion(Promotions promotion, MultipartFile promotionImage);

    Promotions getPromotionById(int promotionId);
}
