package io.kiosk.kioskPrj.admin.Service;

import io.kiosk.kioskPrj.admin.repository.AdminMenuRepository;
import io.kiosk.kioskPrj.common.model.Menu;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MenuServiceImpl implements MenuService {

    private final AdminMenuRepository adminMenuRepository;

    @Autowired
    public MenuServiceImpl(AdminMenuRepository adminMenuRepository) {
        this.adminMenuRepository = adminMenuRepository;
    }

    // 모든 메뉴 조회
    @Override
    public List<Menu> getAllMenus() {
        return adminMenuRepository.findAll();
    }

    // 메뉴 추가
    @Override
    public void saveMenu(Menu menu) {
        adminMenuRepository.save(menu);
    }

    // 조건 검색
    @Override
    public List<Menu> searchMenu(String menuName, String menuCategory, Integer active) {
        return adminMenuRepository.searchMenu(menuName, menuCategory, active);
    }

    // 상세 보기
    @Override
    public Menu getById(int menuId) {
        return adminMenuRepository.getById(menuId);
    }

    // 메뉴 수정
    @Override
    public void updateMenu(Menu menu) {
        adminMenuRepository.save(menu);
    }
}
