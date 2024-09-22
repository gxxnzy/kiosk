package io.kiosk.kioskPrj.kiosk.repository;

import io.kiosk.kioskPrj.common.model.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrdersRepository extends JpaRepository<Orders, Integer> {

    // 가게와 결제 상태에 따른 주문조회
    List<Orders> findByStoreNameAndPayStatus(String storeName, int payStatus);

    // 키오스크와 가게 이름에 해당하는 주문조회
    @Query("SELECT o FROM Orders o WHERE o.kiosksNum = :kioskNum AND o.storeName = :storeName")
    List<Orders> findByKioskNumAndStoreName(@Param("kioskNum") int kioskNum,
        @Param("storeName") String storeName);
}
