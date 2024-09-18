package io.kiosk.kioskPrj.admin.Service;

import io.kiosk.kioskPrj.common.model.Kiosks;
import io.kiosk.kioskPrj.common.model.Store;
import io.kiosk.kioskPrj.admin.repository.StoreRepository;
import io.kiosk.kioskPrj.kiosk.repository.KiosksRepository;
import java.util.HashMap;
import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
public class StoreServiceImpl implements StoreService {


    private final StoreRepository storeRepository;
    private final KiosksRepository kiosksRepository;

    public StoreServiceImpl(StoreRepository storeRepository, KiosksRepository kiosksRepository) {
        this.storeRepository = storeRepository;
        this.kiosksRepository = kiosksRepository;
    }

    @Override
    public List<Store> getAllStores() {
        return storeRepository.findAll();
    }

    @Override
    public List<Store> searchStores(String storeName, String storeStatus, Sort sort) {
        return storeRepository.searchStores(storeName,storeStatus,sort);
    }

    @Override
    public void saveStore(Store store) {
        storeRepository.save(store);
    }

    @Override
    public Store getStoreById(String storeId) {
        return storeRepository.findById(storeId).orElse(null);
    }

    @Override
    public List<Kiosks> getKiosksByStoreName(String storeName) {
        return kiosksRepository.findByStoreName(storeName);
    }

//    @Override
//    public List<Store> searchStoresByName(String storeName) {
//        if (storeName != null && !storeName.isEmpty()) {
//            return storeRepository.findByStoreNameContaining(storeName);
//        } else {
//            return storeRepository.findAll();
//        }
//    }


}
