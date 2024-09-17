package io.kiosk.kioskPrj.store.service;

import io.kiosk.kioskPrj.common.model.Kiosks;
import io.kiosk.kioskPrj.common.model.OrderDetails;
import io.kiosk.kioskPrj.common.model.Orders;
import io.kiosk.kioskPrj.common.model.Store;
import io.kiosk.kioskPrj.kiosk.repository.KiosksRepository;
import io.kiosk.kioskPrj.kiosk.repository.OrdersRepository; // 추가된 부분
import io.kiosk.kioskPrj.store.repository.OrderdetailsRepository;
import io.kiosk.kioskPrj.store.repository.StoresRepository;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class StoreService {

    private final OrderdetailsRepository orderdetailsRepository;
    private final StoresRepository storesRepository;
    private final KiosksRepository kiosksRepository;
    private final OrdersRepository ordersRepository;

    public StoreService(OrderdetailsRepository orderdetailsRepository, StoresRepository storesRepository, KiosksRepository kiosksRepository, OrdersRepository ordersRepository) {
        this.orderdetailsRepository = orderdetailsRepository;
        this.storesRepository = storesRepository;
        this.kiosksRepository = kiosksRepository;
        this.ordersRepository = ordersRepository;
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

    public List<Kiosks> getKiosksByStoreName(String storeName) {
        return kiosksRepository.findByStoreName(storeName);
    }


    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        return orderdetailsRepository.findByOrderId(orderId);
    }

    public void updatePaymentStatusForOrders(List<Integer> orderIds) {
        for (Integer orderId : orderIds) {
            Orders order = ordersRepository.findById(orderId).orElse(null);
            if (order != null) {
                order.setPayStatus(1); // 결제 완료 상태로 업데이트
                ordersRepository.save(order);
            }
        }
    }


    public List<Orders> getUnpaidOrdersByStoreName(String storeName) {
        return ordersRepository.findByStoreNameAndPayStatus(storeName, 0);
    }
    public List<Orders> getOrdersByKioskNumAndStoreName(int kioskNum, String storeName) {
        return ordersRepository.findByKioskNumAndStoreName(kioskNum, storeName);
    }

    public List<OrderDetails> searchMenuByKeyword(String storeName, String keyword) {
        return orderdetailsRepository.findByStoreNameAndMenuNameContaining(storeName, keyword);
    }
}



