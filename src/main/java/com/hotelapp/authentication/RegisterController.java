package com.hotelapp.authentication;

import com.hotelapp.data.Credential;
import com.hotelapp.data.User;
import com.hotelapp.repository.CredentialRepository;
import com.hotelapp.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RegisterController {

    @Autowired
    CredentialRepository credentialRepository;

    @Autowired
    UserRepository userRepository;

    @PostMapping("/register")
    public User registerUser(String email,String password,String name,String phone)
    {
        Credential credential = Credential.builder().email(email).password(password).build();
        User user = User.builder().email(email).name(name).phone(phone).userType(User.VISITOR).build();
        userRepository.save(user);
        credentialRepository.save(credential);
        return user;
    }
}
