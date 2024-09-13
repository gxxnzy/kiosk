package io.kiosk.kioskPrj.common.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="stores")
public class Store {

    @Id
    private String storeId;

    private String storeName;
    private String storeAddress;


}
