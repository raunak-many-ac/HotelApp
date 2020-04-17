package com.hotelapp.repository;

import com.hotelapp.data.Credential;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface CredentialRepository extends MongoRepository<Credential, String> {
    Credential findByEmailAndPassword(String email, String password);
    Credential findByEmail(String email);
}
