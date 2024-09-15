package io.kiosk.kioskPrj.kiosk.service;


import io.kiosk.kioskPrj.common.model.OrderDetails;
import io.kiosk.kioskPrj.common.model.Orders;
import io.kiosk.kioskPrj.kiosk.repository.OrdersRepository;
import io.kiosk.kioskPrj.store.repository.OrderdetailsRepository;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderService {
    private final OrdersRepository ordersRepository;
    private final OrderdetailsRepository orderdetailsRepository;
    public OrderService(OrdersRepository ordersRepository, OrderdetailsRepository orderdetailsRepository){
        this.ordersRepository = ordersRepository;
        this.orderdetailsRepository = orderdetailsRepository;
    }
    @Transactional
    public Orders saveOrderAndDetails(String storeName, Integer kioskNum, List<Map<String, Object>> cartItems) {
        // Orders 객체 생성 및 저장
        Orders order = new Orders();
        order.setStoreName(storeName);
        order.setKiosksNum(kioskNum);
        order.setPayStatus(0); // 기본값 0으로 설정
        Orders savedOrder = ordersRepository.save(order);

        // OrderDetails 객체 저장
        for (Map<String, Object> item : cartItems) {
            OrderDetails orderDetails = new OrderDetails();
            orderDetails.setOrder(savedOrder);
            orderDetails.setMenuName((String) item.get("menuName"));
            orderDetails.setQuantity((Integer) item.get("quantity"));
            orderDetails.setQuantityPrice((Integer) item.get("menuPrice") * (Integer) item.get("quantity"));
            orderdetailsRepository.save(orderDetails);
        }

        return savedOrder;  // 저장된 order 반환
    }
}
