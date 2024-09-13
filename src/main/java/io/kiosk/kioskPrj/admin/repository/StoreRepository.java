package io.kiosk.kioskPrj.admin.repository;

import io.kiosk.kioskPrj.common.model.Store;
import java.util.HashMap;
import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface StoreRepository extends JpaRepository<Store, String> {

    //List<Store> findByStoreNameContaining(String storeName);

    @Query("SELECT s FROM Store s WHERE " +
        "(:storeName = '' OR s.storeName LIKE %:storeName%) AND " +
        "(:storeStatus = '' OR s.storeStatus = :storeStatus)")
    List<Store> searchStores(String storeName,String storeStatus, Sort sort);
}
