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
    //@Column(name = "store_id")
    private String storeId;

    //@Column(name = "store_name")
    private String storeName;

   // @Column(name = "road_address")
    private String roadAddress;

   // @Column(name = "address1")
    private String storeAddress1;

   // @Column(name = "address2")
    private String storeAddress2;

   // @Column(name = "store_status")
    private String storeStatus;

    //@Column(name = "store_open_date")
    private String storeOpenDate;

   // @Column(name = "store_phonenumber")
    private String storePhonenumber;

}
