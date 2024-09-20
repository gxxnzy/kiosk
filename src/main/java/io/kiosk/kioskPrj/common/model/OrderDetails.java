package io.kiosk.kioskPrj.common.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDate; // Date 타입을 위한 import 추가

@Entity
@Table(name = "order_details")
@Getter @Setter
public class OrderDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_details_id")
    private int orderDetailsId;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Orders order;

    @Column(name = "menu_name", nullable = false)
    private String menuName;

    @Column(name = "quantity")
    private Integer quantity; // Integer로 변경하여 nullable 허용

    @Column(name = "quantity_price")
    private Integer quantityPrice; // Integer로 변경하여 nullable 허용



}
