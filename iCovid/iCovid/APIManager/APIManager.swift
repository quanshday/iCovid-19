//
//  APIManager.swift
//  iCovid
//
//  Created by Mac on 30/07/2021.
//

import Foundation
import SwiftyJSON

class APIManager{
    
    var totalVN = [TotalVNModel]()
    var detail = [DetailModel]()
    var planTotal = [PlanTotalModel]()
    var planDetail = [PlanDetailModel]()
    var covidWorld = [CovidWorld]()
    var dailyCovid = [DailyCovidModel]()
    
    static let shared = APIManager()
    
    func updateTotalAPI(completion: @escaping ([TotalVNModel]) -> Void){
        
        let urlString = update_url
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard let data = data else {return}
            
            do{
                
                let json = try JSON(data: data)
                let result = json["total"]
                
                self.totalVN.append(TotalVNModel(json: result))
                
                DispatchQueue.main.async {
                    completion(self.totalVN)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func updateDetailAPI(completion: @escaping ([DetailModel]) -> Void){
        
        let urlString = update_url
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard let data = data else {return}
            
            do{
                
                let json = try JSON(data: data)
                let result = json["detail"]
                
                for (key, subJson): (String, JSON) in result{
                    self.detail.append(DetailModel(json: subJson, index: key))
                }
                
                DispatchQueue.main.async {
                    completion(self.detail)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func planTotalAPI(completion: @escaping ([PlanTotalModel])->Void){
        
        let urlString = plan_url
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard let data = data else {return}
            
            do{
                
                let json = try JSON(data: data)
                let result = json["totalDistribution"]
                
                self.planTotal.append(PlanTotalModel(json: result))
                
                DispatchQueue.main.async {
                    completion(self.planTotal)
                }
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func planDetailAPI(completion: @escaping ([PlanDetailModel]) -> Void){
        
        let urlString = plan_url
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard let data = data else {return}
            
            do{
                
                let json = try JSON(data: data)
                let result = json["dataDistribution"]
                
                for (key, subJson) : (String, JSON) in result{
                    self.planDetail.append(PlanDetailModel(json: subJson, index: key))
                }
                
                DispatchQueue.main.async {
                    completion(self.planDetail)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func covidWorldAPI(completion: @escaping ([CovidWorld])->Void){
        
        let urlString = map_url
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard let data = data else {return}
            
            do{
                
                let json = try JSON(data: data)
                let result = json[]
                
                for arr in result.arrayValue{
                    self.covidWorld.append(CovidWorld(json: arr))
                }
                
                DispatchQueue.main.async {
                    completion(self.covidWorld)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func searchCountry(country: String, completion: @escaping ([CovidWorld])->Void){
        
        let urlString = map_url + "/\(country)"
        let url = URL(string: urlString)

        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard let data = data else {return}

            do{

                if country == ""{
                let json = try JSON(data: data)
                let result = json[]

                    for arr in result.arrayValue{
                        self.covidWorld.append(CovidWorld(json: arr))
                    }

                }

                else{
                    let json = try JSON(data: data)
                    let result = json[]

                    self.covidWorld.append(CovidWorld(json: result))
                }

                DispatchQueue.main.async {
                    completion(self.covidWorld)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func dailyCovidAPI(completion: @escaping ([DailyCovidModel])->Void){
        
        let urlString = daily_url
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard let data = data else {return}
            
            do{
                
                let json = try JSON(data: data)
                let result = json["data"]
                
                self.dailyCovid.removeAll()
                for (key, subJson) : (String, JSON) in result{
                    self.dailyCovid.append(DailyCovidModel(json: subJson, key: key))
                }
                
                DispatchQueue.main.async {
                    completion(self.dailyCovid)
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

