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

    public StoreService(OrderdetailsRepository orderdetailsRepository,
        StoresRepository storesRepository, KiosksRepository kiosksRepository,
        OrdersRepository ordersRepository) {
        this.orderdetailsRepository = orderdetailsRepository;
        this.storesRepository = storesRepository;
        this.kiosksRepository = kiosksRepository;
        this.ordersRepository = ordersRepository;
    }

    // 상점 이름에 따른 주문 상세 정보를 가져오는 메서드
    public List<OrderDetails> getOrderDetailsByStoreName(String storeName) {
        return orderdetailsRepository.findByStoreName(storeName);
    }

    // 상점 이름에 따른 총 매출 계산
    public int getTotalSalesByStoreName(String storeName) {
        List<OrderDetails> orderDetails = getOrderDetailsByStoreName(storeName);
        return orderDetails.stream()
            .mapToInt(detail -> detail.getQuantity() * detail.getQuantityPrice())
            .sum();
    }

    // 모든 상점 정보 가져옴
    public List<Store> getAllStores() {
        return storesRepository.findAll();
    }

    public Store getStoreById(String storeId) {
        return storesRepository.findById(storeId).orElse(null);
    }

    // 상점 이름에 따른 키오스크 정보
    public List<Kiosks> getKiosksByStoreName(String storeName) {
        return kiosksRepository.findByStoreName(storeName);
    }

    // 주문 id에 따른 주문 상세 정보
    public List<OrderDetails> getOrderDetailsByOrderId(int orderId) {
        return orderdetailsRepository.findByOrderId(orderId);
    }

    // 여러 주문 id에 대한 결제 상태 업데이트
    public void updatePaymentStatusForOrders(List<Integer> orderIds) {
        for (Integer orderId : orderIds) {
            Orders order = ordersRepository.findById(orderId).orElse(null);
            if (order != null) {
                order.setPayStatus(1); // 결제 완료 상태로 업데이트
                ordersRepository.save(order);
            }
        }
    }

    // 상점 이름에 따른 미결제 주문
    public List<Orders> getUnpaidOrdersByStoreName(String storeName) {
        return ordersRepository.findByStoreNameAndPayStatus(storeName, 0);
    }

    // 키오스크 번호와 상점 이름에 따른 주문정보
    public List<Orders> getOrdersByKioskNumAndStoreName(int kioskNum, String storeName) {
        return ordersRepository.findByKioskNumAndStoreName(kioskNum, storeName);
    }

    // 상점 이름과 키워드에 따라 메뉴 검색
    public List<OrderDetails> searchMenuByKeyword(String storeName, String keyword) {
        return orderdetailsRepository.findByStoreNameAndMenuNameContaining(storeName, keyword);
    }
}



