package io.kiosk.kioskPrj.kiosk.service;

import io.kiosk.kioskPrj.common.model.Menu;
import io.kiosk.kioskPrj.kiosk.repository.MenuRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;


@Service
public class MenuService {
    private final MenuRepository menuRepository;
    public MenuService(MenuRepository menuRepository){
        this.menuRepository = menuRepository;
    }
    @Cacheable(value = "menusCache")  // 캐시 저장
    public List<Menu> getActiveMenus() {
        return menuRepository.findByMenuActive(1);
    }
}
