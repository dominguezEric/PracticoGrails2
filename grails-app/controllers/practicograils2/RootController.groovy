package practicograils2

import grails.converters.JSON

class RootController {

    MapService mapService
    MeliService meliService

    def index() {
        [lista: meliService.paymentMethods() ]
    }

    def search (){
        def latLng = mapService.geolocation(params)
        def lista1 = meliService.agente(params,latLng)
        [lista: lista1, markers: lista1 as JSON ,latitud:latLng[0].location.lat ,longitud:latLng[0].location.lng  ]
    }

}