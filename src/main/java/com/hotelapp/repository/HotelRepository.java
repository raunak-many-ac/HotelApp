package com.hotelapp.repository;

import com.hotelapp.data.Hotel;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HotelRepository extends MongoRepository<Hotel,String> {
     Hotel findAllBy();
     List<Hotel> getAllBy();
     Hotel findByHotelId(String hotelId);
}
