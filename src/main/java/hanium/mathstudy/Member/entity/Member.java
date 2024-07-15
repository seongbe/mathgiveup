package hanium.mathstudy.Member.entity;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Member {
    private String email;
    private String login_id;
    private String login_pwd;
    private String nickname;
    private int grade;
    private String birthDate;
    private boolean emailVerified;

    private String googleId;
}
