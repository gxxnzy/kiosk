package io.kiosk.kioskPrj.security.config.auth;


import io.kiosk.kioskPrj.common.model.User;
import java.util.ArrayList;
import java.util.Collection;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

//시큐리티가 /login 주소를 낚아채서 로그인 진행, 로그인 완료 대면 session을 만들어
//Security ContextHolder 키 값에 정보 저장
//오브젝트 타입 => Authentication 객체 => user 정보
//user 타입 => userDetail 타입
//Security session 에는 Authentication 객체만 가능 => user 정보는 UserDetails(PrincipleDetails) 타입
public class PrincipleDetails implements UserDetails {

    private User user;

    public PrincipleDetails(User user) {
        this.user = user;
    }

    //해당 유저의 권한 리턴 하는 곳
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> collect = new ArrayList<>();
        collect.add(new GrantedAuthority() {
            @Override
            public String getAuthority() {
                return user.getRole();
            }
        });
        return collect;
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        if(user.getEnabled() == 0){
            return false;
        }
        return true;
    }
}
