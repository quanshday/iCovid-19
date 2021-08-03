//
//  DetailVaccinesViewController.swift
//  iCovid
//
//  Created by Mac on 28/07/2021.
//

import UIKit
import SwiftyJSON

class DetailPlanViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var planDetail = [PlanDetailModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.layer.cornerRadius = 30
        tableView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.nib(), forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        planDetailAPI()
    }
    
    func planDetailAPI(){
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.white
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.async {
            APIManager.shared.planDetailAPI { (plan) in
                self.planDetail = plan
                self.tableView.reloadData()
                
                activityIndicatorView.stopAnimating()
            }
        }
        
        
    }
    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DetailPlanViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        
        cell.setPlanDetail(plan: planDetail[indexPath.row])
        
        return cell
    }
    
    
}

extension DetailPlanViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navvc = storyboard?.instantiateViewController(withIdentifier: "ChartViewController") as! UINavigationController
        let vc = navvc.viewControllers[0] as! ChartViewController
        vc.planDetail = planDetail[indexPath.row]
        self.present(navvc, animated: true, completion: nil)
    }
}
