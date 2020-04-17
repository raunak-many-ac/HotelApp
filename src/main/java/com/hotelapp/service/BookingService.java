package com.hotelapp.service;

import com.hotelapp.data.Booking;
import com.hotelapp.data.Room;
import com.hotelapp.repository.BookingRepository;
import com.hotelapp.repository.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookingService {

    @Autowired
    BookingRepository bookingRepository;

    @Autowired
    RoomRepository roomRepository;

    public List<Room> getAllAvailableRooms(Date startDate,Date endDate,String hotelId){
        List<Booking> bookings = bookingRepository.getAllByCheckInBetweenOrCheckOutBetween(startDate,endDate,startDate,endDate);
        List<String> roomIds = bookings.stream().map(Booking::getRoomId).collect(Collectors.toList());
        return roomRepository.getAllByBookingIdNotInAndHotelId(roomIds,hotelId);
    }

    public List<Booking> getAllBookings(Date startDate,Date endDate,String hotelId){
        return bookingRepository.getAllByCheckInBetweenOrCheckOutBetween(startDate,endDate,startDate,endDate);
    }

    public List<Booking> getAllBookingForVisitor(String name)
    {
        return bookingRepository.findByVisitorName(name);
    }
}
