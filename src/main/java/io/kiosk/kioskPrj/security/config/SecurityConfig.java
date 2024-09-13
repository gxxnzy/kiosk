package io.kiosk.kioskPrj.security.config;


import io.kiosk.kioskPrj.security.config.auth.PrincipleDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class SecurityConfig {
    private final PrincipleDetailsService principleDetailsService;

    public SecurityConfig(PrincipleDetailsService principleDetailsService) {
        this.principleDetailsService = principleDetailsService;
    }
    @Bean
    public BCryptPasswordEncoder encodePwd() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // Disable CSRF for this example
        http.csrf().disable();
        // Set up access control
        http.authorizeHttpRequests(authorizeRequests -> authorizeRequests
            .requestMatchers("/kiosk/**").hasAnyRole("KIOSK", "STORE")
            .requestMatchers("/store/**").hasRole("STORE")
            .requestMatchers("/admin/**").hasRole("ADMIN")
            .anyRequest().permitAll()
        );
        http.formLogin(form -> form
            .loginPage("/loginForm")
            .loginProcessingUrl("/login")
            .successHandler((request, response, authentication) -> {
                // Role-based redirection
                String role = authentication.getAuthorities().iterator().next().getAuthority();
                if (role.equals("ROLE_ADMIN")) {
                    response.sendRedirect("/admin/adminMain");
                } else if (role.equals("ROLE_KIOSK")) {
                    response.sendRedirect("/kiosk/menu");
                } else if (role.equals("ROLE_STORE")) {
                    response.sendRedirect("/store/main");
                }
            })
            .permitAll()
        );

        // Configure exception handling
        http.exceptionHandling(exceptionHandling -> exceptionHandling
            .authenticationEntryPoint(authenticationEntryPoint())
        );

        return http.build();
    }

    @Bean
    public AuthenticationEntryPoint authenticationEntryPoint() {
        return (request, response, authException) -> {
            String uri = request.getRequestURI();
            if (uri.startsWith("/admin")) {
                response.sendRedirect("/loginForm"); // Redirect to admin login page
            } else if (uri.startsWith("/store") || uri.startsWith("/kiosk")) {
                response.sendRedirect("/loginForm"); // Redirect to kiosk login page
            }
        };
    }
}
