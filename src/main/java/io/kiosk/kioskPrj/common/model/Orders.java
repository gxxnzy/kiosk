package io.kiosk.kioskPrj.common.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;


@Entity
@Table(name = "orders")
@Getter @Setter
public class Orders {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id") // 테이블의 컬럼명과 일치시킴
    private int orderId;

    @Column(name = "store_name", nullable = false)
    private String storeName;

    @Column(name = "kiosks_num")
    private Integer kiosksNum; // Integer로 변경하여 nullable 허용

    @Column(name = "order_time")
    private LocalDate orderTime; // Java의 LocalDate 타입 사용

    @Column(name = "pay_status")
    private Integer payStatus; // 결제 상태를 나타내는 Integer 타입
}
