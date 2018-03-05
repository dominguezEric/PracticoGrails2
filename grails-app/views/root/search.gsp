<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">

    <meta charset="utf-8">
    <title>Simple markers</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap.min.css">
    <asset:stylesheet href="search.css"/>

</head>
<body>
    <div class="container">
        <h1 class="text-center"> Agencias encontradas</h1>
        <br>
        <div class="row">
            <div class="col-sm-12">
                <div id="map"></div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-*-*">
                <table id="example" class="display" cellspacing="0" width="100%">
                    <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Distancia</th>
                        <th> </th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>Nombre</th>
                        <th>Distancia</th>
                        <th> </th>
                    </tr>
                    </tfoot>
                    <tbody>
                    <g:each in="${lista}" var="p">
                        <tr>
                            <td>${p.description}</td>
                            <td>${p.distance}</td>
                            <td> <img class="raton" onclick="dialog('${p.id}')" src="https://www.catalogolatampass.com.ar/shell/Empresarios/images/lupa.png" alt="Lupa" height="30" width="30"></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div id="myModal" class="modal">

        <!-- Modal content -->
        <div class="modal-content">
            <div class="modal-header">
                <span class="close">&times;</span>
                <h2 id="m-titulo">Modal Header</h2>
            </div>
            <div class="modal-body" id="m-contenido">
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap.min.js"></script>
    <script>

        $('#example').DataTable({
            "order": [[ 1, "asc" ]]
        });
        <g:applyCodec encodeAs="none">
            var markers = ${markers};
        </g:applyCodec>
        function initMap() {
            var myLatLng = {lat: parseFloat(${latitud}), lng: parseFloat(${longitud})};

            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 13,
                center: myLatLng
            });
            //console.log(markers);
            for(var i = 0; i < markers.length; i++ ) {
                var position = markers[i].address.location.split(",")
                var id =  markers[i].id;
                //console.log(position)
                //var position = new google.maps.LatLng(position[0],[1]);
                marker = new google.maps.Marker({
                    position: {lat:parseFloat(position[0]),lng:parseFloat(position[1])},
                    map: map,
                    title: markers[i].description,
                });
                marker.addListener('click', function () {
                    //console.log(id);
                    dialog(id);
                });
                marker.addListener('mouseover', function () {
                    if (this.getAnimation() == null) {
                        this.setAnimation(google.maps.Animation.BOUNCE);
                    }
                });
                marker.addListener('mouseout', function () {
                    if (this.getAnimation() !== null) {
                        this.setAnimation(null);
                    }
                });

            }
        }


        // Get the modal
        var modal = document.getElementById('myModal');

        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];



        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        function dialog (id) {
            ////console.log(id);
            $.each(markers, function(i, v) {
                if (v.id == id) {
                    //alert(v.id);
                    $("#m-titulo").text(v.description);
                    $("#m-temp").remove();
                    $("#m-contenido").append("<div id='m-temp'></div>");
                    $("#m-temp").append("<li> Distancia         : "+ v.distance +" </li>")
                    $("#m-temp").append("<li> Formas de pago    : "+v.payment_method_id +"</li>")
                    $("#m-temp").append("<li> Numero de agencia : "+v.agency_code +"</li>")

                    $("#m-temp").append("<li> Telefono       : "+v.phone +"</li>")
                    $("#m-temp").append("<li> Provincia      : "+v.address.state +"</li>")
                    $("#m-temp").append("<li> Ciudad         : "+v.address.city +"</li>")
                    $("#m-temp").append("<li> Pais           : "+v.address.country +"</li>")
                    $("#m-temp").append("<li> Codigo zip     : "+v.address.zip_code +"</li>")
                    $("#m-temp").append("<li> Otra info      : "+v.address.other_info +"</li>")
                    $("#m-temp").append("<br>");
                    $("#m-temp").append("<div id= 'mapaParticular'></div>");
                    var position = markers[i].address.location.split(",")
                    var map = new google.maps.Map(document.getElementById('mapaParticular'), {
                        zoom: 15,
                        center: {lat:parseFloat(position[0]),lng:parseFloat(position[1])}
                    });
                    marker = new google.maps.Marker({
                        position: {lat:parseFloat(position[0]),lng:parseFloat(position[1])},
                        map: map,
                        title: markers[i].description,
                        animation: google.maps.Animation.BOUNCE
                    });
                    return;
                }
            });
            modal.style.display = "block";
        }

    </script>
    <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB7LgMCbgsQ_4TfgKoN42aH_PmVRfotVLE&callback=initMap">
    </script>

</body>
</html>
