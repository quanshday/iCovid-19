//
//  TotalVNModel.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import Foundation
import SwiftyJSON

struct TotalVNModel{
    
    var totalCases : Int?
    var totalRecovered : Int?
    var totalDeaths: Int?

    init(){}
    
    init(json: JSON){
        
        totalCases = json["totalCases"].intValue
        totalRecovered = json["totalRecovered"].intValue
        totalDeaths = json["totalDeaths"].intValue
    }
}
