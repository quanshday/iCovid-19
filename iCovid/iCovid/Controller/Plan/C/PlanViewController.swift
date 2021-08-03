//
//  VaccinesViewController.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import UIKit
import SwiftyJSON

class PlanViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var planTotal = [PlanTotalModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UpdateTableViewCell.nib(), forCellReuseIdentifier: UpdateTableViewCell.identifier)
        
        planTotalAPI()
    }

    
    func planTotalAPI(){
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.white
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.async {
            APIManager.shared.planTotalAPI { (plan) in
                self.planTotal = plan
                self.tableView.reloadData()
                
                activityIndicatorView.stopAnimating()
            }
        }
        
        
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapDetailButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "DataVac", bundle: nil)
        let navvc = storyboard.instantiateViewController(withIdentifier: "DetailPlanViewController") as! UINavigationController
        present(navvc, animated: true, completion: nil)
    }
    
    
}

extension PlanViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return planTotal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: UpdateTableViewCell.identifier, for: indexPath) as! UpdateTableViewCell
            
            switch indexPath.section {
            case 0:
                cell.titleLabel.text = "TỔNG SỐ KẾ HOẠCH Ở VIỆT NAM"
                cell.peopleLabel.text = "\(planTotal[indexPath.row].totalPlanned ?? 0)"
                cell.categoryLabel.text = "Kế hoạch"
            case 1:
                cell.titleLabel.text = "TỔNG SỐ THỰC TẾ Ở VIỆT NAM"
                cell.peopleLabel.text = "\(planTotal[indexPath.row].totalRealistic ?? 0)"
                cell.categoryLabel.text = "Kế hoạch"
            default:
                cell.titleLabel.text = "TỔNG TỶ LỆ Ở VIỆT NAM"
                cell.peopleLabel.text = "\(planTotal[indexPath.row].totalDistributedRate ?? 0)"
                cell.categoryLabel.text = "%"
            }
            
            return cell

        }
   
    
}

extension PlanViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 163
    }
}
