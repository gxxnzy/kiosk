package io.kiosk.kioskPrj.admin.Service;

import io.kiosk.kioskPrj.common.model.User;
import io.kiosk.kioskPrj.security.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserRepository userRepository;

    @Override
    public void saveUser(User user) {
        userRepository.save(user);
    }
}