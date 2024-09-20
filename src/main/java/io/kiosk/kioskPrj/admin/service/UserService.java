package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.common.model.User;

public interface UserService {

    void saveUser(User user);

    void deleteUserByUsername(String kioskId);

    void updatePassword(String storeName, String password);
}
