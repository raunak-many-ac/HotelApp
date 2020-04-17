package com.hotelapp.data;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

import java.util.Date;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Booking {

    @Id
    private String bookingId;
    private String visitorEmail;
    private String visitorName;
    private String hotelName;
    private String roomNumber;
    private String roomId;
    private String no_of_guests;
    private Date checkIn;
    private Date checkOut;
}
