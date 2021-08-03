//
//  DetailCovidViewController.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import UIKit
import SwiftyJSON
import Kingfisher
import MapKit

class DetailCovidViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var numberCasesLabel: UILabel!
    @IBOutlet weak var numberCasesTodayLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var deathsTodayLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var recoveredTodayLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var crtical: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var continentLabel: UILabel!
    
    var covid : CovidWorld!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lat = covid.countryInfo?.lat ?? 0.0
        let long = covid.countryInfo?.long ?? 0.0
        
        let mapKit = CLLocation(latitude: lat, longitude: long)
        let regionRadius: CLLocationDistance = 1000.0
        let region = MKCoordinateRegion(center: mapKit.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
        
        countryLabel.text = covid.country
        numberCasesLabel.text = "\(covid.cases ?? 0)"
        numberCasesTodayLabel.text = "\(covid.todayCases ?? 0)"
        deathsLabel.text = "\(covid.deaths ?? 0)"
        deathsTodayLabel.text = "\(covid.todayDeaths ?? 0)"
        recoveredLabel.text = "\(covid.recovered ?? 0)"
        recoveredTodayLabel.text = "\(covid.todayRecovered ?? 0)"
        activeLabel.text = "\(covid.active ?? 0)"
        crtical.text = "\(covid.critical ?? 0)"
        testLabel.text = "\(covid.test ?? 0)"
        populationLabel.text = "\(covid.poplulation ?? 0)"
        continentLabel.text = covid.continent
    }

    
    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
    
extension DetailCovidViewController: MKMapViewDelegate{
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("Rendering.............")
    }
}
