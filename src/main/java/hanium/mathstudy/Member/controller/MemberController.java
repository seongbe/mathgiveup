package hanium.mathstudy.Member.controller;

import hanium.mathstudy.Member.entity.Member;
import hanium.mathstudy.Member.service.MemberService;

import java.util.concurrent.ExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController; // 추가된 import 문
import org.springframework.web.bind.annotation.RequestMapping; // 추가된 import 문

import org.springframework.http.ResponseEntity;  // 추가된 import 문

@RestController
@RequestMapping("/api/members")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestBody Member Member) {
        try {
            hanium.mathstudy.Member.entity.Member infoUser = memberService.getMemberById(Member.getId());
            if (infoUser != null && infoUser.getPassword().equals(Member.getPassword())) {
                return ResponseEntity.ok("Login successful");
            } else {
                return ResponseEntity.status(401).body("Invalid credentials");
            }
        } catch (ExecutionException | InterruptedException e) {
            return ResponseEntity.status(500).body("Error during login: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
