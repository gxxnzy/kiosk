package io.kiosk.kioskPrj.store.repository;

import io.kiosk.kioskPrj.common.model.OrderDetails;
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
    // 주문 id 기준으로 주문 세부 사항 조회
    @Query("SELECT od FROM OrderDetails od WHERE od.order.orderId = :orderId")
    List<OrderDetails> findByOrderId(@Param("orderId") int orderId);

    // 메뉴 이름에 키워드를 포함하는 주문 조회 쿼리
    @Query("SELECT d FROM OrderDetails d WHERE d.order.storeName = :storeName AND d.menuName LIKE %:menuName%")
    List<OrderDetails> findByStoreNameAndMenuNameContaining(@Param("storeName") String storeName, @Param("menuName") String menuName);

}




