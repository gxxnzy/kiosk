package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.common.model.Kiosks;
import io.kiosk.kioskPrj.common.model.Store;
import io.kiosk.kioskPrj.common.model.User;
import java.util.List;
import org.springframework.data.domain.Sort;

public interface StoreService {

    List<Store> getAllStores();

    //List<Store> searchStoresByName(String storeName);

    List<Store> searchStores(String storeName, String storeStatus, Sort sort);

    void saveStore(Store store);

    Store getStoreById(String storeId);

    List<Kiosks> getKiosksByStoreName(String storeName);

    void saveStoreAndUser(Store store, User user);

    Kiosks createKiosksForStore(String storeId, String storeName);

    void deleteLastKiosk(String storeName);

    void updateStore(Store store);
}
