package com.project.model.table;

import com.project.model.table.Hotel;
import com.project.pja.databases.generalisation.annotation.AttributDb;
import com.project.pja.databases.generalisation.annotation.IdDb;
import com.project.pja.databases.generalisation.annotation.TableDb;
import java.util.Date;

@TableDb(name = "reservation")
public class Reservation {

    @IdDb
    @AttributDb(name = "id")
    private String id;

    @IdDb
    @AttributDb(name = "id")
    private String id;

    @AttributDb(name = "id_client")
    private String idClient;

    @AttributDb(name = "id_client")
    private String idClient;

    @AttributDb(name = "nb_passsager")
    private Integer nbPasssager;

    @AttributDb(name = "nb_passsager")
    private Integer nbPasssager;

    @AttributDb(name = "date_heure_arrive")
    private Date dateHeureArrive;

    @AttributDb(name = "date_heure_arrive")
    private Date dateHeureArrive;

    @AttributDb(name = "id_hotel")
    private Hotel hotel; // ← objet Hotel

    @AttributDb(name = "id_hotel")
    private Hotel hotel; // ← objet Hotel

    public Reservation() {
    }

    public Reservation(int id, String idClient, String idClient, Integer nbPasssager, Integer nbPasssager, Date dateHeureArrive, Date dateHeureArrive, Hotel hotel, Hotel hotel) {
        this.id = id;
        this.idClient = idClient;
        this.idClient = idClient;
        this.nbPasssager = nbPasssager;
        this.nbPasssager = nbPasssager;
        this.dateHeureArrive = dateHeureArrive;
        this.dateHeureArrive = dateHeureArrive;
        this.hotel = hotel;
        this.hotel = hotel;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        if (id != null && id.trim().length() > 0)
            this.id = id;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        if (id != null && id.trim().length() > 0)
            this.id = id;
    }

    public String getIdClient() {
        return this.idClient;
    }

    public void setIdClient(String idClient) {
        if (idClient != null && idClient.trim().length() > 0)
            this.idClient = idClient;
    }

    public String getIdClient() {
        return this.idClient;
    }

    public void setIdClient(String idClient) {
        if (idClient != null && idClient.trim().length() > 0)
            this.idClient = idClient;
    }

    public int getNbPasssager() {
        return this.nbPasssager != null ? this.nbPasssager.intValue() : 0;
    }

    public Integer getNbPasssagerObject() {
        return this.nbPasssager;
    }

    public void setNbPasssager(Integer nbPasssager) {
        this.nbPasssager = nbPasssager;
    }

    public int getNbPasssager() {
        return this.nbPasssager != null ? this.nbPasssager.intValue() : 0;
    }

    public Integer getNbPasssagerObject() {
        return this.nbPasssager;
    }

    public void setNbPasssager(Integer nbPasssager) {
        this.nbPasssager = nbPasssager;
    }

    public Date getDateHeureArrive() {
        return this.dateHeureArrive;
    }

    public void setDateHeureArrive(Date dateHeureArrive) {
        this.dateHeureArrive = dateHeureArrive;
    }

    public Date getDateHeureArrive() {
        return this.dateHeureArrive;
    }

    public void setDateHeureArrive(Date dateHeureArrive) {
        this.dateHeureArrive = dateHeureArrive;
    }

    public Hotel getHotel() {
        return this.hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }

    public Hotel getHotel() {
        return this.hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }

}
