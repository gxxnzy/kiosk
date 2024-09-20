package io.kiosk.kioskPrj.common.model;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "kiosks")
public class Kiosks {
    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    private String kioskId;
    private String storeName;
    private int kioskNum;
}
