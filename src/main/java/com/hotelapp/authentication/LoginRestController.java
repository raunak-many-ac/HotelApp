package com.hotelapp.authentication;

import com.hotelapp.data.Credential;
import com.hotelapp.data.User;
import com.hotelapp.repository.CredentialRepository;
import com.hotelapp.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/login")
public class LoginRestController {

    @Autowired
    CredentialRepository credentialRepository;

    @Autowired
    UserRepository userRepository;

    @PostMapping("/visitor")
    private User visitorLogin(String email,String password)
    {
        Credential cred = credentialRepository.findByEmailAndPassword(email,password);
        if(cred == null)
            return null;

        User user = userRepository.getByEmail(email);
        if(user.getUserType().equals(User.VISITOR))
            return user;
        return null;
    }

    @PostMapping("/admin")
    private User adminLogin(String email,String password)
    {
        Credential cred = credentialRepository.findByEmailAndPassword(email,password);
        if(cred == null)
            return null;

        User user = userRepository.getByEmail(email);
        if(user.getUserType().equals(User.ADMIN))
            return user;

        return null;
    }


}
