<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.project.model.table.Hotel" %>
<%@ page import="com.project.model.table.Hotel" %>
<%@ page import="com.project.model.table.Hotel" %>
<%@ page import="com.project.model.table.Hotel" %>
<%@ page import="com.project.model.table.Hotel" %>
<%@ page import="com.project.model.table.Hotel" %>
<%@ page import="com.project.model.table.Hotel" %>
<%@ page import="com.project.model.table.Hotel" %>
<%
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
    List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <ma`et name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Creation Reservation</title>
    <%@ include file="../../includes/css.jsp" %>
  </head>
  <body>
    <div class="container-scroller">
      <%@ include file="../../includes/navbar.jsp" %>
      <div class="container-fluid page-body-wrapper">
        <%@ include file="../../includes/header.jsp" %>
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="page-header">
              <h3 class="page-title">Creation Reservation</h3>
            </div>
            
            <!-- Messages d'alerte -->
            <% if (success != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
              <%= success %>
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <% } %>
            
            <% if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
              <%= error %>
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <% } %>
            
            <div class="row">
              <div class="col-md-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">Création de Reservation</h4>
                    <p class="card-description">Ajouter un nouveau reservation</p>
                    <form class="forms-sample" action="saveReservation" method="post">
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group row">
                            <label for="idClient" class="col-sm-3 col-form-label">IdClient</label>
                            <div class="col-sm-9">
                              <input type="text" class="form-control" id="idClient" name="idClient" required>
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="idClient" class="col-sm-3 col-form-label">IdClient</label>
                            <div class="col-sm-9">
                              <input type="text" class="form-control" id="idClient" name="idClient" required>
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="nbPasssager" class="col-sm-3 col-form-label">NbPasssager</label>
                            <div class="col-sm-9">
                              <input type="number" class="form-control" id="nbPasssager" name="nbPasssager" required>
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="nbPasssager" class="col-sm-3 col-form-label">NbPasssager</label>
                            <div class="col-sm-9">
                              <input type="number" class="form-control" id="nbPasssager" name="nbPasssager" required>
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="dateHeureArrive" class="col-sm-3 col-form-label">DateHeureArrive</label>
                            <div class="col-sm-9">
                              <input type="datetime-local" class="form-control" id="dateHeureArrive" name="dateHeureArrive" required>
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="dateHeureArrive" class="col-sm-3 col-form-label">DateHeureArrive</label>
                            <div class="col-sm-9">
                              <input type="datetime-local" class="form-control" id="dateHeureArrive" name="dateHeureArrive" required>
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="hotel" class="col-sm-3 col-form-label">Hotel</label>
                            <div class="col-sm-9">
                              <select class="form-control" id="hotel" name="hotelId" required>
                                <option value="">Sélectionnez un Hotel</option>
                                <% if (hotels != null) {
                                    for (Hotel hotel : hotels) { 
%>
                                <option value="<%= hotel.getId() %>"> 
                                       
                                  <%= hotel.getNom() != null ? hotel.getNom() : "ID: " + hotel.getId() %>
                                </option>
<% }
                                } %>
                              </select>
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="hotel" class="col-sm-3 col-form-label">Hotel</label>
                            <div class="col-sm-9">
                              <select class="form-control" id="hotel" name="hotelId" required>
                                <option value="">Sélectionnez un Hotel</option>
                                <% if (hotels != null) {
                                    for (Hotel hotel : hotels) { 
%>
                                <option value="<%= hotel.getId() %>"> 
                                       
                                  <%= hotel.getNom() != null ? hotel.getNom() : "ID: " + hotel.getId() %>
                                </option>
<% }
                                } %>
                              </select>
                            </div>
                          </div>
                        </div>
                      </div>
                      <button type="submit" class="btn btn-primary me-2">Enregistrer</button>
                      <a href="listeReservation" class="btn btn-dark">Annuler</a>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <%@ include file="../../includes/footer.jsp" %>
        </div>
      </div>
    </div>
    <%@ include file="../../includes/js.jsp" %>
  </body>
</html>
