package hanium.mathstudy.Member.config;

import com.google.cloud.firestore.Firestore;
import hanium.mathstudy.Member.service.CustomMemberDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity
@Configuration
public class SecurityConfig {

    private final Firestore firestore;

    public SecurityConfig(Firestore firestore) {
        this.firestore = firestore;
        System.out.println("Firestore instance injected: " + firestore);
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        System.out.println("Configuring SecurityFilterChain...");
        http
                .csrf(csrf -> csrf.disable()) // CSRF 보호 비활성화
                .authorizeHttpRequests(authorizeRequests -> authorizeRequests
                        .requestMatchers("/api/members/login", "/api/members/signup", "/api/members/google-login",
                                "/api/members/initiate-email-verification", "/api/members/complete-registration").permitAll() // 이메일 인증 및 회원가입 경로 추가).permitAll()
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .permitAll()
                )
                .logout(logout -> logout
                        .permitAll()
                );
        System.out.println("SecurityFilterChain configured.");
        return http.build();

    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        System.out.println("Configuring PasswordEncoder...");
        return new BCryptPasswordEncoder();
    }

    @Bean
    public CustomMemberDetailsService CustomMemberDetailsService() {
        System.out.println("Creating CustomMemberDetailsService with Firestore: " + firestore);
        return new CustomMemberDetailsService(firestore);
    }
}