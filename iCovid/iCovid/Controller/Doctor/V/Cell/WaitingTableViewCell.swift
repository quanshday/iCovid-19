//
//  WaitingTableViewCell.swift
//  iCovid
//
//  Created by Mac on 31/07/2021.
//

import UIKit

class WaitingTableViewCell: UITableViewCell {
    
    static let identifier = "WaitingTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "WaitingTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var waitingImageView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        waitingImageView.animationImages = (1...3).map {
            index in
            return UIImage(named: "thinking\(index)")!
        }
        waitingImageView.animationDuration = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
