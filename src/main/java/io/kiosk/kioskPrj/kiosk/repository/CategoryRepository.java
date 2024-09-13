package io.kiosk.kioskPrj.kiosk.repository;

import io.kiosk.kioskPrj.kiosk.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, String> {

}
