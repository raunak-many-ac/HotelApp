package com.hotelapp;


import com.hotelapp.data.Hotel;
import com.hotelapp.repository.HotelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.UUID;


@SpringBootApplication
public class HotelAppApplication {

    @Autowired
    HotelRepository hotelRepository;

    public static void main(String[] args) throws Exception {
        SpringApplication.run(HotelAppApplication.class, args);


    }
}
