package hanium.mathstudy.Member.entity;

import lombok.*;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class Member {
    private String id;
    private String name;
    private String password;
}
