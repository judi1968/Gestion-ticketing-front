<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.project.model.table.Reservation" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
    String error = (String) request.getAttribute("error");
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Liste des reservations</title>
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
              <h3 class="page-title">Liste des reservations</h3>
            </div>
            
            <% if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
              <%= error %>
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <% } %>
            
            <div class="row">
              <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">Liste des reservations</h4>
                    <p class="card-description">Tous les reservations disponibles</p>
                    <div class="table-responsive">
                      <table class="table table-hover table-striped">
                        <thead>
                          <tr>
                            <th>Id</th>
                            <th>Id</th>
                            <th>IdClient</th>
                            <th>IdClient</th>
                            <th>NbPasssager</th>
                            <th>NbPasssager</th>
                            <th>DateHeureArrive</th>
                            <th>DateHeureArrive</th>
                            <th>IdHotel</th>
                            <th>IdHotel</th>
                          </tr>
                        </thead>
                        <tbody>
                          <% if (reservations != null && !reservations.isEmpty()) {
                               for (Reservation reservation : reservations) { 
%>
                          <tr>
                            <td><%= reservation.getId() %></td>
                            <td><%= reservation.getId() %></td>
                            <td><%= reservation.getIdClient() %></td>
                            <td><%= reservation.getIdClient() %></td>
                            <td><%= reservation.getNbPasssager() %></td>
                            <td><%= reservation.getNbPasssager() %></td>
                            <td>
                              <% if (reservation.getDateHeureArriveObject() != null) { %>
                                <%= sdf.format(reservation.getDateHeureArriveObject()) %>
                              <% } else { %>
                                Non défini
                              <% } %>
                            </td>
                            <td>
                              <% if (reservation.getDateHeureArriveObject() != null) { %>
                                <%= sdf.format(reservation.getDateHeureArriveObject()) %>
                              <% } else { %>
                                Non défini
                              <% } %>
                            </td>
                            <td>
                              <% if (reservation.getHotel() != null) { %>
                                <%= reservation.getHotel().getNom() %>
                              <% } else { %>
                                Non défini
                              <% } %>
                            </td>
                            <td>
                              <% if (reservation.getHotel() != null) { %>
                                <%= reservation.getHotel().getNom() %>
                              <% } else { %>
                                Non défini
                              <% } %>
                            </td>
                          </tr>
<% }
                             } else { %>
                          <tr>
                            <td colspan="10" class="text-center">Aucun reservation trouvé</td>
                          </tr>
                          <% } %>
                        </tbody>
                      </table>
                    </div>
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
