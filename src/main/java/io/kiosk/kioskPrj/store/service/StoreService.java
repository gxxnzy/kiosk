package io.kiosk.kioskPrj.store.service;

import io.kiosk.kioskPrj.common.model.OrderDetails;
import io.kiosk.kioskPrj.common.model.Store;
import io.kiosk.kioskPrj.store.repository.OrderdetailsRepository;
import io.kiosk.kioskPrj.store.repository.StoresRepository; // 새로운 레포지토리 추가
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StoreService {

    private final OrderdetailsRepository orderdetailsRepository;
    private final StoresRepository storesRepository;

    public StoreService(OrderdetailsRepository orderdetailsRepository, StoresRepository storesRepository) {
        this.orderdetailsRepository = orderdetailsRepository;
        this.storesRepository = storesRepository;
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
}