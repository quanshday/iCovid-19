//
//  AskTableViewCell.swift
//  iCovid
//
//  Created by Mac on 31/07/2021.
//

import UIKit

class AskTableViewCell: UITableViewCell {
    
    static let identifier = "AskTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "AskTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var questionTextField : UITextField!


    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
