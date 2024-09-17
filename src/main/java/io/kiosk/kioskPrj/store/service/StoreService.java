package io.kiosk.kioskPrj.store.service;

import io.kiosk.kioskPrj.common.model.Kiosks;
import io.kiosk.kioskPrj.common.model.OrderDetails;
import io.kiosk.kioskPrj.common.model.Store;
import io.kiosk.kioskPrj.kiosk.repository.KiosksRepository;
import io.kiosk.kioskPrj.store.repository.OrderdetailsRepository;
import io.kiosk.kioskPrj.store.repository.StoresRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StoreService {

    private final OrderdetailsRepository orderdetailsRepository;
    private final StoresRepository storesRepository;
    private final KiosksRepository kiosksRepository;

    public StoreService(OrderdetailsRepository orderdetailsRepository, StoresRepository storesRepository, KiosksRepository kiosksRepository) {
        this.orderdetailsRepository = orderdetailsRepository;
        this.storesRepository = storesRepository;
        this.kiosksRepository = kiosksRepository;
    }

    public List<OrderDetails> getOrderDetailsByStoreName(String storeName) {
        return orderdetailsRepository.findByStoreName(storeName);
    }

    public int getTotalSalesByStoreName(String storeName) {
        List<OrderDetails> orderDetails = getOrderDetailsByStoreName(storeName);
        return orderDetails.stream()
                .mapToInt(detail -> detail.getQuantity() * detail.getQuantityPrice())
                .sum();
    }

    public List<Store> getAllStores() {
        return storesRepository.findAll();
    }

    public Store getStoreById(String storeId) {
        return storesRepository.findById(storeId).orElse(null);
    }

    // 키오스크 리스트를 조회하는 메서드
    public List<Kiosks> getKiosksByStoreName(String storeName) {
        // storeName을 기반으로 키오스크 리스트를 조회하는 로직을 추가합니다.
        return kiosksRepository.findByStoreName(storeName);
    }

}
