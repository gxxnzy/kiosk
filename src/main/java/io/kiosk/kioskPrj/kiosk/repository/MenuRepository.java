package io.kiosk.kioskPrj.kiosk.repository;

import io.kiosk.kioskPrj.kiosk.model.Menu;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MenuRepository extends JpaRepository<Menu,Integer> {
    public List<Menu> findByMenuActive(int menuActive);
}
