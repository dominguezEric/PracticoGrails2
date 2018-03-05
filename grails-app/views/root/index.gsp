<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Simple markers</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <asset:stylesheet href="index.css"/>
    <asset:javascript src="inde"/>
</head>
<body>
    <div class="container">
        <h1 class="text-center"> Buscar Agencia </h1>
        <div class="row limit-w">
            <div class="col-*-*">
                <g:form resource="${this.root}" method="POST" controller="root" action="search">
                    <fieldset class="form">
                        <div class="form-group">
                            <label for="direccion">Direccion:</label>
                            <input type="text" class="form-control" name="direccion" id="direccion" placeholder="Ingrese su direccion" value= "Lima 78, Córdoba Argentina" required/>
                        </div>
                        <div class="form-group">
                            <label for="formasPagoId">Formas de pago:</label>
                            <g:select class="form-control" name="formasPagoId" id="formasPagoId" from="${lista}" optionValue="${{it.name?.toUpperCase()}}" optionKey="${{it.id}}"   />
                        </div>
                        <div class="form-group">
                            <label for="radio">Distancia:</label>
                            <input type="number" id="radio" class="form-control" name="radio" placeholder="La distancia maxima" value="1000" required/>
                        </div>
                        <div class="form-group">
                            <label for="cantidad">cantidad Agencia:</label>
                            <input type="number" id="cantidad" class="form-control" name="cantidad" placeholder="La cantidad maxima" value="100" required/>
                        </div>
                        <div class="form-group">
                            <button type="submit" value="Submit">Buscar</button>
                        </div>
                    </fieldset>
                </g:form>
            </div>
        </div>
    </div>
</body>
</html>