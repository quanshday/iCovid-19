//
//  MapViewController.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import UIKit
import SwiftyJSON
import Alamofire
import Lottie

class MapViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewLotties: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var animationView : AnimationView!

    var covidWorld = [CovidWorld]()
    var rec = [CovidWorld]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.layer.cornerRadius = 30
        tableView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MapTableViewCell.nib(), forCellReuseIdentifier: MapTableViewCell.identifier)

        parseAPI()
        
        //MARK: - Animation Lottie
        
        viewLotties.layer.cornerRadius = viewLotties.frame.size.width / 2
        viewLotties.clipsToBounds = true
        
        animationView = .init(name: "earth")
        animationView.frame = viewLotties.bounds
        animationView.contentMode = .center
        animationView.loopMode = .loop
        
        animationView.play()
        viewLotties.addSubview(animationView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.animationView?.isAnimationPlaying == false {
           self.animationView?.play()
        }
    }
    
    func parseAPI(){
              
        let urlString = "https://corona.lmao.ninja/v2/countries"
        let url = URL(string: urlString)

        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            guard let data = data else{return}

            do{

                let json = try JSON(data: data)
                let result = json[]
                
                for arr in result.arrayValue{
                    self.covidWorld.append(CovidWorld(json: arr))
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchCountry(country: String){
        
        let urlString = "https://corona.lmao.ninja/v2/countries/\(country)"
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
                    self.tableView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()

    }

    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension MapViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidWorld.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as! MapTableViewCell

        cell.setMap(covid: covidWorld[indexPath.row])
        
        return cell
    }
    
    
}

extension MapViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailCovid", bundle: nil)
        let navigationVC = storyboard.instantiateViewController(withIdentifier: "DetailCovidViewController") as! UINavigationController
        let vc = navigationVC.viewControllers[0] as! DetailCovidViewController

        vc.covid = covidWorld[indexPath.row]

        self.present(navigationVC, animated: true, completion: nil)
    }
}

extension MapViewController : UISearchBarDelegate{
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText == ""{
//            rec = covidWorld
//            tableView.reloadData()
//            searchBar.resignFirstResponder()
//            return
//        }
//
//        let result = covidWorld.filter { (name) -> Bool in
//            return name.country.lowercased().contains(searchText.lowercased())
//        }
//        rec = result
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            covidWorld = []
            tableView.reloadData()
        
           fetchCountry(country: text)
        }
    }
    
    
}
