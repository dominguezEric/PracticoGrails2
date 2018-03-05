package practicograils2

import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper

@Transactional
class MeliService {

    def paymentMethods() {
        def lista=[]
        try {
            def url = new URL('https://api.mercadolibre.com/sites/MLA/payment_methods')
            def connection = (HttpURLConnection) url.openConnection()
            connection.setRequestMethod("GET")
            connection.setRequestProperty("Accept", "application/json")
            connection.setRequestProperty("User-Agent", "Mozzilla/5.0")
            JsonSlurper json = new JsonSlurper()
            lista = json.parse(connection.getInputStream()).findAll { x -> x.payment_type_id == "ticket" }
        }catch (UnknownHostException e){
            System.err.println("Error en la traida del paymentMethods")
        }
        return lista;
    }

    def agente (params , latLng){
        def lista=[]
        try {
            def url1 = new URL('https://api.mercadolibre.com/sites/MLA/payment_methods/' + params.formasPagoId + '/agencies?near_to=' + latLng[0].location.lat + ',' + latLng[0].location.lng + ',' + params.radio + '&limit=' + params.cantidad + '&sort_by=distance,desc')
            def connection1 = (HttpURLConnection) url1.openConnection()
            connection1.setRequestMethod("GET")
            connection1.setRequestProperty("Accept", "application/json")
            connection1.setRequestProperty("User-Agent", "Mozzilla/5.0")
            JsonSlurper json1 = new JsonSlurper()
            lista = json1.parse(connection1.getInputStream())
        }catch (UnknownHostException e){
            System.err.println("Error en la traida del paymentMethods")
            lista = [[results:""]]
        }
        return lista.results
    }
}
