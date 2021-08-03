//
//  VaccinesType.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import Foundation
import SwiftyJSON

struct PlanTotalModel{
    
    var totalPlanned: Int?
    var totalRealistic: Int?
    var totalDistributedRate: Int?
    
    init(json: JSON){
        
        totalPlanned = json["totalPlanned"].intValue
        totalRealistic = json["totalRealistic"].intValue
        totalDistributedRate = json["totalDistributedRate"].intValue
    }
}
