//
//  DetailViewController.swift
//  iCovid
//
//  Created by Mac on 28/07/2021.
//

import UIKit
import SwiftyJSON

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailModel = [DetailModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.layer.cornerRadius = 30
        tableView.clipsToBounds = true

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.nib(), forCellReuseIdentifier: DetailTableViewCell.identifier)

        updateDetailAPI()
    }
    
    func updateDetailAPI(){
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.white
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.async {
            APIManager.shared.updateDetailAPI { (detail) in
                self.detailModel = detail
                self.tableView.reloadData()
                activityIndicatorView.stopAnimating()
            }
            
            
        }
        
        
    }
    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        cell.setDetail(detail: detailModel[indexPath.row])
        return cell
    }
    
    
}

extension DetailViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
