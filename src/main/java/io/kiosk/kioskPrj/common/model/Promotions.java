package io.kiosk.kioskPrj.common.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDate;
import lombok.Data;

@Entity
@Data
@Table(name = "promotions")
public class Promotions {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int promotionId;
    private String promotionName;
    private LocalDate startDate;
    private LocalDate endDate;
    private String promotionImage;
    @Column(name = "promotion_status")
    private String promotionActive;
}
