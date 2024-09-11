package io.kiosk.kioskPrj.store.service;

import io.kiosk.kioskPrj.store.entity.OrderDetails;
import io.kiosk.kioskPrj.store.entity.Stores;
import io.kiosk.kioskPrj.store.repository.OrderdetailsRepository;
import io.kiosk.kioskPrj.store.repository.StoresRepository; // 새로운 레포지토리 추가
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StoreService {

    private final OrderdetailsRepository orderdetailsRepository;
    private final StoresRepository storesRepository; // 새로운 레포지토리 추가

    public StoreService(OrderdetailsRepository orderdetailsRepository, StoresRepository storesRepository) {
        this.orderdetailsRepository = orderdetailsRepository;
        this.storesRepository = storesRepository;
    }

    public List<OrderDetails> getOrderDetailsByStoreName(String storeName) {
        return orderdetailsRepository.findByStoreName(storeName);
    }

    public List<Stores> getAllStores() {
        return storesRepository.findAll();
    }
}

