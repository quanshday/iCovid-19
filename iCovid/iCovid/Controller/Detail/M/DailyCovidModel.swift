//
//  TotalModel.swift
//  iCovid
//
//  Created by Mac on 29/07/2021.
//

import Foundation
import SwiftyJSON

struct DailyCovidModel {
    
    var key : String = ""
    var date : String?
    var totalCases: Int?
    var newCases: Int?
    var totalDeaths: Int?
    var newDeaths: Int?
    
    init(){}
    
    init(json: JSON, key: String) {
        
        self.key = key
        date = json["date"].stringValue
        totalCases = json["total_cases"].intValue
        newCases = json["new_cases"].intValue
        totalDeaths = json["total_deaths"].intValue
        newDeaths = json["new_deaths"].intValue
    }
}
