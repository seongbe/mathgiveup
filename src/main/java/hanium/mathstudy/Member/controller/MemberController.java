package hanium.mathstudy.Member.controller;

import hanium.mathstudy.Member.entity.Member;
import hanium.mathstudy.Member.service.MemberService;

import java.util.concurrent.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/members")
public class MemberController {

    private MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService; // controller가 생성될 때 service 주입하기
        // System.out.println("MemberController instantiated with MemberService");
    }

    @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestBody Member member) {
        System.out.println("RequestBody received: " + member);

        try {
            System.out.println("Login request received for ID: " + member.getLogin_id());

            Member infoMember = memberService.getMemberById(member.getLogin_id());

            if (infoMember != null && infoMember.getLogin_pwd().equals(member.getLogin_pwd())) {
                System.out.println("Login successful for ID: " + member.getLogin_id());
                return ResponseEntity.ok("Login successful");
            } else {
                System.out.println("Invalid credentials for ID: " + member.getLogin_id());
                return ResponseEntity.status(401).body("Invalid credentials");
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
    @PostMapping("/signup")
    public ResponseEntity<String> signUpUser(@RequestBody Member member) {
        try {
            if (!member.isEmailVerified()) {
                return ResponseEntity.badRequest().body("Email not verified");
            }

            memberService.createMember(member);
            return ResponseEntity.ok("Signup successful");
        } catch (ExecutionException | InterruptedException e) {
            return ResponseEntity.status(500).body("Error during signup: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/verify-email")
    public ResponseEntity<String> verifyEmail(@RequestBody Member member) {
        try {
            memberService.verifyEmail(member.getEmail());
            return ResponseEntity.ok("Email verified");
        } catch (ExecutionException | InterruptedException e) {
            return ResponseEntity.status(500).body("Error during email verification: " + e.getMessage());
        }
    }

    @GetMapping("/check-id")
    public ResponseEntity<Boolean> checkId(@RequestParam String login_id) {
        try {
            Member member = memberService.getMemberById(login_id);
            return ResponseEntity.ok(member == null);
        } catch (ExecutionException | InterruptedException e) {
            return ResponseEntity.status(500).body(false);
        } catch (TimeoutException e) {
            throw new RuntimeException(e);
        }
    }

    @GetMapping("/check-nickname")
    public ResponseEntity<Boolean> checkNickname(@RequestParam String nickname) {
        try {
            Member member = memberService.getMemberByNickname(nickname);
            return ResponseEntity.ok(member == null);
        } catch (ExecutionException | InterruptedException e) {
            return ResponseEntity.status(500).body(false);
        }
    }
}
