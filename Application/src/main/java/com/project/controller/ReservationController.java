package com.project.controller;


import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.If;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.project.model.table.Hotel;
import com.project.model.table.Reservation;
import com.project.pja.databases.generalisation.DB;


@Controller
public class ReservationController {

/**
 * @param model
 * @return
 * @throws Exception 
 */
@GetMapping("/")
public String showReservationListe(@RequestParam(required = false) String date_reservation, Model model) throws Exception {

    List<Reservation> reservations = new ArrayList<>();


    Hotel h1 = new Hotel( "Hotel Paradise");
    Hotel h2 = new Hotel("Ocean View");
    Hotel h3 = new Hotel( "Mountain Lodge");

    reservations.add(new Reservation("R001", "CL001", 2, new Date(System.currentTimeMillis()), h1));
    reservations.add(new Reservation("R002", "CL002", 4, new Date(System.currentTimeMillis()), h2));
    reservations.add(new Reservation("R003", "CL003", 1, new Date(System.currentTimeMillis()), h1));
    reservations.add(new Reservation("R004", "CL004", 3, new Date(System.currentTimeMillis()), h3));
    reservations.add(new Reservation("R005", "CL005", 5, new Date(System.currentTimeMillis()), h2));
    String a = "";
    if(date_reservation != null) {
        Date date = Date.valueOf(date_reservation);
       List<Reservation> filteredReservations = Reservation.getReservationByDate(reservations, date);
        model.addAttribute("ca",date.toString()) ;

       
       a = DB.getTableau(filteredReservations, new Reservation(), "Liste reservation", "");
    }

    else {
        a = DB.getTableau(reservations, new Reservation(), "Liste reservation", "");
    }
    model.addAttribute("as", a);
    return "pages/reservation/list";
}




    
}
