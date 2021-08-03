//
//  DetailTableViewCell.swift
//  iCovid
//
//  Created by Mac on 28/07/2021.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let identifier = "DetailTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "DetailTableViewCell", bundle: nil)
    }
    
//    var index = 0

    @IBOutlet weak var sttLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var casesLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDetail(detail: DetailModel){
        
        nameLabel.text = detail.name
        casesLabel.text = detail.cases
        recoveredLabel.text = detail.recovered
        deathsLabel.text = detail.deaths
    }
    
    func setPlanDetail(plan: PlanDetailModel){

        nameLabel.text = plan.name
        casesLabel.text = "\(plan.planned ?? 0)"
        recoveredLabel.text = "\(plan.realistic ?? 0)"
        deathsLabel.text = "\(plan.rate ?? 0)" + "%"
    }
    
}
