package com.project.model.table;


import java.util.Date;

import com.project.pja.databases.generalisation.annotation.AttributDb;
import com.project.pja.databases.generalisation.annotation.IdDb;
import com.project.pja.databases.generalisation.annotation.ShowTable;
import com.project.pja.databases.generalisation.annotation.TableDb;

@TableDb(name = "reservation")
public class Reservation {

    @IdDb
    @AttributDb(name = "id")
    private String id;

  

    @AttributDb(name = "id_client")
    private String idClient;

   
    @AttributDb(name = "nb_passsager")
    private Integer nbPasssager;

    
    @AttributDb(name = "date_heure_arrive")
    private Date dateHeureArrive;


    @AttributDb(name = "id_hotel")
    private Hotel hotel; // ← objet Hotel

    public Reservation() {
    }

    public Reservation(String id, String idClient, Integer nbPasssager, Date dateHeureArrive,  Hotel hotel) {
        this.id = id;
        this.idClient = idClient;
        this.nbPasssager = nbPasssager;
        this.dateHeureArrive = dateHeureArrive;
        this.hotel = hotel;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public Integer getNbPasssager() {
        return nbPasssager;
    }

    public void setNbPasssager(Integer nbPasssager) {
        this.nbPasssager = nbPasssager;
    }

    public Date getDateHeureArrive() {
        return dateHeureArrive;
    }

    public void setDateHeureArrive(Date dateHeureArrive) {
        this.dateHeureArrive = dateHeureArrive;
    }

    public Hotel getHotel() {
        return hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }
    @ShowTable(name = "ID Réservation" , numero = 1)
    public String getIdString() {
        return id;
    }
    @ShowTable(name = "ID Client" , numero = 2)
    public String getIdClientString() {
        return idClient;
    }
    @ShowTable(name = "Nombre de passagers" , numero = 3)
    public Integer getNbPasssagerInt() {
        return nbPasssager;
    }
    @ShowTable(name = "Date d'arrivée" , numero = 4)
    public Date getDateHeureArriveDate() {
        return dateHeureArrive;
    }
     @ShowTable(name = "Hotel" , numero = 5)
    public String getNomHotel() {
        return hotel != null ? hotel.getNom() : "N/A";
    }


}
