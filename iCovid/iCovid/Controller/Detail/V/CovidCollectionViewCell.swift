//
//  CovidCollectionViewCell.swift
//  iCovid
//
//  Created by Mac on 30/07/2021.
//

import UIKit

class CovidCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CovidCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CovidCollectionViewCell", bundle: nil)
    }

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var newCasesLabel: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var newDeathLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCovid(covid: DailyCovidModel){
        
        dateLabel.text = covid.date
        totalCasesLabel.text = "\(covid.totalCases ?? 0)"
        newCasesLabel.text = "\(covid.newCases ?? 0)"
        totalDeaths.text = "\(covid.totalDeaths ?? 0)"
        newDeathLabel.text = "\(covid.newDeaths ?? 0)"
        
    }

}
