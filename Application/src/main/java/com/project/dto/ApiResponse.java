package com.project.dto;

import java.util.List;
import com.project.model.table.Reservation;

public class ApiResponse {

    private String status;
    private int code;
    private List<Reservation> data;
    private int count;
    private String message;

    public ApiResponse() {}

    public List<Reservation> getData() {
        return data;
    }

    public void setData(List<Reservation> data) {
        this.data = data;
    }

}
