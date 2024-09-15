package io.kiosk.kioskPrj.kiosk.service;

import io.kiosk.kioskPrj.common.model.Category;
import io.kiosk.kioskPrj.common.model.Menu;
import io.kiosk.kioskPrj.kiosk.repository.CategoryRepository;
import java.util.List;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;
    public CategoryService (CategoryRepository categoryRepository){
        this.categoryRepository = categoryRepository;
    }
    @Cacheable(value = "categoryCache")
    public List<Category> selectAll(){
        return categoryRepository.findAll();
    }

}
