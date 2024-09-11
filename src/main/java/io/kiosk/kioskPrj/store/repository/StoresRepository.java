package io.kiosk.kioskPrj.store.repository;

import io.kiosk.kioskPrj.store.entity.Stores;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StoresRepository extends JpaRepository<Stores, String> {
}
