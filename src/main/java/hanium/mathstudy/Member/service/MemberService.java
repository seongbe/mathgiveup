package hanium.mathstudy.Member.service;

import com.google.cloud.firestore.DocumentReference;
import hanium.mathstudy.Member.entity.Member;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreOptions;
import org.springframework.stereotype.Service;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.concurrent.ExecutionException;

import com.google.api.core.ApiFuture;


@Service
public class MemberService {

        private final Firestore firestore;

        @Autowired
        public MemberService(Firestore firestore) {
            this.firestore = firestore;
        }

    public Member getMemberById(String id) throws ExecutionException, InterruptedException {
        DocumentReference docRef = firestore.collection("Members").document(id);
        ApiFuture<com.google.cloud.firestore.DocumentSnapshot> future = docRef.get();
        com.google.cloud.firestore.DocumentSnapshot document = future.get();

        if (document.exists()) {
            return document.toObject(Member.class);
        }
        else {
            throw new IllegalArgumentException(new Exception("Document not found"));
        }
    }
}
