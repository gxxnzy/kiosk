package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.common.model.Kiosks;
import io.kiosk.kioskPrj.common.model.Store;
import io.kiosk.kioskPrj.admin.repository.StoreRepository;
import io.kiosk.kioskPrj.common.model.User;
import io.kiosk.kioskPrj.kiosk.repository.KiosksRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
public class StoreServiceImpl implements StoreService {


    private final StoreRepository storeRepository;
    private final KiosksRepository kiosksRepository;

    @Autowired
    private UserService userService;


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

    @Override
    @Transactional
    public void saveStoreAndUser(Store store, User user) {
        // 1. Store 저장
        storeRepository.save(store);

        // 2. User 저장
        userService.saveUser(user);

        // 이 두 가지 작업 중 하나라도 실패하면 전체 작업이 롤백됩니다.
    }

    @Override
    public Kiosks createKiosksForStore(String storeId, String storeName) {
        int kioskCount = kiosksRepository.countByStoreName(storeName);
        String kioskId = storeId + "-Kiosk" + (kioskCount + 1);

        // 키오스크 엔티티 생성
        Kiosks kiosk = new Kiosks();
        kiosk.setKioskId(kioskId);
        kiosk.setStoreName(storeName);
        kiosk.setKioskNum(kioskCount+1);

        kiosksRepository.save(kiosk);


        return kiosk;
    }

    @Override
    @Transactional
    public void deleteLastKiosk(String storeName) {
        Kiosks lastKiosk = kiosksRepository.findTopByStoreNameOrderByKioskNumDesc(storeName);

        if (lastKiosk != null) {
            // 마지막 키오스크 삭제
            kiosksRepository.delete(lastKiosk);
            userService.deleteUserByUsername(lastKiosk.getKioskId());
        }
    }

    @Override
    public void updateStore(Store store) {
        storeRepository.save(store);
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
