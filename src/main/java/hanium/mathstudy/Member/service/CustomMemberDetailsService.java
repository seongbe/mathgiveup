package hanium.mathstudy.Member.service;

import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.Query;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import hanium.mathstudy.Member.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class CustomMemberDetailsService implements UserDetailsService {

    private final Firestore firestore;

    @Autowired
    public CustomMemberDetailsService(Firestore firestore) {
        this.firestore = firestore;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            System.out.println("Fetching member with login_id: " + username);
            Query query = firestore.collection("Members").whereEqualTo("login_id", username);
            QuerySnapshot querySnapshot = query.get().get();

            List<QueryDocumentSnapshot> documents = querySnapshot.getDocuments();
            if (documents.isEmpty()) {
                throw new UsernameNotFoundException("User not found");
            }

            Member member = documents.get(0).toObject(Member.class);

            return User.builder()
                    .username(member.getLogin_id())
                    .password(member.getLogin_pwd())
                    .build();
        } catch (InterruptedException | ExecutionException e) {
            throw new RuntimeException(e);
        }
    }
}
