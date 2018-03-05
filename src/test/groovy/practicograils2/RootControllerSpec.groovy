package practicograils2

import grails.testing.web.controllers.ControllerUnitTest
import groovy.json.JsonSlurper
import spock.lang.Specification

class RootControllerSpec extends Specification implements ControllerUnitTest<RootController> {

    def setup() {
    }

    def cleanup() {
    }

    def 'Test the index action returns the correct model'() {
        given:

        List lista = [ "pagofacil", "Pago facil","ticket" ]
        controller.meliService = Stub(MeliService) {
            paymentMethods() >> lista
        }

        when: 'The index action is executed'
        def respuesta = controller.index()

        then: 'The model is correct'
        respuesta.lista
        respuesta.lista.size() == 3
        respuesta.lista[0] == "pagofacil"
        respuesta.lista[1] == "Pago facil"
        respuesta.lista[2] == "ticket"
        view == "/root/index.gsp"
        //respuesta.id ="pagofacil"
        //response == 3
    }

    def 'Test the search action returns the correct model'() {
        given:

        List lista = [ [location:[lat:20,lng:30]] ]
        List lista2 = [ "agente1","agente2","agente3","agente4" ]
        controller.mapService = Stub(MapService) {
            geolocation(_) >> lista
        }
        controller.meliService = Stub(MeliService) {
            agente(_,_) >> lista2
        }

        when: 'The index action is executed'
        def respuesta = controller.search()

        then: 'The model is correct'
        respuesta.lista
        respuesta.lista.size() == 4
        respuesta.lista[0] == "agente1"
        respuesta.lista[1] == "agente2"
        respuesta.lista[2] == "agente3"
        respuesta.lista[3] == "agente4"
        respuesta.markers != null
        respuesta.latitud == 20
        respuesta.longitud == 30
        view == "/root/search.gsp"
    }
}
