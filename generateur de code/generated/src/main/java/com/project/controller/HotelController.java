package com.project.controller;

import java.sql.Connection;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.dto.HotelDTO;
import com.project.model.table.Hotel;
import com.project.pja.databases.MyConnection;
import com.project.pja.databases.generalisation.DB;

@Controller
public class HotelController {

    @GetMapping("/creationHotel")
    public String goToCreate(Model model) {
        Connection connection = null;
        try {
            connection = MyConnection.connect();


            // Aucune donnée à charger

            // Initialiser un DTO vide pour le formulaire
            model.addAttribute("hotelDTO", new HotelDTO());

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
        return "pages/hotel/creation";
    }

    @PostMapping("/saveHotel")
    public String saveHotel(@ModelAttribute HotelDTO hotelDTO, Model model) {
        
        Connection connection = null;
        try {
            // Établir la connexion
            connection = MyConnection.connect();
            
            // Créer l'objet Hotel à partir du DTO
            Hotel hotel = new Hotel();
            hotel.setNom(hotelDTO.getNom());
            hotel.setNom(hotelDTO.getNom());
            
            // Sauvegarder dans la base de données
            DB.save(hotel, connection);
            
            // Message de succès
            model.addAttribute("success", "Hotel enregistré avec succès !");
            model.addAttribute("hotelDTO", new HotelDTO()); // Réinitialiser le formulaire
            
            // Recharger les listes pour les foreign keys
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Erreur lors de l'enregistrement : " + e.getMessage());
            model.addAttribute("hotelDTO", hotelDTO); // Garder les données saisies
            
            // Recharger les listes en cas d'erreur
            try {
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
        
        return "pages/hotel/creation";
    }

    @GetMapping("/listeHotel")
    public String listeHotel(Model model) {
        Connection connection = null;
        try {
            connection = MyConnection.connect();

            // Récupérer la liste des hotels depuis la base
            List<Hotel> hotels = (List<Hotel>) DB.getAll(new Hotel(), connection);

            // Ajouter la liste des hotels au modèle
            model.addAttribute("hotels", hotels);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Erreur lors du chargement des hotels: " + e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return "pages/hotel/listeHotel";
    }
}
