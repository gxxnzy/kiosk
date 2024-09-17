package io.kiosk.kioskPrj.common.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;


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

    @CreationTimestamp
    @Column(name = "order_time")
    private LocalDateTime orderTime;

    @Column(name = "pay_status")
    private int payStatus;


}
