//
//  AlertView.swift
//  iCovid
//
//  Created by Mac on 31/07/2021.
//

import Foundation
import UIKit

class AlertView: UIView {
    
    static let shared = AlertView()

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        
        iconImageView.layer.cornerRadius = 30
        iconImageView.layer.borderColor = UIColor.white.cgColor
        iconImageView.clipsToBounds = true
        
        alertView.layer.cornerRadius = 10
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
//    func showAlert(){
//        UIApplication.shared.keyWindow?.addSubview(parentView)
//    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        
        parentView.removeFromSuperview()
    }
}
