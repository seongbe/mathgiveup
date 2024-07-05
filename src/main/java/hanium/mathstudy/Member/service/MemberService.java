package hanium.mathstudy.Member.service;

import hanium.mathstudy.Member.entity.Member;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    private final Firestore db;

    public MemberService() {
        this.db = FirestoreOptions.getDefaultInstance().getService();
    }
}

