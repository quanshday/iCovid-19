//
//  AnswerTableViewCell.swift
//  iCovid
//
//  Created by Mac on 31/07/2021.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    
    static let identifier = "AnswerTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "AnswerTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        answerLabel.text = message.text
    }
    
}
