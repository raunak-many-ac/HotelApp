package com.hotelapp.repository;

import com.hotelapp.data.User;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface UserRepository extends MongoRepository<User, String> {
     User getByEmail(String email);

}
