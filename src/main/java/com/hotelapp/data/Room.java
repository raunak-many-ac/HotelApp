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
public class Room {
    @Id
    private String roomId;
    private String roomNumber;
    private String hotelId;
    private boolean isBooked;
    private String bookingId;
    private String roomType;
    private String capacity;
    private Date lastModified;
}
