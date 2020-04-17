package com.hotelapp.controllers;

import com.hotelapp.data.Hotel;
import com.hotelapp.data.Room;
import com.hotelapp.data.User;
import com.hotelapp.repository.HotelRepository;
import com.hotelapp.repository.RoomRepository;
import com.hotelapp.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class HomeController {

    @Autowired
    HotelRepository hotelRepository;

    @Autowired
    RoomRepository roomRepository;

    @Autowired
    UserRepository userRepository;

    @GetMapping("/")
    public String startPage(){
        return "Your Application is running on web.....";
    }

    @GetMapping("/getHotel/{hotelId}")
    public Hotel getHotel(@PathVariable("hotelId") String hotelId)
    {
        return hotelRepository.findByHotelId(hotelId);
    }

    @PostMapping("/getAllRooms")
    private List<Room> getAllRooms(String email)
    {
        if (!isUser(email))
            return null;
        return roomRepository.getAllBy();
    }

    @PostMapping("/getRooms")
    private  List<Room> getRooms(String email,String hotelId)
    {
        if (!isUser(email))
            return null;
        return roomRepository.getAllByHotelId(hotelId);
    }

    @PostMapping("/getRoom")
    private Room getRoom(String email,String roomId)
    {
        if (!isUser(email))
            return null;
        return roomRepository.findByRoomId(roomId);
    }

    private boolean isUser(String email)
    {
        User user = userRepository.getByEmail(email);
        return user != null;
    }
}
