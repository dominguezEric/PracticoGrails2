package practicograils2

import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper

@Transactional
class MapService {

    def geolocation(params){
        def address1= URLEncoder.encode(params.direccion, "UTF-8")
        def url = new URL('https://maps.googleapis.com/maps/api/geocode/json?address='+address1+'&key=AIzaSyB7LgMCbgsQ_4TfgKoN42aH_PmVRfotVLE')
        def connection = (HttpURLConnection)url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozzilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def lista  = json.parse(connection.getInputStream())
        def e =  lista.results.geometry*.findAll { 'location' in it.key }
        return e
    }
}
