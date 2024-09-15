package io.kiosk.kioskPrj.kiosk.repository;

import io.kiosk.kioskPrj.common.model.Kiosks;
import org.springframework.data.jpa.repository.JpaRepository;

public interface KiosksRepository extends JpaRepository<Kiosks,String> {
    public Kiosks findAllByKioskId(String kioskId);
}
