package com.project.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.project.pja.databases.MyConnection;

@Component
public class TicketingInitializer implements CommandLineRunner {
    
    @Autowired
    private TicketingConfigProperties ticketingConfig;
    
    @Override
    public void run(String... args) throws Exception {
        Ticketing.setToken(ticketingConfig.getToken());
        Ticketing.setUrlBackOffice(ticketingConfig.getUrl());
    }
}