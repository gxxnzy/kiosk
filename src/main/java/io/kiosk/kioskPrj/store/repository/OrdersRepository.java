package io.kiosk.kioskPrj.store.repository;

import io.kiosk.kioskPrj.common.model.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrdersRepository extends JpaRepository<Orders, Integer> {
    List<Orders> findByStoreName(String storeName);
}
