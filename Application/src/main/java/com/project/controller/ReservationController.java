package com.project.controller;


import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.If;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.project.configuration.Ticketing;
import com.project.dto.ApiResponse;
import com.project.model.table.Hotel;
import com.project.model.table.Reservation;
import com.project.pja.databases.generalisation.DB;


@Controller
public class ReservationController {

      private final RestTemplate restTemplate = new RestTemplate();

/**
 * @param model
 * @return
 * @throws Exception 
 */
@GetMapping("/")
public String showReservationListe(@RequestParam(required = false) String date_reservation, Model model) throws Exception {    
  String url = Ticketing.getUrlBackOffice()+"/reservations?dateReservation="+date_reservation+"&token="+Ticketing.getToken();
    System.out.println(url);
        ApiResponse response = restTemplate.getForObject(
            url,
            ApiResponse.class
        );

        List<Reservation> reservations = response.getData();
    String a = "";
  
        a = DB.getTableau(reservations, new Reservation(), "Liste reservation", "");
    
    model.addAttribute("as", a);
    return "pages/reservation/list";
}




    
}
