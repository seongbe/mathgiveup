package hanium.mathstudy.Member.controller;

import hanium.mathstudy.Member.entity.Member;
import hanium.mathstudy.Member.service.GoogleLoginService;
import hanium.mathstudy.Member.service.MemberService;

import java.util.Map;
import java.util.concurrent.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/members")
public class MemberController {

    private MemberService memberService;
    private final GoogleLoginService googleLoginService;

    @Autowired
    public MemberController(MemberService memberService, GoogleLoginService googleLoginService) {
        this.memberService = memberService; // controller가 생성될 때 service 주입하기
         System.out.println("MemberController instantiated with MemberService");
        this.googleLoginService = googleLoginService;
        System.out.println("MemberController instantiated with googleLoginService");
    }

    @PostMapping("/signup")
    public ResponseEntity<String> signUp(@RequestBody Member member) {
        System.out.println("RequestBody received: " + member);
        try {
            String memberId = memberService.createMember(member);
            return ResponseEntity.ok("Member created with ID: " + memberId);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (ExecutionException | InterruptedException | TimeoutException e) {
            return ResponseEntity.status(500).body("Error creating member: " + e.getMessage());
        }
    }

    @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestBody Member member) {
        System.out.println("RequestBody received: " + member);

        if(member.getLogin_id() == null || member.getLogin_id().isEmpty()) {
            return ResponseEntity.badRequest().body("Login_id is empty.");
        }

        if(member.getLogin_pwd() == null || member.getLogin_pwd().isEmpty()) {
            return ResponseEntity.badRequest().body("Login_pwd is empty.");
        }

        try {
            System.out.println("Login request received for ID: " + member.getLogin_id());

            Member infoMember = memberService.getMemberById(member.getLogin_id());

            if(infoMember != null) {
                if (infoMember.getLogin_pwd().equals(member.getLogin_pwd())) {
                    System.out.println("Login successful for ID: " + member.getLogin_id());
                    return ResponseEntity.ok("Login successful ! Nickname : " + infoMember.getNickname());
                } else {
                    System.out.println("Login failed for Password: " + member.getLogin_id());
                    return ResponseEntity.ok("Invalid password");
                }
            } else {
                System.out.println("Login failed for ID: " + member.getLogin_id());
                return ResponseEntity.status(401).body("Login faild for ID");
            }
        } catch (ExecutionException | InterruptedException e) { // 비동기 및 스레드 오류
            System.err.println("Error during login: " + e.getMessage());
            return ResponseEntity.status(500).body("Error during login: " + e.getMessage());
        } catch (IllegalArgumentException e) { // 메서드가 잘못된 인수로 인한 오류
            System.err.println("Error: " + e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (TimeoutException e) {
            throw new RuntimeException(e);
        }
    }

    @PostMapping("/google-login")
    public ResponseEntity<String> googleLogin(@RequestBody Map<String, String> request) {
        String idToken = request.get("idToken");

        try {
            System.out.println("ID Token received: " + idToken);

            Member member = googleLoginService.processGoogleLogin(idToken);

            if (member != null) {
                return ResponseEntity.ok("Login successful! Nickname: " + member.getNickname());
            } else {
                return ResponseEntity.status(401).body("Login failed for Google ID");
            }

        } catch (Exception e) {
            System.err.println("Error during login: " + e.getMessage());
            return ResponseEntity.status(500).body("Error during login: " + e.getMessage());
        }
    }



    @PostMapping("/initiate-email-verification")
    public ResponseEntity<String> initiateEmailVerification(@RequestBody Map<String, String> request) {
        String email = request.get("email");

        try {
            String result = memberService.initiateEmailVerification(email);
            return ResponseEntity.ok(result);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (ExecutionException | InterruptedException | TimeoutException e) {
            return ResponseEntity.status(500).body("Error initiating email verification: " + e.getMessage());
        }
    }

    @PostMapping("/complete-registration")
    public ResponseEntity<String> completeRegistration(@RequestBody Member member) {
        try {
            String memberId = memberService.completeRegistration(member);
            return ResponseEntity.ok("Member registered with ID: " + memberId);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (ExecutionException | InterruptedException | TimeoutException e) {
            return ResponseEntity.status(500).body("Error completing registration: " + e.getMessage());
        }
    }
}
