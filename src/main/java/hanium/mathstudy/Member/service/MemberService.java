package hanium.mathstudy.Member.service;

import com.google.cloud.firestore.*;
import hanium.mathstudy.Member.entity.Member;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.concurrent.*;

import com.google.api.core.ApiFuture;


@Service
public class MemberService {

    private final Firestore firestore;

    @Autowired
    public MemberService(Firestore firestore) {
        this.firestore = firestore; // memberservice 클래스 생성될 때 firestore 객체 주입
        // System.out.println("MemberService instantiated with Firestore");
    }

    public Member getMemberById(String id) throws ExecutionException, InterruptedException, TimeoutException {
        try {
            System.out.println("Fetching member with login_id: " + id);

            Query query = firestore.collection("Members").whereEqualTo("login_id", id);
            ApiFuture<QuerySnapshot> querySnapshot = query.get();

            // 타임아웃을 10초로 설정
            List<QueryDocumentSnapshot> documents = querySnapshot.get(10, TimeUnit.SECONDS).getDocuments();
            System.out.println("Documents found: " + documents.size());

            if (!documents.isEmpty()) {
                return documents.get(0).toObject(Member.class);
            } else {
                throw new IllegalArgumentException("Document not found");
            }
        } catch (Exception ex) {
            System.err.println("Error retrieving member: " + ex.getMessage());
            ex.printStackTrace();
            throw ex;
        }
    }
    public Member getMemberByEmail(String email) throws ExecutionException, InterruptedException {
        Query query = firestore.collection("Members").whereEqualTo("email", email);
        ApiFuture<QuerySnapshot> querySnapshot = query.get();
        List<QueryDocumentSnapshot> documents = querySnapshot.get().getDocuments();

        if (!documents.isEmpty()) {
            return documents.get(0).toObject(Member.class);
        }
        return null;
    }

    public Member getMemberByNickname(String nickname) throws ExecutionException, InterruptedException {
        Query query = firestore.collection("Members").whereEqualTo("nickname", nickname);
        ApiFuture<QuerySnapshot> querySnapshot = query.get();
        List<QueryDocumentSnapshot> documents = querySnapshot.get().getDocuments();

        if (!documents.isEmpty()) {
            return documents.get(0).toObject(Member.class);
        }
        return null;
    }

    public String createMember(Member member) throws ExecutionException, InterruptedException, IllegalArgumentException {
        if (getMemberById(member.getLogin_id()) != null) {
            throw new IllegalArgumentException("ID already exists");
        }

        if (getMemberByNickname(member.getNickname()) != null) {
            throw new IllegalArgumentException("Nickname already exists");
        }

        CollectionReference members = firestore.collection("Members");
        ApiFuture<DocumentReference> result = members.add(member);

        return result.get().getId();
    }

    public void verifyEmail(String email) throws ExecutionException, InterruptedException {
        Member member = getMemberByEmail(email);
        if (member != null) {
            member.setEmailVerified(true);
            CollectionReference members = firestore.collection("Members");
            ApiFuture<WriteResult> future = members.document(member.getLogin_id()).set(member);
            future.get();
        }
    }
}
