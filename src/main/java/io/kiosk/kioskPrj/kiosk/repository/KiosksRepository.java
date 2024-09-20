package io.kiosk.kioskPrj.kiosk.repository;

import io.kiosk.kioskPrj.common.model.Kiosks;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface KiosksRepository extends JpaRepository<Kiosks,String> {
    public Kiosks findAllByKioskId(String kioskId);
    List<Kiosks> findByStoreName(String storeId);
    int countByStoreName(String storeName);

    Kiosks findTopByStoreNameOrderByKioskNumDesc(String storeName);
}
