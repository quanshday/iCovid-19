//
//  MapViewController.swift
//  iCovid
//
//  Created by Mac on 29/07/2021.
//

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

        covidWorldAPI()
        
        //MARK: - Animation Lottie
        
        viewLotties.layer.cornerRadius = viewLotties.frame.size.width / 2
        viewLotties.clipsToBounds = true
        
        animationView = .init(name: "earth")
        animationView.frame = viewLotties.bounds
        animationView.contentMode = .center
        animationView.loopMode = .loop
        
        animationView.play()
        viewLotties.addSubview(animationView)
        
        searchBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.animationView?.isAnimationPlaying == false {
           self.animationView?.play()
        }
    }
    
    func covidWorldAPI(){
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.white
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.async {
            APIManager.shared.covidWorldAPI { (covid) in
                self.covidWorld = covid
                self.tableView.reloadData()
                activityIndicatorView.stopAnimating()
            }
            
            
        }
              
        

    }
    
    func fetchCountry(country: String){

//        APIManager.shared.searchCountry(country: country) { (covid) in
//            self.covidWorld = covid
//            self.tableView.reloadData()
//        }
//    }
        
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
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        
        if searchBar.isHidden == true{
            searchBar.isHidden = false
        }
        else{
            searchBar.isHidden = true
        }
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            covidWorld = []
            tableView.reloadData()
  
           fetchCountry(country: text)
        }
    }
    
    
}
