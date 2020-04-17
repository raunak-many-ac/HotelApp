package com.hotelapp.data;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

    public static final String ADMIN = "ADMIN";
    public static final String VISITOR = "VISITOR";

    @Id
    private String email;
    private String name;
    private String userType;
    private String phone;
    private String hotelID;

}
