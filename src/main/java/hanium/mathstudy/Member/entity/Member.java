package hanium.mathstudy.Member.entity;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Member {
    private String name;
    private String email;
    private String login_id;
    private String login_pwd;
    private String nickname;
    private String birthDate;
    private int grade;
    private boolean emailVerified;

    private String googleId;
}
