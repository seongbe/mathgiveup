package hanium.mathstudy.user.entity;

import lombok.*;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class User {
    private String id;
    private String name;
    private String password;
    private String email;
}
