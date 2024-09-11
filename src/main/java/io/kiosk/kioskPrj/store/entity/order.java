package io.kiosk.kioskPrj.store.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "orders")
@Getter @Setter
public class order {

    @Id @Column(name = "order_name")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "store_name", nullable = false)
    private String storeName; // 스토어 이름

    @Column(name = "kiosks_num")
    private Integer kiosksNum; // 키오스크 번호
}
