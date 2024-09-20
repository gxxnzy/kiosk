package io.kiosk.kioskPrj.common.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "stores")
public class Store {

    @Id
    private String storeId;


    private String storeName;


    private String roadAddress;

    @Column(name = "address1")
    private String storeAddress1;

    @Column(name = "address2")
    private String storeAddress2;


    private String storeStatus;


    private String storeOpenDate;

    @Column(name = "store_phonenumber")
    private String storePhonenumber;

}
