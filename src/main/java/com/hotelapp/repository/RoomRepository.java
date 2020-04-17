package com.hotelapp.repository;

import com.hotelapp.data.Hotel;
import com.hotelapp.data.Room;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoomRepository extends MongoRepository<Room,String> {
    Room findByRoomId(String roomId);
    Room findByBookingId(String bookingId);
    List<Room> getAllByBookingIdNotInAndHotelId(List<String> roomIds,String hotelId);
    List<Room> getAllBy();
    List<Room> getAllByHotelId(String hotelId);
}
