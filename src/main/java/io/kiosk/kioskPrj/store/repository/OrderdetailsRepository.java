package io.kiosk.kioskPrj.store.repository;

import io.kiosk.kioskPrj.store.entity.OrderDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderdetailsRepository extends JpaRepository<OrderDetails, Integer> {

    // 특정 가게(storeName)에 대한 주문 상세 내역을 조회하는 쿼리
    @Query("SELECT od FROM OrderDetails od JOIN Orders o ON od.order.orderId = o.orderId WHERE o.storeName = :storeName")
    List<OrderDetails> findByStoreName(@Param("storeName") String storeName);
}




