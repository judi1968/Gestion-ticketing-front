package com.project.configuration;

public class Ticketing {
    public static String token;
    public static String urlBackOffice;

    public static String getUrlBackOffice() {
        return urlBackOffice;
    }

    public static void setUrlBackOffice(String urlBackOffice) {
        Ticketing.urlBackOffice = urlBackOffice;
    }

    public static String getToken() {
        return token;
    }

    public static void setToken(String token) {
        Ticketing.token = token;
    }
}
