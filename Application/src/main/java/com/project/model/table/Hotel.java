package com.project.model.table;

import java.util.Date;

import com.project.pja.databases.generalisation.annotation.AttributDb;
import com.project.pja.databases.generalisation.annotation.IdDb;
import com.project.pja.databases.generalisation.annotation.TableDb;


@TableDb(name = "hotel")
public class Hotel {

    @IdDb
    @AttributDb(name = "id")
    private String id;

    @AttributDb(name = "nom")
    private String nom;

   
    public Hotel() {
    }


    public String getId() {
        return id;
    }


    public void setId(String id) {
        this.id = id;
    }


    public String getNom() {
        return nom;
    }


    public void setNom(String nom) {
        this.nom = nom;
    }
    public Hotel(String nom) {
        this.id = id;
        this.nom = nom;
    }


}
