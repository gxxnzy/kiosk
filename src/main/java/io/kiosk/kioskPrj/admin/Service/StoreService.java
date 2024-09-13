package io.kiosk.kioskPrj.admin.Service;

import io.kiosk.kioskPrj.common.model.Store;
import java.util.HashMap;
import java.util.List;
import org.springframework.data.domain.Sort;

public interface StoreService {

    List<Store> getAllStores();

    //List<Store> searchStoresByName(String storeName);

    List<Store> searchStores(String storeName, String storeStatus, Sort sort);

    void saveStore(Store store);
}
