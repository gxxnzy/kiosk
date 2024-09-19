package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.common.model.Menu;
import java.util.List;

public interface MenuService {

    // 모든 메뉴 조회
    List<Menu> getAllMenus();

    // 메뉴 추가
    void saveMenu(Menu menu);

    // 조건 검색
    List<Menu> searchMenu(String menuName, String categoryName, Integer active);

    // 상세 보기
    Menu getById(int menuId);

    // 메뉴 수정
    void updateMenu(Menu menu);
}
