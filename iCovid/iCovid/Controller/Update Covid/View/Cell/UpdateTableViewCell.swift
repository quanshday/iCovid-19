//
//  UpdateTableViewCell.swift
//  iCovid
//
//  Created by Mac on 27/07/2021.
//

import UIKit

class UpdateTableViewCell: UITableViewCell {
    
    static let identifier = "UpdateTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "UpdateTableViewCell", bundle: nil)
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
