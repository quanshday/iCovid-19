//
//  VaccinesTableViewCell.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    
    static let identifier = "PlanTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "PlanTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var astrazLabel: UILabel!
    @IBOutlet weak var pfizerLabel: UILabel!
    @IBOutlet weak var modernaLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
