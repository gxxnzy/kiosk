package io.kiosk.kioskPrj.common.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity // 엔티티라는 표시
@Table(name = "menu") // DB의 테이블 명
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Menu {

    @Id // primary key
    @GeneratedValue(strategy = GenerationType.IDENTITY) // primary key 자동생성
    @Column(name = "menu_id")
    private int menuId;

    @Column(name = "menu_name") // 실제 DB의 컬럼명
    private String menuName;

    @Column(name = "menu_price")
    private int menuPrice;

    private String info;

    @Column(name = "menu_image")
    private String menuImage;

    @Column(name = "category_name")
    private String categoryName;

    @Column(name = "menu_status")
    private int menuActive;
}
