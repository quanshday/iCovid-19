//
//  UpdateViewController.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import UIKit
import SwiftyJSON

class UpdateViewController: UIViewController {
    
    static let identifier = "UpdateViewController"
    
    static func nib() -> UINib{
        return UINib(nibName: "UpdateViewController", bundle: nil)
    }

    @IBOutlet weak var tableView: UITableView!
    
    var totalVN = [TotalVNModel]()
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UpdateTableViewCell.nib(), forCellReuseIdentifier: UpdateTableViewCell.identifier)
        
        fetchTotalAPI()
    
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapDetailButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let navvc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! UINavigationController
//        let vc = navvc.viewControllers[0] as! DetailViewController
        present(navvc, animated: true, completion: nil)
    }

    func fetchTotalAPI(){
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.white
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.async {
            APIManager.shared.updateTotalAPI { (totalVN) in
                self.totalVN = totalVN
                self.tableView.reloadData()
                activityIndicatorView.stopAnimating()
            }
            
            
        }
        
    }
    
}

extension UpdateViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 163
    }
}

extension UpdateViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {

            return 3

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return totalVN.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: UpdateTableViewCell.identifier, for: indexPath) as! UpdateTableViewCell
            switch indexPath.section {
            case 0:
                cell.titleLabel.text = "TỔNG SỐ BỆNH NHÂN TỪ KHI CÓ DỊCH Ở VIỆT NAM"
                cell.categoryLabel.text = "Người"
                cell.peopleLabel.text = "\(String(totalVN[indexPath.row].totalCases ?? 0))"
            case 1:
                cell.titleLabel.text = "TỔNG SỐ BỆNH NHÂN TỬ VONG Ở VIỆT NAM"
                cell.categoryLabel.text = "Người"
                cell.peopleLabel.text = "\(String(totalVN[indexPath.row].totalDeaths ?? 0))"
            default:
                cell.titleLabel.text = "TỔNG SỐ CA HỒI PHỤC Ở VIỆT NAM"
                cell.categoryLabel.text = "Người"
                cell.peopleLabel.text = "\(String(totalVN[indexPath.row].totalRecovered ?? 0))"
            }
        
            return cell
        }
        
}
    
