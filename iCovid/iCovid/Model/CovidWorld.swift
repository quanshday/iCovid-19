//
//  CovidWorld.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import Foundation
import SwiftyJSON

struct CovidWorld{
    
    var country: String = ""
    var cases: Int?
    var todayCases : Int?
    var deaths : Int?
    var todayDeaths: Int?
    var recovered: Int?
    var todayRecovered: Int?
    var active: Int?
    var critical: Int?
    var casesPerOneMillion: Int?
    var deathsPerOneMillion: Int?
    var test: Int?
    var testsPerOneMillion: Int?
    var poplulation: Int?
    var continent: String = ""
    var oneCasePerPeole: Int?
    var oneDeathPerPeole: Int?
    var activePerOneMillion: Int?
    var recoveredPerOneMillion: Int?
    var criticalPerOneMillion: Int?
    var countryInfo : CountryInfo?
    
    init(){}
    
    init(json: JSON){
        
        country = json["country"].stringValue
        cases = json["cases"].intValue
        todayCases = json["todayCases"].intValue
        deaths = json["deaths"].intValue
        todayDeaths = json["todayDeaths"].intValue
        recovered = json["recovered"].intValue
        todayRecovered = json["todayRecovered"].intValue
        active = json["active"].intValue
        critical = json["critical"].intValue
        casesPerOneMillion = json["casesPerOneMillion"].intValue
        deathsPerOneMillion = json["deathsPerOneMillion"].intValue
        test = json["tests"].intValue
        testsPerOneMillion = json["testsPerOneMillion"].intValue
        poplulation = json["population"].intValue
        continent = json["continent"].stringValue
        oneCasePerPeole = json["oneCasePerPeole"].intValue
        oneDeathPerPeole = json["oneDeathPerPeole"].intValue
        activePerOneMillion = json["activePerOneMillion"].intValue
        recoveredPerOneMillion = json["recoveredPerOneMillion"].intValue
        criticalPerOneMillion = json["criticalPerOneMillion"].intValue
        
        countryInfo = CountryInfo(json: json["countryInfo"])
    }
    
}

struct CountryInfo{
    
    var id : Int?
    var iso2 : String = ""
    var iso3 : String = ""
    var lat : Double?
    var long : Double?
    var flag: String = ""
    
    init(json: JSON) {
        id = json["id"].intValue
        iso2 = json["iso2"].stringValue
        iso3 = json["iso3"].stringValue
        lat = json["lat"].doubleValue
        long = json["long"].doubleValue
        flag = json["flag"].stringValue
    }
}
