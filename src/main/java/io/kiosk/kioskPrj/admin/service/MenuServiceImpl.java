package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.admin.repository.AdminMenuRepository;
import io.kiosk.kioskPrj.common.model.Menu;
import io.kiosk.kioskPrj.kiosk.repository.MenuRepository;
import java.io.IOException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private AdminMenuRepository adminMenuRepository;

    @Autowired
    private S3Service s3Service;

    // 모든 메뉴 조회
    @Override
    public List<Menu> getAllMenus() {
        return adminMenuRepository.findAll();
    }

    // 메뉴 추가
    @Override
    @Transactional
    public void saveMenu(Menu menu, MultipartFile file) {
        try {
            if (!file.isEmpty()) {
                // 이미지 파일을 AWS S3에 업로드하고 URL을 가져옴
                String imageUrl = s3Service.saveFile(file);
                menu.setMenuImage(imageUrl);
                adminMenuRepository.save(menu);
            }
        } catch (IOException e) {
            System.out.println("이미지 업로드 실패 : " + e.getMessage());
        }

    }

    // 조건 검색
    @Override
    public List<Menu> searchMenu(String menuName, String menuCategory, Integer menuActive) {
        return adminMenuRepository.searchMenu(menuName, menuCategory, menuActive);
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
