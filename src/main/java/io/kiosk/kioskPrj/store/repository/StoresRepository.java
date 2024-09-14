package io.kiosk.kioskPrj.store.repository;

import io.kiosk.kioskPrj.common.model.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface StoresRepository extends JpaRepository<Store, String> {


}
