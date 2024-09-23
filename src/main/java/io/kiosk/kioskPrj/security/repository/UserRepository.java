package io.kiosk.kioskPrj.security.repository;

import io.kiosk.kioskPrj.common.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

//@Repository 상속 없이 ioc 가능 JpaRepository 상속해서 자동 bean 등록
public interface UserRepository extends JpaRepository<User, Integer> {

    //select * from user where username = username
    public User findByUsername(String username);

    void deleteByUsername(String kioskId);
}
