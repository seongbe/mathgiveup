package hanium.mathstudy.Member.service;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class GoogleIdTokenVerifierService {

    private static final String CLIENT_ID = "903509884558-am8vjchn9ag5av9n1l0h174tpd97p9fu.apps.googleusercontent.com";  // 구글 클라우드 만들고 바꿔야함.

    public GoogleIdToken.Payload verifyToken(String idTokenString) throws Exception {

        GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new JacksonFactory())
                .setAudience(Collections.singletonList(CLIENT_ID))
                .build();

        System.out.println("Verifier built with client ID: " + CLIENT_ID);

        GoogleIdToken idToken = verifier.verify(idTokenString);

        if(idToken != null) {
            System.out.println("Token verified successfully");
            return idToken.getPayload();
        } else {
            System.out.println("Invalid token");
            throw new Exception("Invalid token");
        }
    }

}
