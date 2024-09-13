package io.kiosk.kioskPrj.kiosk.service;

import io.kiosk.kioskPrj.common.model.Menu;
import io.kiosk.kioskPrj.kiosk.repository.MenuRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;


@Service
public class MenuService {
    private final MenuRepository menuRepository;
    public MenuService(MenuRepository menuRepository){
        this.menuRepository = menuRepository;
    }
    public List<Menu> findByMenuActive(int menuActive){
        List<Menu> list = menuRepository.findByMenuActive(menuActive);
        List<Menu> list1 = new ArrayList<>();
        for(Menu menu : list){
            Menu menu1 = new Menu();
            menu1.setMenuName(menu.getMenuName());
            menu1.setMenuPrice(menu.getMenuPrice());
            menu1.setInfo(menu.getInfo());
            menu1.setMenuImage(menu.getMenuImage());
            menu1.setCategoryName(menu.getCategoryName());
            list1.add(menu1);
        }
        return list1;
    }
}
