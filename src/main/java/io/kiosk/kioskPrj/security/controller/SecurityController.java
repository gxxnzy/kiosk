package io.kiosk.kioskPrj.security.controller;


import io.kiosk.kioskPrj.common.model.User;
import io.kiosk.kioskPrj.security.repository.UserRepository;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SecurityController {

    private final UserRepository userRepository;

    public SecurityController(UserRepository userRepository,
        BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.userRepository = userRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Autowired
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @GetMapping({"", "/"})
    public String index() {
        return "redirect:/kiosk/menu";
    }

    @GetMapping("/loginForm")
    public String loginForm() {
        return "main/loginForm";
    }

    @GetMapping("/joinForm")
    public String joinForm() {
        return "main/joinForm";
    }

    @GetMapping("/kiosk/kiosk")
    public @ResponseBody String user() {
        return "kiosk";
    }

    @PostMapping("/join")
    public String join(User user) {
        user.setRole("ROLE_KIOSK");
        String rawPassword = user.getPassword();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);
        user.setPassword(encPassword);
        user.setUserStatus(1);
        userRepository.save(user);
        System.out.println(user);
        return "redirect:/loginForm";
    }
}
