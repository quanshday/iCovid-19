//
//  QuestionTableViewCell.swift
//  iCovid
//
//  Created by Mac on 31/07/2021.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    static let identifier = "QuestionTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "QuestionTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = true
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }()
    
    func configureWithMessage(_ message: Message) {
        dateLabel.text = dateFormatter.string(from: message.date as Date)
    
        questionLabel.text = message.text
    }
    

    
}
