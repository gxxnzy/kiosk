package io.kiosk.kioskPrj.security.controller;


import io.kiosk.kioskPrj.security.model.User;
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
        BCryptPasswordEncoder bCryptPasswordEncoder){
        this.userRepository = userRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }
    @Autowired
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    @GetMapping({"","/"})
    public @ResponseBody List<String> index(){
        //spring session user 이름 가져오기
        String user = SecurityContextHolder.getContext().getAuthentication().getName();
        //session user 권한 가져오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        Iterator<? extends GrantedAuthority> iter = authorities.iterator();
        GrantedAuthority auth = iter.next();
        String role = auth.getAuthority();
        List<String> list = new ArrayList<>();
        list.add(user);
        list.add(role);
        return list;
    }
    @GetMapping("/loginForm")
    public String loginForm(){
        return "main/loginForm";
    }
    @GetMapping("/joinForm")
    public String joinForm(){
        return "main/joinForm";
    }
    @GetMapping("/kiosk/kiosk")
    public @ResponseBody String user(){
        return "kiosk";
    }
    @PostMapping("/join")
    public String join(User user){
        user.setRole("ROLE_KIOSK");
        String rawPassword = user.getPassword();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);
        user.setPassword(encPassword);
        user.setEnabled(1);
        userRepository.save(user);
        System.out.println(user);
        return "redirect:/loginForm";
    }
    @GetMapping("/role")
    @Secured("ROLE_STORE")
    public @ResponseBody String role(){
        return "개인정보 이 페이지는 manager만 가능";
    }
    @GetMapping("/admin")
    public @ResponseBody String admin(){
        return "admin만 가능";
    }
    @GetMapping("/manager")
    public @ResponseBody String manager(){
        return "manager 가능";
    }
    @GetMapping("/info")
    @Secured("ROLE_ADMIN")
    public @ResponseBody String info(){
        return "개인정보 이 페이지는 admin만 가능";
    }
}
