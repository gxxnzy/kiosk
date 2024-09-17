package io.kiosk.kioskPrj.kiosk.repository;

import io.kiosk.kioskPrj.common.model.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrdersRepository extends JpaRepository<Orders, Integer>{

    List<Orders> findByStoreNameAndPayStatus(String storeName, int payStatus);

    @Query("SELECT o FROM Orders o WHERE o.kiosksNum = :kioskNum AND o.storeName = :storeName")
    List<Orders> findByKioskNumAndStoreName(@Param("kioskNum") int kioskNum,
                                            @Param("storeName") String storeName);
}
