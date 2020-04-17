package com.hotelapp.controllers;

import com.hotelapp.data.*;
import com.hotelapp.repository.*;
import com.hotelapp.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("/admin")
public class AdminRestController {

    @Autowired
    CredentialRepository credentialRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    HotelRepository hotelRepository;

    @Autowired
    RoomRepository roomRepository;

    @Autowired
    BookingRepository bookingRepository;

    @Autowired
    BookingService bookingService;

    private boolean isAdmin(String email)
    {
        User admin = userRepository.getByEmail(email);
        return (admin.getUserType()).equals(User.ADMIN);
    }

    @PostMapping("/addRoomType")
    private String addRoomType(String email, String roomType)
    {

        if(!isAdmin(email))
            return "You are not authorized";

        roomType = roomType.toUpperCase();
        User admin = userRepository.getByEmail(email);
        String hotelId = admin.getHotelID();
        Hotel hotel = hotelRepository.findByHotelId(hotelId);
        hotel.getRoomTypes().add(roomType);
        hotelRepository.save(hotel);
        return "New Room Type added";
    }

    @PostMapping("/deleteRoomType")
    private String deleteRoomType(String email, String roomType)
    {
        if(!isAdmin(email))
            return "You are not authorized";

        roomType = roomType.toUpperCase();
        User admin = userRepository.getByEmail(email);
        String hotelId = admin.getHotelID();
        Hotel hotel = hotelRepository.findByHotelId(hotelId);
        hotel.getRoomTypes().remove(roomType);
        hotelRepository.save(hotel);
        return "Room Type removed";
    }

    @PostMapping("/editRoom")
    private String changeCapacity(String email, String roomId,String newCapacity,String newRoomType)
    {
        if(!isAdmin(email))
            return "You are not authorized";

        Room room = roomRepository.findByRoomId(roomId);
        room.setCapacity(newCapacity);
        room.setRoomType(newRoomType);
        Calendar calobj = Calendar.getInstance();
        room.setLastModified(calobj.getTime());
        roomRepository.save(room);
        return "Room capacity changed";
    }

    @PostMapping("/addRoom")
    private String addRoom(String email,String hotelId,String roomNumber,String roomType,String capacity) {

        if (!isAdmin(email))
            return "You are not authorized";

        Room room;
        Calendar calobj = Calendar.getInstance();
        room = Room.builder().roomId(UUID.randomUUID().toString())
                .roomNumber(roomNumber)
                .hotelId(hotelId)
                .bookingId(null)
                .isBooked(false)
                .roomType(roomType)
                .capacity(capacity)
                .lastModified(calobj.getTime())
            .build();
        roomRepository.save(room);
        return "New Room added";
    }

    //..this method is only for test purpose
    @GetMapping("/putdata")
    private String addData()
    {
        String hotelId = UUID.randomUUID().toString();
        Credential cred = Credential.builder().email("hotel1_admin@gmail.com")
                .password("a")
                .build();
        credentialRepository.save(cred);
        User user = User.builder()
                .hotelID(hotelId)
                .phone("9089786756")
                .userType(User.ADMIN)
                .name("admin1")
                .email("hotel1_admin@gmail.com")
                .build();
        userRepository.save(user);

        Hotel hotel = Hotel.builder()
                .hotelId(hotelId)
                .hotelName("HOTEL 1")
                .adress("address 1")
                .phone("9089786756")
                .roomTypes(new HashSet<>())
                .build();
        hotelRepository.save(hotel);
        return "done";
    }

    @PostMapping("/getBooking")
    private Booking getBooking(String email,String bookingid)
    {
        if (!isAdmin(email))
            return null;
        return bookingRepository.findByBookingId(bookingid);
    }

    @PostMapping("/getVisitor")
    private User getVisitor(String email,String visitorEmail)
    {
        if(!isAdmin(email))
            return null;
        return userRepository.getByEmail(visitorEmail);
    }

    @PostMapping("/getBookings")
        private List<Booking> getBookings(String email,String hotelId,String checkIn,String checkOut) throws Exception
    {
        if(!isAdmin(email))
            return null;

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date_checkIn = format.parse(checkIn);
        Date date_checkOut = format.parse(checkOut);
        return bookingService.getAllBookings(date_checkIn,date_checkOut,hotelId);
    }

    @PostMapping("/getBookingForVisitor")
    private List<Booking> getBookingsForVisitor(String email,String name) throws Exception
    {
        if(!isAdmin(email))
            return null;
        return bookingService.getAllBookingForVisitor(name);
    }

}
