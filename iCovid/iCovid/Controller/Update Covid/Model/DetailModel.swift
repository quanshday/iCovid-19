//
//  DetailModel.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import Foundation
import SwiftyJSON

//struct DetailModel{
//
//    var stt: Detail?
//    var index: String?
//
//    init() {}
//
//    init(json: JSON, index: String) {
//        self.index = index
//        stt = Detail(json: json)
//    }
//}

struct DetailModel{
    
    var name: String = ""
    var cases: String = ""
    var recovered: String = ""
    var deaths : String = ""
    var index : String = ""
    
    init(json: JSON, index: String){
        
        self.index = index
        name = json["name"].stringValue
        cases = json["cases"].stringValue
        recovered = json["recovered"].stringValue
        deaths = json["deaths"].stringValue
    }
}
