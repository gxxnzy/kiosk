package io.kiosk.kioskPrj.admin.repository;

import io.kiosk.kioskPrj.common.model.Menu;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

// <1, 2> -> 1번 값에는 Repository가 사용할 엔티티, 2번 값은 primary key의 데이터 타입
public interface AdminMenuRepository extends JpaRepository<Menu, Integer> {

    // 검색
    @Query("SELECT m FROM Menu m WHERE "
        + "(:menuName IS NULL OR :menuName = '' OR m.menuName LIKE %:menuName%) AND "
        + "(:categoryName IS NULL OR :categoryName = '' OR m.categoryName = :categoryName) AND "
        + "(:menuActive IS NULL OR m.menuActive = :menuActive)")
    List<Menu> searchMenu(String menuName, String categoryName, Integer menuActive);
}
