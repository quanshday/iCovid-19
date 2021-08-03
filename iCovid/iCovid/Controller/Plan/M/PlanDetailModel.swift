//
//  VaccinesType.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import Foundation
import SwiftyJSON

class PlanDetailModel{
    
    var index: String = ""
    var name: String = ""
    var planned: Int?
    var realistic: Int?
    var rate: Int?
    
    init(){}
    
    init(json: JSON, index: String){
        self.index = index
        
        name = json["name"].stringValue
        planned = json["Planned"].intValue
        realistic = json["Realistic"].intValue
        rate = json["DistributedRate"].intValue
    }
}
