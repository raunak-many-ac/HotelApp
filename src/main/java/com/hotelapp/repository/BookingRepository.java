package com.hotelapp.repository;

import com.hotelapp.data.Booking;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface BookingRepository extends MongoRepository<Booking,String> {
    List<Booking> getAllByCheckInBetweenOrCheckOutBetween(Date checkin1, Date checkout1,Date checkin2,Date checkout2);
    Booking findByBookingId(String bookingId);
    List<Booking> getAllByCheckOutIsBefore(Date checkIn);
    List<Booking> findByVisitorName(String name);
}
