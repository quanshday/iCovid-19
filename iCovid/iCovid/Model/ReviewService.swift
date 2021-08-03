//
//  ReviewService.swift
//  iCovid
//
//  Created by Mac on 02/08/2021.
//

import Foundation
import StoreKit

class ReviewService{
    private init () {}
    
    static let shared = ReviewService()
    
    func requestReview(){
        SKStoreReviewController.requestReview()
    }
}
