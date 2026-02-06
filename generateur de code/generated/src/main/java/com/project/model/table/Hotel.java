package com.project.model.table;

import com.project.pja.databases.generalisation.annotation.AttributDb;
import com.project.pja.databases.generalisation.annotation.IdDb;
import com.project.pja.databases.generalisation.annotation.TableDb;

@TableDb(name = "hotel")
public class Hotel {

    @IdDb
    @AttributDb(name = "id")
    private String id;

    @IdDb
    @AttributDb(name = "id")
    private String id;

    @AttributDb(name = "nom")
    private String nom;

    @AttributDb(name = "nom")
    private String nom;

    public Hotel() {
    }

    public Hotel(int id, String nom, String nom) {
        this.id = id;
        this.nom = nom;
        this.nom = nom;
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

    public String getNom() {
        return this.nom;
    }

    public void setNom(String nom) {
        if (nom != null && nom.trim().length() > 0)
            this.nom = nom;
    }

    public String getNom() {
        return this.nom;
    }

    public void setNom(String nom) {
        if (nom != null && nom.trim().length() > 0)
            this.nom = nom;
    }

}
