package hanium.mathstudy.Member.controller;

import hanium.mathstudy.Member.entity.Member;
import hanium.mathstudy.Member.service.MemberService;
import java.util.concurrent.ExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/members")
public class MemberController {

    private MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestBody Member Member) {
        try {
            hanium.mathstudy.Member.entity.Member infoMember = memberService.getMemberById(Member.getId());
            if (infoMember != null && infoMember.getPassword().equals(Member.getPassword())) {
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
