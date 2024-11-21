package hanium.mathstudy.Member.service;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import hanium.mathstudy.Member.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GoogleLoginService {

    @Autowired
    private MemberService memberService;

    @Autowired
    private GoogleIdTokenVerifierService googleIdTokenVerifier;

    public Member processGoogleLogin(String idTokenString) throws Exception {
        System.out.println("Processing Google login with token: " + idTokenString);

        GoogleIdToken.Payload payload = googleIdTokenVerifier.verifyToken(idTokenString);

        if (payload == null) {
            throw new Exception("Invalid ID token.");
        }
        System.out.println("Token payload: " + payload);

        String userId = payload.getSubject();
        String email = payload.getEmail();
        String name = (String) payload.get("name");

        System.out.println("Google ID: " + userId);
        System.out.println("Email: " + email);
        System.out.println("Name: " + name);

        Member member = memberService.findByGoogleId(userId);

        if(member == null) {
            System.out.println("No existing member found. Creating new member.");

            member = new Member();
            member.setGoogleId(userId);
            member.setEmail(email);
            member.setNickname(name);
            member.setLogin_id(email);
            member.setEmailVerified(true);
            memberService.save(member);
        } else {
            System.out.println("Existing member found: " + member.getNickname());
        }

        return member;
    }
}
