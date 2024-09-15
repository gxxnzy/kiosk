package io.kiosk.kioskPrj.common.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;


@Entity
@Data
@Table(name = "category")
public class Category {
    @Id
    private String categoryName;
    private String categoryInfo;
}
