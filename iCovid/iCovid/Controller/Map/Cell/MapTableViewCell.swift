//
//  MapTableViewCell.swift
//  iCovid
//
//  Created by Mac on 27/07/2021.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    
    static let identifier = "MapTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MapTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMap(covid: CovidWorld){
        
        flagImageView.kf.setImage(with: URL(string: covid.countryInfo?.flag ?? ""))
        countryLabel.text = covid.country
    }
    
}
