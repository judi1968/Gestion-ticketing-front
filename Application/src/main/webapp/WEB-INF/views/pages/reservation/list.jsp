
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Liste des voitures par voyage</title>
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
              <h3 class="page-title">Liste des voitures par voyage</h3>
            </div>
            
            <div class="row">
              <div class="col-md-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">Filtre</h4>
                    <form class="forms-sample" action="/" method="get">
                      <div class="row">
                        <div class="col-md-6">
                         
                          <div class="form-group row">
                            <label for="dateDiffusion" class="col-sm-3 col-form-label">Chosir Date</label>
                            <div class="col-sm-9">
                              <input type="date" class="form-control" id="dateDiffusion" name="date_reservation" >
                            </div>
                            <h1>            <%= (String) request.getAttribute("ca")  %>
</h1>
                          </div>
                  
                        </div>
                      </div>
                      <button type="submit" class="btn btn-primary me-2">Chercher</button>
                    </form>
                  </div>
                </div>
              </div>
            </div>

            <%= (String) request.getAttribute("as")  %>
       

            
          </div>
          <%@ include file="../../includes/footer.jsp" %>
        </div>
      </div>
    </div>
    <%@ include file="../../includes/js.jsp" %>
  </body>
</html>