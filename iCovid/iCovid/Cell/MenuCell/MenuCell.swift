//
//  MenuCell.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    static let identifier = "MenuCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MenuCell", bundle: nil)
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width / 2
        iconImageView.clipsToBounds = true
    }


}
