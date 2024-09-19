package io.kiosk.kioskPrj.admin.service;

import io.kiosk.kioskPrj.common.model.User;
import io.kiosk.kioskPrj.security.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserRepository userRepository;

    @Override
    public void saveUser(User user) {
        userRepository.save(user);
    }

    @Override
    public void deleteUserByUsername(String kioskId) {
        userRepository.deleteByUsername(kioskId);
    }

    @Override
    public void updatePassword(String userName, String password) {
        User user = userRepository.findByUsername(userName);  // storeId가 User 테이블의 username
        user.setPassword(new BCryptPasswordEncoder().encode(password));  // 비밀번호 암호화
        userRepository.save(user);
    }
}