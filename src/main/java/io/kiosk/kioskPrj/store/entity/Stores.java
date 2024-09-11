package io.kiosk.kioskPrj.store.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "stores")
@Getter @Setter
public class Stores {

    @Id
    private String storeId;


    private String storeName; // 가게 이름
    private String password; // 비밀번호
    private String address; // 가게 위치
    private int dailySales; // 당일 판매량

    public Stores() {

    }
}
