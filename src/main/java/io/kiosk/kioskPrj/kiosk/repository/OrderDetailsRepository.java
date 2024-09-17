package io.kiosk.kioskPrj.kiosk.repository;

import io.kiosk.kioskPrj.common.model.OrderDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface OrderDetailsRepository extends JpaRepository<OrderDetails, Integer> {

    @Query("SELECT od, o.orderTime FROM OrderDetails od " +
        "JOIN od.order o " +
        "WHERE o.storeName = :storeName " +
        "AND o.kiosksNum = :kiosksNum " +
        "AND o.payStatus = :payStatus")
    List<Object[]> findOrderDetailsWithOrderTimeByStoreNameKiosksNumAndPayStatus(
        @Param("storeName") String storeName,
        @Param("kiosksNum") Integer kiosksNum,
        @Param("payStatus") int payStatus
    );
}
