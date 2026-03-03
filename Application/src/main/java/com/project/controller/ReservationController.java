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
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
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
public String showReservationListe(@RequestParam(required = false) String date_reservation, Model model)
        throws Exception {
    String url = Ticketing.getUrlBackOffice() + "/reservations?dateReservation=" + date_reservation + "&token="
            + Ticketing.getToken();
    System.out.println(url);
    ApiResponse response = restTemplate.getForObject(
            url,
            ApiResponse.class);
    String a = "";
    if (response.getCode() == 200) {
        ObjectMapper objectMapper = new ObjectMapper();

        List<Reservation> reservations = objectMapper.convertValue(response.getData(), new TypeReference<List<Reservation>>(){});
        for (Reservation reservation : reservations) {
            System.out.println(reservation.getId());
        }
        a = DB.getTableau(reservations, new Reservation(), "Liste reservation", "");
        System.out.println("tonga atooo"+ reservations.size());
    }else{
        a = "<div class=\"alert alert-danger alert-dismissible fade show\">\r\n" + //
                        "                    <svg viewBox=\"0 0 24 24\" width=\"24\" height=\"24\" stroke=\"currentColor\" stroke-width=\"2\" fill=\"none\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"me-2\"><polygon points=\"7.86 2 16.14 2 22 7.86 22 16.14 16.14 22 7.86 22 2 16.14 2 7.86 7.86 2\"></polygon><line x1=\"15\" y1=\"9\" x2=\"9\" y2=\"15\"></line><line x1=\"9\" y1=\"9\" x2=\"15\" y2=\"15\"></line></svg>\r\n" + //
                        "                    <strong>Erreur!</strong> "+ (String) response.getData() +"\r\n" + //
                        "                    <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"btn-close\">\r\n" + //
                        "                    </button>\r\n" + //
                        "                </div>";
        System.out.println("tonga eetooo");

    }
    model.addAttribute("as", a);
    return "pages/reservation/list";
}




    
}
