package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.admin.repository.PromotionRepository;
import io.kiosk.kioskPrj.common.model.Promotions;
import java.io.IOException;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class PromotionServiceImpl implements PromotionService{

    @Autowired
    private PromotionRepository promotionRepository;

    @Autowired
    private S3Service s3Service;

    @Autowired
    public PromotionServiceImpl(PromotionRepository promotionRepository) {
        this.promotionRepository = promotionRepository;
    }

    public List<Promotions> getAllPromotions() {
        return promotionRepository.findAll();
    }

    @Override
    public List<Promotions> searchPromotions(String promotionName, int promotionActive, Sort sort) {
        return promotionRepository.searchPromotions(promotionName, promotionActive, sort);
    }

    @Override
    @Transactional
    public void savePromotion(Promotions promotion, MultipartFile promotionImage) {
        try {
            if (!promotionImage.isEmpty()) {
                // 이미지 파일을 AWS S3에 업로드하고 URL을 가져옴
                String imageUrl = s3Service.saveFile(promotionImage);
                promotion.setPromotionImage(imageUrl);
                promotionRepository.save(promotion);
            }
        } catch (IOException e) {
            System.out.println("이미지 업로드 실패 : " + e.getMessage());
        }
    }

    @Override
    public Promotions getPromotionById(int promotionId) {
        Optional<Promotions> optionalPromotion = promotionRepository.findById(promotionId);
        if (optionalPromotion.isPresent()) {
            return optionalPromotion.get();
        } else {
            throw new NoSuchElementException("해당 ID의 광고를 찾을 수 없습니다: " + promotionId);
        }
    }
}
