package com.project.controller;

import java.sql.Connection;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.dto.ReservationDTO;
import com.project.model.table.Reservation;
import com.project.model.table.Hotel;
import com.project.model.table.Hotel;
import com.project.model.table.Hotel;
import com.project.model.table.Hotel;
import com.project.model.table.Hotel;
import com.project.model.table.Hotel;
import com.project.model.table.Hotel;
import com.project.model.table.Hotel;
import com.project.pja.databases.MyConnection;
import com.project.pja.databases.generalisation.DB;

@Controller
public class ReservationController {

    @GetMapping("/creationReservation")
    public String goToCreate(Model model) {
        Connection connection = null;
        try {
            connection = MyConnection.connect();


            // Récupérer la liste des hotels
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
            model.addAttribute("hotels", hotels);

            // Initialiser un DTO vide pour le formulaire
            model.addAttribute("reservationDTO", new ReservationDTO());

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Erreur lors du chargement des données: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return "pages/reservation/creation";
    }

    @PostMapping("/saveReservation")
    public String saveReservation(@ModelAttribute ReservationDTO reservationDTO, Model model) {
        
        Connection connection = null;
        try {
            // Établir la connexion
            connection = MyConnection.connect();
            
            // Créer l'objet Reservation à partir du DTO
            Reservation reservation = new Reservation();
            reservation.setIdClient(reservationDTO.getIdClient());
            reservation.setIdClient(reservationDTO.getIdClient());
            reservation.setNbPasssager(reservationDTO.getNbPasssager());
            reservation.setNbPasssager(reservationDTO.getNbPasssager());
            reservation.setDateHeureArrive(reservationDTO.getDateHeureArrive());
            reservation.setDateHeureArrive(reservationDTO.getDateHeureArrive());
            
            // Récupération de l'objet Hotel
            if (reservationDTO.getHotelId() != 0) {
                Hotel hotel = Hotel.getById(reservationDTO.getHotelId(), connection);
                reservation.setHotel(hotel);
            }
            
            // Récupération de l'objet Hotel
            if (reservationDTO.getHotelId() != 0) {
                Hotel hotel = Hotel.getById(reservationDTO.getHotelId(), connection);
                reservation.setHotel(hotel);
            }
            
            // Sauvegarder dans la base de données
            DB.save(reservation, connection);
            
            // Message de succès
            model.addAttribute("success", "Reservation enregistré avec succès !");
            model.addAttribute("reservationDTO", new ReservationDTO()); // Réinitialiser le formulaire
            
            // Recharger les listes pour les foreign keys
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
            model.addAttribute("hotels", hotels);
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
            model.addAttribute("hotels", hotels);
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
            model.addAttribute("hotels", hotels);
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
            model.addAttribute("hotels", hotels);
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
            model.addAttribute("hotels", hotels);
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
            model.addAttribute("hotels", hotels);
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
            model.addAttribute("hotels", hotels);
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
            model.addAttribute("hotels", hotels);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Erreur lors de l'enregistrement : " + e.getMessage());
            model.addAttribute("reservationDTO", reservationDTO); // Garder les données saisies
            
            // Recharger les listes en cas d'erreur
            try {
                List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
                model.addAttribute("hotels", hotels);
                List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
                model.addAttribute("hotels", hotels);
                List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
                model.addAttribute("hotels", hotels);
                List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
                model.addAttribute("hotels", hotels);
                List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
                model.addAttribute("hotels", hotels);
                List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
                model.addAttribute("hotels", hotels);
                List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
                model.addAttribute("hotels", hotels);
                List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);
                model.addAttribute("hotels", hotels);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        
        return "pages/reservation/creation";
    }

    @GetMapping("/listeReservation")
    public String listeReservation(Model model) {
        Connection connection = null;
        try {
            connection = MyConnection.connect();

            // Récupérer la liste des reservations depuis la base
            List<Reservation> reservations = (List<Reservation>) DB.getAll(new Reservation(), connection);

            // Ajouter la liste des reservations au modèle
            model.addAttribute("reservations", reservations);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Erreur lors du chargement des reservations: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return "pages/reservation/listeReservation";
    }
}
