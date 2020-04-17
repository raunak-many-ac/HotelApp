package com.hotelapp.controllers;

import com.hotelapp.data.Booking;
import com.hotelapp.data.Hotel;
import com.hotelapp.data.Room;
import com.hotelapp.repository.BookingRepository;
import com.hotelapp.repository.HotelRepository;
import com.hotelapp.repository.RoomRepository;
import com.hotelapp.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/visitor")
public class VisitorRestController {

    @Autowired
    HotelRepository hotelRepository;

    @Autowired
    RoomRepository roomRepository;

    @Autowired
    BookingRepository bookingRepository;

    @Autowired
    BookingService bookingService;

    @PostMapping("/getAllHotels")
    private List<Hotel> getAllHotels()
    {
        return hotelRepository.getAllBy();
    }

    @PostMapping("/bookRoom")
    private Booking bookRoom(String email,String visitorName,String roomId, String no_guest, String checkIn,String checkOut) throws Exception
    {
        Room room = roomRepository.findByRoomId(roomId);
        Hotel hotel = hotelRepository.findByHotelId(room.getHotelId());
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date_checkIn = format.parse(checkIn);
        Date date_checkOut = format.parse(checkOut);
        System.out.println(date_checkIn);
        Booking booking = Booking.builder().bookingId(UUID.randomUUID().toString())
                .visitorEmail(email)
                .hotelName(hotel.getHotelName())
                .visitorName(visitorName)
                .roomId(roomId)
                .roomNumber(room.getRoomNumber())
                .checkIn(date_checkIn)
                .checkOut(date_checkOut)
                .no_of_guests(no_guest)
                .build();

        bookingRepository.save(booking);

        room.setBooked(true);
        room.setBookingId(booking.getBookingId());
        roomRepository.save(room);

        return booking;
    }

    @GetMapping("/test")
    public String test()
    {
        Hotel hotel = Hotel.builder().hotelId(UUID.randomUUID().toString()).hotelName("dummyHotel").adress("bakwaaspur").phone("9089786756").build();
        hotelRepository.save(hotel);
        return "done";
    }

    @PostMapping("/getRooms")
    public List<Room> getAvailableRoomsByDate(String startDate,String endDate,String hotelId) throws Exception{
        System.out.println("here");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        System.out.println("here1");
        Date date_checkIn = format.parse(startDate);
        Date date_checkOut = format.parse(endDate);
        System.out.println("here2");
        List<Room> rooms = bookingService.getAllAvailableRooms(date_checkIn,date_checkOut,hotelId);
        return rooms;
    }
}
