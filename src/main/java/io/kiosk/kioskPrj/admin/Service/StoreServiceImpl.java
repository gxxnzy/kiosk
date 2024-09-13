package io.kiosk.kioskPrj.admin.Service;

import io.kiosk.kioskPrj.common.model.Store;
import io.kiosk.kioskPrj.admin.repository.StoreRepository;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class StoreServiceImpl implements StoreService {


    private final StoreRepository storeRepository;

    public StoreServiceImpl(StoreRepository storeRepository) {
        this.storeRepository = storeRepository;
    }

    @Override
    public List<Store> getAllStores() {
        return storeRepository.findAll();
    }
}
